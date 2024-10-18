INSERT INTO `menu_item` (`menu_item_id`, `menu_id`, `type`, `url`, `parent_id`, `item_id`, `sort_order`, `status`)  VALUES 
(1,3,'link','',0,null,1,1),
(2,3,'link','',1,null,2,1),
(3,3,'link','',0,null,3,1),
(4,3,'link','',0,null,5,1),
(5,3,'link','',0,null,2,1),
(6,3,'link','',0,null,4,1),
(7,3,'link','',3,null,3,1),
(8,3,'link','',1,null,3,1),
(9,3,'link','',3,null,3,1),
(10,3,'link','',3,null,3,1),
(11,3,'link','',3,null,3,1),
(12,3,'link','',3,null,3,1),
(13,3,'link','',0,null,6,1),
(14,3,'link','',0,null,7,1),
(15,3,'link','',7,null,0,1),
(16,3,'link','',7,null,0,1),
(17,3,'link','',14,null,0,1),
(18,3,'link','',14,null,0,1),
(19,3,'link','',14,null,0,1),
(20,3,'link','',14,null,0,1),
(21,3,'link','',14,null,0,1),
(22,3,'link','',14,null,0,1),
(23,3,'link','',14,null,0,1),
(24,3,'link','',14,null,0,1),
(25,3,'link','',5,null,0,1),
(26,3,'link','',5,null,0,1),
(27,3,'link','',14,null,0,1),
(28,3,'link','',14,null,0,1),
(29,3,'link','',14,null,0,1),
(30,3,'link','',14,null,0,1),
(31,3,'link','',14,null,0,1),
(32,3,'link','',14,null,0,1),
(33,3,'link','',14,null,0,1),
(34,3,'link','',14,null,0,1),
(35,3,'link','',14,null,0,1),
(36,3,'link','',14,null,0,1),
(37,3,'link','',0,null,1,1),
(38,3,'link','',32,null,0,1),
-- tags
(39,2,'link','',0,null,0,1),
(40,2,'link','',0,null,0,1),
(41,2,'link','',0,null,0,1),
-- menu
(42,1,'link','/',0,null,0,1),
(43,1,'link','/shop',0,null,3,1),
-- (44,1,'link','//docs.*.*',0,null,2,1),
-- (45,1,'link','//docs.*.*',44,null,0,1),
(46,1,'link','/blog',0,null,5,1),
-- (47,1,'link','//github.com/givanz/Vvveb/discussions',44,null,0,1),
-- (48,1,'link','//dev.*.*',44,null,3,1),

(49,1,'page','/page/contact-7',0,7,6,1),
(59,1,'page','/page/about-11',0,11,1,1),
-- (60,1,'link','/page/contact-7',59,null,0,1),
-- (61,1,'link','/page/contact-7',59,null,3,1),
-- (62,1,'link','/page/contact-7',59,null,2,1),

(63,1,'page','/page/services-12',0,12,4,1),
(64,1,'page','/page/pricing-13',63,13,0,1),
(65,1,'page','/page/services-12',63,12,0,1),
(80,5,'page','/page/marketplace-15',63,15,0,1),
(66,1,'page','/page/portfolio-14',63,14,0,1),
(67,1,'text','#',0,14,3,0),
(68,1,'text','#',67,11,0,0),

-- footer
(50,5,'link','',0,null,0,1),
(51,5,'link','/',50,null,0,1),
(52,5,'link','/shop',50,null,0,1),
(53,5,'link','/',0,null,0,1),
(54,5,'page','/page/shipping-delivery-8',8,8,0,1),
(55,5,'page','/page/terms-conditions-9',9,9,0,1),
(56,5,'page','/page/contact-7',0,7,0,1),
(57,5,'page','/page/contact-7',56,7,0,1),
(58,5,'page','/page/portfolio-14',56,14,0,1),
(73,5,'link','/user/return-form',56,null,0,1),



(69,5,'link','/user',0,null,0,1),
(70,5,'link','/user/order-tracking',69,null,0,1),
(71,5,'link','/user/wishlist',69,null,0,1),
(72,5,'link','/user/orders',69,null,0,1),
(79,5,'link','/cart/compare',69,null,0,1),


(74,5,'link','/blog',50,null,0,1),
(75,5,'page','/page/services-12',50,12,0,1),
(76,5,'page','/page/about-11',56,11,0,1),
(77,5,'link','/brand',53,null,0,1),
(78,5,'link','/vendor',53,null,0,1);
