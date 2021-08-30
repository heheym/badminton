/*
Navicat MySQL Data Transfer

Source Server         : 192.168.150.250
Source Server Version : 50714
Source Host           : 192.168.150.250:3306
Source Database       : guoshu

Target Server Type    : MYSQL
Target Server Version : 50714
File Encoding         : 65001

Date: 2018-11-16 10:13:01
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for fox_access
-- ----------------------------
DROP TABLE IF EXISTS `fox_access`;
CREATE TABLE `fox_access` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL COMMENT '权限名字',
  `group` varchar(20) DEFAULT NULL COMMENT '所属分组',
  `right` text COMMENT '权限码(控制器+动作)',
  `is_del` tinyint(1) DEFAULT '0' COMMENT '删除状态 1删除,0正常',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fox_access
-- ----------------------------

-- ----------------------------
-- Table structure for fox_ad
-- ----------------------------
DROP TABLE IF EXISTS `fox_ad`;
CREATE TABLE `fox_ad` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '幻灯片0 广告1',
  `title` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '标题',
  `img` varchar(200) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '图片',
  `gid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '链接的商品ID',
  `sort` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of fox_ad
-- ----------------------------
INSERT INTO `fox_ad` VALUES ('2', '0', '手机', '20180211/062843d860ddd577f192e26b6b62e4c7.jpg', '1', '1');
INSERT INTO `fox_ad` VALUES ('3', '0', '日用百货', '20180206/a46d85a0ba172c6b45f2c6f1e2b6b026.jpg', '1', '3');
INSERT INTO `fox_ad` VALUES ('4', '1', '电脑', '20180206/18234254764e7d0cf2d85c9592a44b4d.jpg', '2', '6');
INSERT INTO `fox_ad` VALUES ('5', '1', 'test4', '20180206/7ca80ccb0240ad13ebdaad74aeaed234.jpg', '4', '4');
INSERT INTO `fox_ad` VALUES ('6', '1', 'test5', '20180206/41364f87ff8e4d90336b3f325f4edc91.jpg', '5', '7');
INSERT INTO `fox_ad` VALUES ('7', '1', 'test6', '20180206/66792278061b54626a0305ed10cd8092.jpg', '6', '5');
INSERT INTO `fox_ad` VALUES ('11', '0', '手机', '20180211/e592cfa8b91486927188319d88ed7344.jpg', '1', '2');

-- ----------------------------
-- Table structure for fox_address
-- ----------------------------
DROP TABLE IF EXISTS `fox_address`;
CREATE TABLE `fox_address` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0',
  `is_default` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '默认收货地址',
  `consignee` varchar(60) NOT NULL DEFAULT '',
  `address` varchar(200) NOT NULL DEFAULT '',
  `mobile` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `user_id` (`uid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fox_address
-- ----------------------------
INSERT INTO `fox_address` VALUES ('20', '8', '1', '测试', '', '1388');
INSERT INTO `fox_address` VALUES ('25', '12', '1', '123', '', '123');
INSERT INTO `fox_address` VALUES ('26', '11', '1', '梁昆路', '', '13457587362');
INSERT INTO `fox_address` VALUES ('28', '11', '0', '王二锤', '', '13855556666');
INSERT INTO `fox_address` VALUES ('29', '9', '0', '123', '', '13855667788');
INSERT INTO `fox_address` VALUES ('30', '9', '1', '123', '', '13855667788');

-- ----------------------------
-- Table structure for fox_admin
-- ----------------------------
DROP TABLE IF EXISTS `fox_admin`;
CREATE TABLE `fox_admin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '姓名',
  `password` varchar(32) NOT NULL,
  `email` varchar(30) NOT NULL DEFAULT '' COMMENT '邮箱',
  `ip` varchar(20) NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是超级管理员 1表示是 0 表示不是',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 1：有效 0：无效',
  `updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次更新时间',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '插入时间',
  PRIMARY KEY (`id`),
  KEY `idx_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of fox_admin
-- ----------------------------
INSERT INTO `fox_admin` VALUES ('1', 'admin', '4d4d8beaffee4096c1f3b42ea1a8916e', '', '12', '0', '1', '2018-10-07 16:17:09', '2018-10-07 16:17:09');
INSERT INTO `fox_admin` VALUES ('2', 'admin', '4d4d8beaffee4096c1f3b42ea1a8916e', '', '12', '0', '1', '2018-10-07 16:17:09', '2018-10-07 16:17:09');
INSERT INTO `fox_admin` VALUES ('3', 'admin', '4d4d8beaffee4096c1f3b42ea1a8916e', '', '12', '0', '1', '2018-10-07 16:17:09', '2018-10-07 16:17:09');
INSERT INTO `fox_admin` VALUES ('4', 'admin', '4d4d8beaffee4096c1f3b42ea1a8916e', '', '12', '0', '1', '2018-10-07 16:17:09', '2018-10-07 16:17:09');
INSERT INTO `fox_admin` VALUES ('5', 'admin', '4d4d8beaffee4096c1f3b42ea1a8916e', '', '12', '0', '1', '2018-10-07 16:17:09', '2018-10-07 16:17:09');
INSERT INTO `fox_admin` VALUES ('6', 'admin', '4d4d8beaffee4096c1f3b42ea1a8916e', '', '12', '0', '1', '2018-10-07 16:17:09', '2018-10-07 16:17:09');
INSERT INTO `fox_admin` VALUES ('7', 'admin', '4d4d8beaffee4096c1f3b42ea1a8916e', '', '12', '0', '1', '2018-10-07 16:17:09', '2018-10-07 16:17:09');
INSERT INTO `fox_admin` VALUES ('8', 'admin', '4d4d8beaffee4096c1f3b42ea1a8916e', '', '12', '0', '1', '2018-10-07 16:17:09', '2018-10-07 16:17:09');
INSERT INTO `fox_admin` VALUES ('9', 'admin', '4d4d8beaffee4096c1f3b42ea1a8916e', '', '12', '0', '1', '2018-10-07 16:17:09', '2018-10-07 16:17:09');
INSERT INTO `fox_admin` VALUES ('10', 'admin', '4d4d8beaffee4096c1f3b42ea1a8916e', '', '12', '0', '1', '2018-10-07 16:17:09', '2018-10-07 16:17:09');

-- ----------------------------
-- Table structure for fox_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `fox_admin_log`;
CREATE TABLE `fox_admin_log` (
  `log_id` bigint(16) unsigned NOT NULL AUTO_INCREMENT COMMENT '表id',
  `admin_id` int(10) DEFAULT NULL COMMENT '管理员id',
  `log_info` varchar(255) DEFAULT NULL COMMENT '日志描述',
  `log_ip` varchar(30) DEFAULT NULL COMMENT 'ip地址',
  `log_url` varchar(50) DEFAULT NULL COMMENT 'url',
  `log_time` int(10) DEFAULT NULL COMMENT '日志时间',
  PRIMARY KEY (`log_id`)
) ENGINE=MyISAM AUTO_INCREMENT=997 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fox_admin_log
-- ----------------------------
INSERT INTO `fox_admin_log` VALUES ('939', '1', '后台登录', '127.0.0.1', '/admin/admin/login', '1538900243');
INSERT INTO `fox_admin_log` VALUES ('940', '1', '后台登录', '127.0.0.1', '/admin/admin/login', '1538900335');
INSERT INTO `fox_admin_log` VALUES ('941', '1', '后台登录', '127.0.0.1', '/admin/admin/login', '1538900387');
INSERT INTO `fox_admin_log` VALUES ('942', '1', '后台登录', '127.0.0.1', '/admin/admin/login', '1538900625');
INSERT INTO `fox_admin_log` VALUES ('943', '1', '后台登录', '127.0.0.1', '/admin/admin/login', '1538961929');
INSERT INTO `fox_admin_log` VALUES ('944', '1', '后台登录', '127.0.0.1', '/admin/admin/login', '1538985700');
INSERT INTO `fox_admin_log` VALUES ('945', '1', '后台登录', '127.0.0.1', '/admin/admin/login', '1539055047');
INSERT INTO `fox_admin_log` VALUES ('946', '1', '后台登录', '192.168.150.189', '/admin/admin/login', '1539066696');
INSERT INTO `fox_admin_log` VALUES ('947', '1', '后台登录', '192.168.150.151', '/admin/admin/login', '1539066770');
INSERT INTO `fox_admin_log` VALUES ('948', '1', '后台登录', '127.0.0.1', '/admin/admin/login', '1539138800');
INSERT INTO `fox_admin_log` VALUES ('949', '1', '后台登录', '127.0.0.1', '/admin/admin/login', '1539161580');
INSERT INTO `fox_admin_log` VALUES ('950', '1', '后台登录', '127.0.0.1', '/admin/admin/login', '1539308883');
INSERT INTO `fox_admin_log` VALUES ('951', '1', '后台登录', '127.0.0.1', '/admin/admin/login', '1539570982');
INSERT INTO `fox_admin_log` VALUES ('952', '1', '后台登录', '192.168.150.189', '/admin/admin/login', '1539572603');
INSERT INTO `fox_admin_log` VALUES ('953', '1', '后台登录', '192.168.150.109', '/admin/admin/login', '1539572795');
INSERT INTO `fox_admin_log` VALUES ('954', '1', '后台登录', '127.0.0.1', '/admin/admin/login', '1539653314');
INSERT INTO `fox_admin_log` VALUES ('955', '1', '后台登录', '192.168.150.170', '/admin/admin/login', '1539658919');
INSERT INTO `fox_admin_log` VALUES ('956', '1', '后台登录', '192.168.150.167', '/admin/admin/login', '1539670703');
INSERT INTO `fox_admin_log` VALUES ('957', '1', '后台登录', '192.168.150.189', '/admin/admin/login', '1539671526');
INSERT INTO `fox_admin_log` VALUES ('958', '1', '后台登录', '127.0.0.1', '/admin/admin/login', '1539738816');
INSERT INTO `fox_admin_log` VALUES ('959', '1', '后台登录', '192.168.150.170', '/admin/admin/login', '1539765597');
INSERT INTO `fox_admin_log` VALUES ('960', '1', '后台登录', '127.0.0.1', '/admin/admin/login', '1539825345');
INSERT INTO `fox_admin_log` VALUES ('961', '1', '后台登录', '192.168.150.62', '/admin/admin/login', '1539856283');
INSERT INTO `fox_admin_log` VALUES ('962', '1', '后台登录', '127.0.0.1', '/admin/admin/login', '1539913340');
INSERT INTO `fox_admin_log` VALUES ('963', '1', '后台登录', '127.0.0.1', '/admin/admin/login', '1539997798');
INSERT INTO `fox_admin_log` VALUES ('964', '1', '后台登录', '192.168.150.189', '/admin/admin/login', '1540005861');
INSERT INTO `fox_admin_log` VALUES ('965', '1', '后台登录', '192.168.150.189', '/admin/admin/login', '1540020498');
INSERT INTO `fox_admin_log` VALUES ('966', '1', '后台登录', '192.168.150.189', '/admin/admin/login', '1540171651');
INSERT INTO `fox_admin_log` VALUES ('967', '1', '后台登录', '127.0.0.1', '/admin/admin/login', '1540191364');
INSERT INTO `fox_admin_log` VALUES ('968', '1', '后台登录', '127.0.0.1', '/admin/admin/login', '1540258833');
INSERT INTO `fox_admin_log` VALUES ('969', '1', '后台登录', '192.168.150.205', '/admin/admin/login', '1540266627');
INSERT INTO `fox_admin_log` VALUES ('970', '1', '后台登录', '192.168.150.189', '/admin/admin/login', '1540344938');
INSERT INTO `fox_admin_log` VALUES ('971', '1', '后台登录', '127.0.0.1', '/admin/admin/login', '1540350212');
INSERT INTO `fox_admin_log` VALUES ('972', '1', '后台登录', '127.0.0.1', '/admin/admin/login', '1540431068');
INSERT INTO `fox_admin_log` VALUES ('973', '1', '后台登录', '192.168.150.189', '/admin/admin/login', '1540432727');
INSERT INTO `fox_admin_log` VALUES ('974', '1', '后台登录', '192.168.150.70', '/admin/admin/login', '1540522095');
INSERT INTO `fox_admin_log` VALUES ('975', '1', '后台登录', '192.168.150.250', '/admin/admin/login', '1540869716');
INSERT INTO `fox_admin_log` VALUES ('976', '1', '后台登录', '127.0.0.1', '/admin/admin/login', '1540881951');
INSERT INTO `fox_admin_log` VALUES ('977', '1', '后台登录', '192.168.150.250', '/admin/admin/login', '1540949704');
INSERT INTO `fox_admin_log` VALUES ('978', '1', '后台登录', '192.168.150.68', '/admin/admin/login', '1540949788');
INSERT INTO `fox_admin_log` VALUES ('979', '1', '后台登录', '192.168.150.68', '/admin/admin/login', '1540950774');
INSERT INTO `fox_admin_log` VALUES ('980', '1', '后台登录', '127.0.0.1', '/admin/admin/login', '1540953276');
INSERT INTO `fox_admin_log` VALUES ('981', '1', '后台登录', '192.168.150.68', '/admin/admin/login', '1540968464');
INSERT INTO `fox_admin_log` VALUES ('982', '1', '后台登录', '192.168.150.250', '/admin/admin/login', '1541036334');
INSERT INTO `fox_admin_log` VALUES ('983', '1', '后台登录', '127.0.0.1', '/admin/admin/login', '1541135183');
INSERT INTO `fox_admin_log` VALUES ('984', '1', '后台登录', '192.168.150.99', '/admin/admin/login', '1541211090');
INSERT INTO `fox_admin_log` VALUES ('985', '1', '后台登录', '192.168.150.68', '/admin/admin/login', '1541213827');
INSERT INTO `fox_admin_log` VALUES ('986', '1', '后台登录', '192.168.150.68', '/admin/admin/login', '1541229503');
INSERT INTO `fox_admin_log` VALUES ('987', '1', '后台登录', '192.168.150.250', '/admin/admin/login', '1541385002');
INSERT INTO `fox_admin_log` VALUES ('988', '1', '后台登录', '192.168.150.252', '/admin/admin/login', '1541388921');
INSERT INTO `fox_admin_log` VALUES ('989', '1', '后台登录', '127.0.0.1', '/admin/admin/login', '1541407354');
INSERT INTO `fox_admin_log` VALUES ('990', '1', '后台登录', '127.0.0.1', '/admin/admin/login', '1541468839');
INSERT INTO `fox_admin_log` VALUES ('991', '1', '后台登录', '127.0.0.1', '/admin/admin/login', '1541639821');
INSERT INTO `fox_admin_log` VALUES ('992', '1', '后台登录', '192.168.150.250', '/admin/admin/login', '1541830071');
INSERT INTO `fox_admin_log` VALUES ('993', '1', '后台登录', '192.168.150.250', '/admin/admin/login', '1542072567');
INSERT INTO `fox_admin_log` VALUES ('994', '1', '后台登录', '192.168.150.250', '/admin/admin/login', '1542159438');
INSERT INTO `fox_admin_log` VALUES ('995', '1', '后台登录', '127.0.0.1', '/admin/admin/login', '1542261376');
INSERT INTO `fox_admin_log` VALUES ('996', '1', '后台登录', '192.168.150.250', '/admin/admin/login', '1542331068');

-- ----------------------------
-- Table structure for fox_cart
-- ----------------------------
DROP TABLE IF EXISTS `fox_cart`;
CREATE TABLE `fox_cart` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `gid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `name` varchar(200) NOT NULL DEFAULT '' COMMENT '商品名称',
  `price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '价格',
  `num` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '购买数量',
  `selected` tinyint(1) unsigned DEFAULT '1' COMMENT '购物车选中状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=411 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fox_cart
-- ----------------------------
INSERT INTO `fox_cart` VALUES ('324', '9', '22', '酷冷至尊(CoolerMaster) MK750 RGB 幻彩 机械键盘（红轴）樱桃轴（CNC上盖/全键无冲/绝地求生吃鸡键盘）', '0.01', '1', '1');

-- ----------------------------
-- Table structure for fox_category
-- ----------------------------
DROP TABLE IF EXISTS `fox_category`;
CREATE TABLE `fox_category` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品分类id',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '分类名称',
  `pid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `img` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '图片',
  `is_show_index` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '首页显示',
  `sort` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`pid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fox_category
-- ----------------------------
INSERT INTO `fox_category` VALUES ('1', '手机数码', '0', '', '1', '1');
INSERT INTO `fox_category` VALUES ('2', '家用电器', '0', '', '1', '2');
INSERT INTO `fox_category` VALUES ('3', '电脑办公', '0', '', '1', '3');
INSERT INTO `fox_category` VALUES ('4', '家具厨具', '0', '', '0', '4');
INSERT INTO `fox_category` VALUES ('5', '服装服饰', '0', '', '0', '5');
INSERT INTO `fox_category` VALUES ('6', '美妆个护 ', '0', '', '0', '6');
INSERT INTO `fox_category` VALUES ('7', '箱包珠宝', '0', '', '0', '7');
INSERT INTO `fox_category` VALUES ('8', '手机', '1', '20180215/f5e3cd84add0985b68b9334b0bca528e.jpg', '0', '1');
INSERT INTO `fox_category` VALUES ('9', '手机配件', '1', '20180215/a3d4e138a58a73e47dbdf9075b50156b.jpg', '0', '2');
INSERT INTO `fox_category` VALUES ('10', '摄影摄像', '1', '20180215/f3d88f1d515c12fb5ab3b7e4dcc8294a.jpg', '0', '3');
INSERT INTO `fox_category` VALUES ('11', '数码配件', '1', '20180215/1f8d285cc658affd7132743eeb68c28b.jpg', '0', '4');
INSERT INTO `fox_category` VALUES ('12', '影音娱乐', '1', '20180215/78c3d0479be2c2e158a059bcfaf274c1.jpg', '0', '5');
INSERT INTO `fox_category` VALUES ('13', '电子教育', '1', '20180215/463d1cf7d2d8d232bca4bd121a67d88c.jpg', '0', '6');
INSERT INTO `fox_category` VALUES ('14', '智能设备', '1', '20180215/941aad6a9a6676cf5b474e18b4731415.jpg', '0', '7');
INSERT INTO `fox_category` VALUES ('17', '电视', '2', '20180215/f8a3bc388b5e3d482bf89e15bed4d2b4.jpg', '0', '1');
INSERT INTO `fox_category` VALUES ('18', '空调', '2', '20180215/4db552348f4d046d5b1850836b26c976.jpg', '0', '2');
INSERT INTO `fox_category` VALUES ('19', '洗衣机', '2', '20180215/204474d43223dc5278aba1119e12089e.jpg', '0', '3');
INSERT INTO `fox_category` VALUES ('20', '冰箱', '2', '20180215/910b8a962c69b20f89aa7f02356e10d6.jpg', '0', '4');
INSERT INTO `fox_category` VALUES ('21', '电脑', '3', '20180215/2a82d46194946963fcd6e939aa879c51.jpg', '0', '1');
INSERT INTO `fox_category` VALUES ('22', '外设', '3', '20180215/d0d387ea162ecc520ff1c699d4673542.jpg', '0', '2');
INSERT INTO `fox_category` VALUES ('23', '办公设备', '3', '20180215/2c0092d2d387a7cccf34a732c9e74650.jpg', '0', '3');
INSERT INTO `fox_category` VALUES ('24', '家具', '4', '20180215/7b9f0be0b4c69715306d4b6521ee9515.jpg', '0', '1');
INSERT INTO `fox_category` VALUES ('25', '厨具', '4', '20180215/84cb93808a5a1dc0cf2a2e45f879c2fd.jpg', '0', '2');
INSERT INTO `fox_category` VALUES ('26', '女装', '5', '20180215/5fbb715520574252e310b4cbc019ea9e.jpg', '0', '1');
INSERT INTO `fox_category` VALUES ('27', '护肤', '6', '20180215/340404e32739c1c81006b43e51f3a844.jpg', '0', '1');
INSERT INTO `fox_category` VALUES ('28', '珠宝首饰', '7', '20180215/f8f1da2dc74391f7a88c6aad2785b222.jpg', '0', '1');

-- ----------------------------
-- Table structure for fox_community
-- ----------------------------
DROP TABLE IF EXISTS `fox_community`;
CREATE TABLE `fox_community` (
  `c_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `c_name` varchar(20) NOT NULL DEFAULT '' COMMENT '社区名',
  `c_address` varchar(50) NOT NULL DEFAULT '' COMMENT '小区收货地址',
  `communiter` varchar(20) NOT NULL DEFAULT '' COMMENT '团长名',
  `c_phone` varchar(12) NOT NULL DEFAULT '' COMMENT '团长电话',
  `coordinate` varchar(20) NOT NULL DEFAULT '' COMMENT '小区坐标',
  `referee` int(11) NOT NULL DEFAULT '0' COMMENT '推荐人',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '社区状态',
  `uid` int(11) NOT NULL DEFAULT '0',
  `c_reg_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '插入时间',
  `lng` varchar(20) NOT NULL DEFAULT '' COMMENT '经度',
  `lat` varchar(20) NOT NULL DEFAULT '' COMMENT '纬度',
  `total_commision` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '累计佣金',
  `present_commision` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '可提现佣金',
  `cash_commision` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '已提现佣金',
  `pay_commision` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '待打款佣金',
  `realname` varchar(50) NOT NULL DEFAULT '' COMMENT '提现的真实姓名',
  `wxacount` varchar(50) NOT NULL DEFAULT '' COMMENT '微信帐号',
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='社区表';

-- ----------------------------
-- Records of fox_community
-- ----------------------------
INSERT INTO `fox_community` VALUES ('1', '测试', '测试收获地址', '测试团长名', '13888888888', '', '0', '1', '12', '2018-10-10 10:39:47', '121.365959', '31.22628', '2723.57', '2156.46', '34.23', '601.11', '123', '123');
INSERT INTO `fox_community` VALUES ('2', '独立团', '广州市白云区', '李云龙', '10086', '', '0', '1', '11', '2018-10-15 15:25:56', '121.365959', '31.22628', '2006.82', '1021.82', '202.00', '3222.00', '昆路', '810964001');

-- ----------------------------
-- Table structure for fox_cron
-- ----------------------------
DROP TABLE IF EXISTS `fox_cron`;
CREATE TABLE `fox_cron` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `oid` int(11) unsigned NOT NULL DEFAULT '0',
  `order_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '订单状态 待付款0 已完成1 待发货2 待收货3 已取消4 待退款5 已退款6 拒绝退款7',
  `starttime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '开始时间',
  `endtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '结束时间',
  `status` tinyint(1) DEFAULT '0' COMMENT '定时操作 0 自动取消 1自动收货',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=228 DEFAULT CHARSET=utf8 COMMENT='定时表';

-- ----------------------------
-- Records of fox_cron
-- ----------------------------
INSERT INTO `fox_cron` VALUES ('125', '192', '0', '2018-10-18 16:41:31', '2018-10-18 16:51:31', '0');
INSERT INTO `fox_cron` VALUES ('126', '192', '0', '2018-10-18 16:43:38', '2018-10-18 16:53:38', '1');
INSERT INTO `fox_cron` VALUES ('127', '193', '0', '2018-10-18 16:46:07', '2018-10-18 18:27:07', '0');
INSERT INTO `fox_cron` VALUES ('128', '194', '0', '2018-10-18 16:47:18', '2018-10-18 18:28:18', '0');
INSERT INTO `fox_cron` VALUES ('129', '195', '0', '2018-10-18 16:48:58', '2018-10-18 18:29:58', '0');
INSERT INTO `fox_cron` VALUES ('130', '196', '0', '2018-10-18 16:49:15', '2018-10-18 18:30:15', '0');
INSERT INTO `fox_cron` VALUES ('131', '197', '0', '2018-10-18 16:50:36', '2018-10-18 18:31:36', '0');
INSERT INTO `fox_cron` VALUES ('132', '198', '0', '2018-10-18 16:51:16', '2018-10-18 18:32:16', '0');
INSERT INTO `fox_cron` VALUES ('133', '199', '0', '2018-10-18 16:53:51', '2018-10-18 18:34:51', '0');
INSERT INTO `fox_cron` VALUES ('134', '200', '0', '2018-10-18 17:13:30', '2018-10-18 18:54:30', '0');
INSERT INTO `fox_cron` VALUES ('135', '201', '0', '2018-10-18 17:22:45', '2018-10-18 19:03:45', '0');
INSERT INTO `fox_cron` VALUES ('136', '202', '0', '2018-10-19 11:13:33', '2018-10-19 12:54:33', '0');
INSERT INTO `fox_cron` VALUES ('137', '203', '0', '2018-10-19 11:26:51', '2018-10-19 13:07:51', '0');
INSERT INTO `fox_cron` VALUES ('138', '204', '0', '2018-10-19 11:38:39', '2018-10-19 13:19:39', '0');
INSERT INTO `fox_cron` VALUES ('139', '205', '0', '2018-10-19 14:09:54', '2018-10-19 15:50:54', '0');
INSERT INTO `fox_cron` VALUES ('140', '206', '0', '2018-10-19 14:35:37', '2018-10-19 16:16:37', '0');
INSERT INTO `fox_cron` VALUES ('141', '207', '0', '2018-10-19 14:35:52', '2018-10-19 16:16:52', '0');
INSERT INTO `fox_cron` VALUES ('142', '208', '0', '2018-10-19 14:38:47', '2018-10-19 16:19:47', '0');
INSERT INTO `fox_cron` VALUES ('143', '209', '0', '2018-10-19 14:40:45', '2018-10-19 16:21:45', '0');
INSERT INTO `fox_cron` VALUES ('144', '210', '0', '2018-10-19 16:10:15', '2018-10-19 17:51:15', '0');
INSERT INTO `fox_cron` VALUES ('145', '211', '0', '2018-10-19 17:43:56', '2018-10-19 19:24:56', '0');
INSERT INTO `fox_cron` VALUES ('146', '212', '0', '2018-10-20 14:44:33', '2018-10-20 16:25:33', '0');
INSERT INTO `fox_cron` VALUES ('147', '213', '0', '2018-10-20 16:09:26', '2018-10-20 17:50:26', '0');
INSERT INTO `fox_cron` VALUES ('148', '214', '0', '2018-10-22 17:37:43', '2018-10-22 19:18:43', '0');
INSERT INTO `fox_cron` VALUES ('149', '215', '0', '2018-10-23 15:25:48', '2018-10-23 17:06:48', '0');
INSERT INTO `fox_cron` VALUES ('150', '216', '0', '2018-10-23 16:42:42', '2018-10-23 18:23:42', '0');
INSERT INTO `fox_cron` VALUES ('151', '217', '0', '2018-10-23 17:56:41', '2018-10-23 19:37:41', '0');
INSERT INTO `fox_cron` VALUES ('152', '218', '0', '2018-10-25 09:57:47', '2018-10-25 11:38:47', '0');
INSERT INTO `fox_cron` VALUES ('153', '219', '0', '2018-10-25 10:04:17', '2018-10-25 11:45:17', '0');
INSERT INTO `fox_cron` VALUES ('154', '220', '0', '2018-10-25 16:26:36', '2018-10-25 18:07:36', '0');
INSERT INTO `fox_cron` VALUES ('155', '221', '0', '2018-10-25 17:20:58', '2018-10-25 19:01:58', '0');
INSERT INTO `fox_cron` VALUES ('156', '222', '0', '2018-10-26 16:41:31', '2018-10-26 18:22:31', '0');
INSERT INTO `fox_cron` VALUES ('157', '223', '0', '2018-10-27 15:09:06', '2018-10-27 16:50:06', '0');
INSERT INTO `fox_cron` VALUES ('158', '224', '0', '2018-10-27 15:22:51', '2018-10-27 17:03:51', '0');
INSERT INTO `fox_cron` VALUES ('159', '225', '0', '2018-10-27 15:36:23', '2018-10-27 17:17:23', '0');
INSERT INTO `fox_cron` VALUES ('160', '226', '0', '2018-10-27 17:32:27', '2018-10-27 19:13:27', '0');
INSERT INTO `fox_cron` VALUES ('161', '227', '0', '2018-11-01 09:19:05', '2018-11-01 11:00:05', '0');
INSERT INTO `fox_cron` VALUES ('162', '228', '0', '2018-11-01 10:22:14', '2018-11-01 12:03:14', '0');
INSERT INTO `fox_cron` VALUES ('163', '229', '0', '2018-11-01 10:24:15', '2018-11-01 12:05:15', '0');
INSERT INTO `fox_cron` VALUES ('164', '230', '0', '2018-11-01 14:18:33', '2018-11-01 15:59:33', '0');
INSERT INTO `fox_cron` VALUES ('165', '231', '0', '2018-11-01 15:08:30', '2018-11-01 16:49:30', '0');
INSERT INTO `fox_cron` VALUES ('166', '232', '0', '2018-11-02 09:50:19', '2018-11-02 11:31:19', '0');
INSERT INTO `fox_cron` VALUES ('167', '233', '0', '2018-11-02 10:08:27', '2018-11-02 11:49:27', '0');
INSERT INTO `fox_cron` VALUES ('168', '234', '0', '2018-11-02 11:22:48', '2018-11-02 13:03:48', '0');
INSERT INTO `fox_cron` VALUES ('169', '235', '0', '2018-11-03 10:30:29', '2018-11-03 12:11:29', '0');
INSERT INTO `fox_cron` VALUES ('170', '236', '0', '2018-11-03 16:00:22', '2018-11-03 17:41:22', '0');
INSERT INTO `fox_cron` VALUES ('171', '237', '0', '2018-11-05 10:15:50', '2018-11-05 11:56:50', '0');
INSERT INTO `fox_cron` VALUES ('172', '238', '0', '2018-11-05 10:17:10', '2018-11-05 11:58:10', '0');
INSERT INTO `fox_cron` VALUES ('173', '239', '0', '2018-11-05 10:18:15', '2018-11-05 11:59:15', '0');
INSERT INTO `fox_cron` VALUES ('174', '240', '0', '2018-11-05 10:20:20', '2018-11-05 12:01:20', '0');
INSERT INTO `fox_cron` VALUES ('175', '241', '0', '2018-11-05 10:35:23', '2018-11-05 12:16:23', '0');
INSERT INTO `fox_cron` VALUES ('176', '242', '0', '2018-11-05 10:36:21', '2018-11-05 12:17:21', '0');
INSERT INTO `fox_cron` VALUES ('177', '243', '0', '2018-11-05 10:38:35', '2018-11-05 12:19:35', '0');
INSERT INTO `fox_cron` VALUES ('178', '244', '0', '2018-11-05 10:39:58', '2018-11-05 12:20:58', '0');
INSERT INTO `fox_cron` VALUES ('179', '245', '0', '2018-11-05 12:51:20', '2018-11-05 14:32:20', '0');
INSERT INTO `fox_cron` VALUES ('180', '246', '0', '2018-11-05 16:31:50', '2018-11-05 18:12:50', '0');
INSERT INTO `fox_cron` VALUES ('181', '247', '0', '2018-11-05 16:32:08', '2018-11-05 18:13:08', '0');
INSERT INTO `fox_cron` VALUES ('182', '248', '0', '2018-11-05 17:06:46', '2018-11-05 18:47:46', '0');
INSERT INTO `fox_cron` VALUES ('183', '249', '0', '2018-11-05 17:07:46', '2018-11-05 18:48:46', '0');
INSERT INTO `fox_cron` VALUES ('184', '250', '0', '2018-11-05 17:08:11', '2018-11-05 18:49:11', '0');
INSERT INTO `fox_cron` VALUES ('185', '251', '0', '2018-11-05 17:08:23', '2018-11-05 18:49:23', '0');
INSERT INTO `fox_cron` VALUES ('186', '252', '0', '2018-11-05 17:08:32', '2018-11-05 18:49:32', '0');
INSERT INTO `fox_cron` VALUES ('187', '253', '0', '2018-11-05 17:09:25', '2018-11-05 18:50:25', '0');
INSERT INTO `fox_cron` VALUES ('188', '254', '0', '2018-11-05 17:17:09', '2018-11-05 18:58:09', '0');
INSERT INTO `fox_cron` VALUES ('189', '255', '0', '2018-11-05 17:18:15', '2018-11-05 18:59:15', '0');
INSERT INTO `fox_cron` VALUES ('190', '256', '0', '2018-11-05 17:19:02', '2018-11-05 19:00:02', '0');
INSERT INTO `fox_cron` VALUES ('191', '257', '0', '2018-11-05 17:19:55', '2018-11-05 19:00:55', '0');
INSERT INTO `fox_cron` VALUES ('192', '258', '0', '2018-11-05 17:20:23', '2018-11-05 19:01:23', '0');
INSERT INTO `fox_cron` VALUES ('193', '259', '0', '2018-11-05 17:21:05', '2018-11-05 19:02:05', '0');
INSERT INTO `fox_cron` VALUES ('194', '260', '0', '2018-11-05 17:23:50', '2018-11-05 19:04:50', '0');
INSERT INTO `fox_cron` VALUES ('195', '261', '0', '2018-11-05 17:24:41', '2018-11-05 19:05:41', '0');
INSERT INTO `fox_cron` VALUES ('196', '262', '0', '2018-11-05 17:26:03', '2018-11-05 19:07:03', '0');
INSERT INTO `fox_cron` VALUES ('197', '263', '0', '2018-11-05 17:31:51', '2018-11-05 19:12:51', '0');
INSERT INTO `fox_cron` VALUES ('198', '264', '0', '2018-11-06 09:43:23', '2018-11-06 11:24:23', '0');
INSERT INTO `fox_cron` VALUES ('199', '265', '0', '2018-11-06 09:45:59', '2018-11-06 11:26:59', '0');
INSERT INTO `fox_cron` VALUES ('200', '266', '0', '2018-11-06 09:46:29', '2018-11-06 11:27:29', '0');
INSERT INTO `fox_cron` VALUES ('201', '267', '0', '2018-11-06 09:46:54', '2018-11-06 11:27:54', '0');
INSERT INTO `fox_cron` VALUES ('202', '268', '0', '2018-11-06 09:49:45', '2018-11-06 11:30:45', '0');
INSERT INTO `fox_cron` VALUES ('203', '269', '0', '2018-11-06 09:52:11', '2018-11-06 11:33:11', '0');
INSERT INTO `fox_cron` VALUES ('204', '270', '0', '2018-11-06 09:53:47', '2018-11-06 11:34:47', '0');
INSERT INTO `fox_cron` VALUES ('205', '271', '0', '2018-11-06 09:58:21', '2018-11-06 11:39:21', '0');
INSERT INTO `fox_cron` VALUES ('206', '272', '0', '2018-11-06 09:59:12', '2018-11-06 11:40:12', '0');
INSERT INTO `fox_cron` VALUES ('207', '273', '0', '2018-11-06 10:07:30', '2018-11-06 11:48:30', '0');
INSERT INTO `fox_cron` VALUES ('208', '274', '0', '2018-11-06 10:13:16', '2018-11-06 11:54:16', '0');
INSERT INTO `fox_cron` VALUES ('209', '275', '0', '2018-11-06 10:13:58', '2018-11-06 11:54:58', '0');
INSERT INTO `fox_cron` VALUES ('210', '276', '0', '2018-11-06 10:16:20', '2018-11-06 11:57:20', '0');
INSERT INTO `fox_cron` VALUES ('211', '277', '0', '2018-11-06 10:17:37', '2018-11-06 11:58:37', '0');
INSERT INTO `fox_cron` VALUES ('212', '278', '0', '2018-11-06 10:18:00', '2018-11-06 11:59:00', '0');
INSERT INTO `fox_cron` VALUES ('213', '279', '0', '2018-11-06 10:18:44', '2018-11-06 11:59:44', '0');
INSERT INTO `fox_cron` VALUES ('214', '280', '0', '2018-11-06 14:54:57', '2018-11-06 16:35:57', '0');
INSERT INTO `fox_cron` VALUES ('215', '281', '0', '2018-11-06 16:40:51', '2018-11-06 18:21:51', '0');
INSERT INTO `fox_cron` VALUES ('216', '282', '0', '2018-11-06 16:41:10', '2018-11-06 18:22:10', '0');
INSERT INTO `fox_cron` VALUES ('217', '283', '0', '2018-11-06 16:41:23', '2018-11-06 18:22:23', '0');
INSERT INTO `fox_cron` VALUES ('218', '284', '0', '2018-11-06 16:41:33', '2018-11-06 18:22:33', '0');
INSERT INTO `fox_cron` VALUES ('219', '285', '0', '2018-11-06 16:41:45', '2018-11-06 18:22:45', '0');
INSERT INTO `fox_cron` VALUES ('220', '286', '0', '2018-11-06 17:03:31', '2018-11-06 18:44:31', '0');
INSERT INTO `fox_cron` VALUES ('221', '287', '0', '2018-11-06 17:05:31', '2018-11-06 18:46:31', '0');
INSERT INTO `fox_cron` VALUES ('222', '288', '0', '2018-11-08 10:28:40', '2018-11-08 12:09:40', '0');
INSERT INTO `fox_cron` VALUES ('223', '289', '0', '2018-11-08 10:34:53', '2018-11-08 12:15:53', '0');
INSERT INTO `fox_cron` VALUES ('224', '290', '0', '2018-11-08 11:12:52', '2018-11-08 12:53:52', '0');
INSERT INTO `fox_cron` VALUES ('225', '291', '0', '2018-11-08 11:13:34', '2018-11-08 12:54:34', '0');
INSERT INTO `fox_cron` VALUES ('226', '292', '0', '2018-11-08 11:15:33', '2018-11-08 12:56:33', '0');
INSERT INTO `fox_cron` VALUES ('227', '293', '0', '2018-11-13 11:33:10', '2018-11-13 13:14:10', '0');

-- ----------------------------
-- Table structure for fox_driver
-- ----------------------------
DROP TABLE IF EXISTS `fox_driver`;
CREATE TABLE `fox_driver` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `telephone` varchar(25) NOT NULL DEFAULT '',
  `reg_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='司机表';

-- ----------------------------
-- Records of fox_driver
-- ----------------------------
INSERT INTO `fox_driver` VALUES ('1', 'fa', '', '2018-10-09 11:18:12', '1');
INSERT INTO `fox_driver` VALUES ('2', '分啊', 'fe\'a', '2018-10-10 10:34:23', '1');

-- ----------------------------
-- Table structure for fox_goods
-- ----------------------------
DROP TABLE IF EXISTS `fox_goods`;
CREATE TABLE `fox_goods` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `cid_one` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '一级分类id',
  `cid_two` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '二级分类',
  `name` varchar(120) NOT NULL DEFAULT '' COMMENT '商品名称',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览量',
  `store` smallint(5) unsigned NOT NULL DEFAULT '10' COMMENT '库存数量',
  `collect` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏数',
  `price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '价格',
  `content` text CHARACTER SET utf16 COMMENT '商品描述',
  `img` varchar(200) NOT NULL DEFAULT '' COMMENT '商品图片',
  `sales` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '销量',
  `sort` smallint(4) unsigned NOT NULL DEFAULT '50' COMMENT '商品排序',
  `original` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '原价',
  `starttime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `endtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `video` varchar(200) NOT NULL DEFAULT '',
  `title` varchar(100) DEFAULT '',
  `limitsales` tinyint(3) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cat_id` (`cid_one`),
  KEY `goods_number` (`store`),
  KEY `sort_order` (`sort`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fox_goods
-- ----------------------------
INSERT INTO `fox_goods` VALUES ('1', '1', '8', 'Apple iPhone X (A1865) 256GB 深空灰色 移动联通电信4G手机', '42', '100', '0', '0.01', '', '20180216/166d6e04fa8ee1e9f0241efc26198011.jpg', '0', '1', '0.00', '2018-12-14 17:45:21', '2018-12-15 12:01:05', '1', '', '', '0');
INSERT INTO `fox_goods` VALUES ('2', '1', '8', 'Apple iPhone 8 Plus (A1864) 64GB 金色 移动联通电信4G手机', '9', '102', '0', '6688.00', '', '20180217/c61841f9bf2be8a7c50c91967b360fc2.jpg', '0', '2', '0.00', '2018-12-15 12:01:06', '2019-01-01 12:01:05', '1', '', '', '0');
INSERT INTO `fox_goods` VALUES ('3', '1', '8', '华为 HUAWEI Mate 10 Pro 全网通 6GB+128GB 银钻灰 移动联通电信4G手机 双卡双待', '10', '103', '0', '5399.00', '', '20180217/5664870c160d6c2097075aca6b8f9bcc.jpg', '0', '3', '0.00', '2018-12-15 12:01:06', '2018-12-29 12:01:05', '1', '', '', '0');
INSERT INTO `fox_goods` VALUES ('4', '1', '8', '华为 HUAWEI P10 Plus 全网通4G智能手机 钻雕金 6G+128G', '20', '103', '0', '4488.00', '', '20180217/15af57289c262eef3599171634f78b52.jpg', '3', '4', '0.00', '2018-10-10 17:45:21', '2018-12-15 12:01:05', '1', '', '', '0');
INSERT INTO `fox_goods` VALUES ('5', '1', '8', '小米MIX2 全网通 6GB 128GB 黑色 移动联通电信4G手机 双卡双待', '10', '105', '0', '3599.00', '', '20180217/17ba99b5a7d32a2b95181eb4ebe11490.jpg', '0', '5', '0.00', '2018-10-10 17:45:21', '2018-12-15 12:01:05', '1', '', '', '0');
INSERT INTO `fox_goods` VALUES ('6', '1', '8', '小米 Note2 全网通4G 移动联通电信全网通4G智能手机 亮黑色 6+128GB 全球版', '4', '104', '0', '2349.00', '', '20180217/669bbd371cf2bb17c711c18391bc249b.jpg', '2', '6', '0.00', '2018-10-10 17:45:21', '2018-12-15 12:01:05', '1', '', '', '0');
INSERT INTO `fox_goods` VALUES ('7', '1', '8', '魅族 PRO6S 4GB+64GB 全网通公开版 玫瑰金 移动联通电信4G手机 双卡双待', '7', '104', '0', '1499.00', '', '20180217/643a94466226ff1e9ae50fadd398cd86.jpg', '2', '7', '0.00', '2018-10-10 17:45:21', '2018-12-15 12:01:05', '1', '', '', '0');
INSERT INTO `fox_goods` VALUES ('8', '1', '8', '三星 Galaxy Note8（SM-N9500）6GB+128GB 谜夜黑 移动联通电信4G手机 双卡双待', '15', '96', '0', '7388.00', '', '20180217/da50f2928784fe1d1b9fcab3a2868a95.jpg', '5', '8', '0.00', '2018-10-10 17:45:21', '2018-12-15 12:01:05', '1', '', '', '0');
INSERT INTO `fox_goods` VALUES ('9', '1', '8', 'vivo X20 全面屏双摄拍照手机 6GB+64GB 移动联通电信全网通4G手机 双卡双待', '9', '110', '0', '3698.00', '', '20180217/a0e0f1bfbd4d598057849a9e35a006e4.jpg', '1', '9', '0.00', '2018-10-10 17:45:21', '2018-12-15 12:01:05', '1', '', '', '0');
INSERT INTO `fox_goods` VALUES ('10', '1', '8', '一加手机5T 8GB+128GB 星辰黑 全面屏双摄游戏手机 全网通4G 双卡双待', '11', '83', '0', '3499.00', '', '20180217/13aa8c8912575fccf66f2792d18e5f57.jpg', '120', '10', '0.00', '2018-10-10 17:45:21', '2018-12-15 12:01:05', '1', '', '', '0');
INSERT INTO `fox_goods` VALUES ('11', '1', '9', '毕亚兹(BIAZE) 苹果6/6S手机壳 iPhone6/6S保护套 全包防摔透明软壳 清爽系列', '23', '106', '0', '8.80', '', '20180217/783c94e65e2b8e7364e13c6afdebc73c.jpg', '2', '11', '0.00', '2018-10-10 17:45:21', '2018-12-15 12:01:05', '1', '', '', '0');
INSERT INTO `fox_goods` VALUES ('12', '1', '10', '索尼（SONY） DSC-RX100M5（RX100V）黑卡数码相机 等效24-70mm F1.8-2.8蔡司镜头', '19', '94', '0', '6149.00', '', '20180217/cf26ced45a4e314fd6b43d24b67e681d.jpg', '5', '12', '0.00', '2018-10-10 17:45:21', '2018-12-15 12:01:05', '1', '', '', '0');
INSERT INTO `fox_goods` VALUES ('13', '1', '11', '三星（SAMSUNG）存储卡128GB 读速100MB/s 写速90MB/s 4K Class10 高速TF卡（Micro SD卡）红色plus升级版', '34', '0', '0', '245.00', '', '20180217/da9172edb219502bfbcced2b60460a46.jpg', '4', '16', '0.00', '2018-10-10 17:45:21', '2018-12-15 12:01:05', '1', '', '133664646', '0');
INSERT INTO `fox_goods` VALUES ('14', '1', '12', 'JBL CM102 高保真蓝牙音响 HIFI音质 有源监听音箱 低音炮 多媒体电脑电视音响', '39', '96', '0', '999.00', '', '20180217/61a55e95cd6d66b7dd13f0012c67e830.jpg', '11', '1', '0.00', '2018-10-10 17:45:21', '2018-12-15 12:01:05', '1', '', '', '0');
INSERT INTO `fox_goods` VALUES ('15', '1', '13', '步步高家教机S3 香槟金64G 9.7英寸Retina视网膜屏安全护眼 学生平板电脑学习机 英语点读机点读笔早教机', '64', '109', '0', '3498.00', '', '20180217/20a182d48ccf9efeb09924ec4bdf8191.jpg', '8', '1', '0.00', '2018-10-10 17:45:21', '2018-12-15 12:01:05', '1', '', '', '0');
INSERT INTO `fox_goods` VALUES ('16', '1', '14', '华为手环B3 (蓝牙耳机与智能手环结合+金属机身+触控屏幕+真皮腕带) 商务版 摩卡棕', '107', '150', '0', '1199.00', '', '20180217/ebe473c60aa2371995298b4fd08740f8.jpg', '28', '1', '0.00', '2018-10-10 17:45:21', '2018-12-01 15:01:05', '1', '', '', '0');
INSERT INTO `fox_goods` VALUES ('17', '2', '17', '飞利浦（PHILIPS）65PUF6051/T3 65英寸 二级能效 丰富影视应用 64位4K超高清WIFI智能液晶电视机', '193', '186', '0', '4799.00', '', '20180217/47ea646c035727ea6938678aa8fb06cc.jpg', '17', '1', '0.00', '2018-10-10 17:45:21', '2018-12-01 16:00:00', '1', '', '', '0');
INSERT INTO `fox_goods` VALUES ('18', '2', '18', '格力（GREE）正1.5匹 变频 品圆 冷暖 壁挂式空调 KFR-35GW/(35592)FNhDa-A3', '4', '211', '0', '3399.00', '', '20180217/a6c348f4866c66fa0c742e24a3b7da38.jpg', '0', '1', '0.00', '2018-10-10 17:45:21', '2018-10-14 12:01:05', '1', '', '', '0');
INSERT INTO `fox_goods` VALUES ('19', '2', '19', '西门子 (SIEMENS) XQG80-WM12N1600W 8公斤 变频 滚筒洗衣机 缓震降噪 筒清洁 加漂洗', '4', '100', '0', '3899.00', '', '20180217/1077add1ba6f68fab4d7284f4c834633.jpg', '0', '1', '0.00', '2018-10-10 17:45:21', '2018-10-14 12:01:05', '1', '', '', '0');
INSERT INTO `fox_goods` VALUES ('20', '2', '20', '西门子（SIEMENS）610升 变频风冷无霜 对开门冰箱 LED显示速冷速冻（白色）', '40', '92', '0', '5999.02', '', '20180217/3bc0ebabc6b01ed5083377dc0b4f1e7a.jpg', '8', '1', '0.00', '2018-10-10 17:45:21', '2018-12-01 17:45:37', '1', '', '', '0');
INSERT INTO `fox_goods` VALUES ('21', '3', '21', '戴尔DELL灵越游匣Master15-R4645B 15.6英寸游戏笔记本电脑(i5-7300HQ 8G 128GSSD+1T GTX1050Ti 4G独显)黑', '73', '108', '0', '0.03', '', '20180217/5f1f549e3483239f35825f1d3a96399e.jpg', '15', '1', '0.00', '2018-10-10 17:45:21', '2018-12-01 17:45:37', '1', '', '', '50');
INSERT INTO `fox_goods` VALUES ('22', '3', '22', '酷冷至尊吃鸡键盘', '847', '72', '0', '0.05', '<p><img src=\"https://img.alicdn.com/imgextra/i2/2116524093/TB26w42qSYTBKNjSZKbXXXJ8pXa_!!2116524093.jpg\" width=\"169\" height=\"130\"/><img src=\"https://img.alicdn.com/imgextra/i2/2116524093/TB2MqXLqIUrBKNjSZPxXXX00pXa_!!2116524093.jpg\"/><img src=\"https://img.alicdn.com/imgextra/i1/2116524093/TB2UDRFqGQoBKNjSZJnXXaw9VXa_!!2116524093.jpg\"/><img src=\"https://img.alicdn.com/imgextra/i2/2116524093/TB26SgJqLImBKNjSZFlXXc43FXa_!!2116524093.jpg\"/><br/></p>', '20180218/6b67348b8114a2f4350461d8fd86222b.jpg', '53', '1', '99999.00', '2018-10-10 17:45:21', '2019-01-01 17:45:37', '1', '0011b3X7lx07oPcWNWyI01040200gGIa0k010.mp4', '键盘侠标配', '0');
INSERT INTO `fox_goods` VALUES ('23', '3', '23', '爱普生（EPSON）L360墨仓式打印机 家用彩色喷墨一体机（打印 复印 扫描）', '10', '120', '0', '999.00', '', '20180218/e4e4426956df9f4e1c910508a4a7ee0c.jpg', '0', '1', '0.00', '2018-10-10 17:45:21', '2018-10-10 17:45:37', '1', '', '', '0');
INSERT INTO `fox_goods` VALUES ('24', '4', '24', '测试商品1', '2', '121', '0', '3600.00', '', '20180218/230bde6df02385fcd1efac3396525271.jpg', '0', '1', '0.00', '2018-10-10 17:45:21', '2018-10-10 17:45:37', '1', '', '', '0');
INSERT INTO `fox_goods` VALUES ('25', '4', '25', '测试商品2', '2', '211', '0', '2288.00', '', '20180218/e1555f01cdfef4589057073713b40b07.jpg', '0', '1', '0.00', '2018-10-10 17:45:21', '2018-10-10 17:45:37', '1', '', '', '0');
INSERT INTO `fox_goods` VALUES ('26', '5', '26', 'intercrew打底衫女套头2018春新款长袖半高领修身保暖女装气质百搭打底弹力针织衫女 ICS1DR53A 黑色', '1', '233', '0', '109.00', '', '20180218/74810328c83ff36916cd2d93d71185d8.jpg', '0', '1', '0.00', '2018-10-10 17:45:21', '2018-10-10 17:45:37', '1', '', '', '0');
INSERT INTO `fox_goods` VALUES ('27', '6', '27', '欧莱雅（LOREAL）男士劲能极润护肤霜 50ml（补水保湿 护肤面霜）', '9', '211', '0', '119.00', '', '20180218/f1c370f07db0c2da32a5d061db359487.jpg', '0', '1', '0.00', '2018-10-10 17:45:21', '2018-10-25 16:35:37', '1', '', '欧莱雅', '0');
INSERT INTO `fox_goods` VALUES ('28', '7', '28', '测试商品3', '1', '124', '0', '1690.00', '', '20180218/3e9c6e937b9e5c3c98e7681d4c9449c6.jpg', '0', '1', '0.00', '2018-10-10 17:45:21', '2018-10-10 17:45:37', '1', '', '', '0');
INSERT INTO `fox_goods` VALUES ('30', '3', '21', '测试商品4', '43', '134', '0', '0.01', '', '20180218/964ed0315d3a6063ee8b223c3367f02c.jpg', '0', '2', '0.00', '2018-10-10 17:45:21', '2018-10-20 17:45:37', '0', '', '', '0');
INSERT INTO `fox_goods` VALUES ('31', '1', '8', 'admin', '5', '100', '0', '1231.00', null, '20180217/3bc0ebabc6b01ed5083377dc0b4f1e7a.jpg', '123', '0', '4546.00', '2018-10-24 00:00:00', '2018-10-25 00:00:00', '1', '', '4564', '1');

-- ----------------------------
-- Table structure for fox_goods_collect
-- ----------------------------
DROP TABLE IF EXISTS `fox_goods_collect`;
CREATE TABLE `fox_goods_collect` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `gid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  PRIMARY KEY (`id`),
  KEY `user_id` (`uid`) USING BTREE,
  KEY `goods_id` (`gid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fox_goods_collect
-- ----------------------------
INSERT INTO `fox_goods_collect` VALUES ('3', '1', '16');
INSERT INTO `fox_goods_collect` VALUES ('5', '1', '30');
INSERT INTO `fox_goods_collect` VALUES ('6', '3', '25');

-- ----------------------------
-- Table structure for fox_goods_images
-- ----------------------------
DROP TABLE IF EXISTS `fox_goods_images`;
CREATE TABLE `fox_goods_images` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品图片id',
  `gid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `img` varchar(200) NOT NULL DEFAULT '' COMMENT '图片地址',
  PRIMARY KEY (`id`),
  KEY `goods_id` (`gid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fox_goods_images
-- ----------------------------
INSERT INTO `fox_goods_images` VALUES ('1', '1', '20180217/a906ce80ba7113748dcaebeb24d86b99.jpg');
INSERT INTO `fox_goods_images` VALUES ('2', '1', '20180217/fa1eb05bf3a9d27ee323dbe1f598b82c.jpg');
INSERT INTO `fox_goods_images` VALUES ('3', '1', '20180217/f78993b92f58849cb9748f494ae71ce3.jpg');
INSERT INTO `fox_goods_images` VALUES ('4', '1', '20180217/ef089475c6da9fab11fe5d9c680f584d.jpg');
INSERT INTO `fox_goods_images` VALUES ('5', '1', '20180217/065f2c319d14bf245110cc2384151491.jpg');
INSERT INTO `fox_goods_images` VALUES ('6', '2', '20180217/60840318790e4c6ac4af94399e12813f.jpg');
INSERT INTO `fox_goods_images` VALUES ('7', '2', '20180217/f6c4ee6fcfe7d38fe30afb0aea059260.jpg');
INSERT INTO `fox_goods_images` VALUES ('8', '2', '20180217/14b52e6a84a22ad1bf6609c258807bfc.jpg');
INSERT INTO `fox_goods_images` VALUES ('9', '2', '20180217/f346deb3343a456f9eae30949a1e497f.jpg');
INSERT INTO `fox_goods_images` VALUES ('10', '3', '20180217/540234d2c61de110e41259d4c8c8465b.jpg');
INSERT INTO `fox_goods_images` VALUES ('11', '3', '20180217/9a423a0cad615c050f4962720a4e9a31.jpg');
INSERT INTO `fox_goods_images` VALUES ('12', '4', '20180217/df6b60744f155d362d580e5439c364cb.jpg');
INSERT INTO `fox_goods_images` VALUES ('13', '4', '20180217/91e54e90970eb53a6bf697abf1cdb5e7.jpg');
INSERT INTO `fox_goods_images` VALUES ('17', '5', '20180217/89a1c96ce454fa07ff3241fcb9beb399.jpg');
INSERT INTO `fox_goods_images` VALUES ('16', '5', '20180217/a7a40d84aba7b41e388c4b89a3aad2cb.jpg');
INSERT INTO `fox_goods_images` VALUES ('18', '5', '20180217/266fb41b31379510606a5eccc2e5871d.jpg');
INSERT INTO `fox_goods_images` VALUES ('19', '6', '20180217/88ff6e130c0b52b1170b69e9aefb758c.jpg');
INSERT INTO `fox_goods_images` VALUES ('20', '6', '20180217/8566ec9a9bfe76bc8dc1214955c97685.jpg');
INSERT INTO `fox_goods_images` VALUES ('21', '7', '20180217/73d23701a71819a4abbc00e07bbb7029.jpg');
INSERT INTO `fox_goods_images` VALUES ('22', '7', '20180217/fdfa635b5d1540d4555ad4a52e0437a1.jpg');
INSERT INTO `fox_goods_images` VALUES ('23', '8', '20180217/c9e27cebe8a04b6f717adb95682cebba.jpg');
INSERT INTO `fox_goods_images` VALUES ('24', '8', '20180217/8804bb3f4f1eb2f72b36d8de2c4a2d82.jpg');
INSERT INTO `fox_goods_images` VALUES ('25', '9', '20180217/4d468573c34bfe4e0961c6a4b80a2568.jpg');
INSERT INTO `fox_goods_images` VALUES ('26', '9', '20180217/5251c023dd3f7ecb24245d43a660adcc.jpg');
INSERT INTO `fox_goods_images` VALUES ('27', '10', '20180217/2ec5bae2013570a3962d9fda11828847.jpg');
INSERT INTO `fox_goods_images` VALUES ('28', '10', '20180217/d236282d232a0b0fb3d78a5be8c1b423.jpg');
INSERT INTO `fox_goods_images` VALUES ('29', '11', '20180217/9343f88d56e60375904215e2f01114a5.jpg');
INSERT INTO `fox_goods_images` VALUES ('30', '11', '20180217/4b80aa28c23f6d14d420f6309b4c7510.jpg');
INSERT INTO `fox_goods_images` VALUES ('31', '12', '20180217/0237420278173aa1ee98364db8f372cc.jpg');
INSERT INTO `fox_goods_images` VALUES ('32', '12', '20180217/05160cd8db0e68c5a031dc153b27b115.jpg');
INSERT INTO `fox_goods_images` VALUES ('33', '13', '20180217/de843658fa9974091989949b9ba2ce90.jpg');
INSERT INTO `fox_goods_images` VALUES ('34', '13', '20180217/5c9681a62e561c8416d07964032d7e69.jpg');
INSERT INTO `fox_goods_images` VALUES ('35', '14', '20180217/e626a24a8971d7d156943dcb92cee3da.jpg');
INSERT INTO `fox_goods_images` VALUES ('36', '14', '20180217/c1493d07ce070f0c62cfbcdb64facaa4.jpg');
INSERT INTO `fox_goods_images` VALUES ('37', '15', '20180217/b20fe76b42a1577ce82c7d5ba762b0ba.jpg');
INSERT INTO `fox_goods_images` VALUES ('38', '15', '20180217/b3a956ff77dca5d3b468dd8d9787c4d8.jpg');
INSERT INTO `fox_goods_images` VALUES ('39', '16', '20180217/4a031b248576a9554959fd0fcc01129e.jpg');
INSERT INTO `fox_goods_images` VALUES ('40', '16', '20180217/e9fa8d00c2c4a0f18e8d5d5467ad8254.jpg');
INSERT INTO `fox_goods_images` VALUES ('41', '17', '20180217/095b9bd21e8ed074988e6f9016e57bd7.jpg');
INSERT INTO `fox_goods_images` VALUES ('42', '17', '20180217/db87c33757a4d0888cb11e643a7dcb83.jpg');
INSERT INTO `fox_goods_images` VALUES ('43', '18', '20180217/585f9dc73e9c243b4825c969f768c400.jpg');
INSERT INTO `fox_goods_images` VALUES ('44', '18', '20180217/3ea4bf49482d5ad2784b5d7ef2bf6186.jpg');
INSERT INTO `fox_goods_images` VALUES ('45', '19', '20180217/7e64f881c088442e65abf2ec7b03c4c2.jpg');
INSERT INTO `fox_goods_images` VALUES ('46', '19', '20180217/f9ad368ceb740032bb05d881283f8172.jpg');
INSERT INTO `fox_goods_images` VALUES ('47', '21', '20180217/b7b304d4533b7d90570e425802a54efd.jpg');
INSERT INTO `fox_goods_images` VALUES ('48', '21', '20180217/a523a635fa9c1587d652f57974f3acc2.jpg');
INSERT INTO `fox_goods_images` VALUES ('49', '22', '20180218/6b67348b8114a2f4350461d8fd86222b.jpg');
INSERT INTO `fox_goods_images` VALUES ('50', '22', '20180218/1f796c7ab4a55e37774195e47b77a147.jpg');
INSERT INTO `fox_goods_images` VALUES ('51', '23', '20180218/8db53e0ceb03676751635d1a741b7549.jpg');
INSERT INTO `fox_goods_images` VALUES ('52', '23', '20180218/0de238910b014a83b7447801244207cf.jpg');
INSERT INTO `fox_goods_images` VALUES ('53', '24', '20180218/d6958ef6c4a32576953d976f8cfdd9c8.jpg');
INSERT INTO `fox_goods_images` VALUES ('54', '25', '20180218/b23141a164d5ed13ce63dfa616796ab5.jpg');
INSERT INTO `fox_goods_images` VALUES ('55', '25', '20180218/55cac7d1b01c509d43dae42cbdc59d1d.jpg');
INSERT INTO `fox_goods_images` VALUES ('56', '26', '20180218/97371cf86a8bb325c237c54d82d523f4.jpg');
INSERT INTO `fox_goods_images` VALUES ('57', '26', '20180218/e44db9bded9bb1dd13698003be7c761c.jpg');
INSERT INTO `fox_goods_images` VALUES ('58', '27', '20180218/468d8a332b838f0630be760507c5240f.jpg');
INSERT INTO `fox_goods_images` VALUES ('59', '27', '20180218/ca794889bc9c68f1846980d84c3677ea.jpg');
INSERT INTO `fox_goods_images` VALUES ('60', '28', '20180218/9b82d66bb93eb3d99fa3bd642211659d.jpg');
INSERT INTO `fox_goods_images` VALUES ('61', '28', '20180218/48a696a5335182ab648be7a8fc90f88a.jpg');
INSERT INTO `fox_goods_images` VALUES ('62', '30', '20180218/930b010d32a8b22e9ab41c1e0d45ce9a.jpg');
INSERT INTO `fox_goods_images` VALUES ('63', '30', '20180218/29a16ca312b47787be6a22331bad61e0.jpg');
INSERT INTO `fox_goods_images` VALUES ('64', '20', '20180220/19988e81d2c98f5703d1968dd3ae453b.jpg');
INSERT INTO `fox_goods_images` VALUES ('65', '20', '20180220/224155427e24b311f89e0e7e364e4fc5.jpg');

-- ----------------------------
-- Table structure for fox_mall
-- ----------------------------
DROP TABLE IF EXISTS `fox_mall`;
CREATE TABLE `fox_mall` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `overtime` tinyint(4) NOT NULL DEFAULT '0',
  `receive` tinyint(4) NOT NULL DEFAULT '0',
  `percent` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='商城表';

-- ----------------------------
-- Records of fox_mall
-- ----------------------------
INSERT INTO `fox_mall` VALUES ('1', '101', '100', '10');

-- ----------------------------
-- Table structure for fox_order
-- ----------------------------
DROP TABLE IF EXISTS `fox_order`;
CREATE TABLE `fox_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `order_sn` varchar(20) NOT NULL DEFAULT '' COMMENT '订单号，小程序中显示用',
  `order_sn_submit` varchar(20) NOT NULL DEFAULT '' COMMENT '订单号，微信支付时提交用，可变',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `order_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '订单状态 待付款0 已完成1 待发货2 待收货3 已取消4 待退款5 已退款6 拒绝退款7',
  `amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '订单总价',
  `submit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '下单时间',
  `deliver_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发货时间',
  `note` varchar(300) NOT NULL DEFAULT '' COMMENT '备注',
  `o_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '订单是否有效，0无效 1有效',
  `cid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '社区id',
  `did` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '司机id',
  `consignee` varchar(60) NOT NULL DEFAULT '' COMMENT '收货人',
  `address` varchar(200) NOT NULL DEFAULT '' COMMENT '地址',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '手机',
  `reason` varchar(300) NOT NULL DEFAULT '',
  `usernote` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_sn` (`order_sn`) USING BTREE,
  KEY `user_id` (`uid`) USING BTREE,
  KEY `order_status` (`order_status`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=294 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fox_order
-- ----------------------------
INSERT INTO `fox_order` VALUES ('293', '201811131133107422', '201811131133106051', '12', '0', '24773.00', '2018-11-13 11:33:10', '2018-11-13 11:33:10', '', '1', '1', '0', '123', '', '123', '', '');
INSERT INTO `fox_order` VALUES ('292', '201811081115339882', '201811081115337779', '12', '0', '1199.00', '2018-11-08 11:15:33', '2018-11-08 11:15:33', '', '1', '1', '0', '123', '', '123', '', '');
INSERT INTO `fox_order` VALUES ('291', '201811081113345217', '201811081114347802', '12', '0', '4799.00', '2018-11-08 11:13:34', '2018-11-08 11:13:34', '', '1', '1', '0', '123', '', '123', '', '');
INSERT INTO `fox_order` VALUES ('290', '201811081112526055', '201811081114384114', '12', '0', '0.09', '2018-11-08 11:12:52', '2018-11-08 11:12:52', '', '1', '1', '0', '123', '', '123', '', '');
INSERT INTO `fox_order` VALUES ('289', '201811081034532711', '201811081034534101', '12', '1', '5999.02', '2018-11-08 10:34:53', '2018-11-08 10:34:53', '', '1', '1', '0', '123', '', '123', '', '');
INSERT INTO `fox_order` VALUES ('286', '201811061703312578', '201811061703316145', '11', '6', '0.05', '2018-11-06 17:03:31', '2018-11-06 17:03:31', '', '1', '2', '0', '梁昆路', '', '13457587362', '', '');
INSERT INTO `fox_order` VALUES ('287', '201811061705319396', '201811061705311416', '11', '0', '0.05', '2018-11-06 17:05:31', '2018-11-06 17:05:31', '', '1', '2', '0', '梁昆路', '', '13457587362', '', '');
INSERT INTO `fox_order` VALUES ('288', '201811081028405632', '201811081028408303', '12', '1', '0.03', '2018-11-08 10:28:40', '2018-11-08 10:28:40', '', '1', '1', '0', '123', '', '123', '', '');
INSERT INTO `fox_order` VALUES ('281', '201811061640517560', '201811061640514264', '11', '4', '1200.00', '2018-11-06 16:40:51', '2018-11-06 16:40:51', '', '1', '2', '0', '王二锤', '', '13855556666', '', '');
INSERT INTO `fox_order` VALUES ('282', '201811061641106641', '201811061641103374', '11', '1', '5999.02', '2018-11-06 16:41:10', '2018-11-06 16:41:10', '', '1', '2', '0', '梁昆路', '', '13457587362', '', '');
INSERT INTO `fox_order` VALUES ('283', '201811061641234423', '201811061641237299', '11', '2', '4799.00', '2018-11-06 16:41:23', '2018-11-06 16:41:23', '', '1', '2', '0', '梁昆路', '', '13457587362', '', '');
INSERT INTO `fox_order` VALUES ('284', '201811061641333590', '201811061641337874', '11', '3', '3498.00', '2018-11-06 16:41:33', '2018-11-06 16:41:33', '', '1', '2', '0', '梁昆路', '', '13457587362', '', '');
INSERT INTO `fox_order` VALUES ('285', '201811061641453983', '201811061641459341', '11', '4', '6149.00', '2018-11-06 16:41:45', '2018-11-06 16:41:45', '', '1', '2', '0', '梁昆路', '', '13457587362', '', '');

-- ----------------------------
-- Table structure for fox_order_goods
-- ----------------------------
DROP TABLE IF EXISTS `fox_order_goods`;
CREATE TABLE `fox_order_goods` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `oid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单id',
  `gid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `num` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT '购买数量',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  PRIMARY KEY (`id`),
  KEY `order_id` (`oid`) USING BTREE,
  KEY `goods_id` (`gid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=334 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fox_order_goods
-- ----------------------------
INSERT INTO `fox_order_goods` VALUES ('86', '59', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('85', '57', '4', '2', '4488.00');
INSERT INTO `fox_order_goods` VALUES ('84', '57', '9', '2', '3698.00');
INSERT INTO `fox_order_goods` VALUES ('83', '57', '15', '1', '3498.00');
INSERT INTO `fox_order_goods` VALUES ('82', '57', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('81', '56', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('80', '55', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('79', '55', '13', '1', '245.00');
INSERT INTO `fox_order_goods` VALUES ('78', '55', '12', '1', '6149.00');
INSERT INTO `fox_order_goods` VALUES ('77', '54', '19', '2', '3899.00');
INSERT INTO `fox_order_goods` VALUES ('76', '53', '18', '1', '3399.00');
INSERT INTO `fox_order_goods` VALUES ('75', '52', '18', '1', '3399.00');
INSERT INTO `fox_order_goods` VALUES ('74', '45', '27', '1', '119.00');
INSERT INTO `fox_order_goods` VALUES ('73', '45', '28', '1', '1690.00');
INSERT INTO `fox_order_goods` VALUES ('72', '45', '30', '2', '0.01');
INSERT INTO `fox_order_goods` VALUES ('71', '44', '28', '1', '1690.00');
INSERT INTO `fox_order_goods` VALUES ('107', '105', '14', '1', '999.00');
INSERT INTO `fox_order_goods` VALUES ('106', '105', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('105', '104', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('104', '103', '17', '6', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('103', '102', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('102', '101', '1', '1', '0.01');
INSERT INTO `fox_order_goods` VALUES ('101', '100', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('100', '99', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('99', '98', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('98', '88', '16', '1', '1199.00');
INSERT INTO `fox_order_goods` VALUES ('97', '87', '16', '1', '1199.00');
INSERT INTO `fox_order_goods` VALUES ('96', '86', '16', '1', '1199.00');
INSERT INTO `fox_order_goods` VALUES ('95', '83', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('94', '82', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('93', '81', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('69', '43', '28', '1', '1690.00');
INSERT INTO `fox_order_goods` VALUES ('68', '43', '30', '1', '0.01');
INSERT INTO `fox_order_goods` VALUES ('67', '42', '24', '1', '3600.00');
INSERT INTO `fox_order_goods` VALUES ('66', '42', '25', '1', '2288.00');
INSERT INTO `fox_order_goods` VALUES ('70', '44', '30', '1', '0.01');
INSERT INTO `fox_order_goods` VALUES ('92', '71', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('91', '63', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('90', '62', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('89', '61', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('88', '60', '15', '1', '3498.00');
INSERT INTO `fox_order_goods` VALUES ('87', '60', '17', '2', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('108', '106', '13', '1', '245.00');
INSERT INTO `fox_order_goods` VALUES ('109', '106', '12', '1', '6149.00');
INSERT INTO `fox_order_goods` VALUES ('110', '106', '10', '1', '3499.00');
INSERT INTO `fox_order_goods` VALUES ('111', '106', '8', '1', '7388.00');
INSERT INTO `fox_order_goods` VALUES ('112', '107', '13', '2', '245.00');
INSERT INTO `fox_order_goods` VALUES ('113', '108', '13', '4', '245.00');
INSERT INTO `fox_order_goods` VALUES ('114', '109', '13', '4', '245.00');
INSERT INTO `fox_order_goods` VALUES ('115', '110', '13', '1', '245.00');
INSERT INTO `fox_order_goods` VALUES ('116', '111', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('117', '112', '7', '1', '1499.00');
INSERT INTO `fox_order_goods` VALUES ('118', '112', '15', '1', '3498.00');
INSERT INTO `fox_order_goods` VALUES ('119', '112', '17', '2', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('120', '113', '10', '26', '3499.00');
INSERT INTO `fox_order_goods` VALUES ('121', '113', '17', '6', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('122', '113', '30', '1', '0.01');
INSERT INTO `fox_order_goods` VALUES ('123', '114', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('124', '114', '16', '1', '1199.00');
INSERT INTO `fox_order_goods` VALUES ('125', '114', '15', '1', '3498.00');
INSERT INTO `fox_order_goods` VALUES ('126', '118', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('127', '118', '14', '1', '999.00');
INSERT INTO `fox_order_goods` VALUES ('128', '118', '11', '1', '8.80');
INSERT INTO `fox_order_goods` VALUES ('129', '118', '8', '6', '7388.00');
INSERT INTO `fox_order_goods` VALUES ('130', '119', '17', '2', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('131', '120', '12', '12', '6149.00');
INSERT INTO `fox_order_goods` VALUES ('132', '121', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('133', '122', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('134', '122', '15', '3', '3498.00');
INSERT INTO `fox_order_goods` VALUES ('135', '122', '14', '1', '999.00');
INSERT INTO `fox_order_goods` VALUES ('136', '122', '13', '1', '245.00');
INSERT INTO `fox_order_goods` VALUES ('137', '122', '11', '1', '8.80');
INSERT INTO `fox_order_goods` VALUES ('138', '122', '8', '1', '7388.00');
INSERT INTO `fox_order_goods` VALUES ('139', '123', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('140', '123', '15', '1', '3498.00');
INSERT INTO `fox_order_goods` VALUES ('141', '124', '14', '1', '999.00');
INSERT INTO `fox_order_goods` VALUES ('142', '125', '13', '1', '245.00');
INSERT INTO `fox_order_goods` VALUES ('143', '125', '12', '1', '6149.00');
INSERT INTO `fox_order_goods` VALUES ('144', '126', '15', '1', '3498.00');
INSERT INTO `fox_order_goods` VALUES ('145', '126', '14', '2', '999.00');
INSERT INTO `fox_order_goods` VALUES ('146', '126', '13', '1', '245.00');
INSERT INTO `fox_order_goods` VALUES ('147', '127', '13', '2', '245.00');
INSERT INTO `fox_order_goods` VALUES ('148', '128', '15', '1', '3498.00');
INSERT INTO `fox_order_goods` VALUES ('149', '129', '15', '1', '3498.00');
INSERT INTO `fox_order_goods` VALUES ('150', '130', '17', '10', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('151', '131', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('152', '132', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('153', '133', '13', '1', '245.00');
INSERT INTO `fox_order_goods` VALUES ('154', '133', '14', '1', '999.00');
INSERT INTO `fox_order_goods` VALUES ('155', '134', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('156', '135', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('157', '136', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('158', '137', '17', '2', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('159', '137', '16', '1', '1199.00');
INSERT INTO `fox_order_goods` VALUES ('160', '138', '13', '2', '245.00');
INSERT INTO `fox_order_goods` VALUES ('161', '138', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('162', '189', '16', '3', '1199.00');
INSERT INTO `fox_order_goods` VALUES ('163', '189', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('164', '189', '14', '1', '999.00');
INSERT INTO `fox_order_goods` VALUES ('165', '189', '13', '1', '245.00');
INSERT INTO `fox_order_goods` VALUES ('166', '190', '15', '1', '3498.00');
INSERT INTO `fox_order_goods` VALUES ('167', '190', '14', '1', '999.00');
INSERT INTO `fox_order_goods` VALUES ('168', '191', '17', '4', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('169', '191', '15', '1', '3498.00');
INSERT INTO `fox_order_goods` VALUES ('170', '191', '16', '2', '1199.00');
INSERT INTO `fox_order_goods` VALUES ('171', '191', '8', '1', '7388.00');
INSERT INTO `fox_order_goods` VALUES ('172', '192', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('173', '192', '16', '1', '1199.00');
INSERT INTO `fox_order_goods` VALUES ('174', '193', '16', '1', '1199.00');
INSERT INTO `fox_order_goods` VALUES ('175', '193', '14', '1', '999.00');
INSERT INTO `fox_order_goods` VALUES ('176', '193', '11', '1', '8.80');
INSERT INTO `fox_order_goods` VALUES ('177', '194', '17', '2', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('178', '194', '15', '1', '3498.00');
INSERT INTO `fox_order_goods` VALUES ('179', '195', '16', '1', '1199.00');
INSERT INTO `fox_order_goods` VALUES ('180', '195', '15', '1', '3498.00');
INSERT INTO `fox_order_goods` VALUES ('181', '195', '14', '1', '999.00');
INSERT INTO `fox_order_goods` VALUES ('182', '196', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('183', '197', '16', '2', '1199.00');
INSERT INTO `fox_order_goods` VALUES ('184', '198', '17', '3', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('185', '199', '17', '83', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('186', '200', '7', '1', '1499.00');
INSERT INTO `fox_order_goods` VALUES ('187', '200', '9', '1', '3698.00');
INSERT INTO `fox_order_goods` VALUES ('188', '200', '8', '1', '7388.00');
INSERT INTO `fox_order_goods` VALUES ('189', '201', '16', '2', '1199.00');
INSERT INTO `fox_order_goods` VALUES ('190', '201', '15', '1', '3498.00');
INSERT INTO `fox_order_goods` VALUES ('191', '202', '14', '1', '999.00');
INSERT INTO `fox_order_goods` VALUES ('192', '202', '8', '1', '7388.00');
INSERT INTO `fox_order_goods` VALUES ('193', '203', '15', '1', '3498.00');
INSERT INTO `fox_order_goods` VALUES ('194', '203', '4', '1', '4488.00');
INSERT INTO `fox_order_goods` VALUES ('195', '203', '6', '1', '2349.00');
INSERT INTO `fox_order_goods` VALUES ('196', '204', '16', '1', '1199.00');
INSERT INTO `fox_order_goods` VALUES ('197', '204', '10', '1', '3499.00');
INSERT INTO `fox_order_goods` VALUES ('198', '205', '4', '1', '4488.00');
INSERT INTO `fox_order_goods` VALUES ('199', '205', '16', '1', '1199.00');
INSERT INTO `fox_order_goods` VALUES ('200', '205', '12', '1', '6149.00');
INSERT INTO `fox_order_goods` VALUES ('201', '206', '16', '1', '1199.00');
INSERT INTO `fox_order_goods` VALUES ('202', '206', '14', '2', '999.00');
INSERT INTO `fox_order_goods` VALUES ('203', '206', '15', '1', '3498.00');
INSERT INTO `fox_order_goods` VALUES ('204', '206', '12', '1', '6149.00');
INSERT INTO `fox_order_goods` VALUES ('205', '207', '12', '1', '6149.00');
INSERT INTO `fox_order_goods` VALUES ('206', '208', '15', '1', '3498.00');
INSERT INTO `fox_order_goods` VALUES ('207', '208', '14', '1', '999.00');
INSERT INTO `fox_order_goods` VALUES ('208', '209', '8', '1', '7388.00');
INSERT INTO `fox_order_goods` VALUES ('209', '210', '16', '2', '1199.00');
INSERT INTO `fox_order_goods` VALUES ('210', '210', '12', '1', '6149.00');
INSERT INTO `fox_order_goods` VALUES ('211', '210', '11', '1', '8.80');
INSERT INTO `fox_order_goods` VALUES ('212', '211', '12', '1', '6149.00');
INSERT INTO `fox_order_goods` VALUES ('213', '211', '16', '1', '1199.00');
INSERT INTO `fox_order_goods` VALUES ('214', '212', '4', '1', '4488.00');
INSERT INTO `fox_order_goods` VALUES ('215', '212', '16', '2', '1199.00');
INSERT INTO `fox_order_goods` VALUES ('216', '212', '8', '1', '7388.00');
INSERT INTO `fox_order_goods` VALUES ('217', '213', '15', '1', '3498.00');
INSERT INTO `fox_order_goods` VALUES ('218', '213', '11', '1', '8.80');
INSERT INTO `fox_order_goods` VALUES ('219', '213', '8', '1', '7388.00');
INSERT INTO `fox_order_goods` VALUES ('220', '214', '16', '2', '1199.00');
INSERT INTO `fox_order_goods` VALUES ('221', '214', '17', '3', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('222', '215', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('223', '216', '10', '2', '3499.00');
INSERT INTO `fox_order_goods` VALUES ('224', '216', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('225', '217', '16', '1', '1199.00');
INSERT INTO `fox_order_goods` VALUES ('226', '217', '11', '1', '8.80');
INSERT INTO `fox_order_goods` VALUES ('227', '218', '12', '1', '6149.00');
INSERT INTO `fox_order_goods` VALUES ('228', '218', '11', '1', '8.80');
INSERT INTO `fox_order_goods` VALUES ('229', '219', '27', '1', '119.00');
INSERT INTO `fox_order_goods` VALUES ('230', '220', '14', '1', '999.00');
INSERT INTO `fox_order_goods` VALUES ('231', '220', '7', '1', '1499.00');
INSERT INTO `fox_order_goods` VALUES ('232', '220', '5', '1', '3599.00');
INSERT INTO `fox_order_goods` VALUES ('233', '220', '4', '1', '4488.00');
INSERT INTO `fox_order_goods` VALUES ('234', '220', '9', '1', '3698.00');
INSERT INTO `fox_order_goods` VALUES ('235', '221', '14', '1', '999.00');
INSERT INTO `fox_order_goods` VALUES ('236', '221', '9', '1', '3698.00');
INSERT INTO `fox_order_goods` VALUES ('237', '222', '21', '1', '6399.00');
INSERT INTO `fox_order_goods` VALUES ('238', '223', '21', '4', '6399.00');
INSERT INTO `fox_order_goods` VALUES ('246', '225', '22', '1', '1099.00');
INSERT INTO `fox_order_goods` VALUES ('240', '224', '21', '1', '6399.00');
INSERT INTO `fox_order_goods` VALUES ('247', '226', '21', '3', '6399.00');
INSERT INTO `fox_order_goods` VALUES ('242', '224', '20', '1', '5999.00');
INSERT INTO `fox_order_goods` VALUES ('243', '224', '15', '1', '3498.00');
INSERT INTO `fox_order_goods` VALUES ('244', '224', '14', '1', '999.00');
INSERT INTO `fox_order_goods` VALUES ('245', '224', '12', '1', '6149.00');
INSERT INTO `fox_order_goods` VALUES ('248', '226', '20', '4', '5999.00');
INSERT INTO `fox_order_goods` VALUES ('249', '227', '22', '2', '1099.00');
INSERT INTO `fox_order_goods` VALUES ('250', '228', '22', '2', '1099.00');
INSERT INTO `fox_order_goods` VALUES ('251', '229', '22', '1', '1099.00');
INSERT INTO `fox_order_goods` VALUES ('252', '230', '21', '1', '6399.00');
INSERT INTO `fox_order_goods` VALUES ('253', '231', '21', '6', '6399.01');
INSERT INTO `fox_order_goods` VALUES ('254', '231', '20', '2', '5999.02');
INSERT INTO `fox_order_goods` VALUES ('255', '231', '22', '1', '1099.00');
INSERT INTO `fox_order_goods` VALUES ('256', '232', '22', '1', '1099.00');
INSERT INTO `fox_order_goods` VALUES ('257', '233', '21', '2', '6399.01');
INSERT INTO `fox_order_goods` VALUES ('258', '234', '21', '1', '6399.01');
INSERT INTO `fox_order_goods` VALUES ('259', '234', '20', '1', '5999.02');
INSERT INTO `fox_order_goods` VALUES ('260', '234', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('261', '234', '16', '1', '1199.00');
INSERT INTO `fox_order_goods` VALUES ('262', '234', '15', '1', '3498.00');
INSERT INTO `fox_order_goods` VALUES ('263', '234', '14', '1', '999.00');
INSERT INTO `fox_order_goods` VALUES ('264', '234', '11', '1', '8.80');
INSERT INTO `fox_order_goods` VALUES ('265', '234', '7', '1', '1499.00');
INSERT INTO `fox_order_goods` VALUES ('266', '235', '12', '5', '6149.00');
INSERT INTO `fox_order_goods` VALUES ('267', '236', '4', '2', '4488.00');
INSERT INTO `fox_order_goods` VALUES ('268', '236', '21', '2', '6399.01');
INSERT INTO `fox_order_goods` VALUES ('269', '236', '20', '4', '5999.02');
INSERT INTO `fox_order_goods` VALUES ('270', '236', '14', '1', '999.00');
INSERT INTO `fox_order_goods` VALUES ('271', '237', '22', '1', '1099.00');
INSERT INTO `fox_order_goods` VALUES ('272', '238', '20', '1', '5999.02');
INSERT INTO `fox_order_goods` VALUES ('273', '238', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('274', '238', '21', '1', '6399.01');
INSERT INTO `fox_order_goods` VALUES ('275', '239', '22', '1', '0.01');
INSERT INTO `fox_order_goods` VALUES ('276', '240', '22', '2', '0.01');
INSERT INTO `fox_order_goods` VALUES ('277', '241', '22', '1', '0.01');
INSERT INTO `fox_order_goods` VALUES ('278', '242', '21', '1', '6399.01');
INSERT INTO `fox_order_goods` VALUES ('279', '243', '21', '1', '0.01');
INSERT INTO `fox_order_goods` VALUES ('280', '244', '22', '1', '0.01');
INSERT INTO `fox_order_goods` VALUES ('281', '245', '22', '1', '0.01');
INSERT INTO `fox_order_goods` VALUES ('282', '246', '22', '2', '0.01');
INSERT INTO `fox_order_goods` VALUES ('283', '247', '21', '1', '0.01');
INSERT INTO `fox_order_goods` VALUES ('284', '248', '22', '1', '0.01');
INSERT INTO `fox_order_goods` VALUES ('285', '249', '22', '1', '0.01');
INSERT INTO `fox_order_goods` VALUES ('286', '250', '22', '1', '0.01');
INSERT INTO `fox_order_goods` VALUES ('287', '251', '22', '1', '0.01');
INSERT INTO `fox_order_goods` VALUES ('288', '252', '21', '1', '0.01');
INSERT INTO `fox_order_goods` VALUES ('289', '253', '21', '1', '0.01');
INSERT INTO `fox_order_goods` VALUES ('290', '254', '22', '1', '0.01');
INSERT INTO `fox_order_goods` VALUES ('291', '255', '21', '1', '0.01');
INSERT INTO `fox_order_goods` VALUES ('292', '256', '22', '1', '0.01');
INSERT INTO `fox_order_goods` VALUES ('293', '257', '21', '1', '0.03');
INSERT INTO `fox_order_goods` VALUES ('294', '258', '21', '1', '0.03');
INSERT INTO `fox_order_goods` VALUES ('295', '259', '22', '1', '0.05');
INSERT INTO `fox_order_goods` VALUES ('296', '260', '22', '1', '0.05');
INSERT INTO `fox_order_goods` VALUES ('297', '261', '22', '1', '0.05');
INSERT INTO `fox_order_goods` VALUES ('298', '262', '22', '1', '0.05');
INSERT INTO `fox_order_goods` VALUES ('299', '263', '22', '1', '0.05');
INSERT INTO `fox_order_goods` VALUES ('300', '264', '22', '1', '0.05');
INSERT INTO `fox_order_goods` VALUES ('301', '265', '22', '1', '0.05');
INSERT INTO `fox_order_goods` VALUES ('302', '266', '22', '1', '0.05');
INSERT INTO `fox_order_goods` VALUES ('303', '267', '21', '1', '0.03');
INSERT INTO `fox_order_goods` VALUES ('304', '268', '22', '1', '0.05');
INSERT INTO `fox_order_goods` VALUES ('305', '269', '21', '1', '0.03');
INSERT INTO `fox_order_goods` VALUES ('306', '270', '22', '1', '0.05');
INSERT INTO `fox_order_goods` VALUES ('307', '271', '22', '1', '0.05');
INSERT INTO `fox_order_goods` VALUES ('308', '272', '22', '2', '0.05');
INSERT INTO `fox_order_goods` VALUES ('309', '273', '22', '1', '0.05');
INSERT INTO `fox_order_goods` VALUES ('310', '274', '22', '1', '0.05');
INSERT INTO `fox_order_goods` VALUES ('311', '275', '22', '1', '0.05');
INSERT INTO `fox_order_goods` VALUES ('312', '276', '22', '1', '0.05');
INSERT INTO `fox_order_goods` VALUES ('313', '277', '22', '1', '0.05');
INSERT INTO `fox_order_goods` VALUES ('314', '278', '22', '1', '0.05');
INSERT INTO `fox_order_goods` VALUES ('315', '279', '22', '1', '0.05');
INSERT INTO `fox_order_goods` VALUES ('316', '280', '22', '1', '0.05');
INSERT INTO `fox_order_goods` VALUES ('317', '281', '22', '20', '0.05');
INSERT INTO `fox_order_goods` VALUES ('318', '281', '16', '1', '1199.00');
INSERT INTO `fox_order_goods` VALUES ('319', '282', '20', '1', '5999.02');
INSERT INTO `fox_order_goods` VALUES ('320', '283', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('321', '284', '15', '1', '3498.00');
INSERT INTO `fox_order_goods` VALUES ('322', '285', '12', '1', '6149.00');
INSERT INTO `fox_order_goods` VALUES ('323', '286', '22', '1', '0.05');
INSERT INTO `fox_order_goods` VALUES ('324', '287', '22', '1', '0.05');
INSERT INTO `fox_order_goods` VALUES ('325', '288', '21', '1', '0.03');
INSERT INTO `fox_order_goods` VALUES ('326', '289', '20', '1', '5999.02');
INSERT INTO `fox_order_goods` VALUES ('327', '290', '21', '3', '0.03');
INSERT INTO `fox_order_goods` VALUES ('328', '291', '17', '1', '4799.00');
INSERT INTO `fox_order_goods` VALUES ('329', '292', '16', '1', '1199.00');
INSERT INTO `fox_order_goods` VALUES ('330', '293', '12', '1', '6149.00');
INSERT INTO `fox_order_goods` VALUES ('331', '293', '8', '2', '7388.00');
INSERT INTO `fox_order_goods` VALUES ('332', '293', '7', '1', '1499.00');
INSERT INTO `fox_order_goods` VALUES ('333', '293', '6', '1', '2349.00');

-- ----------------------------
-- Table structure for fox_payment
-- ----------------------------
DROP TABLE IF EXISTS `fox_payment`;
CREATE TABLE `fox_payment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `cid` int(10) unsigned NOT NULL DEFAULT '0',
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00',
  `leave` decimal(10,2) NOT NULL DEFAULT '0.00',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `detail` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='收支明细表';

-- ----------------------------
-- Records of fox_payment
-- ----------------------------
INSERT INTO `fox_payment` VALUES ('4', '1', '0.00', '2123.67', '2018-11-08 10:33:13', '确认收货');
INSERT INTO `fox_payment` VALUES ('5', '1', '599.90', '2723.57', '2018-11-08 10:35:25', '确认收货');
INSERT INTO `fox_payment` VALUES ('6', '2', '2.66', '1002.99', '2018-11-08 10:36:34', '工单打款');
INSERT INTO `fox_payment` VALUES ('7', '2', '3.50', '1006.49', '2018-11-08 10:36:59', '工单打款');
INSERT INTO `fox_payment` VALUES ('8', '1', '-111.11', '2612.46', '2018-11-08 10:41:04', '申请提现');
INSERT INTO `fox_payment` VALUES ('9', '1', '-456.00', '2156.46', '2018-11-08 11:07:28', '申请提现');
INSERT INTO `fox_payment` VALUES ('10', '2', '-985.00', '21.49', '2018-11-08 11:11:31', '申请提现');
INSERT INTO `fox_payment` VALUES ('11', '2', '1000.33', '1021.82', '2018-11-10 15:45:07', '工单打款');

-- ----------------------------
-- Table structure for fox_reward
-- ----------------------------
DROP TABLE IF EXISTS `fox_reward`;
CREATE TABLE `fox_reward` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL DEFAULT '0',
  `partner_trade_no` varchar(50) NOT NULL DEFAULT '' COMMENT '商户订单号',
  `rtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '提现时间',
  `amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '提现金额',
  `rstatus` tinyint(1) DEFAULT '0' COMMENT '提现状态 0待审核 1待打款 2微信打款3手动打款4审核不通过',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8 COMMENT='提现表';

-- ----------------------------
-- Records of fox_reward
-- ----------------------------
INSERT INTO `fox_reward` VALUES ('76', '2', '201810171646403537', '2018-10-17 16:46:40', '100.00', '3');
INSERT INTO `fox_reward` VALUES ('77', '2', '201810171649395481', '2018-10-17 16:49:39', '1.00', '4');
INSERT INTO `fox_reward` VALUES ('78', '2', '201810171650162917', '2018-10-17 16:50:16', '2.00', '3');
INSERT INTO `fox_reward` VALUES ('79', '2', '201810181652153460', '2018-10-18 16:52:15', '1.00', '1');
INSERT INTO `fox_reward` VALUES ('80', '2', '201810181652294089', '2018-10-18 16:52:29', '2.00', '0');
INSERT INTO `fox_reward` VALUES ('81', '2', '201810191114202724', '2018-10-19 11:14:20', '133.00', '0');
INSERT INTO `fox_reward` VALUES ('82', '2', '201810191127389020', '2018-10-19 11:27:38', '1111.00', '0');
INSERT INTO `fox_reward` VALUES ('83', '2', '201811021009204655', '2018-11-02 10:09:20', '111.00', '0');
INSERT INTO `fox_reward` VALUES ('84', '2', '201811051100231467', '2018-11-05 11:00:23', '1.00', '0');
INSERT INTO `fox_reward` VALUES ('85', '1', '201811081041047192', '2018-11-08 10:41:04', '111.11', '0');
INSERT INTO `fox_reward` VALUES ('86', '1', '201811081107285752', '2018-11-08 11:07:28', '456.00', '0');
INSERT INTO `fox_reward` VALUES ('87', '2', '201811081111319544', '2018-11-08 11:11:31', '985.00', '0');

-- ----------------------------
-- Table structure for fox_role
-- ----------------------------
DROP TABLE IF EXISTS `fox_role`;
CREATE TABLE `fox_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '角色名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 1：有效 0：无效',
  `updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次更新时间',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '插入时间',
  `act_list` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of fox_role
-- ----------------------------
INSERT INTO `fox_role` VALUES ('1', '123', '1', '2018-10-08 17:23:43', '2018-10-08 17:23:43', '');

-- ----------------------------
-- Table structure for fox_user
-- ----------------------------
DROP TABLE IF EXISTS `fox_user`;
CREATE TABLE `fox_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nickname` varchar(50) NOT NULL DEFAULT '' COMMENT '昵称',
  `head` varchar(200) NOT NULL DEFAULT '' COMMENT '头像 从小程序获取',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '用户金额',
  `total_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '消费累计',
  `reg_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `openid` varchar(200) NOT NULL DEFAULT '' COMMENT '微信验证后返回openid',
  `token` varchar(32) NOT NULL DEFAULT '',
  `token_time` int(10) unsigned NOT NULL DEFAULT '0',
  `cid` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fox_user
-- ----------------------------
INSERT INTO `fox_user` VALUES ('12', '小白大仁', 'https://wx.qlogo.cn/mmopen/vi_32/w78mQA44O5icCURZf2LXyLYx5rlRmJx9oobgJLraZFdoAZicOpnLLaduMfuj1H7NjoCjia5drpMY6dHTTyX3spTCA/132', '0.00', '0.00', '2018-10-19 09:39:18', 'ot7dc5Yhj1lGuU9BIFHPLVWOiPzA', 'EcDy7sCGSQAbaeuFFXNdDQspLgZnh3jH', '1542331333', '1');
INSERT INTO `fox_user` VALUES ('9', '小强', 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqr5TiaCRhulSQOwGwa8vb52ibMtibTMw8auN946nTHI8gQQXKb1YkaZ2BYjGgv3icfGLcosCicRg4sJNQ/132', '0.00', '0.00', '2018-10-15 10:00:44', 'ot7dc5cVO9s3_u5y2PlVPAgu1Wzk', '2n2Q4kuBDYwaHURRIeHzGwLB2SiOMUZx', '1541384102', '1');
INSERT INTO `fox_user` VALUES ('11', '路', 'https://wx.qlogo.cn/mmopen/vi_32/uOByCQXa9iawXcJsqiaZuiaiaoD05SOumzfgqJWX4qVNsk3ywoMWOic44lyJyfwwSoq7XPOAB5hAknFR5Wz8loyVFNQ/132', '0.00', '0.00', '2018-10-15 11:48:31', 'ot7dc5UU971fhL_Sfgrx6wgXU0xM', 'KiOuy1pLAxWSFN1x8hJXQWEQ9gUsSc4t', '1542332517', '2');

-- ----------------------------
-- Table structure for fox_user_role
-- ----------------------------
DROP TABLE IF EXISTS `fox_user_role`;
CREATE TABLE `fox_user_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  `role_id` int(11) NOT NULL DEFAULT '0' COMMENT '角色ID',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '插入时间',
  PRIMARY KEY (`id`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色表';

-- ----------------------------
-- Records of fox_user_role
-- ----------------------------

-- ----------------------------
-- Table structure for fox_workima
-- ----------------------------
DROP TABLE IF EXISTS `fox_workima`;
CREATE TABLE `fox_workima` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `wid` int(10) unsigned NOT NULL DEFAULT '0',
  `img` varchar(200) NOT NULL DEFAULT '' COMMENT '图片地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fox_workima
-- ----------------------------
INSERT INTO `fox_workima` VALUES ('4', '4', '20181023/d076c00c483bb58a34dcd1de12ba2523.jpg');
INSERT INTO `fox_workima` VALUES ('5', '4', '20181023/f080fffcb8fcbe06c411dd6104f99b7f.jpg');
INSERT INTO `fox_workima` VALUES ('6', '4', '20181023/98ceee5a86183de21f31d2443ab8b61c.jpg');
INSERT INTO `fox_workima` VALUES ('7', '4', '20181023/493638085072ea86c06cd8e21577d59c.jpg');
INSERT INTO `fox_workima` VALUES ('8', '4', '20181023/98ceee5a86183de21f31d2443ab8b61c.jpg');
INSERT INTO `fox_workima` VALUES ('9', '5', '20181023/2586f79e553b15d6faa25ea526acc24a.jpg');
INSERT INTO `fox_workima` VALUES ('10', '5', '20181023/3e458fccaecd8723fb3bba582d48de00.jpg');
INSERT INTO `fox_workima` VALUES ('11', '5', '20181023/3a39c390b9d45fde1c23cc20b2e60260.jpg');
INSERT INTO `fox_workima` VALUES ('12', '5', '20181023/8d865508e52a9237e1d9a61262977436.jpg');
INSERT INTO `fox_workima` VALUES ('13', '5', '20181023/31662004a944aee78bca0fe33268e076.jpg');
INSERT INTO `fox_workima` VALUES ('14', '6', '20181023/c07a71d7acf0fdbb3d5044786d223d6b.jpg');
INSERT INTO `fox_workima` VALUES ('15', '6', '20181023/793f19ed47c417a71cc6d941abe74875.jpg');
INSERT INTO `fox_workima` VALUES ('16', '7', '20181023/c4f624c72fc319fb74411171fdc64c7d.jpg');
INSERT INTO `fox_workima` VALUES ('17', '7', '20181023/d33e30fba4804aea2b567a7d5ac65ed2.jpg');
INSERT INTO `fox_workima` VALUES ('18', '7', '20181023/9bb312e5d9d3ab7b12cefbc609dbee67.jpg');
INSERT INTO `fox_workima` VALUES ('19', '7', '20181023/239f17b3610489639f897c5d74e0d3eb.jpg');
INSERT INTO `fox_workima` VALUES ('20', '7', '20181023/750f71b1373e0b72604dd4a545b1c1a0.jpg');
INSERT INTO `fox_workima` VALUES ('21', '8', '20181023/749bb2725193d994f344f1ada6bd5448.jpg');
INSERT INTO `fox_workima` VALUES ('22', '8', '20181023/803ec680210fbcbb7a5dc504d281c8f0.jpg');
INSERT INTO `fox_workima` VALUES ('23', '9', '20181023/63d08021adb822a502ca43052e037da7.jpg');
INSERT INTO `fox_workima` VALUES ('24', '9', '20181023/62e5deaf9395d550b2b60735f35de795.jpg');
INSERT INTO `fox_workima` VALUES ('25', '10', '20181024/8299b75f45e3f89979963bae20cb8cb5.jpg');
INSERT INTO `fox_workima` VALUES ('26', '10', '20181024/20b3ca23b9a5ca39b234e50dd431d0bc.jpg');
INSERT INTO `fox_workima` VALUES ('27', '10', '20181024/2f785f46044cbe11525959dab39d2be5.jpg');
INSERT INTO `fox_workima` VALUES ('28', '11', '20181027/d86c724bea226ec1b73d45a64543d11e.jpg');
INSERT INTO `fox_workima` VALUES ('29', '12', '20181027/bd4bad6c15e615b6d44733766a42d20f.jpg');
INSERT INTO `fox_workima` VALUES ('30', '12', '20181027/4d40ee011ceec23ecbe8fabbbc06f170.jpg');
INSERT INTO `fox_workima` VALUES ('31', '13', '20181027/8e10c64f4a06345c303d73548d9cf9c3.jpg');
INSERT INTO `fox_workima` VALUES ('32', '13', '20181027/dab5e2546bced55b8f864c7f5121f58b.jpg');
INSERT INTO `fox_workima` VALUES ('33', '13', '20181027/b9e23fbc985ca4a5d607815c5dced1d9.jpg');
INSERT INTO `fox_workima` VALUES ('34', '13', '20181027/cc884d000755a3cfab105ac4d7c7345d.jpg');
INSERT INTO `fox_workima` VALUES ('35', '14', '20181027/170b30b946ffedd9054a0943e30dbd03.jpg');
INSERT INTO `fox_workima` VALUES ('36', '14', '20181027/b3cbe7ba1509cf342381b8b882ecd4e8.jpg');
INSERT INTO `fox_workima` VALUES ('37', '14', '20181027/7919da9bb0d71dcef338bdc390440c69.jpg');
INSERT INTO `fox_workima` VALUES ('38', '14', '20181027/36f0c6c8acdbaf429ddf7453b4d4825e.jpg');
INSERT INTO `fox_workima` VALUES ('39', '14', '20181027/97919b50ee0ee76bce0da6160f1afced.jpg');
INSERT INTO `fox_workima` VALUES ('40', '15', '20181027/a67ffd559dccec626d5429803f35e831.jpg');
INSERT INTO `fox_workima` VALUES ('41', '16', '20181027/01aff9d867ac4ba32fbf709c6e1d441a.jpg');
INSERT INTO `fox_workima` VALUES ('42', '17', '20181027/92a9c2d405f5195296c5d39676095671.jpg');
INSERT INTO `fox_workima` VALUES ('43', '18', '20181027/211f4904b2bd5aa40d2e55c92ba9d915.jpg');
INSERT INTO `fox_workima` VALUES ('44', '19', '20181027/15da6152ead959184ae705691699c105.jpg');
INSERT INTO `fox_workima` VALUES ('45', '20', '20181027/18d9454a78c46dad73873466edf5b6cf.jpg');
INSERT INTO `fox_workima` VALUES ('46', '21', '20181028/317c0149882b280f345a3a5c5c029f02.jpg');
INSERT INTO `fox_workima` VALUES ('47', '22', '20181028/cc6f7896be0da875d1e9b46b9bf6ffd5.jpg');
INSERT INTO `fox_workima` VALUES ('48', '23', '20181028/00823f6695c2af782fbfd0b8469c4edd.jpg');
INSERT INTO `fox_workima` VALUES ('49', '23', '20181028/1f4ba2b5836e0bd95e421ba4da945fc3.jpg');
INSERT INTO `fox_workima` VALUES ('50', '24', '20181102/3c7e998347b2185b7396cbeff95c436e.jpg');
INSERT INTO `fox_workima` VALUES ('51', '25', '20181102/836e36f72fe2ea0894e3a00e76908575.jpg');
INSERT INTO `fox_workima` VALUES ('52', '25', '20181102/cda33af86f8e7b600c8a59483df7fe0d.jpg');
INSERT INTO `fox_workima` VALUES ('53', '25', '20181102/75cd4b09909a5f1d16fe360146364bb2.jpg');
INSERT INTO `fox_workima` VALUES ('54', '25', '20181102/ef5eb344b9b65efde6611c82287f87ed.jpg');
INSERT INTO `fox_workima` VALUES ('55', '25', '20181102/90980fadc84128873ae9be5280a0a37a.jpg');
INSERT INTO `fox_workima` VALUES ('56', '26', '20181103/1796ee6fff8325c2648637f1efd0b4a4.jpg');
INSERT INTO `fox_workima` VALUES ('57', '26', '20181103/8e2922274bf6d81cbc76efc6dc28b678.jpg');
INSERT INTO `fox_workima` VALUES ('58', '26', '20181103/060e9fc0ae5e906199e6044d9c89f49f.jpg');
INSERT INTO `fox_workima` VALUES ('59', '26', '20181103/3caecf6cf3dc4b72ea5c7c00e5557de9.jpg');
INSERT INTO `fox_workima` VALUES ('60', '26', '20181103/f2021d201e7cea8798a14010842f7261.jpg');
INSERT INTO `fox_workima` VALUES ('61', '27', '20181103/f17462381da5e719c53c17a8e8d35bdf.jpg');
INSERT INTO `fox_workima` VALUES ('62', '27', '20181103/988d2c19a22f239edbfffc1f83e89c98.jpg');
INSERT INTO `fox_workima` VALUES ('63', '27', '20181103/f64c01479aa454e9f58192215df6b257.jpg');
INSERT INTO `fox_workima` VALUES ('64', '27', '20181103/c48e89cc29a067805a04235163f1a29c.jpg');
INSERT INTO `fox_workima` VALUES ('65', '27', '20181103/70d432def6af8cd46bc4d7064b068895.jpg');
INSERT INTO `fox_workima` VALUES ('66', '28', '20181105/3e6270ff41b76f6b4698ee450f8d109d.jpg');
INSERT INTO `fox_workima` VALUES ('67', '28', '20181105/6722b40d08e2aee80ee9c9f1f991387f.jpg');
INSERT INTO `fox_workima` VALUES ('68', '28', '20181105/b4ad5010b633b8f672f88f12f18d5d98.jpg');
INSERT INTO `fox_workima` VALUES ('69', '28', '20181105/e2d4afa6efb76e4d13d5c6724ae6056d.jpg');
INSERT INTO `fox_workima` VALUES ('70', '28', '20181105/b4ad5010b633b8f672f88f12f18d5d98.jpg');
INSERT INTO `fox_workima` VALUES ('71', '29', '20181105/b3c6500bfe924e0d9f87e6bd5995bd2c.jpg');
INSERT INTO `fox_workima` VALUES ('72', '29', '20181105/4b9169969e021b75af84d94dcf96ff80.jpg');
INSERT INTO `fox_workima` VALUES ('73', '29', '20181105/67f29605010e9d74e15c31e23d75d8cc.jpg');
INSERT INTO `fox_workima` VALUES ('74', '29', '20181105/67f29605010e9d74e15c31e23d75d8cc.jpg');
INSERT INTO `fox_workima` VALUES ('75', '29', '20181105/991cda9f4df919bda31d49e4aaa6569b.jpg');

-- ----------------------------
-- Table structure for fox_workorder
-- ----------------------------
DROP TABLE IF EXISTS `fox_workorder`;
CREATE TABLE `fox_workorder` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cid` int(11) DEFAULT NULL,
  `ordersn` varchar(20) DEFAULT '',
  `des` varchar(500) DEFAULT '',
  `amount` decimal(10,2) DEFAULT '0.00',
  `create_time` timestamp NULL DEFAULT NULL,
  `status` tinyint(2) DEFAULT '0',
  `partner_trade_no` varchar(50) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='工单表';

-- ----------------------------
-- Records of fox_workorder
-- ----------------------------
INSERT INTO `fox_workorder` VALUES ('1', '1', '1', '1feaffeafaffeaaaaaaaaaaaaaaaaaa', '2.00', '2018-10-03 14:57:28', '1', '201810231559583747');
INSERT INTO `fox_workorder` VALUES ('2', '1', '123', 'faefeaoioijuoifeafa', '1000.33', '2018-10-22 17:13:19', '1', '201810231600481886');
INSERT INTO `fox_workorder` VALUES ('3', '1', '123', 'fae飞啊非gagrg工人56sg', '0.00', '2018-10-22 17:15:37', '2', '201810231600481886');
INSERT INTO `fox_workorder` VALUES ('4', '2', '1111', '描ggrsgsgsrgsgrsgssg艰苦艰苦艰苦艰苦艰苦艰苦艰苦艰苦描ggrsgsgsrgsgrsgssg艰苦艰苦艰苦艰苦艰苦艰苦艰苦艰苦描ggrsgsgsrgsgrsgssg艰苦艰苦艰苦艰苦艰苦艰苦艰苦艰苦描ggrsgsgsrgsgrsgssg艰苦艰苦艰苦艰苦艰苦艰苦艰苦艰苦描ggrsgsgsrgsgrsgssg艰苦艰苦艰苦艰苦艰苦艰苦艰苦艰苦描ggrsgsgsrgsgrsgssg艰苦艰苦艰苦艰苦艰苦艰苦艰苦艰苦描ggrsgsgsrgsgrsgssg艰苦艰苦艰苦艰苦艰苦艰苦艰苦艰苦描ggrsgsgsrgsgrsgssg艰苦艰苦艰苦艰苦艰苦艰苦艰苦艰苦描ggrsgsgsrgsgrsgssg艰苦艰苦艰苦艰苦艰苦艰苦艰苦艰苦', '2.66', '2018-10-23 15:01:36', '1', '201810231600481886');
INSERT INTO `fox_workorder` VALUES ('5', '2', '111', '2222描ggrsgsgsrgsgrsgssg艰苦艰苦艰苦艰苦艰苦艰苦艰苦艰苦描ggrsgsgsrgsgrsgssg艰苦艰苦艰苦艰苦艰苦艰苦艰苦艰苦描ggrsgsgsrgsgrsgssg艰苦艰苦艰苦艰苦艰苦艰苦艰苦艰苦', '3.50', '2018-10-23 15:04:36', '1', '201810231600481886');
INSERT INTO `fox_workorder` VALUES ('6', '2', '1002021020212020', 'des描ggrsgsgsrgsgrsgssg艰苦艰苦艰苦艰苦艰苦艰苦艰苦艰苦描ggrsgsgsrgsgrsgssg艰苦艰苦艰苦艰苦艰苦艰苦艰苦艰苦', '1000.33', '2018-10-23 15:23:30', '1', '');
INSERT INTO `fox_workorder` VALUES ('7', '2', '1', '12131描ggrsgsgsrgsgrsgssg艰苦艰苦艰苦艰苦艰苦艰苦艰苦艰苦描ggrsgsgsrgsgrsgssg艰苦艰苦艰苦艰苦艰苦艰苦艰苦艰苦', '1.00', '2018-10-23 17:34:05', '0', '201810231734056976');
INSERT INTO `fox_workorder` VALUES ('8', '1', '123123123', '12312312312描ggrsgsgsrgsgrsgssg艰苦艰苦艰苦艰苦艰苦艰苦艰苦艰苦描ggrsgsgsrgsgrsgssg艰苦艰苦艰苦艰苦艰苦艰苦艰苦艰苦', '1231.00', '2018-10-23 17:41:08', '1', '201810231741087587');
INSERT INTO `fox_workorder` VALUES ('9', '1', '123', '123123123描ggrsgsgsrgsgrsgssg艰苦艰苦艰苦艰苦艰苦艰苦艰苦艰苦描ggrsgsgsrgsgrsgssg艰苦艰苦艰苦艰苦艰苦艰苦艰苦飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊飞啊飞啊飞费啊艰飞啊飞啊飞费啊苦', '123.00', '2018-10-23 17:43:07', '1', '201810231743076696');
INSERT INTO `fox_workorder` VALUES ('10', '1', '123', '123', '123.00', '2018-10-24 14:20:53', '1', '201810241420523585');
INSERT INTO `fox_workorder` VALUES ('11', '2', '12', '3131', '21.00', '2018-10-27 15:18:33', '1', '201810271518336014');
INSERT INTO `fox_workorder` VALUES ('12', '2', '121', '11111', '111.00', '2018-10-27 15:21:05', '1', '201810271521057475');
INSERT INTO `fox_workorder` VALUES ('13', '2', '121', '12121', '121321.00', '2018-10-27 15:21:53', '0', '201810271521538684');
INSERT INTO `fox_workorder` VALUES ('14', '2', '111', '11111', '1111.00', '2018-10-27 15:22:05', '1', '201810271522058419');
INSERT INTO `fox_workorder` VALUES ('15', '2', '1', '131', '21.00', '2018-10-27 16:49:04', '2', '201810271649044091');
INSERT INTO `fox_workorder` VALUES ('16', '2', '1', '1', '1.00', '2018-10-27 16:58:02', '0', '201810271658026009');
INSERT INTO `fox_workorder` VALUES ('17', '2', '1', '22121', '111.00', '2018-10-27 17:19:00', '2', '201810271719006463');
INSERT INTO `fox_workorder` VALUES ('18', '2', '1', '3141', '21.00', '2018-10-27 17:20:01', '0', '201810271720013099');
INSERT INTO `fox_workorder` VALUES ('19', '2', '14', '2141', '343.00', '2018-10-27 17:20:14', '0', '201810271720145311');
INSERT INTO `fox_workorder` VALUES ('20', '2', '2131', '41212', '13141.00', '2018-10-27 17:20:43', '0', '201810271720436072');
INSERT INTO `fox_workorder` VALUES ('21', '2', '201810271720436072', '损坏变质', '10.00', '2018-10-28 15:08:19', '0', '201810281508191437');
INSERT INTO `fox_workorder` VALUES ('22', '2', '201810271720436072', '描述', '100.00', '2018-10-28 15:09:16', '0', '201810281509164633');
INSERT INTO `fox_workorder` VALUES ('23', '2', '201810271720436072', '描述', '11.00', '2018-10-28 15:09:44', '0', '201810281509442181');
INSERT INTO `fox_workorder` VALUES ('24', '2', '1213', '12121', '2121.00', '2018-11-02 10:10:44', '0', '201811021010442709');
INSERT INTO `fox_workorder` VALUES ('25', '2', '121312121', '121212', '121.00', '2018-11-02 10:12:07', '0', '201811021012072864');
INSERT INTO `fox_workorder` VALUES ('26', '2', '2555', '打个车打广告', '22.00', '2018-11-03 10:00:43', '0', '201811031000437702');
INSERT INTO `fox_workorder` VALUES ('27', '2', '11', '损坏', '1000.33', '2018-11-03 17:30:28', '1', '201811031730281218');
INSERT INTO `fox_workorder` VALUES ('28', '2', '1111111', '描述', '10086.00', '2018-11-05 10:23:34', '0', '201811051023348500');
INSERT INTO `fox_workorder` VALUES ('29', '2', '1008611', '描述', '10857.00', '2018-11-05 10:29:16', '0', '201811051029167361');
