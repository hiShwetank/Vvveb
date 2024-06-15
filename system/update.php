<?php

/**
 * Vvveb
 *
 * Copyright (C) 2022  Ziadin Givan
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 */

namespace Vvveb\System;

use function Vvveb\download;
use function Vvveb\getUrl;
use function Vvveb\rcopy;
use function Vvveb\rrmdir;

define('CHMOD_DIR', (0755 & ~umask()));
define('CHMOD_FILE', (0644 & ~umask()));

class Update {
	protected $url 		= 'https://www.vvveb.com/update.json';

	protected $workDir	= DIR_STORAGE . 'upgrade';

	protected $zipFile	= false;

	function checkUpdates($type = 'core', $force = false) {
		if ($force) {
			//delete update cache
			$cacheKey    = md5($this->url);
			$cacheDriver = Cache :: getInstance();
			$cacheDriver->delete('url', $cacheKey);
		}

		//cache results for one week
		try {
			$result = getUrl($this->url, true, 604800, 1, false);
		} catch (\Exception $e) {
			$result = '{}';
		}

		if ($result) {
			$info = json_decode($result, true);

			if ($type == 'core') {
				$info['hasUpdate'] = max(version_compare($info['version'] ?? 0, V_VERSION), 0);
			}

			return $info;
		}

		return [];
	}

	private function checkFolderPermissions($dir) {
		$skip       = ['install', 'locale', 'vendor', 'plugins', 'config'];
		$unwritable = [];

		$handle = @opendir($dir);

		while (false !== ($file = readdir($handle))) {
			$full = $dir . DS . $file;

			if (($file != '.') &&
				($file != '..') && ! in_array($file, $skip)) {
				if (is_dir($full)) {
					if (! is_writable($full)) {
						if (! @chmod($full, CHMOD_DIR)) {
							return $full;
						}
					}

					$result = $this->checkFolderPermissions($full);

					if ($result !== true) {
						return $result;
					}
				}
				//if (str_ends_with($full, '.php') && ! is_writable($full)) {
				if ((substr_compare($full,'.php', -4) === 0) && ! is_writable($full)) {
					if (! @chmod($full, CHMOD_FILE)) {
						return $full;
					}
				}
			}
		}

		return true;
	}

	function checkPermissions() {
		$check = $this->checkFolderPermissions(DIR_ROOT);

		return $check;
	}

	static function backup() {
		$skipFolders  = ['plugins', 'public', 'storage', 'install'];
		$backupFolder = DIR_BACKUP . 'update-' . V_VERSION . '-' . date('Y-m-d_H:i:s');

		rcopy(DIR_ROOT, $backupFolder, $skipFolders);
	}

	static function download($url) {
		//$temp = tmpfile();
		$f    = false;
		$temp = tempnam(sys_get_temp_dir(), 'vvveb_update');

		if ($content = download($url)) {
			$f  = file_put_contents($temp, $content, LOCK_EX);

			return $temp;
		}

		return $f;
	}

	function setPermissions() {
		$folders = [DIR_ROOT . 'app', DIR_ROOT . 'admin', DIR_ROOT . 'system'];
		$files   = [DIR_ROOT . 'index.php', DIR_ROOT . 'admin' . DS . 'index.php', DIR_ROOT . 'install' . DS . 'index.php'];

		foreach ($folders as $folder) {
			@chmod($folder, CHMOD_DIR);
		}

		foreach ($files as $file) {
			@chmod($file, CHMOD_FILE);
		}

		return true;
	}

	private function copyFolder($src, $dest, $skipFolders = []) {
		ignore_user_abort(true);

		if (! is_writable($dest)) {
			throw new \Exception(sprintf('Folder "%s" not writable!', $dest));
		}

		return rcopy($src, $dest, $skipFolders);
	}

	function copyAdmin() {
		//$skipFolders = ['plugins', 'public', 'storage'];
		return $this->copyFolder($this->workDir . DS . 'admin', DIR_ROOT . DS . 'admin');
	}

	function copyApp() {
		ignore_user_abort(true);
		//$skipFolders = ['plugins', 'public', 'storage'];
		return $this->copyFolder($this->workDir . DS . 'app', DIR_ROOT . DS . 'app');
	}

	function copySystem() {
		return $this->copyFolder($this->workDir . DS . 'system', DIR_ROOT . DS . 'system');
	}

	function copyInstall() {
		//$skipFolders = ['plugins', 'public', 'storage'];
		return $this->copyFolder($this->workDir . DS . 'install', DIR_ROOT . DS . 'install');
	}

	function copyCore() {
		$skipFolders = ['plugins', 'public', 'storage', 'system', 'app', 'admin', 'install', 'config', 'env.php'];

		return $this->copyFolder($this->workDir, DIR_ROOT, $skipFolders);
	}

	function copyConfig() {
		$skip = ['plugins.php', 'mail.php', 'sites.php', 'app.php', 'admin.php', 'routes.php', 'env.php'];

		return $this->copyFolder($this->workDir . DS . 'config', DIR_ROOT . DS . 'config', $skip);
	}

	function copyPublic() {
		$skipFolders = ['plugins', 'themes', 'admin', 'media'];

		return $this->copyFolder($this->workDir . DS . 'public', DIR_PUBLIC, $skipFolders);
	}

	function copyPublicAdmin() {
		ignore_user_abort(true);
		$skipFolders = ['plugins'];

		return $this->copyFolder($this->workDir . DS . 'public' . DS . 'admin', DIR_PUBLIC . DS . 'admin', $skipFolders);
	}

	function copyPublicMedia() {
		$skipFolders = ['plugins', 'themes', 'admin'];

		return $this->copyFolder($this->workDir . DS . 'public' . DS . 'media', DIR_PUBLIC . DS . 'media', $skipFolders);
	}

	function clearCache() {
		return CacheManager::delete();
	}

	function cleanup() {
		rrmdir($this->workDir);

		if ($this->zipFile) {
			unlink($this->zipFile);
		}

		return true;
	}

	function install($zipFile) {
		$this->unzip($zipFile, $this->workDir);

		$success     = true;
		//$dest        = substr(DIR_ROOT,0, -1); //remove trailing slash
		rrmdir($this->workDir);
		//plugins and themes are updated individually
		$skipFolders = ['plugins', 'public' . DS . 'themes', 'storage'];

		rcopy($this->workDir, DIR_ROOT, $skipFolders);
		rrmdir($this->workDir);
		unlink($zipFile);
		CacheManager::delete();
	}

	function unzip($zipFile) {
		if (! is_dir($this->workDir)) {
			mkdir($this->workDir);
		}

		$result        = false;
		$this->zipFile = $zipFile;
		$zip           = new \ZipArchive();

		if ($zip->open($zipFile) === true) {
			$result = $zip->extractTo($this->workDir);
		}

		Event :: trigger(__CLASS__, __FUNCTION__, $zipFile, $result);

		return $result;
	}
}
