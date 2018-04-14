/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50540
Source Host           : localhost:3306
Source Database       : db_zwxt

Target Server Type    : MYSQL
Target Server Version : 50540
File Encoding         : 65001

Date: 2018-04-14 15:26:25
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for file
-- ----------------------------
DROP TABLE IF EXISTS `file`;
CREATE TABLE `file` (
  `FileID` varchar(100) NOT NULL,
  `SectionID` varchar(100) DEFAULT NULL,
  `FileName` varchar(500) DEFAULT NULL,
  `PhotoID` int(10) DEFAULT NULL,
  `FileClick` int(10) DEFAULT NULL,
  `FileComment` varchar(500) DEFAULT NULL,
  `FileLike` varchar(500) DEFAULT NULL,
  `FileTime` varchar(100) DEFAULT NULL,
  `FileContent` varchar(100) DEFAULT NULL,
  `FileAuthor` varchar(100) DEFAULT NULL,
  `FileType` varchar(100) DEFAULT NULL,
  `PhotoTypeID` varchar(100) DEFAULT NULL,
  `FileRecommend` varchar(100) DEFAULT NULL,
  `PMID` varchar(100) DEFAULT NULL,
  `FileValue` varchar(100) DEFAULT NULL,
  `FileHot` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`FileID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of file
-- ----------------------------

-- ----------------------------
-- Table structure for livebroadcast
-- ----------------------------
DROP TABLE IF EXISTS `livebroadcast`;
CREATE TABLE `livebroadcast` (
  `LiveBroadcastID` varchar(100) NOT NULL,
  `LiveBroadcastName` varchar(100) DEFAULT NULL,
  `LiveBroadcastPhotoUrl` varchar(500) DEFAULT NULL,
  `LiveBroadcastType` int(10) DEFAULT NULL,
  `LiveBroadcastLike` int(10) DEFAULT NULL,
  `LiveBroadcastContent` varchar(500) DEFAULT NULL,
  `LiveBroadcastVideoUrl` varchar(500) DEFAULT NULL,
  `LiveBroadcastBeginTime` datetime DEFAULT NULL,
  `LiveBroadcastEndTime` datetime DEFAULT NULL,
  `LiveBroadcastLength` time DEFAULT NULL,
  `LiveBroadcastTime` datetime DEFAULT NULL,
  `Hot` bit(1) DEFAULT NULL,
  PRIMARY KEY (`LiveBroadcastID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of livebroadcast
-- ----------------------------
INSERT INTO `livebroadcast` VALUES ('0849d8f2-3f37-11e8-b9c1-f04da295e1ca', 'asdsd', 'http://127.0.0.1:8088/store/uploadFiles/uploadImgs/LiveBroadcastPhotoUrl/20180414/70281ffd60c44837aaa92635ebb6da31.jpg', '1', null, '<p>asd</p>', 'http://127.0.0.1:8088/store/uploadFiles/uploadImgs/LiveBroadcastVideoUrl/20180414/201804142.mp4', null, null, '00:00:59', '2018-04-14 00:23:21', '\0');
INSERT INTO `livebroadcast` VALUES ('1', 'test26', 'http://127.0.0.1:8088/store/uploadFiles/uploadImgs/LiveBroadcastPhotoUrl/20171125/53943e5537be4b3586b6e492e78d06e5.jpg', '0', null, '<p>大三的感觉哈桑的急啊不睡觉20418</p>', 'http://127.0.0.1:8088/store/uploadFiles/uploadImgs/LiveBroadcastVideoUrl/20171125/201711253.mp4', '2017-11-09 00:00:00', '2018-01-12 00:00:00', '00:00:59', '2017-11-27 16:46:38', null);
INSERT INTO `livebroadcast` VALUES ('1ab7ecc4-3f37-11e8-b9c1-f04da295e1ca', 'asd', null, '0', null, '', null, '2018-04-14 12:20:00', '2018-03-29 03:10:00', '00:00:00', '2018-04-14 00:23:52', '\0');
INSERT INTO `livebroadcast` VALUES ('2', '直播直播变录播yy44', 'http://127.0.0.1:8088/store/uploadFiles/uploadImgs/LiveBroadcastPhotoUrl/20171125/ed050d2197d14e739a83cb49f46d181c.jpg', '1', null, '<p>大大阿斯达阿瑟<br/></p>', 'http://127.0.0.1:8088/store/uploadFiles/uploadImgs/LiveBroadcastVideoUrl/20171125/201711256.mp4', null, null, '00:00:59', '2017-11-25 16:19:36', null);
INSERT INTO `livebroadcast` VALUES ('3', '我是录播视频12yy', 'http://127.0.0.1:8088/store/uploadFiles/uploadImgs/LiveBroadcastPhotoUrl/20171125/51963faa233c4f1a8e20db8b112119f1.jpg', '1', null, '<p>录播12</p>', 'http://127.0.0.1:8088/store/uploadFiles/uploadImgs/LiveBroadcastVideoUrl/20171125/201711257.flv', null, null, '00:51:08', '2017-11-25 11:18:22', null);
INSERT INTO `livebroadcast` VALUES ('311e32b2-3f37-11e8-b9c1-f04da295e1ca', 'ttttt', null, '0', null, '', null, '2018-04-14 12:24:00', '2018-04-14 12:24:00', '00:00:00', '2018-04-14 00:24:29', '\0');
INSERT INTO `livebroadcast` VALUES ('4', 'we', 'http://127.0.0.1:8080/store/uploadFiles/uploadImgs/LiveBroadcastPhotoUrl/20171127/b092a857d5ba4c6a96355e9b0da5306d.jpg', '0', null, '<p>ew</p>', 'http://127.0.0.1:8080/store/uploadFiles/uploadImgs/LiveBroadcastVideoUrl/20171127/201711278.mp4', null, null, '00:00:59', '2017-11-27 16:37:32', null);
INSERT INTO `livebroadcast` VALUES ('bbec7ca2-3f36-11e8-b9c1-f04da295e1ca', 'test26', 'http://127.0.0.1:8088/store/uploadFiles/uploadImgs/LiveBroadcastPhotoUrl/20171125/53943e5537be4b3586b6e492e78d06e5.jpg', '0', null, '<p>大三的感觉哈桑的急啊不睡觉20418</p>', 'http://127.0.0.1:8088/store/uploadFiles/uploadImgs/LiveBroadcastVideoUrl/20171125/201711253.mp4', '2017-11-09 00:00:00', '2018-01-12 00:00:00', '00:00:59', '2017-11-27 16:46:38', null);

-- ----------------------------
-- Table structure for sys_app_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_app_user`;
CREATE TABLE `sys_app_user` (
  `USER_ID` varchar(100) NOT NULL,
  `USERNAME` varchar(255) DEFAULT NULL,
  `PASSWORD` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `RIGHTS` varchar(255) DEFAULT NULL,
  `ROLE_ID` varchar(100) DEFAULT NULL,
  `LAST_LOGIN` varchar(255) DEFAULT NULL,
  `IP` varchar(100) DEFAULT NULL,
  `STATUS` varchar(32) DEFAULT NULL,
  `BZ` varchar(255) DEFAULT NULL,
  `PHONE` varchar(100) DEFAULT NULL,
  `SFID` varchar(100) DEFAULT NULL,
  `START_TIME` varchar(100) DEFAULT NULL,
  `END_TIME` varchar(100) DEFAULT NULL,
  `YEARS` int(10) DEFAULT NULL,
  `NUMBER` varchar(100) DEFAULT NULL,
  `EMAIL` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_app_user
-- ----------------------------
INSERT INTO `sys_app_user` VALUES ('04762c0b28b643939455c7800c2e2412', 'dsfsd', 'f1290186a5d0b1ceab27f4e77c0c5d68', 'w', '', '55896f5ce3c0494fa6850775a4e29ff6', '', '', '1', '', '18766666666', '', '', '', '0', '001', '18766666666@qq.com');

-- ----------------------------
-- Table structure for sys_gl_qx
-- ----------------------------
DROP TABLE IF EXISTS `sys_gl_qx`;
CREATE TABLE `sys_gl_qx` (
  `GL_ID` varchar(100) NOT NULL,
  `ROLE_ID` varchar(100) DEFAULT NULL,
  `FX_QX` int(10) DEFAULT NULL,
  `FW_QX` int(10) DEFAULT NULL,
  `QX1` int(10) DEFAULT NULL,
  `QX2` int(10) DEFAULT NULL,
  `QX3` int(10) DEFAULT NULL,
  `QX4` int(10) DEFAULT NULL,
  PRIMARY KEY (`GL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_gl_qx
-- ----------------------------
INSERT INTO `sys_gl_qx` VALUES ('1', '2', '1', '1', '1', '1', '1', '1');
INSERT INTO `sys_gl_qx` VALUES ('2', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `sys_gl_qx` VALUES ('55896f5ce3c0494fa6850775a4e29ff6', '7', '0', '0', '1', '0', '0', '0');
INSERT INTO `sys_gl_qx` VALUES ('5ea97afaa4214f25b557069f66e0850c', '1', '1', '1', '0', '0', '0', '0');
INSERT INTO `sys_gl_qx` VALUES ('68f23fc0caee475bae8d52244dea8444', '7', '0', '0', '1', '1', '0', '0');
INSERT INTO `sys_gl_qx` VALUES ('7dfd8d1f7b6245d283217b7e63eec9b2', '1', '1', '1', '1', '0', '0', '0');
INSERT INTO `sys_gl_qx` VALUES ('ac66961adaa2426da4470c72ffeec117', '1', '1', '0', '0', '0', '0', '0');
INSERT INTO `sys_gl_qx` VALUES ('b0c77c29dfa140dc9b14a29c056f824f', '7', '1', '0', '1', '1', '0', '0');
INSERT INTO `sys_gl_qx` VALUES ('e74f713314154c35bd7fc98897859fe3', '6', '1', '1', '1', '1', '0', '0');
INSERT INTO `sys_gl_qx` VALUES ('f944a9df72634249bbcb8cb73b0c9b86', '7', '1', '1', '1', '1', '0', '0');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `MENU_ID` int(11) NOT NULL,
  `MENU_NAME` varchar(255) DEFAULT NULL,
  `MENU_URL` varchar(255) DEFAULT NULL,
  `PARENT_ID` varchar(100) DEFAULT NULL,
  `MENU_ORDER` varchar(100) DEFAULT NULL,
  `MENU_ICON` varchar(30) DEFAULT NULL,
  `MENU_TYPE` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`MENU_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '系统管理', '#', '0', '1', 'icon-cogs', '2');
INSERT INTO `sys_menu` VALUES ('2', '组织管理', 'role.do', '1', '2', null, '2');
INSERT INTO `sys_menu` VALUES ('5', '系统用户', 'user/listUsers.do', '1', '3', null, '2');
INSERT INTO `sys_menu` VALUES ('42', '菜单管理', 'menu.do', '1', '3', null, '2');
INSERT INTO `sys_menu` VALUES ('46', '党员信息列表', 'kehu/kehuListPage', '56', '1', null, '');
INSERT INTO `sys_menu` VALUES ('56', '党员信息管理', '#', '000', '2', 'icon-list', '');
INSERT INTO `sys_menu` VALUES ('61', '文件信息管理', '#', '0', '3', 'icon-folder-open', '');
INSERT INTO `sys_menu` VALUES ('62', '文件信息列表', 'newsDetailes/getlistPage.do', '61', '1', null, '');
INSERT INTO `sys_menu` VALUES ('64', '版块信息管理', '#', '0', '4', 'icon-th', '');
INSERT INTO `sys_menu` VALUES ('65', '版块信息列表', 'newsModule/getlistPage.do', '64', '1', null, '');
INSERT INTO `sys_menu` VALUES ('66', '新闻多图管理', '#', '0', '5', 'icon-desktop', '2');
INSERT INTO `sys_menu` VALUES ('67', '新闻多图列表', 'xinwen/xinwenlistPage.do', '66', '1', null, '2');
INSERT INTO `sys_menu` VALUES ('68', '评优投票管理', '#', '000', '6', 'icon-edit', '2');
INSERT INTO `sys_menu` VALUES ('69', '评优投票题目列表', 'report/goodsListPage.do', '68', '1', null, '2');
INSERT INTO `sys_menu` VALUES ('70', '党建联盟管理', '#', '000', '7', 'icon-list-alt', '2');
INSERT INTO `sys_menu` VALUES ('71', '党建联盟列表', 'bank/BanklistPage.do', '70', '1', null, '2');
INSERT INTO `sys_menu` VALUES ('72', '组织机构管理', '#', '000', '8', 'icon-lock', '2');
INSERT INTO `sys_menu` VALUES ('73', '党组织机构列表', 'PartyOrgan/PartyOrganizationlistPage.do', '72', '1', null, '2');
INSERT INTO `sys_menu` VALUES ('75', '党员学习管理', '#', '000', '9', 'icon-film', '2');
INSERT INTO `sys_menu` VALUES ('76', '课程学习设置', 'StudyManage/StudyListPage.do', '75', '1', null, '2');
INSERT INTO `sys_menu` VALUES ('81', '直播视频管理', '#', '0', '10', 'icon-facetime-video', '2');
INSERT INTO `sys_menu` VALUES ('82', '直播视频列表', 'LiveBroadcastManage/LiveBroadcastListPage.do', '81', '1', null, '2');
INSERT INTO `sys_menu` VALUES ('83', '内部资料管理', '#', '000', '11', 'icon-book', '2');
INSERT INTO `sys_menu` VALUES ('84', '内部资料列表', 'InterFile/interFileListPage.do', '83', '1', null, '2');
INSERT INTO `sys_menu` VALUES ('87', '党员互动管理', '#', '000', '12', 'icon-comments', '2');
INSERT INTO `sys_menu` VALUES ('88', '党员互动条目', 'InteractionManage/InteractionListPage.do', '87', '1', null, '2');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `ROLE_ID` varchar(100) NOT NULL,
  `ROLE_NAME` varchar(100) DEFAULT NULL,
  `RIGHTS` varchar(255) DEFAULT NULL,
  `PARENT_ID` varchar(100) DEFAULT NULL,
  `ADD_QX` varchar(255) DEFAULT NULL,
  `DEL_QX` varchar(255) DEFAULT NULL,
  `EDIT_QX` varchar(255) DEFAULT NULL,
  `CHA_QX` varchar(255) DEFAULT NULL,
  `QX_ID` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('0bcb8bef98684668a04bb16c398dc194', '海南大学', '118', '4', '0', '0', '0', '0', '0bcb8bef98684668a04bb16c398dc194');
INSERT INTO `sys_role` VALUES ('1', '系统管理员', '274871615654', '0', '1', '1', '1', '1', '1');
INSERT INTO `sys_role` VALUES ('2', '抚州市市研学旅行教育研究院', '274871615654', '1', '246', '50', '50', '38', '2');
INSERT INTO `sys_role` VALUES ('4', '用户组', '118', '0', '0', '0', '0', '0', null);
INSERT INTO `sys_role` VALUES ('50ece54f77c24679b7d661dc1827544d', '市教育局研学旅行工作领导小组办公室', '274871615654', '1', '0', '0', '0', '0', '50ece54f77c24679b7d661dc1827544d');
INSERT INTO `sys_role` VALUES ('55896f5ce3c0494fa6850775a4e29ff6', '特级会员', '498', '7', '0', '0', '0', '0', '55896f5ce3c0494fa6850775a4e29ff6');
INSERT INTO `sys_role` VALUES ('6', '客户组', '18', '0', '1', '1', '1', '1', null);
INSERT INTO `sys_role` VALUES ('68f23fc0caee475bae8d52244dea8444', '中级会员', '498', '7', '0', '0', '0', '0', '68f23fc0caee475bae8d52244dea8444');
INSERT INTO `sys_role` VALUES ('7', '会员组', '498', '0', '0', '0', '0', '1', null);
INSERT INTO `sys_role` VALUES ('78db248f231b4cf59bc4cbcb3e55bd8b', '学生家长', '274871615654', '1', '0', '0', '0', '0', '78db248f231b4cf59bc4cbcb3e55bd8b');
INSERT INTO `sys_role` VALUES ('997eec7218564106b8f8db571cdf1059', '海口市中小学校', '274871615654', '1', '0', '0', '0', '0', '997eec7218564106b8f8db571cdf1059');
INSERT INTO `sys_role` VALUES ('a2160cea66dc474598c4442380d961cc', '研学基地', '274871615654', '1', '0', '0', '0', '0', 'a2160cea66dc474598c4442380d961cc');
INSERT INTO `sys_role` VALUES ('ac66961adaa2426da4470c72ffeec117', '县（区）教体局', '274871615654', '1', '54', '54', '0', '246', 'ac66961adaa2426da4470c72ffeec117');
INSERT INTO `sys_role` VALUES ('b0c77c29dfa140dc9b14a29c056f824f', '高级会员', '498', '7', '0', '0', '0', '0', 'b0c77c29dfa140dc9b14a29c056f824f');
INSERT INTO `sys_role` VALUES ('bec0fd7c8ea547dfb9da176bba214030', '研学营地', '274871615654', '1', '0', '0', '0', '0', 'bec0fd7c8ea547dfb9da176bba214030');
INSERT INTO `sys_role` VALUES ('c0ecdddd02f24c0f9b5d98ac34936ad7', '客运大巴公司', '274871615654', '1', '0', '0', '0', '0', 'c0ecdddd02f24c0f9b5d98ac34936ad7');
INSERT INTO `sys_role` VALUES ('da33d9d031f549a9ad6d5731e83bb590', '研学营地外餐厅', '274871615654', '1', '0', '0', '0', '0', 'da33d9d031f549a9ad6d5731e83bb590');
INSERT INTO `sys_role` VALUES ('e74f713314154c35bd7fc98897859fe3', '黄金客户', '18', '6', '1', '1', '1', '1', 'e74f713314154c35bd7fc98897859fe3');
INSERT INTO `sys_role` VALUES ('f944a9df72634249bbcb8cb73b0c9b86', '初级会员', '498', '7', '1', '1', '1', '1', 'f944a9df72634249bbcb8cb73b0c9b86');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `USER_ID` varchar(100) NOT NULL,
  `USERNAME` varchar(255) DEFAULT NULL,
  `PASSWORD` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `RIGHTS` varchar(255) DEFAULT NULL,
  `ROLE_ID` varchar(100) DEFAULT NULL,
  `LAST_LOGIN` varchar(255) DEFAULT NULL,
  `IP` varchar(100) DEFAULT NULL,
  `STATUS` varchar(32) DEFAULT NULL,
  `BZ` varchar(255) DEFAULT NULL,
  `SKIN` varchar(100) DEFAULT NULL,
  `EMAIL` varchar(32) DEFAULT NULL,
  `NUMBER` varchar(100) DEFAULT NULL,
  `PHONE` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('0bcb8bef98684668a04bb16c398dc194', 'xcyl', 'bb6e1b0b4df2db696a8e45a9939799abeb2f5ff2', '超级管理员', '', '0bcb8bef98684668a04bb16c398dc194', '2017-09-20 18:59:42', '192.168.1.124', '0', '小菜一篮管理者', 'default', 'wwwwq@qq.com', '1101', '18788888888');
INSERT INTO `sys_user` VALUES ('1', 'admin', 'dd94709528bb1c83d08f3088d4043f4742891f4f', '系统管理员', '1133671055321055258374707980945218933803269864762743594642571294', '1', '2018-04-14 01:25:31', '127.0.0.1', '0', '最高统治者', 'default', 'admin@main.com', '001', '18788888888');
INSERT INTO `sys_user` VALUES ('681464038b004566b3c437bcc6555d63', 'yangym', 'f7316e1c4b97ac3bd17f7133976187b63156f90e', '普通管理员', '', 'ac66961adaa2426da4470c72ffeec117', '2017-09-25 14:36:20', '192.168.1.128', '0', '杨永明是管理员', 'default', '734562051@qq.com', '1102', '18898218580');

-- ----------------------------
-- Table structure for sys_user_qx
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_qx`;
CREATE TABLE `sys_user_qx` (
  `U_ID` varchar(100) NOT NULL,
  `C1` int(10) DEFAULT NULL,
  `C2` int(10) DEFAULT NULL,
  `C3` int(10) DEFAULT NULL,
  `C4` int(10) DEFAULT NULL,
  `Q1` int(10) DEFAULT NULL,
  `Q2` int(10) DEFAULT NULL,
  `Q3` int(10) DEFAULT NULL,
  `Q4` int(10) DEFAULT NULL,
  PRIMARY KEY (`U_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user_qx
-- ----------------------------
INSERT INTO `sys_user_qx` VALUES ('0bcb8bef98684668a04bb16c398dc194', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `sys_user_qx` VALUES ('1', '1', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('2', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `sys_user_qx` VALUES ('50ece54f77c24679b7d661dc1827544d', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('55896f5ce3c0494fa6850775a4e29ff6', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('605b0e19e54349d2b8cca96ece966da5', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('68f23fc0caee475bae8d52244dea8444', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('78db248f231b4cf59bc4cbcb3e55bd8b', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('997eec7218564106b8f8db571cdf1059', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('a2160cea66dc474598c4442380d961cc', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('ac66961adaa2426da4470c72ffeec117', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('b0c77c29dfa140dc9b14a29c056f824f', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('bec0fd7c8ea547dfb9da176bba214030', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('c0ecdddd02f24c0f9b5d98ac34936ad7', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('da33d9d031f549a9ad6d5731e83bb590', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('e74f713314154c35bd7fc98897859fe3', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('f944a9df72634249bbcb8cb73b0c9b86', '0', '0', '0', '0', '0', '0', '0', '0');
