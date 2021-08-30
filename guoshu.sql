
--1
CREATE TABLE `fox_admin` (
   `id` int(11) unsigned NOT NULL AUTO_INCREMENT, 
   `name` varchar(20) NOT NULL DEFAULT '' COMMENT '姓名',
    `email` varchar(30) NOT NULL DEFAULT '' COMMENT '邮箱',
    `is_admin` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是超级管理员 1表示是 0 表示不是',
    `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 1：有效 0：无效',
    `updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次更新时间',
   `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '插入时间',
    PRIMARY KEY (`id`),
    KEY `idx_email` (`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='用户表';

--2
CREATE TABLE `fox_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '角色名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 1：有效 0：无效',
  `updated_time` timestamp NOT NULL DEFAULT curent_timestamp COMMENT '最后一次更新时间',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '插入时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表';

--3
CREATE TABLE `fox_user_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
   `role_id` int(11) NOT NULL DEFAULT '0' COMMENT '角色ID',
   `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '插入时间',
   PRIMARY KEY (`id`),
   KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色表';

--4
CREATE TABLE `fox_access` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL COMMENT '权限名字',
  `group` varchar(20) DEFAULT NULL COMMENT '所属分组',
  `right` text COMMENT '权限码(控制器+动作)',
  `is_del` tinyint(1) DEFAULT '0' COMMENT '删除状态 1删除,0正常',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COMMENT '权限详情表';

--5
CREATE TABLE `fox_community` (
	`c_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
	`c_name` varchar(20) NOT NULL DEFAULT '' COMMENT '社区名',
	`c_address` varchar(50) NOT NULL DEFAULT '' COMMENT '小区收货地址',
	`communiter` varchar(20) NOT NULL DEFAULT '' COMMENT '团长名',
	`c_phone` varchar(12) NOT NULL DEFAULT '' COMMENT '团长电话',
	`coordinate` varchar(20) NOT NULL DEFAULT '' COMMENT '小区坐标',  --废用
	`referee` int(11) NOT NULL DEFAULT 0 COMMENT '推荐人',
	`status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '社区状态',
	`lng` varchar(20) NOT NULL DEFAULT '' COMMENT '经度',
	`lat` varchar(20) NOT NULL DEFAULT '' COMMENT '纬度',
	`uid` int(11) NOT NUll DEFAULT 0 COMMENT '用户id',
	`c_reg_time`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '插入时间',
	`realname` varchar(50) not null default '' comment '提现的真实姓名',
	`wxacount` varchar(50) not null default '' comment '微信帐号',
	`total_commision`  decimal(10,2)   not null default 0.00 comment '累计佣金';
	`present_commision`  decimal(10,2)   not null default 0.00 comment '可提现佣金';
	`cash_commision` decimal(10,2)   not null default 0.00 comment '已提现佣金';
	`pay_commision` decimal(10,2)   not null default 0.00 comment '待打款佣金';
	PRIMARY KEY (`c_id`)
)ENGINE InnoDB CHARSET utf8 COMMENT '社区表' ;


CREATE TABLE `fox_driver`(
	`id` int(11) unsigned NOT NULL AUTO_INCREMENT,
	`name` varchar(50) NOT NUll DEFAULT '',
	`telephone` varchar(25) NOT NUll DEFAULT '',
	`reg_time` timestamp NOT NUll DEFAULT CURRENT_TIMESTAMP ,
	`status` tinyint(1) NOT NULL DEFAULT 1,
	PRIMARY KEY (id)
)ENGINE InnoDB CHARSET utf8 COMMENT '司机表';

CREATE TABLE `fox_cron` (
	`id` int(11) unsigned not null AUTO_INCREMENT,
	`oid` int(11) unsigned not null default 0,
	`order_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '订单状态 待付款0 已完成1 待发货2 待收货3 已取消4 待退款5 已退款6 拒绝退款7',
	`starttime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '开始时间',
	`endtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '结束时间',
	`status` tinyint(1) default 0 comment '定时操作 0 自动取消 1自动收货',
	primary key (`id`)
)engine innodb charset utf8 comment '定时表';

CREATE TABLE `fox_reward` (
	`id` int(11) unsigned NOT NULL AUTO_INCREMENT,
	`cid` int(11) not null default 0,
	`partner_trade_no` varchar(50) not null default '' comment '商户订单号',
	`rtime` timestamp not null default current_timestamp comment '提现时间',
	`amount` decimal(10,2) unsigned not null default 0 comment '提现金额',
	`rstatus` tinyint(1) default 0 comment '提现状态 0待审核 1待打款 2微信打款3手动打款4审核不通过',
	primary key(`id`)
)engine innodb charset utf8 comment '提现表';

CREATE TABLE `fox_mall` (
  `id` int(11) unsigned not null auto_increment,
  `overtime` tinyint not null default 0,
  `receive` tinyint not null default 0,
  `percent` tinyint not null default 0,
  primary key(`id`)
)engine innodb charset utf8 comment '商城表';


CREATE TABLE `fox_workorder`(
	`id` int(11) unsigned not null auto_increment primary key,
	`cid` int(11) ,
	`ordersn` varchar(20) default '',
	`des` varchar(500) default '',
	`amount` decimal(10,2) default 0,
	`create_time` timestamp ,
	`partner_trade_no` varchar(32) default '',
	`status` tinyint(2) default 0
)engine innodb charset utf8 comment '工单表';

CREATE TABLE `fox_workima` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `wid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '',
  `img` varchar(200) NOT NULL DEFAULT '' COMMENT '图片地址',
  PRIMARY KEY (`id`)
) ENGINE=innodb AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `fox_payment`(
  `id` int(10) unsigned not null auto_increment primary key comment 'id',
  `cid` int(10) unsigned not null default 0,
  `balance` decimal(10,2) not null default 0,
  `leave` decimal(10,2) not null default 0,
  `detail` varchar(20) not null default '',
  `create_time` timestamp default CURRENT_TIMESTAMP
)engine innodb charset utf8 comment '收支明细表';


/*
 *
*/
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
  `cid` int(10) unsigned not null default 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT '用户表';


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



CREATE TABLE `fox_address` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0',
  `consignee` varchar(60) NOT NULL DEFAULT '' COMMENT '收货人',
  `address` varchar(200) NOT NULL DEFAULT '' COMMENT '地址',
  `mobile` varchar(12) NOT NULL DEFAULT '' COMMENT '手机',
  `is_default` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '默认收货地址',
  PRIMARY KEY (`id`),
  KEY `user_id` (`uid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;



CREATE TABLE `fox_cart` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `gid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `name` varchar(200) NOT NULL DEFAULT '' COMMENT '商品名称',
  `price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '价格',
  `num` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '购买数量',
  `selected` tinyint(1) unsigned DEFAULT '1' COMMENT '购物车选中状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;



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
  `starttime` timestamp NOT NULL default current_timestamp ,
  `endtime` timestamp Not null default current_timestamp,
  `status` tinyint(1) not null default 1,
  `video` varchar(200) not null default '',
  `title` varchar(100) not null default '',
  'limitsales' tinyint(3) not null default 0
  PRIMARY KEY (`id`),
  KEY `cat_id` (`cid_one`),
  KEY `goods_number` (`store`),
  KEY `sort_order` (`sort`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;



CREATE TABLE `fox_goods_collect` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `gid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  PRIMARY KEY (`id`),
  KEY `user_id` (`uid`) USING BTREE,
  KEY `goods_id` (`gid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;


CREATE TABLE `fox_goods_images` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品图片id',
  `gid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `img` varchar(200) NOT NULL DEFAULT '' COMMENT '图片地址',
  PRIMARY KEY (`id`),
  KEY `goods_id` (`gid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `fox_order`;
CREATE TABLE `fox_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `order_sn` varchar(20) NOT NULL DEFAULT '' COMMENT '订单号，小程序中显示用',
  `order_sn_submit` varchar(20) NOT NULL DEFAULT '' COMMENT '订单号，微信支付时提交用，可变',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `cid` int(11) unsigned not null default 0 comment '社区id',
  `did` int(11) unsigned not null default 0 comment '司机id',
  `order_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '订单状态 待付款0 已完成1 待发货2 待收货3 已取消4 待退款5 已退款6 拒绝退款7',
  `consignee` varchar(60) NOT NULL DEFAULT '' COMMENT '收货人',
  `address` varchar(200) NOT NULL DEFAULT '' COMMENT '地址',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '手机',
  `amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '订单总价',
  `submit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '下单时间',
  `deliver_time` timestamp not null default CURRENT_TIMESTAMP comment '发货时间',
  `note` varchar(300) not null default '' comment '备注',
  `usernote` varchar(200) not null default '' comment '',
  `reason` varchar(300) not null default '' ,
  `o_status` tinyint(1) not null default 1 comment '订单是否有效，0无效 1有效',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_sn` (`order_sn`) USING BTREE,
  KEY `user_id` (`uid`) USING BTREE,
  KEY `order_status` (`order_status`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;



DROP TABLE IF EXISTS `fox_order_goods`;
CREATE TABLE `fox_order_goods` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `oid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单id',
  `gid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `num` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT '购买数量',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '单个商品价格',
  PRIMARY KEY (`id`),
  KEY `order_id` (`oid`) USING BTREE,
  KEY `goods_id` (`gid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;





