/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50644
Source Host           : localhost:3306
Source Database       : depr

Target Server Type    : MYSQL
Target Server Version : 50644
File Encoding         : 65001

Date: 2019-09-25 08:47:37
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for broadwise_demand_matrix
-- ----------------------------
DROP TABLE IF EXISTS `broadwise_demand_matrix`;
CREATE TABLE `broadwise_demand_matrix` (
  `broadwise_demand_matrix_id` varchar(32) NOT NULL COMMENT '横向需求矩阵id',
  `achieve_stage_id` varchar(1) DEFAULT NULL COMMENT '实现阶段id',
  `regulation_id` varchar(200) DEFAULT NULL COMMENT '选项id，有多个时，由,分割',
  `product_id` varchar(32) DEFAULT NULL COMMENT '产品id',
  PRIMARY KEY (`broadwise_demand_matrix_id`),
  KEY `broadwise_demand_matrix_product_id` (`product_id`),
  CONSTRAINT `broadwise_demand_matrix_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of broadwise_demand_matrix
-- ----------------------------
INSERT INTO `broadwise_demand_matrix` VALUES ('71a9d3e6ddcb11e98c39f8b156d274ca', '1', '3,4,5,2,1', '0b44246ddc4c11e9b510f8b156d274ca');
INSERT INTO `broadwise_demand_matrix` VALUES ('caf215c8ddf711e98c39f8b156d274ca', '2', '6', '0b44246ddc4c11e9b510f8b156d274ca');
INSERT INTO `broadwise_demand_matrix` VALUES ('cb2ca66fddf711e98c39f8b156d274ca', '4', '7,8', '0b44246ddc4c11e9b510f8b156d274ca');
INSERT INTO `broadwise_demand_matrix` VALUES ('cb5a68b9ddf711e98c39f8b156d274ca', '3', '8', '0b44246ddc4c11e9b510f8b156d274ca');

-- ----------------------------
-- Table structure for datasheet
-- ----------------------------
DROP TABLE IF EXISTS `datasheet`;
CREATE TABLE `datasheet` (
  `datasheet_id` varchar(32) NOT NULL COMMENT '规格书id',
  `datasheet_url` varchar(100) DEFAULT NULL COMMENT '规格书地址',
  `product_id` varchar(32) DEFAULT NULL COMMENT '产品id',
  `file_md5` varchar(255) DEFAULT NULL COMMENT '文件的md5值',
  PRIMARY KEY (`datasheet_id`),
  KEY `datasheet_product_id_fk` (`product_id`),
  CONSTRAINT `datasheet_product_id_fk` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of datasheet
-- ----------------------------
INSERT INTO `datasheet` VALUES ('2e4f79f5dc4c11e9b510f8b156d274ca', 'C:/depr/files\\产品维护2_产品规格书.docx', '0b44246ddc4c11e9b510f8b156d274ca', 'cef83ee3263296c8a867ea2a428b9336');

-- ----------------------------
-- Table structure for db_backup
-- ----------------------------
DROP TABLE IF EXISTS `db_backup`;
CREATE TABLE `db_backup` (
  `db_backup_id` varchar(32) DEFAULT NULL COMMENT '数据库备份id',
  `file_name` varchar(255) DEFAULT NULL COMMENT '数据库备份文件名',
  `operator` varchar(255) DEFAULT NULL COMMENT '数据库备份用户名'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_backup
-- ----------------------------
INSERT INTO `db_backup` VALUES ('012d28dbcfa711e9a47af8b156d274ca', 'depr_2019-09-05_14_32_59_manual.sql', 'wyq');
INSERT INTO `db_backup` VALUES ('aa5acb74d04d11e9a662f8b156d274ca', 'depr_2019-09-06_10_26_00_auto.sql', '自动备份');
INSERT INTO `db_backup` VALUES ('ad3e4debd04d11e9a662f8b156d274ca', 'depr_2019-09-06_10_26_05_auto.sql', '自动备份');
INSERT INTO `db_backup` VALUES ('b0392559d04d11e9a662f8b156d274ca', 'depr_2019-09-06_10_26_10_auto.sql', '自动备份');
INSERT INTO `db_backup` VALUES ('b334219bd04d11e9a662f8b156d274ca', 'depr_2019-09-06_10_26_15_auto.sql', '自动备份');

-- ----------------------------
-- Table structure for demand
-- ----------------------------
DROP TABLE IF EXISTS `demand`;
CREATE TABLE `demand` (
  `demand_id` varchar(32) NOT NULL COMMENT '需求id',
  `demand_name` varchar(200) DEFAULT NULL COMMENT '需求名字',
  `demand_num` varchar(60) DEFAULT NULL COMMENT '需求编号',
  `demand_category_id` varchar(32) DEFAULT NULL COMMENT '需求所属大类',
  `demand_child_category_id` varchar(32) DEFAULT NULL COMMENT '需求所属小类',
  `demand_resume` varchar(200) DEFAULT NULL COMMENT '需求简述',
  `demand_describe` varchar(300) DEFAULT NULL COMMENT '需求描述',
  `demand_priority` int(11) DEFAULT NULL COMMENT '需求优先级，1代表B,2代表A，3代表S',
  `demand_accept_criteria` varchar(300) DEFAULT NULL COMMENT '需求验收标准',
  `demand_remarks` varchar(300) DEFAULT NULL COMMENT '需求备注',
  `product_id` varchar(32) DEFAULT NULL COMMENT '需求属于哪个产品',
  `demand_state` int(11) DEFAULT '0' COMMENT '需求状态，0代表未确定,1代表已确定，2代表已计划，3代表已实现，4代表已验证',
  `demand_origin` int(11) DEFAULT NULL COMMENT '需求来源，1代表产品管理，2代表技术标准和规范，3代表技术服务，4代表测试，5代表友商，6代表直接客户，7代表商业需求',
  `is_core` tinyint(1) DEFAULT NULL COMMENT '是否核心需求，1为核心，0不是核心',
  `realize_edition` varchar(40) DEFAULT NULL COMMENT '实现版本',
  `norms_num` varchar(100) DEFAULT NULL COMMENT '规格编号',
  `demand_order` varchar(100) DEFAULT '0' COMMENT '需求的序号',
  `overall_design_rule_num` varchar(32) DEFAULT NULL COMMENT '总体设计说明书的规则编号',
  PRIMARY KEY (`demand_id`),
  KEY `demand_product_id_fk` (`product_id`),
  CONSTRAINT `demand_product_id_fk` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of demand
-- ----------------------------
INSERT INTO `demand` VALUES ('5d493404dc4c11e9b510f8b156d274ca', '人脸抓拍机接入', 'UF-001-001', '5ce98434dc4c11e9b510f8b156d274ca', null, '11111', '支持视频流预览，摄像机图片分析（图片格式为jpeg）', '1', '1111111', null, '0b44246ddc4c11e9b510f8b156d274ca', '0', '1', '1', 'V1.0', '', null, null);
INSERT INTO `demand` VALUES ('5d493910dc4c11e9b510f8b156d274ca', '实时抓拍显示框', 'UF-001-002', '5ce98434dc4c11e9b510f8b156d274ca', null, null, '实时显示人脸抓拍图片，与目标库比对上的用蓝色框框出，未比对上的（路人）用红色框框出。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0110-005', '002', null);
INSERT INTO `demand` VALUES ('5d493b12dc4c11e9b510f8b156d274ca', '抓拍图片鼠标左键点击事件', 'UF-001-003', '5ce98434dc4c11e9b510f8b156d274ca', null, null, '鼠标左键点击人脸图片，弹窗显示人脸抓拍信息。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0110-004', '003', null);
INSERT INTO `demand` VALUES ('5d493cbedc4c11e9b510f8b156d274ca', '抓拍图片鼠标右键事件', 'UF-001-004', '5ce98434dc4c11e9b510f8b156d274ca', null, null, '鼠标右键点击人脸图片，弹出右键菜单，菜单包含：快速入库；查看原图；搜索人员。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0110-004', '004', null);
INSERT INTO `demand` VALUES ('5d493e62dc4c11e9b510f8b156d274ca', '鼠标右键快速入库', 'UF-001-005', '5ce98434dc4c11e9b510f8b156d274ca', null, null, '快速入库：在本页面弹窗显示，选择需要添加的目标库并补充其他信息；', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0110-004', '005', null);
INSERT INTO `demand` VALUES ('5d494018dc4c11e9b510f8b156d274ca', '鼠标右键查看原图', 'UF-001-006', '5ce98434dc4c11e9b510f8b156d274ca', null, null, '查看原图：在新标签页打开该人员图片的地址；', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0110-004', '006', null);
INSERT INTO `demand` VALUES ('5d49418bdc4c11e9b510f8b156d274ca', '鼠标右键搜索人员', 'UF-001-007', '5ce98434dc4c11e9b510f8b156d274ca', null, null, '搜索人员：在本标签页跳转到以图搜图（路人库），并自动将该人员图片添加到人脸输入框；', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0110-004', '007', null);
INSERT INTO `demand` VALUES ('5d4942e6dc4c11e9b510f8b156d274ca', '人脸跟随框叠加', 'UF-001-008', '5ce98434dc4c11e9b510f8b156d274ca', null, null, '支持实时预览视频时，检测到人脸目标后在实时视频中叠加人脸跟随框。', '3', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', '不涉及', '008', null);
INSERT INTO `demand` VALUES ('5d49445fdc4c11e9b510f8b156d274ca', '人脸跟随框信息展示', 'UF-001-009', '5ce98434dc4c11e9b510f8b156d274ca', null, null, '支持在人脸跟随框上展示其属性信息（例如：睁眼、张嘴、戴口罩、戴眼镜、性别、年轻人、胡须）。', '3', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', '不涉及', '009', null);
INSERT INTO `demand` VALUES ('5d49463fdc4c11e9b510f8b156d274ca', '规则框叠加', 'UF-001-010', '5ce98434dc4c11e9b510f8b156d274ca', null, null, '支持在实时预览视频时，叠加智能分析规则框。（人脸检测的ROI）（只读不写）', '2', null, 'ROI区域：感兴趣区域', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', '不涉及', '010', null);
INSERT INTO `demand` VALUES ('5d4947c2dc4c11e9b510f8b156d274ca', '实时抓拍统计', 'UF-001-011', '5ce98434dc4c11e9b510f8b156d274ca', null, null, '支持实时统计播放摄像机当日的抓拍人流量，并动态显示', '3', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0110-004', '011', null);
INSERT INTO `demand` VALUES ('5d494926dc4c11e9b510f8b156d274ca', '实时报警统计', 'UF-001-012', '5ce98434dc4c11e9b510f8b156d274ca', null, null, '支持实时统计播放摄像机当日的报警人流量，并动态显示', '3', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0110-005', '012', null);
INSERT INTO `demand` VALUES ('5d494a8ddc4c11e9b510f8b156d274ca', 'onvif协议摄像机接入', 'UF-001-013', '5ce98434dc4c11e9b510f8b156d274ca', null, null, '支持onvi接入摄像机，实现实时视频预览及分析', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '013', null);
INSERT INTO `demand` VALUES ('5d494c0adc4c11e9b510f8b156d274ca', 'SDK摄像机接入', 'UF-001-014', '5ce98434dc4c11e9b510f8b156d274ca', null, null, '支持SDK接入摄像机，实现实时视频预览及分析', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '014', null);
INSERT INTO `demand` VALUES ('5d494d5cdc4c11e9b510f8b156d274ca', '国标协议摄像机接入', 'UF-001-015', '5ce98434dc4c11e9b510f8b156d274ca', null, null, '支持通过国标协议接入摄像机，实现实时视频预览及分析', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '015', null);
INSERT INTO `demand` VALUES ('5d494ec3dc4c11e9b510f8b156d274ca', 'V2200管理平台视频流接入', 'UF-001-016', '5ce98434dc4c11e9b510f8b156d274ca', null, null, '支持接入V2200管理平台摄像机，实现实时视频预览及分析', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '016', null);
INSERT INTO `demand` VALUES ('5d495030dc4c11e9b510f8b156d274ca', 'NVR视频流接入', 'UF-001-017', '5ce98434dc4c11e9b510f8b156d274ca', null, null, '支持接入V3073 NVR的视频或存储视频流，实现视频浏览及分析', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '017', null);
INSERT INTO `demand` VALUES ('5d495185dc4c11e9b510f8b156d274ca', '多画面预览', 'UF-001-018', '5ce98434dc4c11e9b510f8b156d274ca', null, null, '支持1，4，6，8多画面实时预览，比对结果和抓拍结果可选摄像机或布控列表', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '018', null);
INSERT INTO `demand` VALUES ('5d4952ecdc4c11e9b510f8b156d274ca', '人脸抠图机接入', 'UF-002-001', '5cebe6a4dc4c11e9b510f8b156d274ca', null, null, '支持人脸识别抓拍终端（小盒子）的接入', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0030-001', '001', null);
INSERT INTO `demand` VALUES ('5d495457dc4c11e9b510f8b156d274ca', '视频流接入', 'UF-002-002', '5cebe6a4dc4c11e9b510f8b156d274ca', null, null, '支持对视频流进行人脸检测，特征提取，及人脸比对分析', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '002', null);
INSERT INTO `demand` VALUES ('5d4955b5dc4c11e9b510f8b156d274ca', '支持导入录像文件分析', 'UF-002-003', '5cebe6a4dc4c11e9b510f8b156d274ca', null, null, '支持主流格式（.mp4、.avi、.ts、.flv、.mov、.rmvb）的录像分析预览', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '003', null);
INSERT INTO `demand` VALUES ('5d49570ddc4c11e9b510f8b156d274ca', '人脸库容量', 'UF-003-001', '5cee3f81dc4c11e9b510f8b156d274ca', null, null, '支持10万张人脸图片入库', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', null, '001', null);
INSERT INTO `demand` VALUES ('5d49586bdc4c11e9b510f8b156d274ca', '人脸库管理', 'UF-003-002', '5cee3f81dc4c11e9b510f8b156d274ca', null, null, ' ', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'SF_MBKGL_001\nSF_MBKGL_002\nSF_MBKGL_003\nPQ_PERF_003', '002', null);
INSERT INTO `demand` VALUES ('5d4959cfdc4c11e9b510f8b156d274ca', '人脸库检索', 'UF-003-003', '5cee3f81dc4c11e9b510f8b156d274ca', null, null, '支持根据目标库名称，建库时间进行目标库检索', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, null, 'V1.0', null, '003', null);
INSERT INTO `demand` VALUES ('5d495b37dc4c11e9b510f8b156d274ca', '人脸建库', 'UF-003-004', '5cee3f81dc4c11e9b510f8b156d274ca', null, null, '1，支持单个目标导入，批量导入，通过模板导入，数据库导入\n2，支持添加目标信息包含：姓名，性别，出生年月，联系方式，证件号码，籍贯，民族，联系地址，备注等信息\n3，可设置目标为：一般对象，重点监控对象\n4，支持人脸目标的添加、修改、删除、批量删除；\n5，支持根据姓名，性别，籍贯，出生日期等信息对目标库中的人脸图片进行检索', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', null, '004', null);
INSERT INTO `demand` VALUES ('5d495d01dc4c11e9b510f8b156d274ca', '刷身份证入库', 'UF-003-007', '5cee3f81dc4c11e9b510f8b156d274ca', null, null, '支持身份证阅读器阅读人脸图片入库；', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'SF_MBKGL_004', '007', null);
INSERT INTO `demand` VALUES ('5d495e60dc4c11e9b510f8b156d274ca', '人脸图片导出', 'UF-003-008', '5cee3f81dc4c11e9b510f8b156d274ca', null, null, '支持对目标库人脸图片单张和批量导出', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0130-006', '008', null);
INSERT INTO `demand` VALUES ('5d495fb5dc4c11e9b510f8b156d274ca', '身份证号唯一', 'UF-003-009', '5cee3f81dc4c11e9b510f8b156d274ca', null, null, '单个人脸库内，身份证号唯一：\n新增人员和编辑人员时，若有重复应拒绝提交，并给予提示', '1', null, '不同目标库中允许身份证号一致', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0130-004', '009', null);
INSERT INTO `demand` VALUES ('5d49614fdc4c11e9b510f8b156d274ca', '报警统计', 'UF-003-010', '5cee3f81dc4c11e9b510f8b156d274ca', null, null, '支持查看目标库中人员的报警统计信息，包含该人员的报警次数。', '3', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0130-008', '010', null);
INSERT INTO `demand` VALUES ('5d4962a1dc4c11e9b510f8b156d274ca', '报警统计关联报警记录', 'UF-003-011', '5cee3f81dc4c11e9b510f8b156d274ca', null, null, '支持通过报警统计，跳转到报警记录页面，并显示该人员所有比对上的报警信息', '3', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0110-005', '011', null);
INSERT INTO `demand` VALUES ('5d496412dc4c11e9b510f8b156d274ca', '目标属性扩展字段', 'UF-003-012', '5cee3f81dc4c11e9b510f8b156d274ca', null, null, '针对人脸目标属性，在现有字段的基础上再提供3对扩展可编辑字段（透明字段）', '1', null, '新增字段应用范围为整个系统', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0080-001', '012', null);
INSERT INTO `demand` VALUES ('5d496573dc4c11e9b510f8b156d274ca', '单个抓拍图片快速入库', 'UF-003-013', '5cee3f81dc4c11e9b510f8b156d274ca', null, null, '支持选定抓拍图片（抓拍记录页面），支持快速入库', '1', null, '银湖会议中心需求', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0110-004', '013', null);
INSERT INTO `demand` VALUES ('5d4966d7dc4c11e9b510f8b156d274ca', '单张入库图片进行质量判断', 'UF-003-014', '5cee3f81dc4c11e9b510f8b156d274ca', null, null, '对于入库的图片进行图片质量判断：\n1、对质量分低于50的人脸图片拒绝入库，并提示是因为什么原因导致入库失败（给出可量化的入库图片质量要求）。\n2、对质量分在50~65之间的，系统应给予提示，可供选择继续操作和重新选择照片\n3、对于质量分在65以上的人脸照片，直接提示入库成功', '1', null, '实际质量分阈值根据算法来调整', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0130-004\nS-0110-004', '014', null);
INSERT INTO `demand` VALUES ('5d496896dc4c11e9b510f8b156d274ca', '批量入库质量分判断', 'UF-003-015', '5cee3f81dc4c11e9b510f8b156d274ca', null, null, '对于入库的图片进行图片质量判断：\n1、有存在质量分＜50的，小于50的图片拒绝入库。并提示哪些被拒绝入库了。\n2、有存在质量分在50~65之间的，提示并继续操作；\n3、所有照片质量分＞65的，直接提示入库成功；', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0130-004\nS-0110-004', '015', null);
INSERT INTO `demand` VALUES ('5d496a82dc4c11e9b510f8b156d274ca', '人脸图片质量分识别', 'UF-003-016', '5cee3f81dc4c11e9b510f8b156d274ca', null, null, '目标库中，应支持识别人脸图片质量分，在个人信息中标识对应的人脸图片质量分', '3', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0130-007', '016', null);
INSERT INTO `demand` VALUES ('5d496bf8dc4c11e9b510f8b156d274ca', '批量入库进度提示', 'UF-003-017', '5cee3f81dc4c11e9b510f8b156d274ca', null, null, '批量入库时，应给出进度条提示入库进度；入库完成时，给出成功率提示，提示一共导入多少张图片，成功了多少张，失败了多少张，有哪些图片导入失败了。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0130-005', '017', null);
INSERT INTO `demand` VALUES ('5d496e21dc4c11e9b510f8b156d274ca', '目标级别配置', 'UF-003-018', '5cee3f81dc4c11e9b510f8b156d274ca', null, null, '针对添加的目标库人员，提供5个以上目标级别，用户可自定义目标级别名称', '3', null, '印度需求', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0080-001', '018', null);
INSERT INTO `demand` VALUES ('5d496f9adc4c11e9b510f8b156d274ca', '入库人员可设置有效期', 'UF-003-019', '5cee3f81dc4c11e9b510f8b156d274ca', null, null, '针对添加的目标库人员，可设置有效期，有效期内则进行人脸比对，有效期外，则不对人员进行人脸比对。\n应用说明：临时来访人员，可设置他的有效期只有当天。以防下次来继续给他开门。', '3', null, '印度需求', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0130-004', '019', null);
INSERT INTO `demand` VALUES ('5d49713bdc4c11e9b510f8b156d274ca', '部门管理', 'UF-003-020', '5cee3f81dc4c11e9b510f8b156d274ca', null, null, '支持针对目标库中人员支持配置所属部门信息', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0090-001\nS-0090-002\nS-0090-003\nS-0090-004\nS-0090-005', '020', null);
INSERT INTO `demand` VALUES ('5d4972abdc4c11e9b510f8b156d274ca', '一人一档', 'UF-003-021', '5cee3f81dc4c11e9b510f8b156d274ca', null, null, '在本系统中，每一个人员，只有一份档案，支持给人员添加不同的标签。创建布控任务（或考勤任务）时，支持根据标签来创建布控任务。', '3', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '021', null);
INSERT INTO `demand` VALUES ('5d497430dc4c11e9b510f8b156d274ca', '布控任务', 'UF-004-001', '5cf08105dc4c11e9b510f8b156d274ca', null, null, '新建、编辑布控任务 ', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'SF_BKGL_001\nSF_BKGL_002\nSF_BKGL_003\nSF_BKGL_004', '001', null);
INSERT INTO `demand` VALUES ('5d49759adc4c11e9b510f8b156d274ca', '布控联动声音', 'UF-004-002', '5cf08105dc4c11e9b510f8b156d274ca', null, null, '布控预警联动声音', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'SF_SSLL_005', '002', null);
INSERT INTO `demand` VALUES ('5d4976eddc4c11e9b510f8b156d274ca', '布控预警推送', 'UF-004-003', '5cf08105dc4c11e9b510f8b156d274ca', null, null, '布控任务支持在发生报警时推送报警信息；\n报警信息包含：报警类型，报警时间，抓拍图片（短信不需要支持抓拍图片），比对结果；', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0120-001', '003', null);
INSERT INTO `demand` VALUES ('5d497863dc4c11e9b510f8b156d274ca', '联动手机短信告警', 'UF-004-004', '5cf08105dc4c11e9b510f8b156d274ca', null, null, '可联动短信发送，最大支持添加50个短信接收手机号', '1', null, '采用V2233同款短信猫', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0120-001', '004', null);
INSERT INTO `demand` VALUES ('5d4979d3dc4c11e9b510f8b156d274ca', '联动邮件告警', 'UF-004-005', '5cf08105dc4c11e9b510f8b156d274ca', null, null, '可联动邮件发送，最大支持添加50个邮件接收地址', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0120-001', '005', null);
INSERT INTO `demand` VALUES ('5d497b34dc4c11e9b510f8b156d274ca', '客户端报警', 'UF-004-006', '5cf08105dc4c11e9b510f8b156d274ca', null, null, '可联动web客户端和APP客户端进行弹框报警和声音报警', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0120-001', '006', null);
INSERT INTO `demand` VALUES ('5d497ca2dc4c11e9b510f8b156d274ca', '第三方http报警', 'UF-004-007', '5cf08105dc4c11e9b510f8b156d274ca', null, null, '可联动指定http地址报警，报警参数可通过模板编辑配置', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0120-001', '007', null);
INSERT INTO `demand` VALUES ('5d497e06dc4c11e9b510f8b156d274ca', '布控类型_黑名单布控', 'UF-004-008', '5cf08105dc4c11e9b510f8b156d274ca', null, null, '黑名单布控：视频画面中出现人员与布控的目标库中人员比对上，则触发报警，并在实时布控页面提示；', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0120-001', '008', null);
INSERT INTO `demand` VALUES ('5d497f6ddc4c11e9b510f8b156d274ca', '布控类型_白名单布控', 'UF-004-009', '5cf08105dc4c11e9b510f8b156d274ca', null, null, '白名单布控：视频画面中出现人员没有与布控的目标库中人员比对上，则触发报警，并在实时布控页面提示；', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0120-001', '009', null);
INSERT INTO `demand` VALUES ('5d4980d4dc4c11e9b510f8b156d274ca', '同一人脸库支持多次布控', 'UF-004-010', '5cf08105dc4c11e9b510f8b156d274ca', null, null, ' 同一个目标库，可以设置不同的布控任务；', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0120-001', '010', null);
INSERT INTO `demand` VALUES ('5d498232dc4c11e9b510f8b156d274ca', '布控任务可设置布控日程', 'UF-004-011', '5cf08105dc4c11e9b510f8b156d274ca', null, null, '布控任务支持根据不同的日程来执行；例如，每天6点到10点执行布控任务；', '1', null, '印度需求', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0120-001', '011', null);
INSERT INTO `demand` VALUES ('5d498394dc4c11e9b510f8b156d274ca', '布控有效期', 'UF-004-012', '5cf08105dc4c11e9b510f8b156d274ca', null, null, '支持设置布控任务的有效期，有效期到期后，任务自动终止。\n在任务有效期内，系统根据日程执行布控任务。执行时间为日程和有效期的交集。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0120-001', '012', null);
INSERT INTO `demand` VALUES ('5d49927edc4c11e9b510f8b156d274ca', '布控类型', 'UF-004-013', '5cf08105dc4c11e9b510f8b156d274ca', null, null, '布控类型支持：实时频繁出现报警，当陌生人员在布控时间内，频繁出现（次数可设置）达到指定次数时，则进行报警。', '1', null, '银湖项目需求', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '013', null);
INSERT INTO `demand` VALUES ('5d4994e6dc4c11e9b510f8b156d274ca', '布控联动实时视频', 'UF-004-014', '5cf08105dc4c11e9b510f8b156d274ca', null, null, '布控预警可设置联动实时视频，当发生预警时，联动弹出实时浏览画面，可手动确认关闭窗口。设定时间内无手动操作，视频自动关闭，时间可设置。是否一定要手动确认也可设置；', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '014', null);
INSERT INTO `demand` VALUES ('5d49969fdc4c11e9b510f8b156d274ca', '布控预警推送', 'UF-004-015', '5cf08105dc4c11e9b510f8b156d274ca', null, null, '布控预警信息推送遵循以下规则：\n（1）优先推送布控页面绑定的报警处理用户；\n（2）若布控页面无绑定的报警处理用户，则推送所在黑名单库所绑定的用户；\n（3）若布控页面无绑定的报警处理用户，所在黑名单库也无绑定的用户，则推送给布控的人（谁布控推送谁）；', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '015', null);
INSERT INTO `demand` VALUES ('5d49985edc4c11e9b510f8b156d274ca', '实时报警', 'UF-005-001', '5cf2cbd6dc4c11e9b510f8b156d274ca', null, null, '实施布控页面，实时显示报警信息', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'SF_SSLL_005', '001', null);
INSERT INTO `demand` VALUES ('5d4999f8dc4c11e9b510f8b156d274ca', '实时报警弹出对话框', 'UF-005-002', '5cf2cbd6dc4c11e9b510f8b156d274ca', null, null, '报警对话框显示抓拍的人脸、相似度、目标人脸，目标人的信息、全景图查看按钮、确认按钮、误报按钮、详情按钮，点击全景图查看按钮可以查看抓拍人脸的全景图；', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'SF_SSLL_005', '002', null);
INSERT INTO `demand` VALUES ('5d499b6bdc4c11e9b510f8b156d274ca', '报警详情', 'UF-005-003', '5cf2cbd6dc4c11e9b510f8b156d274ca', null, null, '详情里包含目标人的姓名、性别、年龄、籍贯、民族、证件号码、电话号码、联系地址、备注、目标级别、目标库名等信息；', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'SF_SSLL_005', '003', null);
INSERT INTO `demand` VALUES ('5d499cdfdc4c11e9b510f8b156d274ca', '历史报警记录查询', 'UF-005-008', '5cf2cbd6dc4c11e9b510f8b156d274ca', null, null, '报警记录查询、导出；', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'SF_LSJL_001', '008', null);
INSERT INTO `demand` VALUES ('5d499e43dc4c11e9b510f8b156d274ca', '报警确认', 'UF-005-009', '5cf2cbd6dc4c11e9b510f8b156d274ca', null, null, '系统支持对报警记录进行确认操作，报警记录处理后，处理状态变更。', '1', null, '处理状态：未处理、已确认、误报', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0140-002', '009', null);
INSERT INTO `demand` VALUES ('5d499fb9dc4c11e9b510f8b156d274ca', '报警记录去重', 'UF-005-010', '5cf2cbd6dc4c11e9b510f8b156d274ca', null, null, '支持历史信息检索查询时，对同一目标任务在一定时间范围内的多次报警进行去重，可设置去重时间范围（支持1~120秒）。', '1', null, '存储去重', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0060-002', '010', null);
INSERT INTO `demand` VALUES ('5d49a133dc4c11e9b510f8b156d274ca', '扑克牌方式展示', 'UF-005-011', '5cf2cbd6dc4c11e9b510f8b156d274ca', null, null, '1.实时报警，以扑克牌方式展示，扑克牌的封面为抓拍的人脸图片，在扑克牌旁边展示姓名、性别、年龄、籍贯，确认按钮、误报按钮、详情 连接，详情里包含目标人的身份证号、护照编号、工作证编号、血型、指纹、驾驶证档案编号、手机号、Email、住址信息；\n2.实时报警列表展示与扑克牌展示可以切换；', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '011', null);
INSERT INTO `demand` VALUES ('5d49a2e2dc4c11e9b510f8b156d274ca', '颜色区分报警记录', 'UF-005-012', '5cf2cbd6dc4c11e9b510f8b156d274ca', null, null, '用三种颜色（红、蓝、黄）分别表示待确认的报警、已确认的报警、误报的报警；', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '012', null);
INSERT INTO `demand` VALUES ('5d49a45fdc4c11e9b510f8b156d274ca', '历史报警关联录像', 'UF-005-013', '5cf2cbd6dc4c11e9b510f8b156d274ca', null, null, '历史报警可以关联V2200、伟视清NVR录像；', '1', null, '讨论结果：暂时不做，有项目再做。', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '013', null);
INSERT INTO `demand` VALUES ('5d49a5e7dc4c11e9b510f8b156d274ca', '报警信息关联大图及录像', 'UF-005-014', '5cf2cbd6dc4c11e9b510f8b156d274ca', null, null, '可查看人脸抓拍图片关联的大图信息及前后的录像信息（录像时间可设置，默认20s，报警发生时的前 10 秒和后 10秒）', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '014', null);
INSERT INTO `demand` VALUES ('5d49a772dc4c11e9b510f8b156d274ca', '抓拍记录的查询', 'UF-006-001', '5cf5067adc4c11e9b510f8b156d274ca', null, null, '可以按照时间、目录或摄像机查询抓拍的记录，记录以列表方式展示；', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'SF_LSJL_003', '001', null);
INSERT INTO `demand` VALUES ('5d49a8e3dc4c11e9b510f8b156d274ca', '抓拍记录导出', 'UF-006-003', '5cf5067adc4c11e9b510f8b156d274ca', null, null, '抓拍记录可以导出；', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'SF_LSJL_003', '003', null);
INSERT INTO `demand` VALUES ('5d49aa44dc4c11e9b510f8b156d274ca', '关联录像', 'UF-006-004', '5cf5067adc4c11e9b510f8b156d274ca', null, null, '可以关联V2200、伟视清NVR录像；', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '004', null);
INSERT INTO `demand` VALUES ('5d49abb7dc4c11e9b510f8b156d274ca', '查询抓拍记录关联的大图及录像', 'UF-006-005', '5cf5067adc4c11e9b510f8b156d274ca', null, null, '可查看人脸抓拍图片关联的大图信息及前后的录像信息（录像时间可设置，默认20s，报警发生时的前 10 秒和后 10秒）', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '005', null);
INSERT INTO `demand` VALUES ('5d49ad21dc4c11e9b510f8b156d274ca', '抓拍记录去重', 'UF-006-006', '5cf5067adc4c11e9b510f8b156d274ca', null, null, '支持历史抓拍记录查询时，对同抓拍人脸图片在一定时间范围内的多次抓拍进行去重显示，去重时间范围可设置（支持1~30秒）', '1', null, '评审后改为V1.2实现', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '006', null);
INSERT INTO `demand` VALUES ('5d49ae9edc4c11e9b510f8b156d274ca', '人脸属性提取', 'UF-006-007', '5cf5067adc4c11e9b510f8b156d274ca', null, null, '支持人脸特征信息提取。如：性别，年龄段，种族（肤色），表情，饰品（是否戴眼镜，戴帽子）、胡须、面部动作状态特征信息。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '007', null);
INSERT INTO `demand` VALUES ('5d49b023dc4c11e9b510f8b156d274ca', '人脸属性快速查找', 'UF-006-008', '5cf5067adc4c11e9b510f8b156d274ca', null, null, '支持按人脸特征信息快速查找抓拍记录。如：性别，年龄段，种族（肤色），表情，饰品（是否戴眼镜，戴帽子）、胡须、面部动作状态特征信息。（字段包含支持的所有属性字段）', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '008', null);
INSERT INTO `demand` VALUES ('5d49b3f2dc4c11e9b510f8b156d274ca', '抓拍图片库搜索（抓拍图片库的以图搜图）', 'UF-007-001', '5cf72407dc4c11e9b510f8b156d274ca', null, null, '根据人脸图片，在抓拍记录里找出该人出现的时间、位置，结果可导出；', '1', null, '印度需求', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0150-001', '001', null);
INSERT INTO `demand` VALUES ('5d49b57bdc4c11e9b510f8b156d274ca', '静态搜索(目标库检索)', 'UF-007-002', '5cf72407dc4c11e9b510f8b156d274ca', null, null, '根据人脸图片，在人脸库中找出匹配的目标人物信息，结果可导出；', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'SF_YTST_002', '002', null);
INSERT INTO `demand` VALUES ('5d49b6e8dc4c11e9b510f8b156d274ca', '1：1比对', 'UF-007-003', '5cf72407dc4c11e9b510f8b156d274ca', null, null, '支持导入两张人脸图片进行一对一比对', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'SF_YTST_004', '003', null);
INSERT INTO `demand` VALUES ('5d49b84fdc4c11e9b510f8b156d274ca', '按特征搜人', 'UF-007-004', '5cf72407dc4c11e9b510f8b156d274ca', null, null, '性别、年龄段、是否戴眼镜特征', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '004', null);
INSERT INTO `demand` VALUES ('5d49b9b9dc4c11e9b510f8b156d274ca', '身份比对查重', 'UF-007-005', '5cf72407dc4c11e9b510f8b156d274ca', null, null, 'N:M，可通过库与库比对，也可以库内分时间段进行对比', '3', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '0', 'V1.2', null, '005', null);
INSERT INTO `demand` VALUES ('5d49bb78dc4c11e9b510f8b156d274ca', '非正脸照片检索', 'UF-007-006', '5cf72407dc4c11e9b510f8b156d274ca', null, null, '检索出非正脸照片，并可从库中删除', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '006', null);
INSERT INTO `demand` VALUES ('5d49bcdfdc4c11e9b510f8b156d274ca', '视频对比', 'UF-007-007', '5cf72407dc4c11e9b510f8b156d274ca', null, null, '支持导入2段视频、压缩包，自动提取人脸进行比对', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '007', null);
INSERT INTO `demand` VALUES ('5d49be3edc4c11e9b510f8b156d274ca', '支持多张人脸照片检索', 'UF-007-008', '5cf72407dc4c11e9b510f8b156d274ca', null, null, '可根据多个条件进行检索，搜索结果可以选择交集和并集显示', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '0', 'V1.2', null, '008', null);
INSERT INTO `demand` VALUES ('5d49bfa2dc4c11e9b510f8b156d274ca', '到场人员提醒', 'UF-008-001', '5d03b51adc4c11e9b510f8b156d274ca', null, null, '到场人员签到提醒；', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0180-001', '001', null);
INSERT INTO `demand` VALUES ('5d49c0eedc4c11e9b510f8b156d274ca', '到场情况查看', 'UF-008-002', '5d03b51adc4c11e9b510f8b156d274ca', null, null, '支持查看实时活动签到详情，哪些人到了哪些人没到。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0180-005', '002', null);
INSERT INTO `demand` VALUES ('5d49c24cdc4c11e9b510f8b156d274ca', '未到场人员', 'UF-008-003', '5d03b51adc4c11e9b510f8b156d274ca', null, null, '未到场人员进行罗列显示，并提示未到场人员的数量', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0180-005', '003', null);
INSERT INTO `demand` VALUES ('5d49c3a7dc4c11e9b510f8b156d274ca', '到场人员、未到场人员展示', 'UF-008-004', '5d03b51adc4c11e9b510f8b156d274ca', null, null, '支持显示签到人数、未签到人数', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0180-005', '004', null);
INSERT INTO `demand` VALUES ('5d49c502dc4c11e9b510f8b156d274ca', '签到信息提示', 'UF-008-005', '5d03b51adc4c11e9b510f8b156d274ca', null, null, '针对不同级别的人员，可弹出不同内容的提示框。', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', '不涉及', '005', null);
INSERT INTO `demand` VALUES ('5d49c657dc4c11e9b510f8b156d274ca', '活动管理-新增活动', 'UF-008-006', '5d03b51adc4c11e9b510f8b156d274ca', null, null, '支持创建多个活动，支持设置活动名称，活动地点，参与活动人员，活动时间，签到时间段，摄像机点位，比对阈值，和提示语', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0180-002', '006', null);
INSERT INTO `demand` VALUES ('5d49c7c2dc4c11e9b510f8b156d274ca', '活动管理-编辑', 'UF-008-007', '5d03b51adc4c11e9b510f8b156d274ca', null, null, '对于未开始及正在签到的活动，系统支持对其内容的修改，内容包含活动名称，活动地点，参与活动人员，活动时间，活动签到时间段（时间段不许设置当前时间之前），摄像机点位，比对阈值，和提示语', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0180-004 ', '007', null);
INSERT INTO `demand` VALUES ('5d49c94ddc4c11e9b510f8b156d274ca', '活动管理-删除', 'UF-008-008', '5d03b51adc4c11e9b510f8b156d274ca', null, null, '管理员支持活动的删除；', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0180-004 ', '008', null);
INSERT INTO `demand` VALUES ('5d49caabdc4c11e9b510f8b156d274ca', '活动管理-查找', 'UF-008-009', '5d03b51adc4c11e9b510f8b156d274ca', null, null, '支持通过活动名称、活动地点模糊查找', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0180-003', '009', null);
INSERT INTO `demand` VALUES ('5d49cbfadc4c11e9b510f8b156d274ca', '活动详情', 'UF-008-010', '5d03b51adc4c11e9b510f8b156d274ca', null, null, '支持查看活动签到结果，有多少人、有哪些人没来，有多少人，有哪些人迟到；', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0180-005', '010', null);
INSERT INTO `demand` VALUES ('5d49cd50dc4c11e9b510f8b156d274ca', '活动详情-统计', 'UF-008-011', '5d03b51adc4c11e9b510f8b156d274ca', null, null, '支持对历史的活动进行分析统计，通过趋势图展示签到趋势图', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0180-005', '011', null);
INSERT INTO `demand` VALUES ('5d49ceabdc4c11e9b510f8b156d274ca', '支持人脸考勤', 'UF-009-001', '5d05c133dc4c11e9b510f8b156d274ca', null, null, '支持上下班打卡，并提示', '1', null, '银湖会议中心需求', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0160-001', '001', null);
INSERT INTO `demand` VALUES ('5d49d006dc4c11e9b510f8b156d274ca', '生日提醒', 'UF-009-002', '5d05c133dc4c11e9b510f8b156d274ca', null, null, '针对当天过生日的员工，可对应提示生日快乐。', '2', null, '银湖会议中心需求', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', '不涉及', '002', null);
INSERT INTO `demand` VALUES ('5d49d173dc4c11e9b510f8b156d274ca', '考勤情况查看', 'UF-009-003', '5d05c133dc4c11e9b510f8b156d274ca', null, null, '展示页面提供当天应到人数，当前实到人数，未到人数信息，可点击进入查看具体人员信息。\n', '1', null, '银湖会议中心需求', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0160-001', '003', null);
INSERT INTO `demand` VALUES ('5d49d2dddc4c11e9b510f8b156d274ca', '考勤结果详情查询', 'UF-009-004', '5d05c133dc4c11e9b510f8b156d274ca', null, null, '点击更多，可按年，月，日，人员名称信息进行考勤结果检索，支持导出报表，提供当天、本周，本月的考勤报表（柱状图或饼图）', '1', null, '银湖会议中心需求', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0160-003\nS-0160-004', '004', null);
INSERT INTO `demand` VALUES ('5d49d451dc4c11e9b510f8b156d274ca', '新增考勤规则', 'UF-009-005', '5d05c133dc4c11e9b510f8b156d274ca', null, null, '支持新增考勤规则，\n字段包含考勤规则名称、上下班时间、考勤', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0100-001', '005', null);
INSERT INTO `demand` VALUES ('5d49d5a6dc4c11e9b510f8b156d274ca', '删除考勤规则', 'UF-009-006', '5d05c133dc4c11e9b510f8b156d274ca', null, null, '支持删除考勤规则，若该考勤计划应用于某一个考勤排班，系统应提示“该考勤规则应用于***排班，是否确认删除，删除后该排班改为默认考勤规则”', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0100-002', '006', null);
INSERT INTO `demand` VALUES ('5d49d71fdc4c11e9b510f8b156d274ca', '修改考勤规则', 'UF-009-007', '5d05c133dc4c11e9b510f8b156d274ca', null, null, '支持修改考勤规则；', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0100-001\nS-0100-002', '007', null);
INSERT INTO `demand` VALUES ('5d49d86edc4c11e9b510f8b156d274ca', '考勤规则查找', 'UF-009-008', '5d05c133dc4c11e9b510f8b156d274ca', null, null, '支持根据考勤规则名称查找考勤规则', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0100-001', '008', null);
INSERT INTO `demand` VALUES ('5d49d9d2dc4c11e9b510f8b156d274ca', '新增考勤排班', 'UF-009-009', '5d05c133dc4c11e9b510f8b156d274ca', null, null, '支持新增考勤排班，设置排班名称、被考勤对象、考勤规则、相似度、有效期。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0160-006', '009', null);
INSERT INTO `demand` VALUES ('5d49db37dc4c11e9b510f8b156d274ca', '修改考勤排班', 'UF-009-010', '5d05c133dc4c11e9b510f8b156d274ca', null, null, '支持修改排班信息。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0160-008', '010', null);
INSERT INTO `demand` VALUES ('5d49dc9bdc4c11e9b510f8b156d274ca', '考勤排班查找', 'UF-009-011', '5d05c133dc4c11e9b510f8b156d274ca', null, null, '支持根据排班名称模糊查找', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0160-007', '011', null);
INSERT INTO `demand` VALUES ('5d49ddeddc4c11e9b510f8b156d274ca', '输出考勤统计报表', 'UF-009-012', '5d05c133dc4c11e9b510f8b156d274ca', null, null, '自动生成考勤报表，按部门可生成日报表，月报表。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0160-002', '012', null);
INSERT INTO `demand` VALUES ('5d49df42dc4c11e9b510f8b156d274ca', '支持手动调整考勤数据', 'UF-009-013', '5d05c133dc4c11e9b510f8b156d274ca', null, null, '支持管理员手动调整员工考勤数据，如手动确认请假，漏打卡状态。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', ' S-0160-005 ', '013', null);
INSERT INTO `demand` VALUES ('5d49e0a3dc4c11e9b510f8b156d274ca', '考勤查询', 'UF-009-014', '5d05c133dc4c11e9b510f8b156d274ca', null, null, '支持根据时间，部门，个人姓名及编号，检索考勤历史记录', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0160-003', '014', null);
INSERT INTO `demand` VALUES ('5d49e256dc4c11e9b510f8b156d274ca', '考勤统计', 'UF-009-015', '5d05c133dc4c11e9b510f8b156d274ca', null, null, '支持考勤信息统计，各部门准点率、迟到人数。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', ' S-0160-002 ', '015', null);
INSERT INTO `demand` VALUES ('5d49e3c0dc4c11e9b510f8b156d274ca', '考勤统计查询导出', 'UF-009-016', '5d05c133dc4c11e9b510f8b156d274ca', null, null, '支持考勤数据导出。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', ' S-0160-004 ', '016', null);
INSERT INTO `demand` VALUES ('5d49e51bdc4c11e9b510f8b156d274ca', '登陆首页', 'UF-010-001', '5d07e832dc4c11e9b510f8b156d274ca', null, null, '登陆首页提示用户登陆信息，日期及天气内容。', '1', null, '银湖项目需求', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0010-001', '001', null);
INSERT INTO `demand` VALUES ('5d49e682dc4c11e9b510f8b156d274ca', '根据不同应用，提供多种风格的展示页面，页面可被用户编辑', 'UF-010-002', '5d07e832dc4c11e9b510f8b156d274ca', null, null, '1，提供不同应用功能的展示页面，同一套人脸识别系统，不同点位可能应用功能不同，则需要对应提供不同的应用页面。\n2，提供人脸考勤应用页面，人流统计应用页面，学校应用页面，提示信息可编辑', '1', null, '银湖项目需求', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '002', null);
INSERT INTO `demand` VALUES ('5d49e823dc4c11e9b510f8b156d274ca', '自定义页面', 'UF-010-003', '5d07e832dc4c11e9b510f8b156d274ca', null, null, '页面布局，背景图，可被用户自定义，可自行编辑文字，图片，视频，实时视频来源，比对结果展示，抓拍结果展示，弹出提示信息编辑，重要通知或温馨提示编辑。', '1', null, '银湖项目需求', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '003', null);
INSERT INTO `demand` VALUES ('5d49e98ddc4c11e9b510f8b156d274ca', '各点位人流量统计分析', 'UF-011-001', '5d0a1570dc4c11e9b510f8b156d274ca', null, null, '支持根据时间（1天，10，30天）内抓拍人脸图片进行分析，统计各点位的人流量；', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0170-001', '001', null);
INSERT INTO `demand` VALUES ('5d49eae5dc4c11e9b510f8b156d274ca', '按时间人流量统计', 'UF-011-002', '5d0a1570dc4c11e9b510f8b156d274ca', null, null, '统计每天及若干天内，各个时间段的人流量', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0170-001', '002', null);
INSERT INTO `demand` VALUES ('5d49ec35dc4c11e9b510f8b156d274ca', '报警统计', 'UF-011-003', '5d0a1570dc4c11e9b510f8b156d274ca', null, null, '按照组织、摄像机、时间统计报警数据', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0170-001', '003', null);
INSERT INTO `demand` VALUES ('5d49ed84dc4c11e9b510f8b156d274ca', '报警与抓拍比统计', 'UF-011-004', '5d0a1570dc4c11e9b510f8b156d274ca', null, null, '按照组织、摄像机、时间统计报警与抓拍的比例', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0170-001', '004', null);
INSERT INTO `demand` VALUES ('5d49eed6dc4c11e9b510f8b156d274ca', '进出统计', 'UF-011-005', '5d0a1570dc4c11e9b510f8b156d274ca', null, null, '系统支持显示人员进入时间、出来时间、逗留时间信息', '3', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', '不涉及', '005', null);
INSERT INTO `demand` VALUES ('5d49f031dc4c11e9b510f8b156d274ca', '新增统计区域', 'UF-011-006', '5d0a1570dc4c11e9b510f8b156d274ca', null, null, '系统新增统计区域，支持设置统计区域名称、进出点位', '3', null, '支持选择多个相机点位为入口、多个点位为出口', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', '不涉及', '006', null);
INSERT INTO `demand` VALUES ('5d49f192dc4c11e9b510f8b156d274ca', '删除统计区域', 'UF-011-007', '5d0a1570dc4c11e9b510f8b156d274ca', null, null, '系统删除统计区域，系统所有删除操作应作出提示并确认', '3', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', '不涉及', '007', null);
INSERT INTO `demand` VALUES ('5d49f2e7dc4c11e9b510f8b156d274ca', '修改统计区域', 'UF-011-008', '5d0a1570dc4c11e9b510f8b156d274ca', null, null, '支持修改统计区域名称、进出点位信息', '3', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', '不涉及', '008', null);
INSERT INTO `demand` VALUES ('5d49f430dc4c11e9b510f8b156d274ca', '查找统计区域', 'UF-011-009', '5d0a1570dc4c11e9b510f8b156d274ca', null, null, '支持根据区域名称模糊查找', '3', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', '不涉及', '009', null);
INSERT INTO `demand` VALUES ('5d49f58bdc4c11e9b510f8b156d274ca', '统计计划配置', 'UF-011-010', '5d0a1570dc4c11e9b510f8b156d274ca', null, null, '支持开始、暂停统计计划', '3', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', '不涉及', '010', null);
INSERT INTO `demand` VALUES ('5d49f6e6dc4c11e9b510f8b156d274ca', '统计告警规则配置', 'UF-011-011', '5d0a1570dc4c11e9b510f8b156d274ca', null, null, '支持配置告警规则，目标人员进入区域超过一定时间，系统认定该目标为异常', '3', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', '不涉及', '011', null);
INSERT INTO `demand` VALUES ('5d49f848dc4c11e9b510f8b156d274ca', '频次分析-针对目标库', 'UF-011-012', '5d0a1570dc4c11e9b510f8b156d274ca', null, null, '可创建频次分析任务，针对目标库人员进行频次分析，可以按照时间段，出现的频次阈值，对应的摄像机及布控任务进行目标库内人员的频次检索。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0170-003 ', '012', null);
INSERT INTO `demand` VALUES ('5d49f9bedc4c11e9b510f8b156d274ca', '频次分析-针对陌生人（抓拍库）', 'UF-011-013', '5d0a1570dc4c11e9b510f8b156d274ca', null, null, '可创建频次分析任务，针对陌生人库（抓拍库）进行频次分析，可以按照时间段，出现的频次阈值，对应的摄像机进行抓拍图片的频次分析。', '2', null, '组织讨论\n讨论结果：支持4路做频次统计，15天', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', '不涉及', '013', null);
INSERT INTO `demand` VALUES ('5d49fb2bdc4c11e9b510f8b156d274ca', '热力图展示', 'UF-011-014', '5d0a1570dc4c11e9b510f8b156d274ca', null, null, '统计的数据在地图上展示', '1', null, '哪些统计数据需要在地图上展示？', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '0', 'V1.2', null, '014', null);
INSERT INTO `demand` VALUES ('5d4a022cdc4c11e9b510f8b156d274ca', '逗留时间统计', 'UF-011-015', '5d0a1570dc4c11e9b510f8b156d274ca', null, null, '1.统计一段时间内某个区域的人员进入到离开的时间，如嫌疑人进出派出所审讯室的时间\n2.输入一个人的人脸照片，查询该人员在某个区域逗留的时间', '3', null, '虎门税务局需求', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '015', null);
INSERT INTO `demand` VALUES ('5d4a03a0dc4c11e9b510f8b156d274ca', '绘制人脸轨迹', 'UF-011-016', '5d0a1570dc4c11e9b510f8b156d274ca', null, null, '支持通过查询目标人员的抓拍记录，绘制目标人员运动轨迹并对其进行回放', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '016', null);
INSERT INTO `demand` VALUES ('5d4a06d2dc4c11e9b510f8b156d274ca', '门禁控制器对接', 'UF-012-001', '5d0c3e4fdc4c11e9b510f8b156d274ca', null, null, '项目内寻找一款门禁控制厂家，实现对接，门禁控制器优选考虑已有的资源', '1', null, '项目暂定厂家：皮克', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0190-001\nS-0190-002\nS-0190-003', '001', null);
INSERT INTO `demand` VALUES ('5d4a0857dc4c11e9b510f8b156d274ca', '新增门禁控制器', 'UF-012-002', '5d0c3e4fdc4c11e9b510f8b156d274ca', null, null, '支持绑定门禁控制器', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0190-003', '002', null);
INSERT INTO `demand` VALUES ('5d4a0a2bdc4c11e9b510f8b156d274ca', '删除门禁控制器', 'UF-012-003', '5d0c3e4fdc4c11e9b510f8b156d274ca', null, null, '支持解绑门禁控制器，进行解绑操作时，系统应作出提示并确认', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0190-003', '003', null);
INSERT INTO `demand` VALUES ('5d4a0cfddc4c11e9b510f8b156d274ca', '修改门禁控制器', 'UF-012-004', '5d0c3e4fdc4c11e9b510f8b156d274ca', null, null, '支持修改门禁控制器信息', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0190-003', '004', null);
INSERT INTO `demand` VALUES ('5d4a10c2dc4c11e9b510f8b156d274ca', '查找门禁控制器', 'UF-012-005', '5d0c3e4fdc4c11e9b510f8b156d274ca', null, null, '支持根据控制器名称模糊查找', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0190-002', '005', null);
INSERT INTO `demand` VALUES ('5d4a1260dc4c11e9b510f8b156d274ca', '刷脸开门', 'UF-012-006', '5d0c3e4fdc4c11e9b510f8b156d274ca', null, null, '通过设置布控任务，绑定摄像机和目标库，联动动作可以指定某一个或多个门禁控制器，当人脸比对成功后，将结果传送给门禁控制器，实现刷脸开门。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0120-001\nS-0190-003', '006', null);
INSERT INTO `demand` VALUES ('5d4a13fbdc4c11e9b510f8b156d274ca', '同步开门记录', 'UF-012-007', '5d0c3e4fdc4c11e9b510f8b156d274ca', null, null, '支持获取门禁控制器的门禁开门记录', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0190-001', '007', null);
INSERT INTO `demand` VALUES ('5d4a1550dc4c11e9b510f8b156d274ca', '历史记录检索', 'UF-012-008', '5d0c3e4fdc4c11e9b510f8b156d274ca', null, null, '支持对记录按照时间，员工名称或员工卡号进行结果查询检索。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0190-001', '008', null);
INSERT INTO `demand` VALUES ('5d4a16a8dc4c11e9b510f8b156d274ca', '操作日志查询', 'UF-013-001', '5d0e655adc4c11e9b510f8b156d274ca', null, null, '根据条件查询操作日志，并可以对日志导出', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'SF_RZCX_001', '001', null);
INSERT INTO `demand` VALUES ('5d4a17eedc4c11e9b510f8b156d274ca', '系统日志查询', 'UF-013-002', '5d0e655adc4c11e9b510f8b156d274ca', null, null, '根据条件查询系统日志，并可以对日志导出。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'SF_RZCX_001', '002', null);
INSERT INTO `demand` VALUES ('5d4a1931dc4c11e9b510f8b156d274ca', '操作日志查询', 'UF-013-003', '5d0e655adc4c11e9b510f8b156d274ca', null, null, '增加摄像机增删改查日志，属于操作日志', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0200-001', '003', null);
INSERT INTO `demand` VALUES ('5d4a1a77dc4c11e9b510f8b156d274ca', '日志优化', 'UF-013-004', '5d0e655adc4c11e9b510f8b156d274ca', null, null, '优化增强日志可读性', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '004', null);
INSERT INTO `demand` VALUES ('5d4a1bc0dc4c11e9b510f8b156d274ca', '人脸入库-手机拍照入库', 'UF-014-001', '5d10a04fdc4c11e9b510f8b156d274ca', null, null, '手机与系统对接，实现拍照上传，人脸注册入库（目标库）', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0220-003', '001', null);
INSERT INTO `demand` VALUES ('5d4a1d12dc4c11e9b510f8b156d274ca', '人脸入库-本地照片入库', 'UF-014-002', '5d10a04fdc4c11e9b510f8b156d274ca', null, null, '手机上的照片上传、注册入库（目标库），可以单张、多张入库（目标库），一次最多20张人脸图片，每张人脸图片大小小于5M', '1', null, '现最大支持9张', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0220-003', '002', null);
INSERT INTO `demand` VALUES ('5d4a1e70dc4c11e9b510f8b156d274ca', '人脸入库', 'UF-014-003', '5d10a04fdc4c11e9b510f8b156d274ca', null, null, '对于入库的图片进行图片质量判断：\n1、对质量分＜50的人脸图片拒绝入库，并提示是因为什么原因导致入库失败。\n2、对质量分在50~65之间的，应给出提示并在确认后继续入库；\n3、对于质量分在65以上的人脸照片，直接提示入库成功', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0220-003', '003', null);
INSERT INTO `demand` VALUES ('5d4a201adc4c11e9b510f8b156d274ca', '新增布控任务', 'UF-014-004', '5d10a04fdc4c11e9b510f8b156d274ca', null, null, '支持新增布控任务，包含字段：布控任务名称、目标库、时间范围、监控点位、阈值', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0250-003', '004', null);
INSERT INTO `demand` VALUES ('5d4a2163dc4c11e9b510f8b156d274ca', '修改布控任务', 'UF-014-005', '5d10a04fdc4c11e9b510f8b156d274ca', null, null, '支持修改布控任务信息', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0250-004', '005', null);
INSERT INTO `demand` VALUES ('5d4a229ddc4c11e9b510f8b156d274ca', '查找布控任务', 'UF-014-006', '5d10a04fdc4c11e9b510f8b156d274ca', null, null, '支持根据布控名称模糊查找', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0250-001', '006', null);
INSERT INTO `demand` VALUES ('5d4a23d7dc4c11e9b510f8b156d274ca', '布控管理-结束布控任务', 'UF-014-007', '5d10a04fdc4c11e9b510f8b156d274ca', null, null, '对已有的布控任务可以结束（中止）', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', '不涉及', '007', null);
INSERT INTO `demand` VALUES ('5d4a251ddc4c11e9b510f8b156d274ca', '布控管理-人脸布控报警', 'UF-014-008', '5d10a04fdc4c11e9b510f8b156d274ca', null, null, '人脸图片与目标库比对达到阈值时，服务器端向APP推送报警信息，报警信息包括抓拍的人脸图片、目标库中的人脸图片、相似度，时间、位置', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0240-001', '008', null);
INSERT INTO `demand` VALUES ('5d4a267bdc4c11e9b510f8b156d274ca', 'APP支持查看实时视频', 'UF-014-009', '5d10a04fdc4c11e9b510f8b156d274ca', null, null, '支持手机APP查看实时视频', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0260-001', '009', null);
INSERT INTO `demand` VALUES ('5d4a27bbdc4c11e9b510f8b156d274ca', '以图搜图-1:1比对', 'UF-014-010', '5d10a04fdc4c11e9b510f8b156d274ca', null, null, '一张人脸图片与另一张人脸图片比对', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0210-002', '010', null);
INSERT INTO `demand` VALUES ('5d4a290ddc4c11e9b510f8b156d274ca', '以图搜图-1:N比对', 'UF-014-011', '5d10a04fdc4c11e9b510f8b156d274ca', null, null, '1张人脸图片与N张人脸图片（一个目标库）比对', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0210-001', '011', null);
INSERT INTO `demand` VALUES ('5d4a2a62dc4c11e9b510f8b156d274ca', '以图搜图-消息推送', 'UF-014-012', '5d10a04fdc4c11e9b510f8b156d274ca', null, null, '以图搜图完成后，应提示操作用户，点击提示消息，可查看详细结果', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0210-004', '012', null);
INSERT INTO `demand` VALUES ('5d4a2babdc4c11e9b510f8b156d274ca', '操作系统', 'UF-014-013', '5d10a04fdc4c11e9b510f8b156d274ca', null, null, 'Android 5.0以上', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0380-002', '013', null);
INSERT INTO `demand` VALUES ('5d4a2cebdc4c11e9b510f8b156d274ca', '操作系统', 'UF-014-014', '5d10a04fdc4c11e9b510f8b156d274ca', null, null, 'IOS 8.0以上', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0380-003', '014', null);
INSERT INTO `demand` VALUES ('5d4a2e2bdc4c11e9b510f8b156d274ca', '移动设备', 'UF-014-015', '5d10a04fdc4c11e9b510f8b156d274ca', null, null, 'APP在Android、IOS手机上运行，暂不考虑PAD', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', '不涉及', '015', null);
INSERT INTO `demand` VALUES ('5d4a2f77dc4c11e9b510f8b156d274ca', '移动设备', 'UF-014-016', '5d10a04fdc4c11e9b510f8b156d274ca', null, null, 'APP在Android、IOS的PAD上运行，暂不考虑PAD', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '016', null);
INSERT INTO `demand` VALUES ('5d4a30eadc4c11e9b510f8b156d274ca', '以图搜图-M:N比对', 'UF-014-017', '5d10a04fdc4c11e9b510f8b156d274ca', null, null, 'M张人脸图片与N张人脸图片（一个目标库）比对', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '017', null);
INSERT INTO `demand` VALUES ('5d4a3243dc4c11e9b510f8b156d274ca', '支持TV APP客户端访问', 'UF-015-001', '5d12cd2ddc4c11e9b510f8b156d274ca', null, null, '支持通过TV APP，在Android系统的电视上登陆系统，访问查看相应功能模块', '1', null, '银湖需求', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0270-001', '001', null);
INSERT INTO `demand` VALUES ('5d4a33a4dc4c11e9b510f8b156d274ca', '人脸考勤', 'UF-015-002', '5d12cd2ddc4c11e9b510f8b156d274ca', null, null, '支持查看人脸考勤页面，查看统计报表页面', '1', null, '银湖项目需求', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0280-001\nS-0280-002 ', '002', null);
INSERT INTO `demand` VALUES ('5d4a34f9dc4c11e9b510f8b156d274ca', '活动签到', 'UF-015-003', '5d12cd2ddc4c11e9b510f8b156d274ca', null, null, '支持查看活动签到页面', '1', null, '银湖项目需求', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0290-001', '003', null);
INSERT INTO `demand` VALUES ('5d4a364bdc4c11e9b510f8b156d274ca', '实时布控', 'UF-015-004', '5d12cd2ddc4c11e9b510f8b156d274ca', null, null, '支持查看实时布控页面，查看实时视频流。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0300-001\n', '004', null);
INSERT INTO `demand` VALUES ('5d4a378edc4c11e9b510f8b156d274ca', '支持自启动恢复画面', 'UF-015-005', '5d12cd2ddc4c11e9b510f8b156d274ca', null, null, '支持开机启动恢复到断电前的页面和视频。\n', '2', null, '银湖项目需求', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', '不涉及', '005', null);
INSERT INTO `demand` VALUES ('5d4a38dadc4c11e9b510f8b156d274ca', '报警记录查询', 'UF-015-006', '5d12cd2ddc4c11e9b510f8b156d274ca', null, null, '支持查查看更多报警信息。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '006', null);
INSERT INTO `demand` VALUES ('5d4a3a35dc4c11e9b510f8b156d274ca', '抓怕记录查询', 'UF-015-007', '5d12cd2ddc4c11e9b510f8b156d274ca', null, null, '支持查看更多抓拍图片信息。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '007', null);
INSERT INTO `demand` VALUES ('5d4a3b75dc4c11e9b510f8b156d274ca', '人员点名', 'UF-015-008', '5d12cd2ddc4c11e9b510f8b156d274ca', null, null, '支持查看点名功能页面', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '008', null);
INSERT INTO `demand` VALUES ('5d4a3cafdc4c11e9b510f8b156d274ca', '设备管理', 'UF-016-001', '5d14f880dc4c11e9b510f8b156d274ca', null, null, '支持人脸抓拍机的接入，支持手动添加、搜索添加、导入添加（批量添加）；', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'SF_SBGL_001\nSF_SBGL_002', '001', null);
INSERT INTO `demand` VALUES ('5d4a3e04dc4c11e9b510f8b156d274ca', '设备管理', 'UF-016-002', '5d14f880dc4c11e9b510f8b156d274ca', null, null, '支持通过ONVIF，SDK，国标接入视频流\n支持从V2200，NVR中接入视频流', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '002', null);
INSERT INTO `demand` VALUES ('5d4a3f50dc4c11e9b510f8b156d274ca', '服务器管理', 'UF-016-003', '5d14f880dc4c11e9b510f8b156d274ca', null, null, '支持服务器IP、子网掩码、网关的配置；\n可单独设置双网口网络配置，任意IP地址均能正常使用系统功能。\n可选对外对外提供一个IP地址，无论插网口1还是插网口2，均能正常使用系统所有功能。当其中一个网口出现故障时，可自动切换到另一个网口使用。\n可设置双网络属性为双网隔离，仅通过其中指定网口才能使用系统', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '003', null);
INSERT INTO `demand` VALUES ('5d4a40fddc4c11e9b510f8b156d274ca', '用户管理', 'UF-016-004', '5d14f880dc4c11e9b510f8b156d274ca', null, null, '1.系统支持根据组织目录增加用户，修改用户，删除用户。\n2.用户具备以下属性：用户名称，联系电话，电子邮箱，描述等信息\n3.可更改用户密码\n4.可以给用户分配角色', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'SF_YHGL_001\nSF_YHGL_002\nSF_YHGL_003\nSF_YHGL_004\nSF_YHGL_005', '004', null);
INSERT INTO `demand` VALUES ('5d4a4276dc4c11e9b510f8b156d274ca', '角色管理', 'UF-016-005', '5d14f880dc4c11e9b510f8b156d274ca', null, null, '1.支持根据组织目录增加、修改、删除角色；\n2.对角色分配配置权限、资源操作权限；', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'SF_JSGL_001\nSF_JSGL_002\nSF_JSGL_003\nSF_JSGL_004\nSF_JSGL_005', '005', null);
INSERT INTO `demand` VALUES ('5d4a43d4dc4c11e9b510f8b156d274ca', '系统管理', 'UF-016-006', '5d14f880dc4c11e9b510f8b156d274ca', null, null, '1.系统的信息（版本、引擎的授权信息等）\n2.其他全局参数设置；\n3，支持服务器时间设置，NTP校时', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'SF_XTGL_001\nSF_XTGL_002', '006', null);
INSERT INTO `demand` VALUES ('5d4a4517dc4c11e9b510f8b156d274ca', '考勤规则配置', 'UF-016-007', '5d14f880dc4c11e9b510f8b156d274ca', null, null, '支持配置考勤规则，包含上下班时间', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0100-001', '007', null);
INSERT INTO `demand` VALUES ('5d4a46b5dc4c11e9b510f8b156d274ca', '部门管理', 'UF-016-008', '5d14f880dc4c11e9b510f8b156d274ca', null, null, '支持部门管理，对应目标库人员属性中的部门设置', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0090-001\nS-0090-002\nS-0090-003\nS-0090-004\nS-0090-005', '008', null);
INSERT INTO `demand` VALUES ('5d4a4804dc4c11e9b510f8b156d274ca', '升级方式', 'UF-016-009', '5d14f880dc4c11e9b510f8b156d274ca', null, null, '支持远程通过升级升级包进行远程维护。', '3', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '009', null);
INSERT INTO `demand` VALUES ('5d4a493edc4c11e9b510f8b156d274ca', '恢复出厂设置', 'UF-016-010', '5d14f880dc4c11e9b510f8b156d274ca', null, null, '支持恢复出厂设置操作', '3', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '010', null);
INSERT INTO `demand` VALUES ('5d4a4a7bdc4c11e9b510f8b156d274ca', '存储策略管理', 'UF-016-011', '5d14f880dc4c11e9b510f8b156d274ca', null, null, '支持存储策略设置，可设置存储满后停止，并短信，邮件或APP通知；或满后覆盖策略。\n支持人脸图片存储到指定服务器，NVR或网盘。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '011', null);
INSERT INTO `demand` VALUES ('5d4a4be5dc4c11e9b510f8b156d274ca', '信息上传到银湖园区集成平台', 'UF-017-001', '5d174388dc4c11e9b510f8b156d274ca', null, null, '人脸比对结果，人脸抓拍记录，统计报表，比对报警，报表信息能够定期（按日，月或指定方式）上传到银湖园区集成管理平台，或集成管理平台可主动查询相应结果。', '1', null, '银湖项目需求', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', '不涉及', '001', null);
INSERT INTO `demand` VALUES ('5d4a4d56dc4c11e9b510f8b156d274ca', '被银湖园区集成中心管理平台集中管理', 'UF-017-002', '5d174388dc4c11e9b510f8b156d274ca', null, null, '支持单点登录，可通过中心平台统一入口管理，无需再输入用户名密码进入。', '1', null, '银湖项目需求', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0010-001', '002', null);
INSERT INTO `demand` VALUES ('5d4a4eb4dc4c11e9b510f8b156d274ca', '考勤数据对接', 'UF-017-003', '5d174388dc4c11e9b510f8b156d274ca', null, null, '考勤数据可上传至集成平台（银湖智慧园区集成平台）', '1', null, '银湖项目需求', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0160-003', '003', null);
INSERT INTO `demand` VALUES ('5d4a4ffadc4c11e9b510f8b156d274ca', '加密授权', 'UF-019-001', '5d197b09dc4c11e9b510f8b156d274ca', null, null, '引擎的授权：与服务器硬件绑定，通过有效期，接入路数来授权，试用期授权30天，正式产品授权终生。接入路数授权根据设备接入能力另行定义', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'PF_ELSE_003', '001', null);
INSERT INTO `demand` VALUES ('5d4a5155dc4c11e9b510f8b156d274ca', '无加密狗系统登录', 'UF-019-002', '5d197b09dc4c11e9b510f8b156d274ca', null, null, '当检测不到加密狗或加密狗不在线时，系统可继续运行，用户登录客户端，每5分钟提示一次授权异常并退出登录。', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0010-001', '002', null);
INSERT INTO `demand` VALUES ('5d4a52b0dc4c11e9b510f8b156d274ca', '无加密狗报警短信提示', 'UF-019-003', '5d197b09dc4c11e9b510f8b156d274ca', null, null, '当检测不到加密狗或加密狗不在线时，可通过短信进行提示。', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', '不涉及', '003', null);
INSERT INTO `demand` VALUES ('5d4a56a6dc4c11e9b510f8b156d274ca', '无加密狗报警APP提示', 'UF-019-004', '5d197b09dc4c11e9b510f8b156d274ca', null, null, '当检测不到加密狗或加密狗不在线时，可通过APP进行提示。', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', '不涉及', '004', null);
INSERT INTO `demand` VALUES ('5d4a586bdc4c11e9b510f8b156d274ca', '无加密狗报警邮件提示', 'UF-019-005', '5d197b09dc4c11e9b510f8b156d274ca', null, null, '当检测不到加密狗或加密狗不在线时，可通过邮件进行提示。', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', '不涉及', '005', null);
INSERT INTO `demand` VALUES ('5d4a59c3dc4c11e9b510f8b156d274ca', '算法性能要求', 'UF-020-001', '5d1bb6e4dc4c11e9b510f8b156d274ca', null, null, '超过缓存丢弃的人脸图片进行标记，待系统闲时在进行比对。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '001', null);
INSERT INTO `demand` VALUES ('5d4a5b15dc4c11e9b510f8b156d274ca', 'GB_T31488', 'UQ-SD-001', '25df8834aed011e9b7bbf8b156d274ca', null, null, '符合GB_T31488安全防范视频监控人脸识别系统技术要求；', '1', null, '智能平台完成后再集成', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '001', null);
INSERT INTO `demand` VALUES ('5d4a5c95dc4c11e9b510f8b156d274ca', 'GA_T922', 'UQ-SD-002', '25df8834aed011e9b7bbf8b156d274ca', null, null, '符合GA_T922安防人脸识别应用系统相关技术要求', '1', null, '智能平台完成后再集成', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '002', null);
INSERT INTO `demand` VALUES ('5d4a5df3dc4c11e9b510f8b156d274ca', 'GA_T893', 'UQ-SD-003', '25df8834aed011e9b7bbf8b156d274ca', null, null, '符合GA_T893-2010安防生物识别应用术语；', '1', null, '智能平台完成后再集成', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '003', null);
INSERT INTO `demand` VALUES ('5d4a5f4bdc4c11e9b510f8b156d274ca', 'GA_T1344', 'UQ-SD-004', '25df8834aed011e9b7bbf8b156d274ca', null, null, '符合GA_T1344-2016安防人脸识别应用 视频人脸图像提取技术要求；', '1', null, '智能平台完成后再集成', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '004', null);
INSERT INTO `demand` VALUES ('5d4a60a3dc4c11e9b510f8b156d274ca', 'GA_T1399', 'UQ-SD-005', '25df8834aed011e9b7bbf8b156d274ca', null, null, '符合GA_T1399.1-2017公安视频图像分析系统 第1部分 通用技术要求；\n符合GA_T1399.2-2017公安视频图像分析系统 第2部分 视频图像内容分析及描述技术要求；', '1', null, '智能平台完成后再集成', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '005', null);
INSERT INTO `demand` VALUES ('5d4a6210dc4c11e9b510f8b156d274ca', 'GA_T1400', 'UQ-SD-006', '25df8834aed011e9b7bbf8b156d274ca', null, null, '符合GA_T1400.1-2017公安视频图像信息应用系统 第1部分 通用技术要求；\n符合GA_T1400.2-2017公安视频图像信息应用系统 第2部分 应用平台技术要求；\n符合GA_T1400.3-2017公安视频图像信息应用系统 第3部分 数据库技术要求；\n符合GA_T1400.4-2017公安视频图像信息应用系统 第4部分 接口协议技术要求；', '1', null, '智能平台完成后再集成', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '006', null);
INSERT INTO `demand` VALUES ('5d4a639fdc4c11e9b510f8b156d274ca', '客户操作系统', 'UQ-ENVI-001', '58d6ffc0aed011e9b7bbf8b156d274ca', null, null, '客户端支持win7 32位、64位', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'PQ_ENVI_002', '001', null);
INSERT INTO `demand` VALUES ('5d4a64eedc4c11e9b510f8b156d274ca', '客户端浏览器', 'UQ-ENVI-002', '58d6ffc0aed011e9b7bbf8b156d274ca', null, null, '浏览器支持IE9，IE11', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'PQ_ENVI_003', '002', null);
INSERT INTO `demand` VALUES ('5d4a6637dc4c11e9b510f8b156d274ca', '服务端操作系统', 'UQ-ENVI-003', '58d6ffc0aed011e9b7bbf8b156d274ca', null, null, 'Centos 7.2 64位', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'PQ_ENVI_001', '003', null);
INSERT INTO `demand` VALUES ('5d4a677ddc4c11e9b510f8b156d274ca', '接口文档', 'UQ-INTF-001', '60f886f3aed011e9b7bbf8b156d274ca', null, null, '对外提供接口文档，实现与第三方平台对接。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'PQ_IF_001', '001', null);
INSERT INTO `demand` VALUES ('5d4a68ccdc4c11e9b510f8b156d274ca', '基本接口', 'UQ-INTF-002', '60f886f3aed011e9b7bbf8b156d274ca', null, null, '应提供接口文档，以满足系统基础功能对接，例如：登录、退出，视频查看、报警记录、布控管理、目标库管理、报警信息推送。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0330-001', '002', null);
INSERT INTO `demand` VALUES ('5d4a6a1edc4c11e9b510f8b156d274ca', '考勤相关接口', 'UQ-INTF-003', '60f886f3aed011e9b7bbf8b156d274ca', null, null, '应提供接口文档，以满足考勤功能对接，例如：考勤统计、报表、补签、排班管理、考勤规则管理。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0330-001', '003', null);
INSERT INTO `demand` VALUES ('5d4a6b6adc4c11e9b510f8b156d274ca', '活动签到相关接口', 'UQ-INTF-004', '60f886f3aed011e9b7bbf8b156d274ca', null, null, '应提供接口文档，以满足考勤功能对接，例如：活动签到详情、活动管理。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0330-001', '004', null);
INSERT INTO `demand` VALUES ('5d4a6cd8dc4c11e9b510f8b156d274ca', '门禁管理相关接口', 'UQ-INTF-005', '60f886f3aed011e9b7bbf8b156d274ca', null, null, '应提供接口文档，以满足门禁管理功能对接，例如：开门记录。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0330-001', '005', null);
INSERT INTO `demand` VALUES ('5d4a6e1bdc4c11e9b510f8b156d274ca', '界面要求', 'UQ-UI-001', '6b463282aed011e9b7bbf8b156d274ca', null, null, '采用V2233DH V1.1的界面旧风格（白色）', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '0', 'V1.0', 'PQ_UI_001', '001', null);
INSERT INTO `demand` VALUES ('5d4a6f57dc4c11e9b510f8b156d274ca', '界面要求', 'UQ-UI-002', '6b463282aed011e9b7bbf8b156d274ca', null, null, '采用V2233DH V1.1的界面新风格（蓝色）', '3', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '0', 'V1.0', 'PQ_UI_001', '002', null);
INSERT INTO `demand` VALUES ('5d4a709ddc4c11e9b510f8b156d274ca', '界面要求', 'UQ-UI-003', '6b463282aed011e9b7bbf8b156d274ca', null, null, '采用V2233DH V2.0的界面风格(蓝色）,支持换肤框架', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0340-001', '003', null);
INSERT INTO `demand` VALUES ('5d4a71e7dc4c11e9b510f8b156d274ca', '分辨率', 'UQ-UI-004', '6b463282aed011e9b7bbf8b156d274ca', null, null, '支持1440*900；1920*1080分辨率', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0340-001', '004', null);
INSERT INTO `demand` VALUES ('5d4a7339dc4c11e9b510f8b156d274ca', '绑定用户信息', 'UQ-SA-001', '73db16b2aed011e9b7bbf8b156d274ca', null, null, '账号必须包含使用使用电脑 mac地址、 IP 等信息', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '0', 'V1.0', null, '001', null);
INSERT INTO `demand` VALUES ('5d4a748edc4c11e9b510f8b156d274ca', '绑定用户信息', 'UQ-SA-002', '73db16b2aed011e9b7bbf8b156d274ca', null, null, '账号必须包含使用者姓名、编号、联系方式、所在单位 信息（用户关联报警）', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '0', 'V1.1', 'S-0040-002', '002', null);
INSERT INTO `demand` VALUES ('5d4a75efdc4c11e9b510f8b156d274ca', '新增用户', 'UQ-SA-003', '73db16b2aed011e9b7bbf8b156d274ca', null, null, '系统支持新增用户，用户属性包含字段：用户名，密码，用户真实姓名，用户ID号（可输入身份证），用户联系电话，用户电子邮箱，用户描述，用户等级，用户有效期，所属组织，用户角色。\n其中用户名、密码、所属组织、用户角色必须填。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0040-001\nS-0040-002', '003', null);
INSERT INTO `demand` VALUES ('5d4a776edc4c11e9b510f8b156d274ca', '修改用户', 'UQ-SA-004', '73db16b2aed011e9b7bbf8b156d274ca', null, null, '系统支持修改用户信息。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0040-002', '004', null);
INSERT INTO `demand` VALUES ('5d4a78c6dc4c11e9b510f8b156d274ca', '删除用户', 'UQ-SA-005', '73db16b2aed011e9b7bbf8b156d274ca', null, null, '系统支持删除用户信息，删除时应提示，操作用户确认后执行删除。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0040-003', '005', null);
INSERT INTO `demand` VALUES ('5d4a7a09dc4c11e9b510f8b156d274ca', '查找用户', 'UQ-SA-006', '73db16b2aed011e9b7bbf8b156d274ca', null, null, '系统应支持根据用户名称、真实姓名、用户ID、电子邮箱模糊查找', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0040-005', '006', null);
INSERT INTO `demand` VALUES ('5d4a7b4fdc4c11e9b510f8b156d274ca', '管理员修改密码', 'UQ-SA-007', '73db16b2aed011e9b7bbf8b156d274ca', null, null, '系统管理员，在用户管理处修改密码应验证该管理员登录密码', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0040-002', '007', null);
INSERT INTO `demand` VALUES ('5d4a7c92dc4c11e9b510f8b156d274ca', '用户修改密码', 'UQ-SA-008', '73db16b2aed011e9b7bbf8b156d274ca', null, null, '用户支持修改密码，修改密码时应验证当前用户的原密码。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', '不涉及', '008', null);
INSERT INTO `demand` VALUES ('5d4a7dd8dc4c11e9b510f8b156d274ca', '用户有效期管理', 'UQ-SA-009', '73db16b2aed011e9b7bbf8b156d274ca', null, null, '系统应在用户有效期即将到期的前15天开始，每天每次登录均提示使用用户即将到期，为确保正常使用，请及时联系管理员。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0040-002', '009', null);
INSERT INTO `demand` VALUES ('5d4a82b4dc4c11e9b510f8b156d274ca', '新增角色', 'UQ-SA-010', '73db16b2aed011e9b7bbf8b156d274ca', null, null, '系统应支持新增角色，新增角色支持配置该角色所拥有的权限，权限应细分到本系统的二级菜单。\n例如“人脸识别子系统-布控管理”，“人脸考勤子系统-排班管理”，这里“人脸考勤子系统”为本系统的一级菜单，“排班管理”为二级菜单。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0050-001', '010', null);
INSERT INTO `demand` VALUES ('5d4a84e3dc4c11e9b510f8b156d274ca', '删除角色', 'UQ-SA-011', '73db16b2aed011e9b7bbf8b156d274ca', null, null, '系统应支持删除角色，删除时应判断该角色是否应用到用户：若无应用的用户，则用户确认口执行删除。若有应用用户，应提示不允许删除。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0040-003', '011', null);
INSERT INTO `demand` VALUES ('5d4a8677dc4c11e9b510f8b156d274ca', '修改角色', 'UQ-SA-012', '73db16b2aed011e9b7bbf8b156d274ca', null, null, '系统应支持修改角色信息；', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0040-002', '012', null);
INSERT INTO `demand` VALUES ('5d4a87eadc4c11e9b510f8b156d274ca', '查找角色', 'UQ-SA-013', '73db16b2aed011e9b7bbf8b156d274ca', null, null, '系统应支持通过角色名称模糊查找；', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', '不涉及', '013', null);
INSERT INTO `demand` VALUES ('5d4a8943dc4c11e9b510f8b156d274ca', '角色', 'UQ-SA-014', '73db16b2aed011e9b7bbf8b156d274ca', null, null, '超级管理员用户及有操作权限的角色可自定义用户角色，角色管理支持真删改，配置权限可分为：配置权限（设备管理，系统管理，用户管理，角色管理），功能权限（人脸布控，目标库管理，布控报警，设备统计，以图搜图，实时视频，操作日志，历史记录），操作权限（针对功能模块，细分增加，删除，查看，编辑，导出的权限分配）', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '014', null);
INSERT INTO `demand` VALUES ('5d4a8af5dc4c11e9b510f8b156d274ca', '权限', 'UQ-SA-015', '73db16b2aed011e9b7bbf8b156d274ca', null, null, '用户角色根据分配的权限对系统进行操作，对无权限操作的模块当用户进入时功能灰色不可点击。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0050-002', '015', null);
INSERT INTO `demand` VALUES ('5d4a8c60dc4c11e9b510f8b156d274ca', '系统保密性', 'UQ-SA-016', '73db16b2aed011e9b7bbf8b156d274ca', null, null, '只有授权的用户角色才能动用和修改信息系统的信息', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0010-001', '016', null);
INSERT INTO `demand` VALUES ('5d4a8db2dc4c11e9b510f8b156d274ca', '系统可用性', 'UQ-SA-017', '73db16b2aed011e9b7bbf8b156d274ca', null, null, '服务故障时可自动重启服务或重启机器，并自动恢复正常工作', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0060-001', '017', null);
INSERT INTO `demand` VALUES ('5d4a8f2bdc4c11e9b510f8b156d274ca', '权限', 'UQ-SA-018', '73db16b2aed011e9b7bbf8b156d274ca', null, null, '对目标库删除，目标库内人员删除，布控任务删除及终止操作，须二次验证用户登录密码方可进行删除操作。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '018', null);
INSERT INTO `demand` VALUES ('5d4a9086dc4c11e9b510f8b156d274ca', '用户数', 'UQ-PERF-001', '7e5a4076aed011e9b7bbf8b156d274ca', null, null, '客户端不同用户并发访问数量20（每个用户满负载进行操作）', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'PQ_PERF_001', '001', null);
INSERT INTO `demand` VALUES ('5d4a91e1dc4c11e9b510f8b156d274ca', '库容量', 'UQ-PERF-002', '7e5a4076aed011e9b7bbf8b156d274ca', null, null, '人脸库支持十万内', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'PQ_PERF_002', '002', null);
INSERT INTO `demand` VALUES ('5d4a932adc4c11e9b510f8b156d274ca', '时延', 'UQ-PERF-003', '7e5a4076aed011e9b7bbf8b156d274ca', null, null, '服务器(摄像机抓拍到客户端)显示时延小于1s', '3', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'PQ_PERF_004', '003', null);
INSERT INTO `demand` VALUES ('5d4a947cdc4c11e9b510f8b156d274ca', '时延', 'UQ-PERF-004', '7e5a4076aed011e9b7bbf8b156d274ca', null, null, '服务器(摄像机抓拍到客户端)显示时延小于2s', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'PQ_PERF_005', '004', null);
INSERT INTO `demand` VALUES ('5d4a95bfdc4c11e9b510f8b156d274ca', '动态摄像机接入数量', 'UQ-PERF-005', '7e5a4076aed011e9b7bbf8b156d274ca', null, null, '动态摄像机可以接入2-20路', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '005', null);
INSERT INTO `demand` VALUES ('5d4a9714dc4c11e9b510f8b156d274ca', '静态摄像机接入数量', 'UQ-PERF-006', '7e5a4076aed011e9b7bbf8b156d274ca', null, null, '批量图像特征提取性能50张/S（约16路人脸抓拍摄像机接入）【硬件须选型】\n批量图像特征提取性能150张/S（约48路人脸抓拍摄像机接入）【硬件须选型，参考硬件：2U机箱，2个Intel® Xeon® E5 2620 处理器，32G内存，单GPU卡，双千兆网口，冗余电源（48路）】', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'PQ_PERF_006', '006', null);
INSERT INTO `demand` VALUES ('5d4aafe7dc4c11e9b510f8b156d274ca', '小盒子性能需求', 'UQ-PERF-007-001', '7e5a4076aed011e9b7bbf8b156d274ca', '5d21c900dc4c11e9b510f8b156d274ca', null, '硬件需求：\nCPU：I7-7700 处理性能以上\n内存：32G以上\n硬盘：除去系统空间，能提供4T以上图片存储空间\nGPU： NVIDIA GTX 1060 6GB以上\n网口：千兆网口，2个以上USB口\n成本：10000以下', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-007-001', '007-001', null);
INSERT INTO `demand` VALUES ('5d4ab1f1dc4c11e9b510f8b156d274ca', '小盒子性能需求', 'UQ-PERF-007-002', '7e5a4076aed011e9b7bbf8b156d274ca', '5d21c900dc4c11e9b510f8b156d274ca', null, '批量图像特征提取速度（张/秒）：78张/s', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-007-002', '007-002', null);
INSERT INTO `demand` VALUES ('5d4ab367dc4c11e9b510f8b156d274ca', '小盒子性能需求', 'UQ-PERF-007-003', '7e5a4076aed011e9b7bbf8b156d274ca', '5d21c900dc4c11e9b510f8b156d274ca', null, '批量图像特征提取速度（张/秒）：大于100张/s', '3', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-007-003', '007-003', null);
INSERT INTO `demand` VALUES ('5d4ab4cfdc4c11e9b510f8b156d274ca', '小盒子性能需求', 'UQ-PERF-007-004', '7e5a4076aed011e9b7bbf8b156d274ca', '5d21c900dc4c11e9b510f8b156d274ca', null, '单张图像特征提取速度（毫秒/张）：11ms/张', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-007-004', '007-004', null);
INSERT INTO `demand` VALUES ('5d4ab61edc4c11e9b510f8b156d274ca', '小盒子性能需求', 'UQ-PERF-007-005', '7e5a4076aed011e9b7bbf8b156d274ca', '5d21c900dc4c11e9b510f8b156d274ca', null, '1:1特征比对速度（张/秒）：150张/秒', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-007-005', '007-005', null);
INSERT INTO `demand` VALUES ('5d4ab76ddc4c11e9b510f8b156d274ca', '小盒子性能需求', 'UQ-PERF-007-006', '7e5a4076aed011e9b7bbf8b156d274ca', '5d21c900dc4c11e9b510f8b156d274ca', null, '1:1图像比对速度（张/秒）：3.5张/秒', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-007-006', '007-006', null);
INSERT INTO `demand` VALUES ('5d4ab8bcdc4c11e9b510f8b156d274ca', '小盒子性能需求', 'UQ-PERF-007-007', '7e5a4076aed011e9b7bbf8b156d274ca', '5d21c900dc4c11e9b510f8b156d274ca', null, '1:1图像比对速度（张/秒）：100张/秒', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-007-007', '007-007', null);
INSERT INTO `demand` VALUES ('5d4abc4cdc4c11e9b510f8b156d274ca', '小盒子性能需求', 'UQ-PERF-007-008', '7e5a4076aed011e9b7bbf8b156d274ca', '5d21c900dc4c11e9b510f8b156d274ca', null, '并发1：N图像搜库速度：60张/秒\n（张/秒，N=10W，返回top10，用特征信息搜库）', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-007-008', '007-008', null);
INSERT INTO `demand` VALUES ('5d4abdc5dc4c11e9b510f8b156d274ca', '小盒子性能需求', 'UQ-PERF-007-009', '7e5a4076aed011e9b7bbf8b156d274ca', '5d21c900dc4c11e9b510f8b156d274ca', null, '并发1：N特征搜库速度：60张/秒\n（张/秒，N=10W，返回top10，用图片搜库）', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-007-009', '007-009', null);
INSERT INTO `demand` VALUES ('5d4abf2cdc4c11e9b510f8b156d274ca', '小盒子性能需求', 'UQ-PERF-007-010', '7e5a4076aed011e9b7bbf8b156d274ca', '5d21c900dc4c11e9b510f8b156d274ca', null, '并发1：N特征搜库速度：100张/秒\n（张/秒，N=10W，返回top10，用图片搜库）', '3', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-007-010', '007-010', null);
INSERT INTO `demand` VALUES ('5d4ac093dc4c11e9b510f8b156d274ca', '小盒子性能需求', 'UQ-PERF-007-011', '7e5a4076aed011e9b7bbf8b156d274ca', '5d21c900dc4c11e9b510f8b156d274ca', null, '并发1：N特征搜库速度：150张/秒\n（张/秒，N=10W，返回top10，用图片搜库）', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-007-011', '007-011', null);
INSERT INTO `demand` VALUES ('5d4ac1f4dc4c11e9b510f8b156d274ca', '小盒子性能需求', 'UQ-PERF-007-012', '7e5a4076aed011e9b7bbf8b156d274ca', '5d21c900dc4c11e9b510f8b156d274ca', null, '单张图像入库速度：12毫秒/张\n（毫秒/张，完成图像特征提取，特性信息入库）', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-007-012', '007-012', null);
INSERT INTO `demand` VALUES ('5d4ac350dc4c11e9b510f8b156d274ca', '小盒子性能需求', 'UQ-PERF-007-013', '7e5a4076aed011e9b7bbf8b156d274ca', '5d21c900dc4c11e9b510f8b156d274ca', null, '批量图像入库速度：30万张/小时  （83.6张/秒）\n（张/小时，完成图像特征提取，特性信息入库）', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-007-013', '007-013', null);
INSERT INTO `demand` VALUES ('5d4ac4b7dc4c11e9b510f8b156d274ca', '小盒子性能需求', 'UQ-PERF-007-014', '7e5a4076aed011e9b7bbf8b156d274ca', '5d21c900dc4c11e9b510f8b156d274ca', null, '批量图像入库速度：36万张/小时\n（张/小时，完成图像特征提取，特性信息入库）', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-007-014', '007-014', null);
INSERT INTO `demand` VALUES ('5d4ac609dc4c11e9b510f8b156d274ca', '小盒子性能需求', 'UQ-PERF-007-015', '7e5a4076aed011e9b7bbf8b156d274ca', '5d21c900dc4c11e9b510f8b156d274ca', null, '图片流处理能力：44张/秒\n（张/秒，底库10w，完成特征提取，特征搜库及结果入库，稳定运行24小时无明显延时的值）', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-007-015', '007-015', null);
INSERT INTO `demand` VALUES ('5d4ac770dc4c11e9b510f8b156d274ca', '小盒子性能需求', 'UQ-PERF-007-016', '7e5a4076aed011e9b7bbf8b156d274ca', '5d21c900dc4c11e9b510f8b156d274ca', null, '图片流处理能力：50张/秒\n（张/秒，底库10w，完成特征提取，特征搜库及结果入库，稳定运行24小时无明显延时的值）', '3', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-007-016', '007-016', null);
INSERT INTO `demand` VALUES ('5d4ac8c5dc4c11e9b510f8b156d274ca', '小盒子性能需求', 'UQ-PERF-007-017', '7e5a4076aed011e9b7bbf8b156d274ca', '5d21c900dc4c11e9b510f8b156d274ca', null, '图片流处理能力：60张/秒\n（张/秒，底库10w，完成特征提取，特征搜库及结果入库，稳定运行24小时无明显延时的值）', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-007-017', '007-017', null);
INSERT INTO `demand` VALUES ('5d4aca1adc4c11e9b510f8b156d274ca', '小盒子性能需求', 'UQ-PERF-007-018', '7e5a4076aed011e9b7bbf8b156d274ca', '5d21c900dc4c11e9b510f8b156d274ca', null, '视频流接入处理能力：至少接入15路\n（路，1080P视频流，完成人脸检测，特征提取比对分析，10万底库）', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '007-018', null);
INSERT INTO `demand` VALUES ('5d4acb91dc4c11e9b510f8b156d274ca', '小盒子性能需求', 'UQ-PERF-007-019', '7e5a4076aed011e9b7bbf8b156d274ca', '5d21c900dc4c11e9b510f8b156d274ca', null, '10万库容下1：N图片检索告警平均响应时间：不大于1秒', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-007-019', '007-019', null);
INSERT INTO `demand` VALUES ('5d4acd2bdc4c11e9b510f8b156d274ca', '小盒子性能需求', 'UQ-PERF-007-020', '7e5a4076aed011e9b7bbf8b156d274ca', '5d21c900dc4c11e9b510f8b156d274ca', null, '考虑降低成本，设备增加公司LOGO丝印', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '007-020', null);
INSERT INTO `demand` VALUES ('5d4ace86dc4c11e9b510f8b156d274ca', '小盒子性能需求', 'UQ-PERF-007-021', '7e5a4076aed011e9b7bbf8b156d274ca', '5d21c900dc4c11e9b510f8b156d274ca', null, '屏蔽硬件上无用的接口，如网口2，USB口，VGA口，DP接口，COM口，SIM卡，音频输入输出接口', '1', null, '周林先确认方案及价格影响，如果接收，单独立定制项目进行硬件的产品化。V1.2考虑集成', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '007-021', null);
INSERT INTO `demand` VALUES ('5d4ad003dc4c11e9b510f8b156d274ca', '机架式服务器性能需求', 'UQ-PERF-008-001', '7e5a4076aed011e9b7bbf8b156d274ca', '5d2492e9dc4c11e9b510f8b156d274ca', null, '硬件需求：\nCPU：双颗E5-2620v3/v4系列以上处理器\n内存：32G以上，支持扩展\nGPU：GTX1080 11G\n硬盘：最大可提供42T图片存储空间\n网卡：双万兆网卡\n其他：9271-8i RAID卡\n成本：23000以下', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-008-001', '008-001', null);
INSERT INTO `demand` VALUES ('5d4ad1afdc4c11e9b510f8b156d274ca', '机架式服务器性能需求', 'UQ-PERF-008-002', '7e5a4076aed011e9b7bbf8b156d274ca', '5d2492e9dc4c11e9b510f8b156d274ca', null, '批量图像特征提取速度（张/秒）：281张/s', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-008-002', '008-002', null);
INSERT INTO `demand` VALUES ('5d4ad317dc4c11e9b510f8b156d274ca', '机架式服务器性能需求', 'UQ-PERF-008-003', '7e5a4076aed011e9b7bbf8b156d274ca', '5d2492e9dc4c11e9b510f8b156d274ca', null, '批量图像特征提取速度（张/秒）：大于350张/s', '3', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-008-003', '008-003', null);
INSERT INTO `demand` VALUES ('5d4ad469dc4c11e9b510f8b156d274ca', '机架式服务器性能需求', 'UQ-PERF-008-004', '7e5a4076aed011e9b7bbf8b156d274ca', '5d2492e9dc4c11e9b510f8b156d274ca', null, '单张图像特征提取速度（毫秒/张）：3ms/张', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-008-004', '008-004', null);
INSERT INTO `demand` VALUES ('5d4ad5c1dc4c11e9b510f8b156d274ca', '机架式服务器性能需求', 'UQ-PERF-008-005', '7e5a4076aed011e9b7bbf8b156d274ca', '5d2492e9dc4c11e9b510f8b156d274ca', null, '1:1特征比对速度（张/秒）：450张/秒', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-008-005', '008-005', null);
INSERT INTO `demand` VALUES ('5d4ad7c5dc4c11e9b510f8b156d274ca', '机架式服务器性能需求', 'UQ-PERF-008-006', '7e5a4076aed011e9b7bbf8b156d274ca', '5d2492e9dc4c11e9b510f8b156d274ca', null, '1:1图像比对速度（张/秒）：2.5张/秒', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-008-006', '008-006', null);
INSERT INTO `demand` VALUES ('5d4ad917dc4c11e9b510f8b156d274ca', '机架式服务器性能需求', 'UQ-PERF-008-007', '7e5a4076aed011e9b7bbf8b156d274ca', '5d2492e9dc4c11e9b510f8b156d274ca', null, '1:1图像比对速度（张/秒）：350张/秒', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-008-007', '008-007', null);
INSERT INTO `demand` VALUES ('5d4adac4dc4c11e9b510f8b156d274ca', '机架式服务器性能需求', 'UQ-PERF-008-008', '7e5a4076aed011e9b7bbf8b156d274ca', '5d2492e9dc4c11e9b510f8b156d274ca', null, '并发1：N图像搜库速度：200张/秒\n（张/秒，N=10W，返回top10，用特征信息搜库）', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-008-008', '008-008', null);
INSERT INTO `demand` VALUES ('5d4addb6dc4c11e9b510f8b156d274ca', '机架式服务器性能需求', 'UQ-PERF-008-009', '7e5a4076aed011e9b7bbf8b156d274ca', '5d2492e9dc4c11e9b510f8b156d274ca', null, '并发1：N特征搜库速度：72张/秒\n（张/秒，N=10W，返回top10，用图片搜库）', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-008-009', '008-009', null);
INSERT INTO `demand` VALUES ('5d4adf36dc4c11e9b510f8b156d274ca', '机架式服务器性能需求', 'UQ-PERF-008-010', '7e5a4076aed011e9b7bbf8b156d274ca', '5d2492e9dc4c11e9b510f8b156d274ca', null, '并发1：N特征搜库速度：150张/秒\n（张/秒，N=10W，返回top10，用图片搜库）', '3', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-008-010', '008-010', null);
INSERT INTO `demand` VALUES ('5d4ae08edc4c11e9b510f8b156d274ca', '机架式服务器性能需求', 'UQ-PERF-008-011', '7e5a4076aed011e9b7bbf8b156d274ca', '5d2492e9dc4c11e9b510f8b156d274ca', null, '并发1：N特征搜库速度：300张/秒\n（张/秒，N=10W，返回top10，用图片搜库）', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-008-011', '008-011', null);
INSERT INTO `demand` VALUES ('5d4ae1d7dc4c11e9b510f8b156d274ca', '机架式服务器性能需求', 'UQ-PERF-008-012', '7e5a4076aed011e9b7bbf8b156d274ca', '5d2492e9dc4c11e9b510f8b156d274ca', null, '单张图像入库速度：4毫秒/张\n（毫秒/张，完成图像特征提取，特性信息入库）', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-008-012', '008-012', null);
INSERT INTO `demand` VALUES ('5d4ae335dc4c11e9b510f8b156d274ca', '机架式服务器性能需求', 'UQ-PERF-008-013', '7e5a4076aed011e9b7bbf8b156d274ca', '5d2492e9dc4c11e9b510f8b156d274ca', null, '批量图像入库速度：81万张/小时 （226张/秒）\n（张/小时，完成图像特征提取，特性信息入库）', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-008-013', '008-013', null);
INSERT INTO `demand` VALUES ('5d4ae499dc4c11e9b510f8b156d274ca', '机架式服务器性能需求', 'UQ-PERF-008-014', '7e5a4076aed011e9b7bbf8b156d274ca', '5d2492e9dc4c11e9b510f8b156d274ca', null, '批量图像入库速度：125万张/小时\n（张/小时，完成图像特征提取，特性信息入库）', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-008-014', '008-014', null);
INSERT INTO `demand` VALUES ('5d4ae5f5dc4c11e9b510f8b156d274ca', '机架式服务器性能需求', 'UQ-PERF-008-015', '7e5a4076aed011e9b7bbf8b156d274ca', '5d2492e9dc4c11e9b510f8b156d274ca', null, '图片流处理能力：80张/秒\n（张/秒，底库10w，完成特征提取，特征搜库及结果入库，稳定运行24小时无明显延时的值）', '1', null, '图片流：人脸抓拍机输出人脸图片', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-008-015', '008-015', null);
INSERT INTO `demand` VALUES ('5d4aea7cdc4c11e9b510f8b156d274ca', '机架式服务器性能需求', 'UQ-PERF-008-016', '7e5a4076aed011e9b7bbf8b156d274ca', '5d2492e9dc4c11e9b510f8b156d274ca', null, '图片流处理能力：100张/秒\n（张/秒，底库10w，完成特征提取，特征搜库及结果入库，稳定运行24小时无明显延时的值）', '3', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-008-016', '008-016', null);
INSERT INTO `demand` VALUES ('5d4aec92dc4c11e9b510f8b156d274ca', '机架式服务器性能需求', 'UQ-PERF-008-017', '7e5a4076aed011e9b7bbf8b156d274ca', '5d2492e9dc4c11e9b510f8b156d274ca', null, '图片流处理能力：200张/秒\n（张/秒，底库10w，完成特征提取，特征搜库及结果入库，稳定运行24小时无明显延时的值）', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-008-017', '008-017', null);
INSERT INTO `demand` VALUES ('5d4aedf0dc4c11e9b510f8b156d274ca', '机架式服务器性能需求', 'UQ-PERF-008-018', '7e5a4076aed011e9b7bbf8b156d274ca', '5d2492e9dc4c11e9b510f8b156d274ca', null, '视频流接入处理能力：至少接入50路\n（路，1080P视频流，完成人脸检测，特征提取比对分析，10万底库）', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '008-018', null);
INSERT INTO `demand` VALUES ('5d4aef51dc4c11e9b510f8b156d274ca', '机架式服务器性能需求', 'UQ-PERF-008-019', '7e5a4076aed011e9b7bbf8b156d274ca', '5d2492e9dc4c11e9b510f8b156d274ca', null, '10万库容下1：N图片检索告警平均响应时间：不大于1秒', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-008-019', '008-019', null);
INSERT INTO `demand` VALUES ('5d4af0a7dc4c11e9b510f8b156d274ca', '机架式服务器性能需求', 'UQ-PERF-008-020', '7e5a4076aed011e9b7bbf8b156d274ca', '5d2492e9dc4c11e9b510f8b156d274ca', null, '考虑降低成本，设备增加公司LOGO丝印', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '008-020', null);
INSERT INTO `demand` VALUES ('5d4af208dc4c11e9b510f8b156d274ca', '机架式服务器性能需求', 'UQ-PERF-008-021', '7e5a4076aed011e9b7bbf8b156d274ca', '5d2492e9dc4c11e9b510f8b156d274ca', null, '支持硬盘热插拔，支持客户现场自行操作硬盘', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-008-021', '008-021', null);
INSERT INTO `demand` VALUES ('5d4af390dc4c11e9b510f8b156d274ca', '算法性能要求', 'UQ-PERF-009-001', '7e5a4076aed011e9b7bbf8b156d274ca', '5d27a302dc4c11e9b510f8b156d274ca', null, '单张/批量人脸注册成功率：95%（人脸图片用V1.0的入库图片集测试）', '1', null, '“注册”即为“入库”', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-009-001', '009-001', null);
INSERT INTO `demand` VALUES ('5d4af525dc4c11e9b510f8b156d274ca', '算法性能要求', 'UQ-PERF-009-002', '7e5a4076aed011e9b7bbf8b156d274ca', '5d27a302dc4c11e9b510f8b156d274ca', null, '单张/批量人脸注册成功率：99.9%（人脸图片用V1.0的入库图片集测试）', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-009-002', '009-002', null);
INSERT INTO `demand` VALUES ('5d4af683dc4c11e9b510f8b156d274ca', '算法性能要求', 'UQ-PERF-009-003', '7e5a4076aed011e9b7bbf8b156d274ca', '5d27a302dc4c11e9b510f8b156d274ca', null, '系统注册失败率：不大于0.09%', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-009-003', '009-003', null);
INSERT INTO `demand` VALUES ('5d4af7ccdc4c11e9b510f8b156d274ca', '算法性能要求', 'UQ-PERF-009-004', '7e5a4076aed011e9b7bbf8b156d274ca', '5d27a302dc4c11e9b510f8b156d274ca', null, '1：N人脸检索比对首位命中率不低于95%\n1：N人脸检索比对TOP5命中率不低于97%\n1：N人脸检索比对TOP10命中率不低于99%', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-009-004', '009-004', null);
INSERT INTO `demand` VALUES ('5d4af92adc4c11e9b510f8b156d274ca', '算法性能要求', 'UQ-PERF-009-005', '7e5a4076aed011e9b7bbf8b156d274ca', '5d27a302dc4c11e9b510f8b156d274ca', null, '1：N人脸检索比对首位命中率不低于98%\n1：N人脸检索比对TOP5命中率不低于99%\n1：N人脸检索比对TOP10命中率不低于99.9%', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-009-005', '009-005', null);
INSERT INTO `demand` VALUES ('5d4afa82dc4c11e9b510f8b156d274ca', '算法性能要求', 'UQ-PERF-009-006', '7e5a4076aed011e9b7bbf8b156d274ca', '5d27a302dc4c11e9b510f8b156d274ca', null, '非监视名单误报率不大于2%', '1', null, '系统默认阈值', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-009-006', '009-006', null);
INSERT INTO `demand` VALUES ('5d4afbe0dc4c11e9b510f8b156d274ca', '算法性能要求', 'UQ-PERF-009-007', '7e5a4076aed011e9b7bbf8b156d274ca', '5d27a302dc4c11e9b510f8b156d274ca', null, '1:1比对，图片相似度准确率不小于99.9%', '1', null, '系统默认阈值', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-009-007', '009-007', null);
INSERT INTO `demand` VALUES ('5d4afd3bdc4c11e9b510f8b156d274ca', '算法性能要求', 'UQ-PERF-009-008', '7e5a4076aed011e9b7bbf8b156d274ca', '5d27a302dc4c11e9b510f8b156d274ca', null, '针对视频流，人脸检测偏转角度支持水平方向转动±30°、倾斜方向转动±45°、俯仰方向转动±40°范围内人脸', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', 'S-0360-009-008', '009-008', null);
INSERT INTO `demand` VALUES ('5d4afe9adc4c11e9b510f8b156d274ca', '算法性能要求', 'UQ-PERF-009-009', '7e5a4076aed011e9b7bbf8b156d274ca', '5d27a302dc4c11e9b510f8b156d274ca', null, '针对视频流，最小可检测瞳距小于等于15个像素的人脸图片', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', 'S-0360-009-009', '009-009', null);
INSERT INTO `demand` VALUES ('5d4afffbdc4c11e9b510f8b156d274ca', '算法性能要求', 'UQ-PERF-009-010', '7e5a4076aed011e9b7bbf8b156d274ca', '5d27a302dc4c11e9b510f8b156d274ca', null, '针对视频流，对于遮挡不大于1/3的人脸，检出率大于99%；准确率大于95%', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', 'S-0360-009-010', '009-010', null);
INSERT INTO `demand` VALUES ('5d4b039adc4c11e9b510f8b156d274ca', '算法性能要求', 'UQ-PERF-009-011', '7e5a4076aed011e9b7bbf8b156d274ca', '5d27a302dc4c11e9b510f8b156d274ca', null, '针对视频流，支持检出单张画面人脸数不小于32张', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', 'S-0360-009-011', '009-011', null);
INSERT INTO `demand` VALUES ('5d4b0504dc4c11e9b510f8b156d274ca', '算法性能要求', 'UQ-PERF-009-012', '7e5a4076aed011e9b7bbf8b156d274ca', '5d27a302dc4c11e9b510f8b156d274ca', null, '最小可识别瞳距等于30个像素的人脸图片，提取特征', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0360-009-012', '009-012', null);
INSERT INTO `demand` VALUES ('5d4b065cdc4c11e9b510f8b156d274ca', '动、静态摄像机接入', 'UQ-CA-001', '87118a47aed011e9b7bbf8b156d274ca', null, null, '系统同时支持接入普通高清摄像机和人脸抓拍摄像机，即静态人脸服务器和动态人脸服务器可以一起混合使用；', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '001', null);
INSERT INTO `demand` VALUES ('5d4b07ccdc4c11e9b510f8b156d274ca', '测试指导', 'UQ-TA-001', '91dbfdf7aed011e9b7bbf8b156d274ca', null, null, '提供测试指导文档；', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'S-0380-001', '001', null);
INSERT INTO `demand` VALUES ('5d4b092ddc4c11e9b510f8b156d274ca', '生产指导文档', 'UQ-PA-001', '9a586a89aed011e9b7bbf8b156d274ca', null, null, '提供生产指导文档', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'S-0390-001', '001', null);
INSERT INTO `demand` VALUES ('5d4b0a83dc4c11e9b510f8b156d274ca', '提供安装包及安装说明书', 'UQ-PA-002', '9a586a89aed011e9b7bbf8b156d274ca', null, null, '提供安装包及安装说明', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'S-0390-001', '002', null);
INSERT INTO `demand` VALUES ('5d4b0bd2dc4c11e9b510f8b156d274ca', '可维护性', 'UQ-MT-001', 'a19bdb93aed011e9b7bbf8b156d274ca', null, null, '1.提供系统打印日志，便于问题分析；\n2.提供安装说明', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'S-0400-001', '001', null);
INSERT INTO `demand` VALUES ('5d4b0d2adc4c11e9b510f8b156d274ca', '委托检验', 'UQ-CER-001', 'b6f6ded8aed011e9b7bbf8b156d274ca', null, null, '项目内完成委托检验报告', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.0', 'S-0430-001', '001', null);
INSERT INTO `demand` VALUES ('5d4b0e73dc4c11e9b510f8b156d274ca', '认证需求', 'UQ-CER-003', 'b6f6ded8aed011e9b7bbf8b156d274ca', null, null, '软件著作权', '3', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0430-002', '003', null);
INSERT INTO `demand` VALUES ('5d4b0fcedc4c11e9b510f8b156d274ca', '认证需求', 'UQ-CER-004', 'b6f6ded8aed011e9b7bbf8b156d274ca', null, null, '完成CCC认证，节能认证', '2', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.2', null, '004', null);
INSERT INTO `demand` VALUES ('5d4b1117dc4c11e9b510f8b156d274ca', 'web国际化', 'UQ-QMS-001', 'bdb73e22aed011e9b7bbf8b156d274ca', null, null, '支持多语言切换，支持中文、英文语言切换。', '1', null, '针对海外出货的硬件由海外提供，获得后再立非正式项目进行兼容性测试，确保稳定性后发布软件给印度安装出货，英文版本印度研发同步测试', '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0440-001', '001', null);
INSERT INTO `demand` VALUES ('5d4b128ddc4c11e9b510f8b156d274ca', 'APP', 'UQ-QMS-002', 'bdb73e22aed011e9b7bbf8b156d274ca', null, null, '支持中文、英文语言切换。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0440-001', '002', null);
INSERT INTO `demand` VALUES ('5d4b13d3dc4c11e9b510f8b156d274ca', 'TV端', 'UQ-QMS-003', 'bdb73e22aed011e9b7bbf8b156d274ca', null, null, '支持中文、英文语言切换。', '1', null, null, '0b44246ddc4c11e9b510f8b156d274ca', '0', null, '1', 'V1.1', 'S-0440-001', '003', null);

-- ----------------------------
-- Table structure for demand_category
-- ----------------------------
DROP TABLE IF EXISTS `demand_category`;
CREATE TABLE `demand_category` (
  `demand_category_id` varchar(32) NOT NULL COMMENT '大类id',
  `demand_category_name` varchar(200) DEFAULT NULL COMMENT '大类名称',
  `demand_category_describe` varchar(300) DEFAULT NULL COMMENT '大类描述',
  `demand_parent_category_id` varchar(32) DEFAULT NULL COMMENT '大类父大类id',
  `demand_category_order` varchar(3) DEFAULT '0' COMMENT '需求的序号',
  `product_id` varchar(32) DEFAULT NULL COMMENT '项目id',
  PRIMARY KEY (`demand_category_id`),
  KEY `demand_category_product_id_fk` (`product_id`),
  CONSTRAINT `demand_category_product_id_fk` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of demand_category
-- ----------------------------
INSERT INTO `demand_category` VALUES ('25df8834aed011e9b7bbf8b156d274ca', '2.1、标准与规范需求', null, null, '', null);
INSERT INTO `demand_category` VALUES ('58d6ffc0aed011e9b7bbf8b156d274ca', '2.2、运行环境需求', null, null, '', null);
INSERT INTO `demand_category` VALUES ('5ce98434dc4c11e9b510f8b156d274ca', '1.1、视频预览', null, null, '001', '0b44246ddc4c11e9b510f8b156d274ca');
INSERT INTO `demand_category` VALUES ('5cebe6a4dc4c11e9b510f8b156d274ca', '1.2、智能分析源接入', null, null, '002', '0b44246ddc4c11e9b510f8b156d274ca');
INSERT INTO `demand_category` VALUES ('5cee3f81dc4c11e9b510f8b156d274ca', '1.3、目标库管理', null, null, '003', '0b44246ddc4c11e9b510f8b156d274ca');
INSERT INTO `demand_category` VALUES ('5cf08105dc4c11e9b510f8b156d274ca', '1.4、布控管理', null, null, '004', '0b44246ddc4c11e9b510f8b156d274ca');
INSERT INTO `demand_category` VALUES ('5cf2cbd6dc4c11e9b510f8b156d274ca', '1.5、报警记录管理', null, null, '005', '0b44246ddc4c11e9b510f8b156d274ca');
INSERT INTO `demand_category` VALUES ('5cf5067adc4c11e9b510f8b156d274ca', '1.6、抓拍记录', null, null, '006', '0b44246ddc4c11e9b510f8b156d274ca');
INSERT INTO `demand_category` VALUES ('5cf72407dc4c11e9b510f8b156d274ca', '1.7、人脸检索', null, null, '007', '0b44246ddc4c11e9b510f8b156d274ca');
INSERT INTO `demand_category` VALUES ('5d03b51adc4c11e9b510f8b156d274ca', '1.8、活动签到', null, null, '008', '0b44246ddc4c11e9b510f8b156d274ca');
INSERT INTO `demand_category` VALUES ('5d05c133dc4c11e9b510f8b156d274ca', '1.9、人脸考勤', null, null, '009', '0b44246ddc4c11e9b510f8b156d274ca');
INSERT INTO `demand_category` VALUES ('5d07e832dc4c11e9b510f8b156d274ca', '1.10、页面需求', null, null, '010', '0b44246ddc4c11e9b510f8b156d274ca');
INSERT INTO `demand_category` VALUES ('5d0a1570dc4c11e9b510f8b156d274ca', '1.11、统计分析', null, null, '011', '0b44246ddc4c11e9b510f8b156d274ca');
INSERT INTO `demand_category` VALUES ('5d0c3e4fdc4c11e9b510f8b156d274ca', '1.12、人脸门禁', null, null, '012', '0b44246ddc4c11e9b510f8b156d274ca');
INSERT INTO `demand_category` VALUES ('5d0e655adc4c11e9b510f8b156d274ca', '1.13、日志管理', null, null, '013', '0b44246ddc4c11e9b510f8b156d274ca');
INSERT INTO `demand_category` VALUES ('5d10a04fdc4c11e9b510f8b156d274ca', '1.14、手机APP移动客户端', null, null, '014', '0b44246ddc4c11e9b510f8b156d274ca');
INSERT INTO `demand_category` VALUES ('5d12cd2ddc4c11e9b510f8b156d274ca', '1.15、TVAPP客户端', null, null, '015', '0b44246ddc4c11e9b510f8b156d274ca');
INSERT INTO `demand_category` VALUES ('5d14f880dc4c11e9b510f8b156d274ca', '1.16、配置管理', null, null, '016', '0b44246ddc4c11e9b510f8b156d274ca');
INSERT INTO `demand_category` VALUES ('5d174388dc4c11e9b510f8b156d274ca', '1.17、系统对接', null, null, '017', '0b44246ddc4c11e9b510f8b156d274ca');
INSERT INTO `demand_category` VALUES ('5d197b09dc4c11e9b510f8b156d274ca', '1.19、加密授权', null, null, '019', '0b44246ddc4c11e9b510f8b156d274ca');
INSERT INTO `demand_category` VALUES ('5d1bb6e4dc4c11e9b510f8b156d274ca', '1.20、其他', null, null, '020', '0b44246ddc4c11e9b510f8b156d274ca');
INSERT INTO `demand_category` VALUES ('5d21c900dc4c11e9b510f8b156d274ca', '小盒子性能需求', null, '7e5a4076aed011e9b7bbf8b156d274ca', null, '0b44246ddc4c11e9b510f8b156d274ca');
INSERT INTO `demand_category` VALUES ('5d2492e9dc4c11e9b510f8b156d274ca', '机架式服务器性能需求', null, '7e5a4076aed011e9b7bbf8b156d274ca', null, '0b44246ddc4c11e9b510f8b156d274ca');
INSERT INTO `demand_category` VALUES ('5d27a302dc4c11e9b510f8b156d274ca', '算法性能要求', null, '7e5a4076aed011e9b7bbf8b156d274ca', null, '0b44246ddc4c11e9b510f8b156d274ca');
INSERT INTO `demand_category` VALUES ('60f886f3aed011e9b7bbf8b156d274ca', '2.3、接口需求', null, null, '', null);
INSERT INTO `demand_category` VALUES ('6b463282aed011e9b7bbf8b156d274ca', '2.4、用户界面需求', null, null, '', null);
INSERT INTO `demand_category` VALUES ('73db16b2aed011e9b7bbf8b156d274ca', '2.5、安全需求', null, null, '', null);
INSERT INTO `demand_category` VALUES ('7e5a4076aed011e9b7bbf8b156d274ca', '2.6、性能需求', null, null, '', null);
INSERT INTO `demand_category` VALUES ('87118a47aed011e9b7bbf8b156d274ca', '2.7、兼容性', null, null, '', null);
INSERT INTO `demand_category` VALUES ('91dbfdf7aed011e9b7bbf8b156d274ca', '2.8、可测试性', null, null, '', null);
INSERT INTO `demand_category` VALUES ('9a586a89aed011e9b7bbf8b156d274ca', '2.9、可生产性', null, null, '', null);
INSERT INTO `demand_category` VALUES ('a19bdb93aed011e9b7bbf8b156d274ca', '2.10、可维护性', null, null, '', null);
INSERT INTO `demand_category` VALUES ('a8d74166aed011e9b7bbf8b156d274ca', '2.11、可扩展性', null, null, '', null);
INSERT INTO `demand_category` VALUES ('b008efa6aed011e9b7bbf8b156d274ca', '2.12、可移植性', null, null, '', null);
INSERT INTO `demand_category` VALUES ('b6f6ded8aed011e9b7bbf8b156d274ca', '2.13、认证需求', null, null, '', null);
INSERT INTO `demand_category` VALUES ('bdb73e22aed011e9b7bbf8b156d274ca', '2.14、国际化需求', null, null, '', null);
INSERT INTO `demand_category` VALUES ('c51f446baed011e9b7bbf8b156d274ca', '2.15、结构需求', null, null, '', null);
INSERT INTO `demand_category` VALUES ('ccaebe7daed011e9b7bbf8b156d274ca', '2.16、法律法规需求', null, null, '', null);
INSERT INTO `demand_category` VALUES ('d37922bfaed011e9b7bbf8b156d274ca', '2.17、其他需求', null, null, '', null);

-- ----------------------------
-- Table structure for demand_norms_relation
-- ----------------------------
DROP TABLE IF EXISTS `demand_norms_relation`;
CREATE TABLE `demand_norms_relation` (
  `demand_id` varchar(32) NOT NULL COMMENT '需求id',
  `norms_id` varchar(32) NOT NULL COMMENT '规格id',
  PRIMARY KEY (`demand_id`,`norms_id`),
  KEY `demand_norms_relation_fk_norms_id` (`norms_id`),
  CONSTRAINT `demand_norms_relation_fk_demand_id` FOREIGN KEY (`demand_id`) REFERENCES `demand` (`demand_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `demand_norms_relation_fk_norms_id` FOREIGN KEY (`norms_id`) REFERENCES `norms` (`norms_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of demand_norms_relation
-- ----------------------------
INSERT INTO `demand_norms_relation` VALUES ('5d49e51bdc4c11e9b510f8b156d274ca', '1e049418dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a4d56dc4c11e9b510f8b156d274ca', '1e049418dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a5155dc4c11e9b510f8b156d274ca', '1e049418dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a8c60dc4c11e9b510f8b156d274ca', '1e049418dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4952ecdc4c11e9b510f8b156d274ca', '1e428b0bdde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a75efdc4c11e9b510f8b156d274ca', '1e464916dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a748edc4c11e9b510f8b156d274ca', '1e4801c2dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a75efdc4c11e9b510f8b156d274ca', '1e4801c2dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a776edc4c11e9b510f8b156d274ca', '1e4801c2dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a7b4fdc4c11e9b510f8b156d274ca', '1e4801c2dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a7dd8dc4c11e9b510f8b156d274ca', '1e4801c2dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a8677dc4c11e9b510f8b156d274ca', '1e4801c2dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a78c6dc4c11e9b510f8b156d274ca', '1e49835fdde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a84e3dc4c11e9b510f8b156d274ca', '1e49835fdde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a7a09dc4c11e9b510f8b156d274ca', '1e4af53bdde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a82b4dc4c11e9b510f8b156d274ca', '1e4bf11adde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a8af5dc4c11e9b510f8b156d274ca', '1e4cf6e4dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a8db2dc4c11e9b510f8b156d274ca', '1e5ea8c4dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d499fb9dc4c11e9b510f8b156d274ca', '1e5eb7a6dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d496412dc4c11e9b510f8b156d274ca', '1e61326cdde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d496e21dc4c11e9b510f8b156d274ca', '1e61326cdde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49713bdc4c11e9b510f8b156d274ca', '1e614f50dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a46b5dc4c11e9b510f8b156d274ca', '1e614f50dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49713bdc4c11e9b510f8b156d274ca', '1e6153dadde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a46b5dc4c11e9b510f8b156d274ca', '1e6153dadde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49713bdc4c11e9b510f8b156d274ca', '1e615693dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a46b5dc4c11e9b510f8b156d274ca', '1e615693dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49713bdc4c11e9b510f8b156d274ca', '1e6169f9dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a46b5dc4c11e9b510f8b156d274ca', '1e6169f9dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49713bdc4c11e9b510f8b156d274ca', '1e617100dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a46b5dc4c11e9b510f8b156d274ca', '1e617100dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49d451dc4c11e9b510f8b156d274ca', '1e6184b7dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49d71fdc4c11e9b510f8b156d274ca', '1e6184b7dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49d86edc4c11e9b510f8b156d274ca', '1e6184b7dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a4517dc4c11e9b510f8b156d274ca', '1e6184b7dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49d5a6dc4c11e9b510f8b156d274ca', '1e6187bcdde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49d71fdc4c11e9b510f8b156d274ca', '1e6187bcdde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d493b12dc4c11e9b510f8b156d274ca', '1e62e115dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d493cbedc4c11e9b510f8b156d274ca', '1e62e115dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d493e62dc4c11e9b510f8b156d274ca', '1e62e115dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d494018dc4c11e9b510f8b156d274ca', '1e62e115dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49418bdc4c11e9b510f8b156d274ca', '1e62e115dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4947c2dc4c11e9b510f8b156d274ca', '1e62e115dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d496573dc4c11e9b510f8b156d274ca', '1e62e115dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4966d7dc4c11e9b510f8b156d274ca', '1e62e115dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d496896dc4c11e9b510f8b156d274ca', '1e62e115dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d493910dc4c11e9b510f8b156d274ca', '1e63a2aadde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d494926dc4c11e9b510f8b156d274ca', '1e63a2aadde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4962a1dc4c11e9b510f8b156d274ca', '1e63a2aadde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4976eddc4c11e9b510f8b156d274ca', '1e63d0cedde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d497863dc4c11e9b510f8b156d274ca', '1e63d0cedde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4979d3dc4c11e9b510f8b156d274ca', '1e63d0cedde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d497b34dc4c11e9b510f8b156d274ca', '1e63d0cedde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d497ca2dc4c11e9b510f8b156d274ca', '1e63d0cedde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d497e06dc4c11e9b510f8b156d274ca', '1e63d0cedde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d497f6ddc4c11e9b510f8b156d274ca', '1e63d0cedde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4980d4dc4c11e9b510f8b156d274ca', '1e63d0cedde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d498232dc4c11e9b510f8b156d274ca', '1e63d0cedde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d498394dc4c11e9b510f8b156d274ca', '1e63d0cedde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a1260dc4c11e9b510f8b156d274ca', '1e63d0cedde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d495fb5dc4c11e9b510f8b156d274ca', '1e658a35dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4966d7dc4c11e9b510f8b156d274ca', '1e658a35dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d496896dc4c11e9b510f8b156d274ca', '1e658a35dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d496f9adc4c11e9b510f8b156d274ca', '1e658a35dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d496bf8dc4c11e9b510f8b156d274ca', '1e659596dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d495e60dc4c11e9b510f8b156d274ca', '1e6598d1dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d496a82dc4c11e9b510f8b156d274ca', '1e66ff04dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49614fdc4c11e9b510f8b156d274ca', '1e6898ecdde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d499e43dc4c11e9b510f8b156d274ca', '1e69a7d3dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49b3f2dc4c11e9b510f8b156d274ca', '1e69bf26dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49ceabdc4c11e9b510f8b156d274ca', '1e69e1e0dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49d173dc4c11e9b510f8b156d274ca', '1e69e1e0dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49ddeddc4c11e9b510f8b156d274ca', '1e69e601dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49d2dddc4c11e9b510f8b156d274ca', '1e69ef9ddde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49e0a3dc4c11e9b510f8b156d274ca', '1e69ef9ddde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a4eb4dc4c11e9b510f8b156d274ca', '1e69ef9ddde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49d2dddc4c11e9b510f8b156d274ca', '1e69f299dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49d9d2dc4c11e9b510f8b156d274ca', '1e69f714dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49dc9bdc4c11e9b510f8b156d274ca', '1e6a0a7cdde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49db37dc4c11e9b510f8b156d274ca', '1e6a12d3dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49e98ddc4c11e9b510f8b156d274ca', '1e6a27c4dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49eae5dc4c11e9b510f8b156d274ca', '1e6a27c4dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49ec35dc4c11e9b510f8b156d274ca', '1e6a27c4dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49ed84dc4c11e9b510f8b156d274ca', '1e6a27c4dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49bfa2dc4c11e9b510f8b156d274ca', '1e6a4011dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49c657dc4c11e9b510f8b156d274ca', '1e6a42aadde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49caabdc4c11e9b510f8b156d274ca', '1e6a50e8dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49c0eedc4c11e9b510f8b156d274ca', '1e6a55bbdde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49c24cdc4c11e9b510f8b156d274ca', '1e6a55bbdde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49c3a7dc4c11e9b510f8b156d274ca', '1e6a55bbdde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49cbfadc4c11e9b510f8b156d274ca', '1e6a55bbdde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d49cd50dc4c11e9b510f8b156d274ca', '1e6a55bbdde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a06d2dc4c11e9b510f8b156d274ca', '1e6b654edde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a13fbdc4c11e9b510f8b156d274ca', '1e6b654edde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a1550dc4c11e9b510f8b156d274ca', '1e6b654edde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a06d2dc4c11e9b510f8b156d274ca', '1e6cc4f3dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a10c2dc4c11e9b510f8b156d274ca', '1e6cc4f3dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a06d2dc4c11e9b510f8b156d274ca', '1e6cd060dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a0857dc4c11e9b510f8b156d274ca', '1e6cd060dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a0a2bdc4c11e9b510f8b156d274ca', '1e6cd060dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a0cfddc4c11e9b510f8b156d274ca', '1e6cd060dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a1260dc4c11e9b510f8b156d274ca', '1e6cd060dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a1931dc4c11e9b510f8b156d274ca', '1e6cd50edde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a290ddc4c11e9b510f8b156d274ca', '1e6ce19adde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a27bbdc4c11e9b510f8b156d274ca', '1e6ce651dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a2a62dc4c11e9b510f8b156d274ca', '1e6cec0ddde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a1bc0dc4c11e9b510f8b156d274ca', '1e6cf649dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a1d12dc4c11e9b510f8b156d274ca', '1e6cf649dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a1e70dc4c11e9b510f8b156d274ca', '1e6cf649dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a251ddc4c11e9b510f8b156d274ca', '1e839d60dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a229ddc4c11e9b510f8b156d274ca', '1e859a9edde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a201adc4c11e9b510f8b156d274ca', '1e85ab7ddde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a2163dc4c11e9b510f8b156d274ca', '1e85bc8ddde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a267bdc4c11e9b510f8b156d274ca', '1e85c2b5dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a3243dc4c11e9b510f8b156d274ca', '1e85c572dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a34f9dc4c11e9b510f8b156d274ca', '1e85d8e9dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a364bdc4c11e9b510f8b156d274ca', '1e85db6cdde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a4ffadc4c11e9b510f8b156d274ca', '1e85e29bdde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a709ddc4c11e9b510f8b156d274ca', '1e860466dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a71e7dc4c11e9b510f8b156d274ca', '1e860466dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4aafe7dc4c11e9b510f8b156d274ca', '1e88afa3dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4ab1f1dc4c11e9b510f8b156d274ca', '1e89daf3dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4ab367dc4c11e9b510f8b156d274ca', '1e89ddd3dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4ab4cfdc4c11e9b510f8b156d274ca', '1e89e038dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4ab61edc4c11e9b510f8b156d274ca', '1e89e1f1dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4ab76ddc4c11e9b510f8b156d274ca', '1e89e3a3dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4ab8bcdc4c11e9b510f8b156d274ca', '1e89e547dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4abc4cdc4c11e9b510f8b156d274ca', '1e89e6e5dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4abdc5dc4c11e9b510f8b156d274ca', '1e89e891dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4abf2cdc4c11e9b510f8b156d274ca', '1e89ea2fdde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4ac093dc4c11e9b510f8b156d274ca', '1e89ebbadde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4ac1f4dc4c11e9b510f8b156d274ca', '1e89ed58dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4ac350dc4c11e9b510f8b156d274ca', '1e89eefedde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4ac4b7dc4c11e9b510f8b156d274ca', '1e89f106dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4ac609dc4c11e9b510f8b156d274ca', '1e89f2a3dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4ac770dc4c11e9b510f8b156d274ca', '1e89f453dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4ac8c5dc4c11e9b510f8b156d274ca', '1e89f5eddde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4acb91dc4c11e9b510f8b156d274ca', '1e89f919dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4ad003dc4c11e9b510f8b156d274ca', '1e89fe3edde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4ad1afdc4c11e9b510f8b156d274ca', '1e89ffe7dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4ad317dc4c11e9b510f8b156d274ca', '1e8a0191dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4ad469dc4c11e9b510f8b156d274ca', '1e8a0380dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4ad5c1dc4c11e9b510f8b156d274ca', '1e8a051adde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4ad7c5dc4c11e9b510f8b156d274ca', '1e8a06fadde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4ad917dc4c11e9b510f8b156d274ca', '1e8a0898dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4adac4dc4c11e9b510f8b156d274ca', '1e8a0a29dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4addb6dc4c11e9b510f8b156d274ca', '1e8a10a6dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4adf36dc4c11e9b510f8b156d274ca', '1e8a1280dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4ae08edc4c11e9b510f8b156d274ca', '1e8a1500dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4ae1d7dc4c11e9b510f8b156d274ca', '1e8a177adde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4ae335dc4c11e9b510f8b156d274ca', '1e8a191adde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4ae499dc4c11e9b510f8b156d274ca', '1e8a1ab2dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4ae5f5dc4c11e9b510f8b156d274ca', '1e8a1c9edde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4aea7cdc4c11e9b510f8b156d274ca', '1e8a1e53dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4aec92dc4c11e9b510f8b156d274ca', '1e8a1ff1dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4aef51dc4c11e9b510f8b156d274ca', '1e8a233bdde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4af208dc4c11e9b510f8b156d274ca', '1e8a270adde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4af390dc4c11e9b510f8b156d274ca', '1e8a28a5dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4af525dc4c11e9b510f8b156d274ca', '1e8a2a45dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4af683dc4c11e9b510f8b156d274ca', '1e8a2be3dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4af7ccdc4c11e9b510f8b156d274ca', '1e8a2e5ddde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4af92adc4c11e9b510f8b156d274ca', '1e8a3013dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4afa82dc4c11e9b510f8b156d274ca', '1e8a3220dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4afbe0dc4c11e9b510f8b156d274ca', '1e8a33bddde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4afd3bdc4c11e9b510f8b156d274ca', '1e8a3613dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4afe9adc4c11e9b510f8b156d274ca', '1e8a37c0dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4afffbdc4c11e9b510f8b156d274ca', '1e8a39bedde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4b039adc4c11e9b510f8b156d274ca', '1e8a3b5edde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4b0504dc4c11e9b510f8b156d274ca', '1e8a3cf9dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4b07ccdc4c11e9b510f8b156d274ca', '1e8a4092dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a2babdc4c11e9b510f8b156d274ca', '1e8a4254dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4a2cebdc4c11e9b510f8b156d274ca', '1e8a442adde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4b092ddc4c11e9b510f8b156d274ca', '1e8a45b6dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4b0a83dc4c11e9b510f8b156d274ca', '1e8a45b6dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4b0bd2dc4c11e9b510f8b156d274ca', '1e8a4756dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4b0d2adc4c11e9b510f8b156d274ca', '1e8a4df4dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4b0e73dc4c11e9b510f8b156d274ca', '1e8a4f8edde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4b1117dc4c11e9b510f8b156d274ca', '1e8a5117dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4b128ddc4c11e9b510f8b156d274ca', '1e8a5117dde911e98c39f8b156d274ca');
INSERT INTO `demand_norms_relation` VALUES ('5d4b13d3dc4c11e9b510f8b156d274ca', '1e8a5117dde911e98c39f8b156d274ca');

-- ----------------------------
-- Table structure for demand_overall_design_rule_relation
-- ----------------------------
DROP TABLE IF EXISTS `demand_overall_design_rule_relation`;
CREATE TABLE `demand_overall_design_rule_relation` (
  `demand_id` varchar(32) DEFAULT NULL COMMENT '需求id',
  `overall_design_rule_id` varchar(32) DEFAULT NULL COMMENT '总体设计规则id',
  KEY `demand_overall_design_rule_relation_fk_demand_id` (`demand_id`),
  KEY `demand_overall_design_rule_relation_fk_overall_design_rule_id` (`overall_design_rule_id`),
  CONSTRAINT `demand_overall_design_rule_relation_fk_demand_id` FOREIGN KEY (`demand_id`) REFERENCES `demand` (`demand_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `demand_overall_design_rule_relation_fk_overall_design_rule_id` FOREIGN KEY (`overall_design_rule_id`) REFERENCES `overall_design_rule` (`overall_design_rule_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of demand_overall_design_rule_relation
-- ----------------------------

-- ----------------------------
-- Table structure for log
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
  `log_id` varchar(32) NOT NULL COMMENT '日志id',
  `log_name` varchar(255) DEFAULT NULL COMMENT '日志名字',
  `log_content` varchar(255) DEFAULT NULL COMMENT '日志内容',
  `log_operator` varchar(255) DEFAULT NULL COMMENT '日志操作者',
  `log_operation_time` datetime DEFAULT NULL COMMENT '日志操作时间',
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of log
-- ----------------------------
INSERT INTO `log` VALUES ('0085eb5ddc4511e9b510f8b156d274ca', '增加产品', null, 'admin', '2019-09-21 15:54:14');
INSERT INTO `log` VALUES ('00b5c6fbd46311e9bfdef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-11 15:08:50');
INSERT INTO `log` VALUES ('00ca2c82d52111e994e5f8b156d274ca', '更新项目', null, 'admin', '2019-09-12 13:48:54');
INSERT INTO `log` VALUES ('00ce7335dc4211e9b510f8b156d274ca', '保存需求', null, 'admin', '2019-09-21 15:32:46');
INSERT INTO `log` VALUES ('013cccd7d85511e9847ef8b156d274ca', '更新项目', null, 'admin', '2019-09-16 15:38:42');
INSERT INTO `log` VALUES ('019bf5bddc4c11e9b510f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-21 16:44:22');
INSERT INTO `log` VALUES ('01c9a485dc4211e9b510f8b156d274ca', '保存需求', null, 'admin', '2019-09-21 15:32:47');
INSERT INTO `log` VALUES ('01d5fd1ad53511e994e5f8b156d274ca', '导入excel', null, 'admin', '2019-09-12 16:12:04');
INSERT INTO `log` VALUES ('01d738d7d45e11e9bfdef8b156d274ca', '导入excel', null, 'admin', '2019-09-11 14:33:03');
INSERT INTO `log` VALUES ('023b1baedc4811e9b510f8b156d274ca', '增加产品', null, 'admin', '2019-09-21 16:15:45');
INSERT INTO `log` VALUES ('0247728ed50711e994e5f8b156d274ca', '上传文档', null, 'admin', '2019-09-12 10:42:08');
INSERT INTO `log` VALUES ('02574754d53711e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:26:26');
INSERT INTO `log` VALUES ('0275f3b4d91711e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 14:47:27');
INSERT INTO `log` VALUES ('02d9caadd53b11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:55:05');
INSERT INTO `log` VALUES ('02f06b02d46b11e9bfdef8b156d274ca', '上传文档', null, 'admin', '2019-09-11 16:05:27');
INSERT INTO `log` VALUES ('036c9a08d91611e9b556f8b156d274ca', '删除需求', null, 'admin', '2019-09-17 14:40:19');
INSERT INTO `log` VALUES ('03f0b9acd91611e9b556f8b156d274ca', '删除需求', null, 'admin', '2019-09-17 14:40:20');
INSERT INTO `log` VALUES ('03f22767d9d411e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 13:20:32');
INSERT INTO `log` VALUES ('03fb413bdb3c11e98ce70cc47a47def0', '增加项目', null, 'admin', '2019-09-20 08:17:32');
INSERT INTO `log` VALUES ('044985e0d85511e9847ef8b156d274ca', '更新项目', null, 'admin', '2019-09-16 15:38:47');
INSERT INTO `log` VALUES ('04912f54dc4711e9b510f8b156d274ca', '上传文档', null, 'admin', '2019-09-21 16:07:57');
INSERT INTO `log` VALUES ('05486e13d90f11e9b556f8b156d274ca', '删除需求', null, 'admin', '2019-09-17 13:50:15');
INSERT INTO `log` VALUES ('055cc310dab611e98ce70cc47a47def0', '删除项目', null, 'admin', '2019-09-19 16:18:22');
INSERT INTO `log` VALUES ('05c62781d85c11e9847ef8b156d274ca', '删除项目', null, 'admin', '2019-09-16 16:28:56');
INSERT INTO `log` VALUES ('0667b431daa311e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-19 14:02:23');
INSERT INTO `log` VALUES ('06e4519bd90f11e9b556f8b156d274ca', '删除需求', null, 'admin', '2019-09-17 13:50:18');
INSERT INTO `log` VALUES ('0737fd37d53b11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:55:12');
INSERT INTO `log` VALUES ('07a21764d85511e9847ef8b156d274ca', '更新项目', null, 'admin', '2019-09-16 15:38:53');
INSERT INTO `log` VALUES ('07dd8445d90f11e9b556f8b156d274ca', '删除需求', null, 'admin', '2019-09-17 13:50:20');
INSERT INTO `log` VALUES ('0865484ed52811e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 14:39:13');
INSERT INTO `log` VALUES ('08a4ad59d9a711e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 07:58:32');
INSERT INTO `log` VALUES ('09119e0ed50211e994e5f8b156d274ca', '上传文档', null, 'admin', '2019-09-12 10:05:55');
INSERT INTO `log` VALUES ('095ca7c3dc4211e9b510f8b156d274ca', '保存需求', null, 'admin', '2019-09-21 15:33:00');
INSERT INTO `log` VALUES ('098a95e9db5311e98ce70cc47a47def0', '保存需求', null, 'admin', '2019-09-20 11:02:20');
INSERT INTO `log` VALUES ('09a74734daa011e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-19 13:41:00');
INSERT INTO `log` VALUES ('09bb24bcd8fc11e9b556f8b156d274ca', '删除需求', null, 'admin', '2019-09-17 11:34:22');
INSERT INTO `log` VALUES ('09bd097ddaa511e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-19 14:16:47');
INSERT INTO `log` VALUES ('0a4cca29dc4211e9b510f8b156d274ca', '保存需求', null, 'admin', '2019-09-21 15:33:02');
INSERT INTO `log` VALUES ('0a839c62d53b11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:55:17');
INSERT INTO `log` VALUES ('0a8bb5e6d85c11e9847ef8b156d274ca', '删除项目', null, 'admin', '2019-09-16 16:29:04');
INSERT INTO `log` VALUES ('0ab80a6ed85c11e9847ef8b156d274ca', '删除项目', null, 'admin', '2019-09-16 16:29:04');
INSERT INTO `log` VALUES ('0ab95c29d86011e9847ef8b156d274ca', '增加产品', null, 'admin', '2019-09-16 16:57:42');
INSERT INTO `log` VALUES ('0acc6fffd85c11e9847ef8b156d274ca', '删除项目', null, 'admin', '2019-09-16 16:29:05');
INSERT INTO `log` VALUES ('0aeb7a1edc4211e9b510f8b156d274ca', '保存需求', null, 'admin', '2019-09-21 15:33:03');
INSERT INTO `log` VALUES ('0aef4529d85c11e9847ef8b156d274ca', '删除项目', null, 'admin', '2019-09-16 16:29:05');
INSERT INTO `log` VALUES ('0b3aa714d85511e9847ef8b156d274ca', '更新项目', null, 'admin', '2019-09-16 15:38:59');
INSERT INTO `log` VALUES ('0b4ce0c3d92b11e9b4ccf8b156d274ca', '增加产品', null, 'admin', '2019-09-17 17:10:51');
INSERT INTO `log` VALUES ('0b4ce8d7dc4c11e9b510f8b156d274ca', '增加产品', null, 'admin', '2019-09-21 16:44:38');
INSERT INTO `log` VALUES ('0b800c0edc4211e9b510f8b156d274ca', '保存需求', null, 'admin', '2019-09-21 15:33:04');
INSERT INTO `log` VALUES ('0ba3f2ded53a11e994e5f8b156d274ca', '添加一条分类', null, 'admin', '2019-09-12 16:48:10');
INSERT INTO `log` VALUES ('0ba4f4c2dc4211e9b510f8b156d274ca', '保存需求', null, 'admin', '2019-09-21 15:33:04');
INSERT INTO `log` VALUES ('0ba58573d9b811e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 10:00:19');
INSERT INTO `log` VALUES ('0bc4e4b5dc4211e9b510f8b156d274ca', '保存需求', null, 'admin', '2019-09-21 15:33:04');
INSERT INTO `log` VALUES ('0bc91c32d85c11e9847ef8b156d274ca', '删除项目', null, 'admin', '2019-09-16 16:29:06');
INSERT INTO `log` VALUES ('0be1b37fd85c11e9847ef8b156d274ca', '删除项目', null, 'admin', '2019-09-16 16:29:06');
INSERT INTO `log` VALUES ('0be44d9ddc4211e9b510f8b156d274ca', '保存需求', null, 'admin', '2019-09-21 15:33:04');
INSERT INTO `log` VALUES ('0c494270d9b811e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 10:00:20');
INSERT INTO `log` VALUES ('0c51ebb3d9d411e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 13:20:46');
INSERT INTO `log` VALUES ('0c56852dd85c11e9847ef8b156d274ca', '删除项目', null, 'admin', '2019-09-16 16:29:07');
INSERT INTO `log` VALUES ('0c6eb050d9a811e98ce70cc47a47def0', '增加项目', null, 'admin', '2019-09-18 08:05:48');
INSERT INTO `log` VALUES ('0c933818db5011e98ce70cc47a47def0', '添加一条分类', null, 'admin', '2019-09-20 10:40:57');
INSERT INTO `log` VALUES ('0cd55173d8fc11e9b556f8b156d274ca', '删除需求', null, 'admin', '2019-09-17 11:34:27');
INSERT INTO `log` VALUES ('0ce928f8d55011e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 19:25:41');
INSERT INTO `log` VALUES ('0d9b0b39d92e11e9b4ccf8b156d274ca', '导入excel', null, 'admin', '2019-09-17 17:32:23');
INSERT INTO `log` VALUES ('0dcd52d5d85511e9847ef8b156d274ca', '更新项目', null, 'admin', '2019-09-16 15:39:03');
INSERT INTO `log` VALUES ('0de54322d9a711e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 07:58:41');
INSERT INTO `log` VALUES ('0e2ae336d92611e9b4ccf8b156d274ca', '增加产品', null, 'admin', '2019-09-17 16:35:08');
INSERT INTO `log` VALUES ('0ec1c979db5111e98ce70cc47a47def0', '保存需求', null, '123456789', '2019-09-20 10:48:10');
INSERT INTO `log` VALUES ('0efe60a7d8fc11e9b556f8b156d274ca', '删除需求', null, 'admin', '2019-09-17 11:34:31');
INSERT INTO `log` VALUES ('0f89f465d9a711e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 07:58:44');
INSERT INTO `log` VALUES ('0fe7c9e2d8f811e9b556f8b156d274ca', '保存需求', null, 'admin', '2019-09-17 11:05:54');
INSERT INTO `log` VALUES ('100d0347d8fa11e9b556f8b156d274ca', '导入excel', null, 'admin', '2019-09-17 11:20:09');
INSERT INTO `log` VALUES ('1053ef87d84c11e9847ef8b156d274ca', '添加一条分类', null, 'admin', '2019-09-16 14:34:42');
INSERT INTO `log` VALUES ('11534d3bdb5011e98ce70cc47a47def0', '添加一条分类', null, 'admin', '2019-09-20 10:41:05');
INSERT INTO `log` VALUES ('123bc50bd53b11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:55:30');
INSERT INTO `log` VALUES ('128c85cbd53a11e994e5f8b156d274ca', '添加一条分类', null, 'admin', '2019-09-12 16:48:21');
INSERT INTO `log` VALUES ('1296479ed52511e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 14:18:02');
INSERT INTO `log` VALUES ('12cf0dbadb6311e98ce70cc47a47def0', '更新需求', null, 'admin', '2019-09-20 12:57:08');
INSERT INTO `log` VALUES ('12f8c56edc4711e9b510f8b156d274ca', '导入excel', null, 'admin', '2019-09-21 16:09:02');
INSERT INTO `log` VALUES ('134f7d12db7d11e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-20 16:02:37');
INSERT INTO `log` VALUES ('135db028d52211e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 13:56:34');
INSERT INTO `log` VALUES ('136d9223dc4511e9b510f8b156d274ca', '上传文档', null, 'admin', '2019-09-21 15:54:43');
INSERT INTO `log` VALUES ('13dec605d4ff11e994e5f8b156d274ca', '更新产品', null, 'admin', '2019-09-12 09:46:03');
INSERT INTO `log` VALUES ('1421e079d90f11e9b556f8b156d274ca', '保存需求', null, 'admin', '2019-09-17 13:50:40');
INSERT INTO `log` VALUES ('1431b214d85511e9847ef8b156d274ca', '更新产品', null, 'admin', '2019-09-16 15:39:14');
INSERT INTO `log` VALUES ('152fa05ed53a11e994e5f8b156d274ca', '添加一条分类', null, 'admin', '2019-09-12 16:48:26');
INSERT INTO `log` VALUES ('161bc615db3d11e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-20 08:25:11');
INSERT INTO `log` VALUES ('162ca268dc4a11e9b510f8b156d274ca', '上传文档', null, 'admin', '2019-09-21 16:29:31');
INSERT INTO `log` VALUES ('1686aca1d55111e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 19:30:42');
INSERT INTO `log` VALUES ('16d60595d85511e9847ef8b156d274ca', '更新产品', null, 'admin', '2019-09-16 15:39:18');
INSERT INTO `log` VALUES ('172bc207db6311e98ce70cc47a47def0', '更新需求', null, 'admin', '2019-09-20 12:57:15');
INSERT INTO `log` VALUES ('176f56a9d84c11e9847ef8b156d274ca', '保存需求', null, 'admin', '2019-09-16 14:34:54');
INSERT INTO `log` VALUES ('178d3351d53e11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 17:15:28');
INSERT INTO `log` VALUES ('17d464e0daa411e98ce70cc47a47def0', '增加项目', null, 'admin', '2019-09-19 14:10:01');
INSERT INTO `log` VALUES ('187a8412d91611e9b556f8b156d274ca', '保存需求', null, 'admin', '2019-09-17 14:40:54');
INSERT INTO `log` VALUES ('18964b48d8fc11e9b556f8b156d274ca', '保存需求', null, 'admin', '2019-09-17 11:34:47');
INSERT INTO `log` VALUES ('189d9bd1daa111e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-19 13:48:34');
INSERT INTO `log` VALUES ('19619ea5db6311e98ce70cc47a47def0', '更新需求', null, 'admin', '2019-09-20 12:57:19');
INSERT INTO `log` VALUES ('196d4742dc3f11e9b510f8b156d274ca', '保存需求', null, 'admin', '2019-09-21 15:10:52');
INSERT INTO `log` VALUES ('196ff6fcd92611e9b4ccf8b156d274ca', '增加产品', null, 'admin', '2019-09-17 16:35:27');
INSERT INTO `log` VALUES ('198736e9d85511e9847ef8b156d274ca', '更新产品', null, 'admin', '2019-09-16 15:39:23');
INSERT INTO `log` VALUES ('19bfb982d92b11e9b4ccf8b156d274ca', '保存需求', null, 'admin', '2019-09-17 17:11:15');
INSERT INTO `log` VALUES ('19f2c049d91911e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 15:02:25');
INSERT INTO `log` VALUES ('19f731f9d9ac11e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 08:34:49');
INSERT INTO `log` VALUES ('1a23bde4d85c11e9847ef8b156d274ca', '增加项目', null, 'admin', '2019-09-16 16:29:30');
INSERT INTO `log` VALUES ('1af29c0ad46611e9bfdef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-11 15:31:02');
INSERT INTO `log` VALUES ('1b4af6bedb5011e98ce70cc47a47def0', '添加一条分类', null, 'admin', '2019-09-20 10:41:21');
INSERT INTO `log` VALUES ('1bb5e59ad53311e994e5f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-12 15:58:30');
INSERT INTO `log` VALUES ('1bc5c16fd53311e994e5f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-12 15:58:30');
INSERT INTO `log` VALUES ('1bed3bd1d85511e9847ef8b156d274ca', '更新产品', null, 'admin', '2019-09-16 15:39:27');
INSERT INTO `log` VALUES ('1c659bc5dda011e98c39f8b156d274ca', '导入excel', null, 'admin', '2019-09-23 09:18:55');
INSERT INTO `log` VALUES ('1c88316edb6f11e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-20 14:23:18');
INSERT INTO `log` VALUES ('1d2a79a6d50d11e994e5f8b156d274ca', '更新产品', null, 'admin', '2019-09-12 11:26:31');
INSERT INTO `log` VALUES ('1d92ab86d53311e994e5f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-12 15:58:33');
INSERT INTO `log` VALUES ('1db69f7cd46111e9bfdef8b156d274ca', '上传文档', null, 'admin', '2019-09-11 14:55:06');
INSERT INTO `log` VALUES ('1e6cc2bbd53311e994e5f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-12 15:58:35');
INSERT INTO `log` VALUES ('1ea0e9e6d85511e9847ef8b156d274ca', '更新产品', null, 'admin', '2019-09-16 15:39:31');
INSERT INTO `log` VALUES ('1ea1e874db7111e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-20 14:37:40');
INSERT INTO `log` VALUES ('1ed1b7f4d91011e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 13:58:08');
INSERT INTO `log` VALUES ('1ed2b3a3dde911e98c39f8b156d274ca', '上传文档', null, '123456789', '2019-09-23 17:59:45');
INSERT INTO `log` VALUES ('1ef750fdd53311e994e5f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-12 15:58:36');
INSERT INTO `log` VALUES ('1f1309c5d50211e994e5f8b156d274ca', '上传文档', null, 'admin', '2019-09-12 10:07:07');
INSERT INTO `log` VALUES ('1f208ad8d86011e9847ef8b156d274ca', '删除项目', null, 'admin', '2019-09-16 16:58:17');
INSERT INTO `log` VALUES ('1f5260f6d92c11e9b4ccf8b156d274ca', '添加一条分类', null, 'admin', '2019-09-17 17:18:34');
INSERT INTO `log` VALUES ('1f729c79d53311e994e5f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-12 15:58:36');
INSERT INTO `log` VALUES ('1f8b5435d86011e9847ef8b156d274ca', '删除项目', null, 'admin', '2019-09-16 16:58:17');
INSERT INTO `log` VALUES ('1fb16211d83211e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 11:29:00');
INSERT INTO `log` VALUES ('1fd86736d53311e994e5f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-12 15:58:37');
INSERT INTO `log` VALUES ('1fe0a291d4ff11e994e5f8b156d274ca', '更新产品', null, 'admin', '2019-09-12 09:46:23');
INSERT INTO `log` VALUES ('1fed407ad84c11e9847ef8b156d274ca', '保存需求', null, 'admin', '2019-09-16 14:35:08');
INSERT INTO `log` VALUES ('1fee5fe7d83211e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 11:29:01');
INSERT INTO `log` VALUES ('2002623ddb5211e98ce70cc47a47def0', '保存需求', null, 'admin', '2019-09-20 10:55:48');
INSERT INTO `log` VALUES ('2035a151d8f011e9b556f8b156d274ca', '增加产品', null, 'admin', '2019-09-17 10:09:06');
INSERT INTO `log` VALUES ('20433a6bd91d11e9b556f8b156d274ca', '更新产品', null, 'admin', '2019-09-17 15:31:14');
INSERT INTO `log` VALUES ('20433a8dd83211e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 11:29:01');
INSERT INTO `log` VALUES ('207159f2d83211e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 11:29:02');
INSERT INTO `log` VALUES ('20804e21d85c11e9847ef8b156d274ca', '更新项目', null, 'admin', '2019-09-16 16:29:41');
INSERT INTO `log` VALUES ('20c9a6d8d53d11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 17:10:14');
INSERT INTO `log` VALUES ('20cb2967d53d11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 17:08:36');
INSERT INTO `log` VALUES ('211f2f5fd83211e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 11:29:03');
INSERT INTO `log` VALUES ('214e3b36d83211e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 11:29:03');
INSERT INTO `log` VALUES ('218ce7c2daa111e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-19 13:48:49');
INSERT INTO `log` VALUES ('22bb0cebd91911e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 15:02:40');
INSERT INTO `log` VALUES ('2323f6e4d91611e9b556f8b156d274ca', '保存需求', null, 'admin', '2019-09-17 14:41:12');
INSERT INTO `log` VALUES ('23a13ae6d8fc11e9b556f8b156d274ca', '保存需求', null, 'admin', '2019-09-17 11:35:05');
INSERT INTO `log` VALUES ('2400d89bd53411e994e5f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-12 16:05:54');
INSERT INTO `log` VALUES ('242be937d53411e994e5f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-12 16:05:54');
INSERT INTO `log` VALUES ('2470bf17d53411e994e5f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-12 16:05:54');
INSERT INTO `log` VALUES ('2482ebb3d91711e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 14:48:24');
INSERT INTO `log` VALUES ('248842e5d53511e994e5f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-12 16:13:04');
INSERT INTO `log` VALUES ('24b2cddadaa211e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-19 13:56:04');
INSERT INTO `log` VALUES ('24bf931ad91011e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 13:58:18');
INSERT INTO `log` VALUES ('24c267cdd53411e994e5f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-12 16:05:55');
INSERT INTO `log` VALUES ('24ce1467d53511e994e5f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-12 16:13:04');
INSERT INTO `log` VALUES ('24dee12dd84911e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 14:13:48');
INSERT INTO `log` VALUES ('24eaa1bcd53411e994e5f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-12 16:05:55');
INSERT INTO `log` VALUES ('25014604db4a11e98ce70cc47a47def0', '保存需求', null, 'admin', '2019-09-20 09:58:41');
INSERT INTO `log` VALUES ('25093f22d84911e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 14:13:48');
INSERT INTO `log` VALUES ('25328db8d53511e994e5f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-12 16:13:05');
INSERT INTO `log` VALUES ('253c33f2d50d11e994e5f8b156d274ca', '更新产品', null, 'admin', '2019-09-12 11:26:45');
INSERT INTO `log` VALUES ('256a8a40d53511e994e5f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-12 16:13:05');
INSERT INTO `log` VALUES ('257dccf9d55011e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 19:26:22');
INSERT INTO `log` VALUES ('2593e665d53411e994e5f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-12 16:05:56');
INSERT INTO `log` VALUES ('259d5d25d53511e994e5f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-12 16:13:06');
INSERT INTO `log` VALUES ('25a630d3d84c11e9847ef8b156d274ca', '保存需求', null, 'admin', '2019-09-16 14:35:18');
INSERT INTO `log` VALUES ('25ab2656d84911e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 14:13:49');
INSERT INTO `log` VALUES ('25afeb92d53411e994e5f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-12 16:05:56');
INSERT INTO `log` VALUES ('25be8630d53511e994e5f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-12 16:13:06');
INSERT INTO `log` VALUES ('25d16a8cd9ac11e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 08:35:09');
INSERT INTO `log` VALUES ('25d4aec9d53411e994e5f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-12 16:05:57');
INSERT INTO `log` VALUES ('25df9387d53511e994e5f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-12 16:13:06');
INSERT INTO `log` VALUES ('25e6236cdaad11e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-19 15:14:50');
INSERT INTO `log` VALUES ('25ef3ddcd84911e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 14:13:49');
INSERT INTO `log` VALUES ('26107285d53411e994e5f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-12 16:05:57');
INSERT INTO `log` VALUES ('2649f3a8d8f011e9b556f8b156d274ca', '增加产品', null, 'admin', '2019-09-17 10:09:16');
INSERT INTO `log` VALUES ('2657b139d53411e994e5f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-12 16:05:58');
INSERT INTO `log` VALUES ('2680f7ebd53511e994e5f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-12 16:13:07');
INSERT INTO `log` VALUES ('2681c5f6d54311e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 17:53:20');
INSERT INTO `log` VALUES ('2682e9ffd53411e994e5f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-12 16:05:58');
INSERT INTO `log` VALUES ('26973c25db7111e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-20 14:37:54');
INSERT INTO `log` VALUES ('26a71f41d53511e994e5f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-12 16:13:08');
INSERT INTO `log` VALUES ('26cb9a65d53411e994e5f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-12 16:05:58');
INSERT INTO `log` VALUES ('26f7e837d53411e994e5f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-12 16:05:59');
INSERT INTO `log` VALUES ('27209b24d53411e994e5f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-12 16:05:59');
INSERT INTO `log` VALUES ('273cdc83dab911e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-19 16:40:47');
INSERT INTO `log` VALUES ('275400e9d53511e994e5f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-12 16:13:09');
INSERT INTO `log` VALUES ('275b9591d53411e994e5f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-12 16:05:59');
INSERT INTO `log` VALUES ('277ca963d85d11e9847ef8b156d274ca', '导入excel', null, 'admin', '2019-09-16 16:37:00');
INSERT INTO `log` VALUES ('27a7f406d53511e994e5f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-12 16:13:09');
INSERT INTO `log` VALUES ('27ef143bd4ff11e994e5f8b156d274ca', '更新产品', null, 'admin', '2019-09-12 09:46:36');
INSERT INTO `log` VALUES ('289d1bb9d8f811e9b556f8b156d274ca', '保存需求', null, 'admin', '2019-09-17 11:06:36');
INSERT INTO `log` VALUES ('28e0b5cfd84911e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 14:13:54');
INSERT INTO `log` VALUES ('294a0618d84911e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 14:13:55');
INSERT INTO `log` VALUES ('2984729ad4fe11e994e5f8b156d274ca', '更新产品', null, 'admin', '2019-09-12 09:39:29');
INSERT INTO `log` VALUES ('29929b89d84911e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 14:13:56');
INSERT INTO `log` VALUES ('29d4bf38d84911e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 14:13:56');
INSERT INTO `log` VALUES ('2a15df49d46b11e9bfdef8b156d274ca', '增加产品', null, 'admin', '2019-09-11 16:07:15');
INSERT INTO `log` VALUES ('2a24652ed50d11e994e5f8b156d274ca', '更新产品', null, 'admin', '2019-09-12 11:26:53');
INSERT INTO `log` VALUES ('2ab4ed49db3c11e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-20 08:18:37');
INSERT INTO `log` VALUES ('2ab6d419d85c11e9847ef8b156d274ca', '更新项目', null, 'admin', '2019-09-16 16:29:58');
INSERT INTO `log` VALUES ('2aba69e9d82111e9847ef8b156d274ca', '更新需求', null, 'admin', '2019-09-16 09:27:37');
INSERT INTO `log` VALUES ('2b4d5442d92611e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:35:57');
INSERT INTO `log` VALUES ('2b599529d53711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 16:27:34');
INSERT INTO `log` VALUES ('2bd77f5fd86011e9847ef8b156d274ca', '增加项目', null, 'admin', '2019-09-16 16:58:38');
INSERT INTO `log` VALUES ('2be270b6d92f11e9b4ccf8b156d274ca', '删除需求', null, 'admin', '2019-09-17 17:40:23');
INSERT INTO `log` VALUES ('2ca315bdd46511e9bfdef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-11 15:24:22');
INSERT INTO `log` VALUES ('2cfee81fdb3e11e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-20 08:32:23');
INSERT INTO `log` VALUES ('2d0e5719d8fc11e9b556f8b156d274ca', '保存需求', null, 'admin', '2019-09-17 11:35:21');
INSERT INTO `log` VALUES ('2d7a4a82db6311e98ce70cc47a47def0', '更新需求', null, 'admin', '2019-09-20 12:57:52');
INSERT INTO `log` VALUES ('2e53f986d52711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 14:33:07');
INSERT INTO `log` VALUES ('2e5acfeedc4c11e9b510f8b156d274ca', '上传文档', null, 'admin', '2019-09-21 16:44:55');
INSERT INTO `log` VALUES ('2ec287d7daa311e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-19 14:03:30');
INSERT INTO `log` VALUES ('2ec83eb2daaa11e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-19 14:53:37');
INSERT INTO `log` VALUES ('2ee8810ad50711e994e5f8b156d274ca', '上传文档', null, 'admin', '2019-09-12 10:43:57');
INSERT INTO `log` VALUES ('2eea580cd52711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 14:33:08');
INSERT INTO `log` VALUES ('2f18d1f9daaa11e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-19 14:53:37');
INSERT INTO `log` VALUES ('2f3ea79ddb6b11e98ce70cc47a47def0', '更新需求', null, 'admin', '2019-09-20 13:55:11');
INSERT INTO `log` VALUES ('2f4b3b9dd91711e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 14:48:42');
INSERT INTO `log` VALUES ('2f5c19d6daaa11e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-19 14:53:38');
INSERT INTO `log` VALUES ('2f90001bd9f511e98ce70cc47a47def0', '添加一条分类', null, 'admin', '2019-09-18 17:17:59');
INSERT INTO `log` VALUES ('2fa1627edaaa11e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-19 14:53:38');
INSERT INTO `log` VALUES ('2fe2b4dfdaaa11e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-19 14:53:39');
INSERT INTO `log` VALUES ('301cd119daaa11e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-19 14:53:39');
INSERT INTO `log` VALUES ('305a0ba9daaa11e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-19 14:53:40');
INSERT INTO `log` VALUES ('30a3ddfbdaaa11e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-19 14:53:40');
INSERT INTO `log` VALUES ('30d6d6d5d4fe11e994e5f8b156d274ca', '更新产品', null, 'admin', '2019-09-12 09:39:42');
INSERT INTO `log` VALUES ('30da9334d90f11e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 13:51:28');
INSERT INTO `log` VALUES ('30f4c293daaa11e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-19 14:53:41');
INSERT INTO `log` VALUES ('313dc704db7311e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-20 14:52:30');
INSERT INTO `log` VALUES ('31c3beafd91c11e9b556f8b156d274ca', '上传文档', null, 'admin', '2019-09-17 15:23:28');
INSERT INTO `log` VALUES ('31f907abdb5011e98ce70cc47a47def0', '保存需求', null, 'admin', '2019-09-20 10:41:59');
INSERT INTO `log` VALUES ('323d4240d55011e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 19:26:44');
INSERT INTO `log` VALUES ('325b9e81d53b11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:56:24');
INSERT INTO `log` VALUES ('32a05d4cd9d411e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-18 13:21:50');
INSERT INTO `log` VALUES ('333bc0d7d9d411e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-18 13:21:51');
INSERT INTO `log` VALUES ('335b3f15d9ac11e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 08:35:32');
INSERT INTO `log` VALUES ('335f703cdaa511e98ce70cc47a47def0', '增加项目', null, 'admin', '2019-09-19 14:17:57');
INSERT INTO `log` VALUES ('337213f9d92b11e9b4ccf8b156d274ca', '保存需求', null, 'admin', '2019-09-17 17:11:58');
INSERT INTO `log` VALUES ('33d171dddb3a11e98ce70cc47a47def0', '删除项目', null, 'admin', '2019-09-20 08:04:33');
INSERT INTO `log` VALUES ('33f32702d46611e9bfdef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-11 15:31:44');
INSERT INTO `log` VALUES ('34853d54db6a11e98ce70cc47a47def0', '保存需求', null, 'admin', '2019-09-20 13:48:11');
INSERT INTO `log` VALUES ('349029d5daa111e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-19 13:49:21');
INSERT INTO `log` VALUES ('35831db8d91711e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 14:48:52');
INSERT INTO `log` VALUES ('359e18a1d92611e9b4ccf8b156d274ca', '增加产品', null, 'admin', '2019-09-17 16:36:14');
INSERT INTO `log` VALUES ('3630b9a8d84f11e9847ef8b156d274ca', '保存需求', null, 'admin', '2019-09-16 14:57:14');
INSERT INTO `log` VALUES ('366a3c40dc4b11e9b510f8b156d274ca', '上传文档', null, 'admin', '2019-09-21 16:38:41');
INSERT INTO `log` VALUES ('36cafaa8d46211e9bfdef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-11 15:03:11');
INSERT INTO `log` VALUES ('36f77824d50111e994e5f8b156d274ca', '更新项目', null, 'admin', '2019-09-12 10:01:20');
INSERT INTO `log` VALUES ('374ec32adb3a11e98ce70cc47a47def0', '删除项目', null, 'admin', '2019-09-20 08:04:39');
INSERT INTO `log` VALUES ('37518540d52711e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 14:33:22');
INSERT INTO `log` VALUES ('37e55c57d46211e9bfdef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-11 15:03:13');
INSERT INTO `log` VALUES ('38004294db3a11e98ce70cc47a47def0', '删除项目', null, 'admin', '2019-09-20 08:04:41');
INSERT INTO `log` VALUES ('3803425ad91d11e9b556f8b156d274ca', '删除需求', null, 'admin', '2019-09-17 15:31:54');
INSERT INTO `log` VALUES ('380a35cbd46211e9bfdef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-11 15:03:13');
INSERT INTO `log` VALUES ('3855a679dabc11e98ce70cc47a47def0', '保存需求', null, 'admin', '2019-09-19 17:02:44');
INSERT INTO `log` VALUES ('38a7910fdaa011e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-19 13:42:19');
INSERT INTO `log` VALUES ('38cad7aad53111e994e5f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-12 15:45:00');
INSERT INTO `log` VALUES ('38d5ecd2db3a11e98ce70cc47a47def0', '删除项目', null, 'admin', '2019-09-20 08:04:42');
INSERT INTO `log` VALUES ('38d83d58db7d11e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-20 16:03:40');
INSERT INTO `log` VALUES ('39633860db3a11e98ce70cc47a47def0', '删除项目', null, 'admin', '2019-09-20 08:04:43');
INSERT INTO `log` VALUES ('39708837d46711e9bfdef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-11 15:39:03');
INSERT INTO `log` VALUES ('398f9bf5d4ff11e994e5f8b156d274ca', '更新产品', null, 'admin', '2019-09-12 09:47:06');
INSERT INTO `log` VALUES ('3992cee9d46711e9bfdef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-11 15:39:03');
INSERT INTO `log` VALUES ('399bb79ddc1711e98ce70cc47a47def0', '上传文档', null, '123456789', '2019-09-21 10:26:13');
INSERT INTO `log` VALUES ('39ac53d6d86011e9847ef8b156d274ca', '增加项目', null, 'admin', '2019-09-16 16:59:01');
INSERT INTO `log` VALUES ('39cde582d50011e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 09:54:16');
INSERT INTO `log` VALUES ('39d1ae95daa511e98ce70cc47a47def0', '增加项目', null, 'admin', '2019-09-19 14:18:08');
INSERT INTO `log` VALUES ('3a5c2e6fd4fe11e994e5f8b156d274ca', '更新产品', null, 'admin', '2019-09-12 09:39:58');
INSERT INTO `log` VALUES ('3aaf2ed2d55211e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 19:37:20');
INSERT INTO `log` VALUES ('3b5fe14bd84f11e9847ef8b156d274ca', '保存需求', null, 'admin', '2019-09-16 14:57:22');
INSERT INTO `log` VALUES ('3b8c98c7dc4b11e9b510f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-21 16:38:50');
INSERT INTO `log` VALUES ('3c012137d9d911e98ce70cc47a47def0', '保存需求', null, 'admin', '2019-09-18 13:57:54');
INSERT INTO `log` VALUES ('3ca45d7dd85f11e9847ef8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-16 16:51:57');
INSERT INTO `log` VALUES ('3cb5dde2d85f11e9847ef8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-16 16:51:57');
INSERT INTO `log` VALUES ('3cd3c0d9d85f11e9847ef8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-16 16:51:57');
INSERT INTO `log` VALUES ('3cfa0614d85f11e9847ef8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-16 16:51:57');
INSERT INTO `log` VALUES ('3d0f027cd85f11e9847ef8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-16 16:51:57');
INSERT INTO `log` VALUES ('3d2b0226d53b11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:56:42');
INSERT INTO `log` VALUES ('3d373b4cd85f11e9847ef8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-16 16:51:58');
INSERT INTO `log` VALUES ('3d4c4c18d85f11e9847ef8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-16 16:51:58');
INSERT INTO `log` VALUES ('3dce8ecbda9f11e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-19 13:35:17');
INSERT INTO `log` VALUES ('3de206c9d85f11e9847ef8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-16 16:51:59');
INSERT INTO `log` VALUES ('3e1530a7d46411e9bfdef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-11 15:17:42');
INSERT INTO `log` VALUES ('3e589befd46411e9bfdef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-11 15:17:42');
INSERT INTO `log` VALUES ('3e6127dad85f11e9847ef8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-16 16:51:59');
INSERT INTO `log` VALUES ('3e62780ad50011e994e5f8b156d274ca', '删除项目', null, 'admin', '2019-09-12 09:54:24');
INSERT INTO `log` VALUES ('3e907144d46411e9bfdef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-11 15:17:43');
INSERT INTO `log` VALUES ('3e91f3fed85f11e9847ef8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-16 16:52:00');
INSERT INTO `log` VALUES ('3ea53431d83211e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 11:29:52');
INSERT INTO `log` VALUES ('3eb0b0a2d52811e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 14:40:44');
INSERT INTO `log` VALUES ('3ed65b60d50011e994e5f8b156d274ca', '删除项目', null, 'admin', '2019-09-12 09:54:24');
INSERT INTO `log` VALUES ('3ee0501cd85f11e9847ef8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-16 16:52:00');
INSERT INTO `log` VALUES ('3efc62a8db3c11e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-20 08:19:10');
INSERT INTO `log` VALUES ('3f0081c1d83211e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 11:29:53');
INSERT INTO `log` VALUES ('3fb990e9daa511e98ce70cc47a47def0', '增加项目', null, 'admin', '2019-09-19 14:18:18');
INSERT INTO `log` VALUES ('3ff03a75d8fc11e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 11:35:53');
INSERT INTO `log` VALUES ('40731b77d52811e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 14:40:47');
INSERT INTO `log` VALUES ('409354ffd9f511e98ce70cc47a47def0', '添加一条分类', null, 'admin', '2019-09-18 17:18:27');
INSERT INTO `log` VALUES ('40b59491d91311e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 14:15:18');
INSERT INTO `log` VALUES ('40b887c7d83211e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 11:29:56');
INSERT INTO `log` VALUES ('40f9c240d83211e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 11:29:56');
INSERT INTO `log` VALUES ('429f5caed50d11e994e5f8b156d274ca', '增加产品', null, 'admin', '2019-09-12 11:27:34');
INSERT INTO `log` VALUES ('42a1bb61dc4b11e9b510f8b156d274ca', '增加产品', null, 'admin', '2019-09-21 16:39:01');
INSERT INTO `log` VALUES ('4328b773d9d411e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-18 13:22:17');
INSERT INTO `log` VALUES ('434c467ad50211e994e5f8b156d274ca', '上传文档', null, 'admin', '2019-09-12 10:08:51');
INSERT INTO `log` VALUES ('43bb6efed9d411e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-18 13:22:19');
INSERT INTO `log` VALUES ('441f8ac3d53611e994e5f8b156d274ca', '添加一条分类', null, 'admin', '2019-09-12 16:21:07');
INSERT INTO `log` VALUES ('4479356fd84c11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:36:09');
INSERT INTO `log` VALUES ('44aea15ed8fb11e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 11:24:14');
INSERT INTO `log` VALUES ('44b302a4d54411e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 18:00:14');
INSERT INTO `log` VALUES ('44fb99bfd84c11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:36:10');
INSERT INTO `log` VALUES ('4538f93bd92611e9b4ccf8b156d274ca', '增加产品', null, 'admin', '2019-09-17 16:36:40');
INSERT INTO `log` VALUES ('4539e28dd83211e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 11:30:03');
INSERT INTO `log` VALUES ('45571c9cd84c11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:36:11');
INSERT INTO `log` VALUES ('45755d73d83211e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 11:30:04');
INSERT INTO `log` VALUES ('45b8695bd84c11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:36:11');
INSERT INTO `log` VALUES ('45fe2931d91511e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 14:35:01');
INSERT INTO `log` VALUES ('463a868edd9f11e98c39f8b156d274ca', '增加产品', null, 'admin', '2019-09-23 09:12:56');
INSERT INTO `log` VALUES ('4642cedddaa511e98ce70cc47a47def0', '增加项目', null, 'admin', '2019-09-19 14:18:29');
INSERT INTO `log` VALUES ('46454b5cd53011e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 15:38:13');
INSERT INTO `log` VALUES ('467b90b6d53811e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:34:58');
INSERT INTO `log` VALUES ('46e7c511daa411e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-19 14:11:20');
INSERT INTO `log` VALUES ('4794d392d82211e9847ef8b156d274ca', '增加产品', null, 'admin', '2019-09-16 09:35:35');
INSERT INTO `log` VALUES ('47bb8a35d52411e994e5f8b156d274ca', '添加一条分类', null, 'admin', '2019-09-12 14:12:21');
INSERT INTO `log` VALUES ('47c06b08d53a11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:49:51');
INSERT INTO `log` VALUES ('47ec80ddd86011e9847ef8b156d274ca', '增加项目', null, 'admin', '2019-09-16 16:59:25');
INSERT INTO `log` VALUES ('480367c7d82311e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 09:42:46');
INSERT INTO `log` VALUES ('483aae50d52f11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 15:29:32');
INSERT INTO `log` VALUES ('48ca3e91d53a11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:49:52');
INSERT INTO `log` VALUES ('48ca9b85d50a11e994e5f8b156d274ca', '上传文档', null, 'admin', '2019-09-12 11:06:15');
INSERT INTO `log` VALUES ('4907b70cdb7211e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-20 14:46:01');
INSERT INTO `log` VALUES ('49ff2a4edb7d11e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-20 16:04:36');
INSERT INTO `log` VALUES ('4a9d3129d91211e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 14:13:40');
INSERT INTO `log` VALUES ('4ae7130ed86011e9847ef8b156d274ca', '增加项目', null, 'admin', '2019-09-16 16:59:30');
INSERT INTO `log` VALUES ('4ae9983cd92f11e9b4ccf8b156d274ca', '导入excel', null, 'admin', '2019-09-17 17:41:15');
INSERT INTO `log` VALUES ('4aecf78bd45e11e9bfdef8b156d274ca', '增加产品', null, 'admin', '2019-09-11 14:35:07');
INSERT INTO `log` VALUES ('4b6b26d2d55711e994e5f8b156d274ca', '保存需求', null, null, '2019-09-12 20:17:32');
INSERT INTO `log` VALUES ('4bf37af1daa211e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-19 13:57:10');
INSERT INTO `log` VALUES ('4c097f78dc4b11e9b510f8b156d274ca', '导入excel', null, 'admin', '2019-09-21 16:39:15');
INSERT INTO `log` VALUES ('4d4b6f82d92611e9b4ccf8b156d274ca', '更新产品', null, 'admin', '2019-09-17 16:36:54');
INSERT INTO `log` VALUES ('4d6403d8daa611e98ce70cc47a47def0', '更新项目', null, 'admin', '2019-09-19 14:25:50');
INSERT INTO `log` VALUES ('4d73f8eed84c11e9847ef8b156d274ca', '保存需求', null, 'admin', '2019-09-16 14:36:24');
INSERT INTO `log` VALUES ('4df601a2d4fe11e994e5f8b156d274ca', '更新产品', null, 'admin', '2019-09-12 09:40:31');
INSERT INTO `log` VALUES ('4e1bc201d9dd11e98ce70cc47a47def0', '删除需求', null, 'admin', '2019-09-18 14:27:02');
INSERT INTO `log` VALUES ('4eb00399d9dd11e98ce70cc47a47def0', '删除需求', null, 'admin', '2019-09-18 14:27:03');
INSERT INTO `log` VALUES ('4f1a4bf7d91211e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 14:13:48');
INSERT INTO `log` VALUES ('4f9c1c39dd9f11e98c39f8b156d274ca', '导入excel', null, 'admin', '2019-09-23 09:13:09');
INSERT INTO `log` VALUES ('50000b0fd8fc11e9b556f8b156d274ca', '删除需求', null, 'admin', '2019-09-17 11:36:20');
INSERT INTO `log` VALUES ('5003f5aed53a11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:50:05');
INSERT INTO `log` VALUES ('5003fe34d54211e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 17:47:21');
INSERT INTO `log` VALUES ('5061db04d82211e9847ef8b156d274ca', '增加产品', null, 'admin', '2019-09-16 09:35:50');
INSERT INTO `log` VALUES ('50f99a28d53311e994e5f8b156d274ca', '增加产品', null, 'admin', '2019-09-12 16:00:00');
INSERT INTO `log` VALUES ('511e3429d92f11e9b4ccf8b156d274ca', '删除需求', null, 'admin', '2019-09-17 17:41:26');
INSERT INTO `log` VALUES ('5139ff14d92f11e9b4ccf8b156d274ca', '删除需求', null, 'admin', '2019-09-17 17:41:26');
INSERT INTO `log` VALUES ('517ab9dadaa611e98ce70cc47a47def0', '更新项目', null, 'admin', '2019-09-19 14:25:57');
INSERT INTO `log` VALUES ('51af70b5d92f11e9b4ccf8b156d274ca', '删除需求', null, 'admin', '2019-09-17 17:41:27');
INSERT INTO `log` VALUES ('51be33b6d82d11e9847ef8b156d274ca', '更新项目', null, 'admin', '2019-09-16 10:54:37');
INSERT INTO `log` VALUES ('520ff044d92f11e9b4ccf8b156d274ca', '删除需求', null, 'admin', '2019-09-17 17:41:28');
INSERT INTO `log` VALUES ('52241201d55011e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 19:27:37');
INSERT INTO `log` VALUES ('522d1d5dd82311e9847ef8b156d274ca', '保存需求', null, 'admin', '2019-09-16 09:43:03');
INSERT INTO `log` VALUES ('52447718d92611e9b4ccf8b156d274ca', '更新产品', null, 'admin', '2019-09-17 16:37:02');
INSERT INTO `log` VALUES ('53300f9fd45b11e9bfdef8b156d274ca', '上传文档', null, 'admin', '2019-09-11 14:13:05');
INSERT INTO `log` VALUES ('533a0c37d91711e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 14:49:42');
INSERT INTO `log` VALUES ('535a7a5fd92f11e9b4ccf8b156d274ca', '删除需求', null, 'admin', '2019-09-17 17:41:30');
INSERT INTO `log` VALUES ('53a0e20adc4c11e9b510f8b156d274ca', '上传文档', null, 'admin', '2019-09-21 16:46:04');
INSERT INTO `log` VALUES ('53ac1893d92f11e9b4ccf8b156d274ca', '删除需求', null, 'admin', '2019-09-17 17:41:30');
INSERT INTO `log` VALUES ('543f711dd91211e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 14:13:56');
INSERT INTO `log` VALUES ('54455ae9daa211e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-19 13:57:24');
INSERT INTO `log` VALUES ('544bc707d86011e9847ef8b156d274ca', '导入excel', null, 'admin', '2019-09-16 16:59:45');
INSERT INTO `log` VALUES ('54c691d3daa311e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-19 14:04:34');
INSERT INTO `log` VALUES ('54f106ecdab611e98ce70cc47a47def0', '更新产品', null, 'admin', '2019-09-19 16:20:35');
INSERT INTO `log` VALUES ('550bea11d92f11e9b4ccf8b156d274ca', '删除需求', null, 'admin', '2019-09-17 17:41:33');
INSERT INTO `log` VALUES ('557bc398d92f11e9b4ccf8b156d274ca', '删除需求', null, 'admin', '2019-09-17 17:41:33');
INSERT INTO `log` VALUES ('567b5ae1d91b11e9b556f8b156d274ca', '增加产品', null, 'admin', '2019-09-17 15:18:26');
INSERT INTO `log` VALUES ('57735db6d54211e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 17:47:33');
INSERT INTO `log` VALUES ('5781be8ad50611e994e5f8b156d274ca', '增加产品', null, 'admin', '2019-09-12 10:38:03');
INSERT INTO `log` VALUES ('57c60937dabc11e98ce70cc47a47def0', '更新需求', null, 'admin', '2019-09-19 17:03:37');
INSERT INTO `log` VALUES ('57fca2eed9a711e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 08:00:45');
INSERT INTO `log` VALUES ('583163bbd82d11e9847ef8b156d274ca', '更新项目', null, 'admin', '2019-09-16 10:54:48');
INSERT INTO `log` VALUES ('586a0c0bdaa411e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-19 14:11:49');
INSERT INTO `log` VALUES ('589c7c3cd90f11e9b556f8b156d274ca', '保存需求', null, 'admin', '2019-09-17 13:52:35');
INSERT INTO `log` VALUES ('592dc0b3d92511e9b4ccf8b156d274ca', '更新产品', null, 'admin', '2019-09-17 16:30:04');
INSERT INTO `log` VALUES ('59ba91d6d4fe11e994e5f8b156d274ca', '更新产品', null, 'admin', '2019-09-12 09:40:50');
INSERT INTO `log` VALUES ('5a31acc0d53b11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:57:31');
INSERT INTO `log` VALUES ('5a90808fd52911e994e5f8b156d274ca', '导入excel', null, 'admin', '2019-09-12 14:48:35');
INSERT INTO `log` VALUES ('5a96acc8db7e11e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-20 16:11:47');
INSERT INTO `log` VALUES ('5ab6525ed46511e9bfdef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-11 15:25:39');
INSERT INTO `log` VALUES ('5b7df6a3d85411e9847ef8b156d274ca', '更新项目', null, 'admin', '2019-09-16 15:34:04');
INSERT INTO `log` VALUES ('5b8353a5d84511e9847ef8b156d274ca', '更新需求', null, 'admin', '2019-09-16 13:46:41');
INSERT INTO `log` VALUES ('5ba4c52cdb5211e98ce70cc47a47def0', '保存需求', null, 'admin', '2019-09-20 10:57:28');
INSERT INTO `log` VALUES ('5bfb53efd50e11e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:34:54');
INSERT INTO `log` VALUES ('5c0b2cead82211e9847ef8b156d274ca', '增加产品', null, 'admin', '2019-09-16 09:36:10');
INSERT INTO `log` VALUES ('5c18ba21dc3811e98ce70cc47a47def0', '保存需求', null, '123456789', '2019-09-21 14:23:54');
INSERT INTO `log` VALUES ('5cd7bdd0d54111e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 17:40:32');
INSERT INTO `log` VALUES ('5cedb044d84511e9847ef8b156d274ca', '更新需求', null, 'admin', '2019-09-16 13:46:44');
INSERT INTO `log` VALUES ('5d3e9c08d84c11e9847ef8b156d274ca', '添加一条分类', null, 'admin', '2019-09-16 14:36:51');
INSERT INTO `log` VALUES ('5d7133b4dc4c11e9b510f8b156d274ca', '导入excel', null, 'admin', '2019-09-21 16:46:55');
INSERT INTO `log` VALUES ('5df8d1a3d84511e9847ef8b156d274ca', '更新需求', null, 'admin', '2019-09-16 13:46:46');
INSERT INTO `log` VALUES ('5e085e2cd92f11e9b4ccf8b156d274ca', '导入excel', null, 'admin', '2019-09-17 17:41:47');
INSERT INTO `log` VALUES ('5e519137d8fc11e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 11:36:44');
INSERT INTO `log` VALUES ('5ee8f590d84f11e9847ef8b156d274ca', '保存需求', null, 'admin', '2019-09-16 14:58:22');
INSERT INTO `log` VALUES ('5f116badd50b11e994e5f8b156d274ca', '更新项目', null, 'admin', '2019-09-12 11:14:03');
INSERT INTO `log` VALUES ('5f80b906d84511e9847ef8b156d274ca', '更新需求', null, 'admin', '2019-09-16 13:46:48');
INSERT INTO `log` VALUES ('60261d12d52711e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 14:34:31');
INSERT INTO `log` VALUES ('605ff2b9d9a711e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 08:01:00');
INSERT INTO `log` VALUES ('60bae0c4d92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:17');
INSERT INTO `log` VALUES ('60d43c5ad92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:17');
INSERT INTO `log` VALUES ('60e36fefd91b11e9b556f8b156d274ca', '导入excel', null, 'admin', '2019-09-17 15:18:43');
INSERT INTO `log` VALUES ('60ff81ded92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:18');
INSERT INTO `log` VALUES ('6108fecad92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:18');
INSERT INTO `log` VALUES ('61149fd7d92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:18');
INSERT INTO `log` VALUES ('6115c904d46311e9bfdef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-11 15:11:31');
INSERT INTO `log` VALUES ('612d508dd92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:18');
INSERT INTO `log` VALUES ('613e25c6d84c11e9847ef8b156d274ca', '保存需求', null, 'admin', '2019-09-16 14:36:57');
INSERT INTO `log` VALUES ('6154f5bbd92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:18');
INSERT INTO `log` VALUES ('616bef49d92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:18');
INSERT INTO `log` VALUES ('61704181d91111e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 14:06:00');
INSERT INTO `log` VALUES ('61a197e0daa111e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-19 13:50:37');
INSERT INTO `log` VALUES ('61a90f6dd92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:19');
INSERT INTO `log` VALUES ('61d57178d52411e994e5f8b156d274ca', '添加一条分类', null, 'admin', '2019-09-12 14:13:05');
INSERT INTO `log` VALUES ('61d9824ad92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:19');
INSERT INTO `log` VALUES ('61f15143d92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:19');
INSERT INTO `log` VALUES ('622e91a9dc3811e98ce70cc47a47def0', '删除需求', null, '123456789', '2019-09-21 14:24:05');
INSERT INTO `log` VALUES ('625383e6da9f11e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-19 13:36:19');
INSERT INTO `log` VALUES ('6273eac8db4911e98ce70cc47a47def0', '保存需求', null, 'admin', '2019-09-20 09:53:14');
INSERT INTO `log` VALUES ('6281f7e9d4f911e994e5f8b156d274ca', '更新需求', null, 'admin', '2019-09-12 09:05:17');
INSERT INTO `log` VALUES ('629b064cd92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:19');
INSERT INTO `log` VALUES ('62a7075ad92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:20');
INSERT INTO `log` VALUES ('62b4fbc4d92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:20');
INSERT INTO `log` VALUES ('62b8380cd92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:20');
INSERT INTO `log` VALUES ('62c4a286d92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:21');
INSERT INTO `log` VALUES ('62d23af8d92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:21');
INSERT INTO `log` VALUES ('62e1515fd92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:21');
INSERT INTO `log` VALUES ('62fee2fdd92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:21');
INSERT INTO `log` VALUES ('631ef2a8d92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:21');
INSERT INTO `log` VALUES ('632f6231d92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:21');
INSERT INTO `log` VALUES ('6355788dd92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:21');
INSERT INTO `log` VALUES ('637d5914d92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:22');
INSERT INTO `log` VALUES ('63ae9d66d92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:22');
INSERT INTO `log` VALUES ('63caa2d9d9a711e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 08:01:05');
INSERT INTO `log` VALUES ('63d7597dd92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:22');
INSERT INTO `log` VALUES ('63e66de9d52811e994e5f8b156d274ca', '更新需求', null, 'admin', '2019-09-12 14:41:47');
INSERT INTO `log` VALUES ('63ead85ed92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:22');
INSERT INTO `log` VALUES ('6410873cd86b11e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 18:18:57');
INSERT INTO `log` VALUES ('641311c2d92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:23');
INSERT INTO `log` VALUES ('641ad401d50b11e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:14:11');
INSERT INTO `log` VALUES ('6425c2c1d92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:23');
INSERT INTO `log` VALUES ('64546102d92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:23');
INSERT INTO `log` VALUES ('6457b848d86b11e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 18:18:57');
INSERT INTO `log` VALUES ('6462e7d6d92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:23');
INSERT INTO `log` VALUES ('64f95b59d53b11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:57:49');
INSERT INTO `log` VALUES ('650d718fd92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:24');
INSERT INTO `log` VALUES ('6513ee97d82211e9847ef8b156d274ca', '增加产品', null, 'admin', '2019-09-16 09:36:25');
INSERT INTO `log` VALUES ('65690ccad92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:25');
INSERT INTO `log` VALUES ('65817defdb4111e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-20 08:56:03');
INSERT INTO `log` VALUES ('659d41c6db4111e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-20 08:56:04');
INSERT INTO `log` VALUES ('65b7cc02d92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:25');
INSERT INTO `log` VALUES ('65df2aa8db6711e98ce70cc47a47def0', '保存需求', null, 'admin', '2019-09-20 13:28:05');
INSERT INTO `log` VALUES ('65e1c531db4111e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-20 08:56:04');
INSERT INTO `log` VALUES ('6615f199d92511e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 16:30:26');
INSERT INTO `log` VALUES ('6652fccbdb4111e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-20 08:56:05');
INSERT INTO `log` VALUES ('6666a25ed84c11e9847ef8b156d274ca', '保存需求', null, 'admin', '2019-09-16 14:37:06');
INSERT INTO `log` VALUES ('6678da8ed9a711e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 08:01:10');
INSERT INTO `log` VALUES ('66af4d7bd92f11e9b4ccf8b156d274ca', '导入excel', null, 'admin', '2019-09-17 17:42:01');
INSERT INTO `log` VALUES ('66bfafc2db4111e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-20 08:56:05');
INSERT INTO `log` VALUES ('66ecbebed50211e994e5f8b156d274ca', '上传文档', null, 'admin', '2019-09-12 10:09:10');
INSERT INTO `log` VALUES ('66fb4f25db4111e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-20 08:56:06');
INSERT INTO `log` VALUES ('670748d9dab411e98ce70cc47a47def0', '增加项目', null, 'admin', '2019-09-19 16:06:46');
INSERT INTO `log` VALUES ('670951c2d9a711e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 08:01:11');
INSERT INTO `log` VALUES ('674653e2db4111e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-20 08:56:06');
INSERT INTO `log` VALUES ('675af5e4d47611e9bfdef8b156d274ca', '更新需求', null, 'admin', '2019-09-11 17:27:42');
INSERT INTO `log` VALUES ('6787d243db4111e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-20 08:56:07');
INSERT INTO `log` VALUES ('67d8fb10db4111e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-20 08:56:07');
INSERT INTO `log` VALUES ('67ed78bdd9af11e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 08:58:28');
INSERT INTO `log` VALUES ('6842d699d84511e9847ef8b156d274ca', '更新需求', null, 'admin', '2019-09-16 13:47:03');
INSERT INTO `log` VALUES ('68954dc8db4111e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-20 08:56:09');
INSERT INTO `log` VALUES ('68a656ecd84f11e9847ef8b156d274ca', '保存需求', null, 'admin', '2019-09-16 14:58:38');
INSERT INTO `log` VALUES ('68c02a10d4f911e994e5f8b156d274ca', '更新需求', null, 'admin', '2019-09-12 09:05:28');
INSERT INTO `log` VALUES ('68c95f82db4111e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-20 08:56:09');
INSERT INTO `log` VALUES ('6904f355db4111e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-20 08:56:09');
INSERT INTO `log` VALUES ('6922a284d8fc11e9b556f8b156d274ca', '删除需求', null, 'admin', '2019-09-17 11:37:02');
INSERT INTO `log` VALUES ('695176dedb4111e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-20 08:56:10');
INSERT INTO `log` VALUES ('69870d1fd9a911e98ce70cc47a47def0', '删除项目', null, 'admin', '2019-09-18 08:15:34');
INSERT INTO `log` VALUES ('69ca1584db4111e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-20 08:56:11');
INSERT INTO `log` VALUES ('6a1e6735db4111e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-20 08:56:11');
INSERT INTO `log` VALUES ('6a64ca8ed91c11e9b556f8b156d274ca', '上传文档', null, 'admin', '2019-09-17 15:25:27');
INSERT INTO `log` VALUES ('6a665335db4111e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-20 08:56:12');
INSERT INTO `log` VALUES ('6a871357d9a911e98ce70cc47a47def0', '删除项目', null, 'admin', '2019-09-18 08:15:36');
INSERT INTO `log` VALUES ('6b54f135d9f511e98ce70cc47a47def0', '保存需求', null, 'admin', '2019-09-18 17:19:39');
INSERT INTO `log` VALUES ('6b769c7fdb5011e98ce70cc47a47def0', '保存需求', null, 'admin', '2019-09-20 10:43:36');
INSERT INTO `log` VALUES ('6bc09fced46011e9bfdef8b156d274ca', '上传文档', null, 'admin', '2019-09-11 14:50:09');
INSERT INTO `log` VALUES ('6bc1ea51d52211e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 13:59:03');
INSERT INTO `log` VALUES ('6c330ec8db7d11e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-20 16:05:13');
INSERT INTO `log` VALUES ('6c8efd3bd52811e994e5f8b156d274ca', '更新需求', null, 'admin', '2019-09-12 14:42:01');
INSERT INTO `log` VALUES ('6c97b171d4fd11e994e5f8b156d274ca', '增加产品', null, 'admin', '2019-09-12 09:34:12');
INSERT INTO `log` VALUES ('6cf99eb0db4811e98ce70cc47a47def0', '更新需求', null, 'admin', '2019-09-20 09:46:22');
INSERT INTO `log` VALUES ('6d0054e4d53611e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:22:15');
INSERT INTO `log` VALUES ('6d609271db4a11e98ce70cc47a47def0', '保存需求', null, 'admin', '2019-09-20 10:00:42');
INSERT INTO `log` VALUES ('6da84925dab211e98ce70cc47a47def0', '增加项目', null, 'admin', '2019-09-19 15:52:38');
INSERT INTO `log` VALUES ('6de07642daad11e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-19 15:16:16');
INSERT INTO `log` VALUES ('6ed17050d9a911e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 08:15:43');
INSERT INTO `log` VALUES ('6f309214d84c11e9847ef8b156d274ca', '保存需求', null, 'admin', '2019-09-16 14:37:21');
INSERT INTO `log` VALUES ('70149463d52211e994e5f8b156d274ca', '删除项目', null, 'admin', '2019-09-12 13:59:10');
INSERT INTO `log` VALUES ('702f36c5d9a911e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 08:15:45');
INSERT INTO `log` VALUES ('7065fda5d45c11e9bfdef8b156d274ca', '增加产品', null, 'admin', '2019-09-11 14:21:50');
INSERT INTO `log` VALUES ('70c68df3d84511e9847ef8b156d274ca', '更新需求', null, 'admin', '2019-09-16 13:47:17');
INSERT INTO `log` VALUES ('70fcbb5dd50311e994e5f8b156d274ca', '上传文档', null, 'admin', '2019-09-12 10:17:06');
INSERT INTO `log` VALUES ('71027c5ed53311e994e5f8b156d274ca', '导入excel', null, 'admin', '2019-09-12 16:00:51');
INSERT INTO `log` VALUES ('717385bfd9a911e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 08:15:47');
INSERT INTO `log` VALUES ('7196bc80d9a911e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 08:15:47');
INSERT INTO `log` VALUES ('71a7ddfcd9a911e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 08:15:48');
INSERT INTO `log` VALUES ('71c4a466dc4b11e9b510f8b156d274ca', '上传文档', null, 'admin', '2019-09-21 16:39:38');
INSERT INTO `log` VALUES ('71ecaadfddcb11e98c39f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-23 14:29:06');
INSERT INTO `log` VALUES ('721ae621ddcb11e98c39f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-23 14:29:08');
INSERT INTO `log` VALUES ('7237865eddcb11e98c39f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-23 14:29:08');
INSERT INTO `log` VALUES ('724dbb41d45e11e9bfdef8b156d274ca', '导入excel', null, 'admin', '2019-09-11 14:36:12');
INSERT INTO `log` VALUES ('7250caa7ddcb11e98c39f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-23 14:29:08');
INSERT INTO `log` VALUES ('727099b3ddcb11e98c39f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-23 14:29:08');
INSERT INTO `log` VALUES ('735fe278db4811e98ce70cc47a47def0', '更新需求', null, 'admin', '2019-09-20 09:46:33');
INSERT INTO `log` VALUES ('74014486d9d411e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-18 13:23:05');
INSERT INTO `log` VALUES ('743ce26cd9d411e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-18 13:23:04');
INSERT INTO `log` VALUES ('74691427dacc11e98ce70cc47a47def0', '更新项目', null, 'admin', '2019-09-19 18:58:57');
INSERT INTO `log` VALUES ('749e00b3d84511e9847ef8b156d274ca', '更新需求', null, 'admin', '2019-09-16 13:47:24');
INSERT INTO `log` VALUES ('74bd8d4dd9b711e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 09:56:06');
INSERT INTO `log` VALUES ('74d0c6fdd53911e994e5f8b156d274ca', '增加产品', null, 'admin', '2019-09-12 16:43:57');
INSERT INTO `log` VALUES ('75705f2ed9ac11e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 08:37:22');
INSERT INTO `log` VALUES ('757fb650d9b711e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 09:56:07');
INSERT INTO `log` VALUES ('75f788f0d4fd11e994e5f8b156d274ca', '更新产品', null, 'admin', '2019-09-12 09:34:28');
INSERT INTO `log` VALUES ('76715071d9af11e98ce70cc47a47def0', '增加项目', null, 'admin', '2019-09-18 08:58:53');
INSERT INTO `log` VALUES ('76a3845ad86011e9847ef8b156d274ca', '上传文档', null, 'admin', '2019-09-16 17:00:03');
INSERT INTO `log` VALUES ('76adb836d9ac11e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 08:37:24');
INSERT INTO `log` VALUES ('76bf0508d9a711e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 08:01:37');
INSERT INTO `log` VALUES ('771d1531d4fe11e994e5f8b156d274ca', '更新产品', null, 'admin', '2019-09-12 09:41:40');
INSERT INTO `log` VALUES ('7723afd7d9ac11e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 08:37:25');
INSERT INTO `log` VALUES ('774e557ed9ac11e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 08:37:25');
INSERT INTO `log` VALUES ('77de6f0cdb6c11e98ce70cc47a47def0', '删除需求', null, 'admin', '2019-09-20 14:04:23');
INSERT INTO `log` VALUES ('77e44aeedb6411e98ce70cc47a47def0', '增加项目', null, 'admin', '2019-09-20 13:07:07');
INSERT INTO `log` VALUES ('78144e04db6711e98ce70cc47a47def0', '添加一条分类', null, 'admin', '2019-09-20 13:28:36');
INSERT INTO `log` VALUES ('78306036d8fa11e9b556f8b156d274ca', '保存需求', null, 'admin', '2019-09-17 11:23:08');
INSERT INTO `log` VALUES ('78902c2ad9af11e98ce70cc47a47def0', '删除项目', null, 'admin', '2019-09-18 08:58:56');
INSERT INTO `log` VALUES ('78d5ee52d53c11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 17:05:32');
INSERT INTO `log` VALUES ('7911d546d9ac11e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 08:37:28');
INSERT INTO `log` VALUES ('795ce16ad52411e994e5f8b156d274ca', '添加一条分类', null, 'admin', '2019-09-12 14:13:45');
INSERT INTO `log` VALUES ('79de4ef9db4d11e98ce70cc47a47def0', '保存需求', null, 'admin', '2019-09-20 10:22:32');
INSERT INTO `log` VALUES ('7aa6e32cd90f11e9b556f8b156d274ca', '保存需求', null, 'admin', '2019-09-17 13:53:32');
INSERT INTO `log` VALUES ('7aac64b7d9b711e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 09:56:16');
INSERT INTO `log` VALUES ('7b04d29ddb4811e98ce70cc47a47def0', '更新需求', null, 'admin', '2019-09-20 09:46:46');
INSERT INTO `log` VALUES ('7bfb7fd7d50211e994e5f8b156d274ca', '导入excel', null, 'admin', '2019-09-12 10:10:23');
INSERT INTO `log` VALUES ('7c6f2b9bd55011e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 19:28:48');
INSERT INTO `log` VALUES ('7c8874ded92111e9b556f8b156d274ca', '增加产品', null, 'admin', '2019-09-17 16:02:26');
INSERT INTO `log` VALUES ('7ce9bda0d55011e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 19:28:49');
INSERT INTO `log` VALUES ('7d2cccf9dab011e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-19 15:38:12');
INSERT INTO `log` VALUES ('7d8d8e0ed52811e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 14:42:30');
INSERT INTO `log` VALUES ('7e1515d0daa611e98ce70cc47a47def0', '更新项目', null, 'admin', '2019-09-19 14:27:12');
INSERT INTO `log` VALUES ('7e4992a5d9d911e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-18 13:59:45');
INSERT INTO `log` VALUES ('7ea0c920d9d911e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-18 13:59:45');
INSERT INTO `log` VALUES ('7ede070bd91511e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 14:36:36');
INSERT INTO `log` VALUES ('7f0636d6db7e11e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-20 16:12:55');
INSERT INTO `log` VALUES ('7f67c45bd53c11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 17:05:43');
INSERT INTO `log` VALUES ('801fe965d54c11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 19:00:16');
INSERT INTO `log` VALUES ('802fea7ad4fd11e994e5f8b156d274ca', '更新产品', null, 'admin', '2019-09-12 09:34:45');
INSERT INTO `log` VALUES ('808a085cd9ac11e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 08:37:41');
INSERT INTO `log` VALUES ('8097d8cdd91411e9b556f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 14:29:30');
INSERT INTO `log` VALUES ('81594019d91411e9b556f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 14:29:31');
INSERT INTO `log` VALUES ('8184478fd8fa11e9b556f8b156d274ca', '保存需求', null, 'admin', '2019-09-17 11:23:24');
INSERT INTO `log` VALUES ('81a42f29d84511e9847ef8b156d274ca', '更新需求', null, 'admin', '2019-09-16 13:47:45');
INSERT INTO `log` VALUES ('8211bed3d45c11e9bfdef8b156d274ca', '导入excel', null, 'admin', '2019-09-11 14:22:18');
INSERT INTO `log` VALUES ('8256c104d9a911e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 08:16:16');
INSERT INTO `log` VALUES ('825b7ef1d9af11e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 08:59:13');
INSERT INTO `log` VALUES ('82e45ebbd50b11e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:15:03');
INSERT INTO `log` VALUES ('831bf299d50b11e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:15:03');
INSERT INTO `log` VALUES ('8330a97bd50b11e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:15:03');
INSERT INTO `log` VALUES ('83675738d50b11e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:15:04');
INSERT INTO `log` VALUES ('837e12cfd90f11e9b556f8b156d274ca', '保存需求', null, 'admin', '2019-09-17 13:53:47');
INSERT INTO `log` VALUES ('837f9fc0d50b11e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:15:04');
INSERT INTO `log` VALUES ('83969b7fd50b11e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:15:04');
INSERT INTO `log` VALUES ('83b0e62cd50b11e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:15:04');
INSERT INTO `log` VALUES ('83c7adb4d52811e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 14:42:40');
INSERT INTO `log` VALUES ('83c904a8d50b11e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:15:04');
INSERT INTO `log` VALUES ('84134d5cd52411e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 14:14:03');
INSERT INTO `log` VALUES ('8448f85ed9a711e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 08:02:00');
INSERT INTO `log` VALUES ('84a3dad3d45f11e9bfdef8b156d274ca', '增加产品', null, 'admin', '2019-09-11 14:43:53');
INSERT INTO `log` VALUES ('8521b9bdd53c11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 17:05:53');
INSERT INTO `log` VALUES ('8556942fd91811e9b556f8b156d274ca', '导入excel', null, 'admin', '2019-09-17 14:58:15');
INSERT INTO `log` VALUES ('856eba39d84a11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:23:39');
INSERT INTO `log` VALUES ('85a25738d84a11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:23:40');
INSERT INTO `log` VALUES ('85a3091cd53111e994e5f8b156d274ca', '添加一条分类', null, 'admin', '2019-09-12 15:47:09');
INSERT INTO `log` VALUES ('85b0c0d3d84a11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:23:40');
INSERT INTO `log` VALUES ('85d6fa8ed84a11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:23:40');
INSERT INTO `log` VALUES ('85df9b92d9d411e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 13:24:09');
INSERT INTO `log` VALUES ('85dfb91dd9d411e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 13:24:09');
INSERT INTO `log` VALUES ('85e2ccd7d9d411e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 13:24:10');
INSERT INTO `log` VALUES ('85e3ff11d9d411e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 13:24:10');
INSERT INTO `log` VALUES ('85e6a12cd9d411e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 13:24:10');
INSERT INTO `log` VALUES ('85ea0401d9d411e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 13:24:09');
INSERT INTO `log` VALUES ('85f81770d9d411e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 13:24:10');
INSERT INTO `log` VALUES ('860319bed84a11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:23:40');
INSERT INTO `log` VALUES ('860f1ca4d84a11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:23:40');
INSERT INTO `log` VALUES ('862dab08d83111e9847ef8b156d274ca', '保存需求', null, 'admin', '2019-09-16 11:24:43');
INSERT INTO `log` VALUES ('86393123d52211e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 13:59:47');
INSERT INTO `log` VALUES ('86893debd9d411e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 13:24:11');
INSERT INTO `log` VALUES ('86992bf0d9d411e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 13:24:11');
INSERT INTO `log` VALUES ('869dfa52d8f911e9b556f8b156d274ca', '保存需求', null, 'admin', '2019-09-17 11:16:23');
INSERT INTO `log` VALUES ('86d17986d84a11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:23:42');
INSERT INTO `log` VALUES ('86f35021d84a11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:23:42');
INSERT INTO `log` VALUES ('875885dfd50611e994e5f8b156d274ca', '增加产品', null, 'admin', '2019-09-12 10:39:23');
INSERT INTO `log` VALUES ('87a1badcd84a11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:23:43');
INSERT INTO `log` VALUES ('87ad3362d8ef11e9b556f8b156d274ca', '增加产品', null, 'admin', '2019-09-17 10:04:50');
INSERT INTO `log` VALUES ('87d5219fdb6811e98ce70cc47a47def0', '添加一条分类', null, 'admin', '2019-09-20 13:36:12');
INSERT INTO `log` VALUES ('887d6671d84a11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:23:44');
INSERT INTO `log` VALUES ('888c8e09d84a11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:23:44');
INSERT INTO `log` VALUES ('88f0f56fd8fa11e9b556f8b156d274ca', '保存需求', null, 'admin', '2019-09-17 11:23:36');
INSERT INTO `log` VALUES ('88fd879dd53a11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:51:40');
INSERT INTO `log` VALUES ('8917a9dcdb6711e98ce70cc47a47def0', '保存需求', null, 'admin', '2019-09-20 13:29:04');
INSERT INTO `log` VALUES ('891ff026d84a11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:23:45');
INSERT INTO `log` VALUES ('892fa444d84a11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:23:46');
INSERT INTO `log` VALUES ('899bac72d84a11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:23:46');
INSERT INTO `log` VALUES ('89aa8b28d84a11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:23:46');
INSERT INTO `log` VALUES ('8a5163c8d84a11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:23:47');
INSERT INTO `log` VALUES ('8b5eae22d85411e9847ef8b156d274ca', '增加项目', null, 'admin', '2019-09-16 15:35:24');
INSERT INTO `log` VALUES ('8c517b4dd90f11e9b556f8b156d274ca', '保存需求', null, 'admin', '2019-09-17 13:54:02');
INSERT INTO `log` VALUES ('8c6971bbd50911e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:01:00');
INSERT INTO `log` VALUES ('8cacd2bed9ac11e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 08:38:01');
INSERT INTO `log` VALUES ('8cbd4bd8d85411e9847ef8b156d274ca', '增加项目', null, 'admin', '2019-09-16 15:35:27');
INSERT INTO `log` VALUES ('8cc7d72cdb6811e98ce70cc47a47def0', '添加一条分类', null, 'admin', '2019-09-20 13:36:20');
INSERT INTO `log` VALUES ('8ceee71fd85411e9847ef8b156d274ca', '增加项目', null, 'admin', '2019-09-16 15:35:27');
INSERT INTO `log` VALUES ('8cf421aad90f11e9b556f8b156d274ca', '添加一条分类', null, 'admin', '2019-09-17 13:54:03');
INSERT INTO `log` VALUES ('8d04e3d2db5011e98ce70cc47a47def0', '保存需求', null, 'admin', '2019-09-20 10:44:32');
INSERT INTO `log` VALUES ('8d0bbf8fd85411e9847ef8b156d274ca', '增加项目', null, 'admin', '2019-09-16 15:35:27');
INSERT INTO `log` VALUES ('8d265bead85411e9847ef8b156d274ca', '增加项目', null, 'admin', '2019-09-16 15:35:27');
INSERT INTO `log` VALUES ('8d509c8ddb6411e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-20 13:07:43');
INSERT INTO `log` VALUES ('8d55e57dd50911e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:01:01');
INSERT INTO `log` VALUES ('8d8e8749d91411e9b556f8b156d274ca', '增加产品', null, 'admin', '2019-09-17 14:29:51');
INSERT INTO `log` VALUES ('8d995359d50911e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:01:02');
INSERT INTO `log` VALUES ('8e160c36d84c11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:38:13');
INSERT INTO `log` VALUES ('8e273329d50711e994e5f8b156d274ca', '上传文档', null, 'admin', '2019-09-12 10:46:02');
INSERT INTO `log` VALUES ('8e740945d9d411e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 13:24:24');
INSERT INTO `log` VALUES ('8e750085d50611e994e5f8b156d274ca', '增加产品', null, 'admin', '2019-09-12 10:39:35');
INSERT INTO `log` VALUES ('8e7e6a12d84c11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:38:13');
INSERT INTO `log` VALUES ('8ee3eea3d84c11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:38:14');
INSERT INTO `log` VALUES ('8efd503dd50911e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:01:04');
INSERT INTO `log` VALUES ('8f16d29cd50911e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:01:04');
INSERT INTO `log` VALUES ('8f26cb4dd9a911e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-18 08:16:36');
INSERT INTO `log` VALUES ('8f32b429d50911e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:01:05');
INSERT INTO `log` VALUES ('8f471792d50911e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:01:05');
INSERT INTO `log` VALUES ('8f50cc9adc4c11e9b510f8b156d274ca', '更新需求', null, 'admin', '2019-09-21 16:48:20');
INSERT INTO `log` VALUES ('8f6229e7d50911e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:01:05');
INSERT INTO `log` VALUES ('8f8a0015d9a711e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 08:02:18');
INSERT INTO `log` VALUES ('8fc44845d84f11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:59:44');
INSERT INTO `log` VALUES ('8fca6ef2daaf11e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-19 15:32:07');
INSERT INTO `log` VALUES ('8fd784cbd84f11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:59:44');
INSERT INTO `log` VALUES ('8feb9a5cd91611e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 14:44:14');
INSERT INTO `log` VALUES ('8ff75750dc4611e9b510f8b156d274ca', '上传文档', null, 'admin', '2019-09-21 16:05:20');
INSERT INTO `log` VALUES ('9041e7b9d84f11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:59:45');
INSERT INTO `log` VALUES ('909ffdb1dab611e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-19 16:22:15');
INSERT INTO `log` VALUES ('90a3e668d84f11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:59:46');
INSERT INTO `log` VALUES ('911036abdab611e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-19 16:22:16');
INSERT INTO `log` VALUES ('911f48e8d84f11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:59:46');
INSERT INTO `log` VALUES ('91315bc5d84f11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:59:46');
INSERT INTO `log` VALUES ('915e17e7d46d11e9bfdef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-11 16:24:27');
INSERT INTO `log` VALUES ('9160dad9dc4b11e9b510f8b156d274ca', '上传文档', null, 'admin', '2019-09-21 16:41:13');
INSERT INTO `log` VALUES ('917eb72bd84f11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:59:47');
INSERT INTO `log` VALUES ('919060a9d84f11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:59:47');
INSERT INTO `log` VALUES ('91bbfb84d46d11e9bfdef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-11 16:24:28');
INSERT INTO `log` VALUES ('91d9d5ccd85411e9847ef8b156d274ca', '更新项目', null, 'admin', '2019-09-16 15:35:35');
INSERT INTO `log` VALUES ('91fba158d46d11e9bfdef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-11 16:24:28');
INSERT INTO `log` VALUES ('9235a7dcd46d11e9bfdef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-11 16:24:29');
INSERT INTO `log` VALUES ('9255a729d52411e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 14:14:27');
INSERT INTO `log` VALUES ('92742206dc4c11e9b510f8b156d274ca', '更新需求', null, 'admin', '2019-09-21 16:48:25');
INSERT INTO `log` VALUES ('9281ba9bdda011e98c39f8b156d274ca', '上传文档', null, 'admin', '2019-09-23 09:20:00');
INSERT INTO `log` VALUES ('9290194edda011e98c39f8b156d274ca', '上传文档', null, 'admin', '2019-09-23 09:21:53');
INSERT INTO `log` VALUES ('9336b3f0d53311e994e5f8b156d274ca', '导入excel', null, 'admin', '2019-09-12 16:01:50');
INSERT INTO `log` VALUES ('93c53dafd54111e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 17:42:05');
INSERT INTO `log` VALUES ('93cdf8e8d84c11e9847ef8b156d274ca', '保存需求', null, 'admin', '2019-09-16 14:38:22');
INSERT INTO `log` VALUES ('95977a62d91b11e9b556f8b156d274ca', '导入excel', null, 'admin', '2019-09-17 15:20:11');
INSERT INTO `log` VALUES ('95f6a19ed53d11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 17:13:30');
INSERT INTO `log` VALUES ('9601b027d9d411e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 13:24:37');
INSERT INTO `log` VALUES ('96b0389ed50b11e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:15:36');
INSERT INTO `log` VALUES ('96f1174bd50b11e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:15:37');
INSERT INTO `log` VALUES ('970a7303d50b11e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:15:37');
INSERT INTO `log` VALUES ('97253ab4d50b11e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:15:37');
INSERT INTO `log` VALUES ('972ce4ded90f11e9b556f8b156d274ca', '保存需求', null, 'admin', '2019-09-17 13:54:20');
INSERT INTO `log` VALUES ('9755bff0d50d11e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:28:57');
INSERT INTO `log` VALUES ('9870ba85d92d11e9b4ccf8b156d274ca', '导入excel', null, 'admin', '2019-09-17 17:29:05');
INSERT INTO `log` VALUES ('98c6e9a1d4fc11e994e5f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-12 09:28:17');
INSERT INTO `log` VALUES ('98fadfe4d84f11e9847ef8b156d274ca', '导入excel', null, 'admin', '2019-09-16 14:59:59');
INSERT INTO `log` VALUES ('992f5176d4fe11e994e5f8b156d274ca', '更新产品', null, 'admin', '2019-09-12 09:42:37');
INSERT INTO `log` VALUES ('99947498db4311e98ce70cc47a47def0', '更新需求', null, 'admin', '2019-09-20 09:11:50');
INSERT INTO `log` VALUES ('99c0aad3d9d311e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 13:17:34');
INSERT INTO `log` VALUES ('9a8f6f11d84a11e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 14:24:15');
INSERT INTO `log` VALUES ('9a9a0cc1d92f11e9b4ccf8b156d274ca', '导入excel', null, 'admin', '2019-09-17 17:43:28');
INSERT INTO `log` VALUES ('9ad8b8ddd84a11e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 14:24:15');
INSERT INTO `log` VALUES ('9ad9367dd91411e9b556f8b156d274ca', '添加一条分类', null, 'admin', '2019-09-17 14:30:14');
INSERT INTO `log` VALUES ('9ade5642d4fc11e994e5f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-12 09:28:20');
INSERT INTO `log` VALUES ('9aecbf3ddb5211e98ce70cc47a47def0', '保存需求', null, 'admin', '2019-09-20 10:59:15');
INSERT INTO `log` VALUES ('9af1471bd91f11e9b556f8b156d274ca', '增加产品', null, 'admin', '2019-09-17 15:48:58');
INSERT INTO `log` VALUES ('9b32de01d84a11e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 14:24:16');
INSERT INTO `log` VALUES ('9bb0c67cd84a11e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 14:24:17');
INSERT INTO `log` VALUES ('9bcff2b0d53111e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 15:47:46');
INSERT INTO `log` VALUES ('9c11e3bfd53711e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:29:44');
INSERT INTO `log` VALUES ('9c5ed349d4fc11e994e5f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-12 09:28:23');
INSERT INTO `log` VALUES ('9c76d689db4811e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-20 09:47:42');
INSERT INTO `log` VALUES ('9cedbf68d84f11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 15:00:06');
INSERT INTO `log` VALUES ('9d675fc8d84f11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 15:00:07');
INSERT INTO `log` VALUES ('9d6db652db3911e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-20 08:00:21');
INSERT INTO `log` VALUES ('9da7add4d8f811e9b556f8b156d274ca', '保存需求', null, 'admin', '2019-09-17 11:09:52');
INSERT INTO `log` VALUES ('9dd14dead84f11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 15:00:08');
INSERT INTO `log` VALUES ('9de3bc18d84f11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 15:00:08');
INSERT INTO `log` VALUES ('9e13a26cd55511e994e5f8b156d274ca', '保存需求', null, null, '2019-09-12 20:05:32');
INSERT INTO `log` VALUES ('9e416b4fd91411e9b556f8b156d274ca', '添加一条分类', null, 'admin', '2019-09-17 14:30:19');
INSERT INTO `log` VALUES ('9e54ed65dc3e11e9b510f8b156d274ca', '保存需求', null, 'admin', '2019-09-21 15:08:32');
INSERT INTO `log` VALUES ('9e8c385dd84f11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 15:00:09');
INSERT INTO `log` VALUES ('9eedd01ed84f11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 15:00:10');
INSERT INTO `log` VALUES ('9f0a9f11d4fe11e994e5f8b156d274ca', '更新产品', null, 'admin', '2019-09-12 09:42:47');
INSERT INTO `log` VALUES ('9f26d5eadb3911e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-20 08:00:24');
INSERT INTO `log` VALUES ('9fc794bcdc1711e98ce70cc47a47def0', '上传文档', null, '123456789', '2019-09-21 10:29:25');
INSERT INTO `log` VALUES ('a011d510d46111e9bfdef8b156d274ca', '上传文档', null, 'admin', '2019-09-11 14:58:14');
INSERT INTO `log` VALUES ('a058bfd7d50211e994e5f8b156d274ca', '更新需求', null, 'admin', '2019-09-12 10:11:27');
INSERT INTO `log` VALUES ('a0753e42d91011e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 14:01:45');
INSERT INTO `log` VALUES ('a08cf249d45e11e9bfdef8b156d274ca', '上传文档', null, 'admin', '2019-09-11 14:36:50');
INSERT INTO `log` VALUES ('a09614a1db7d11e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-20 16:06:42');
INSERT INTO `log` VALUES ('a0bc3f10d4fc11e994e5f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-12 09:28:30');
INSERT INTO `log` VALUES ('a182dda2d9e811e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 15:48:06');
INSERT INTO `log` VALUES ('a1b03c93d4fc11e994e5f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-12 09:28:32');
INSERT INTO `log` VALUES ('a1b5c55dd91e11e9b556f8b156d274ca', '增加产品', null, 'admin', '2019-09-17 15:42:00');
INSERT INTO `log` VALUES ('a1f3c471d9d411e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-18 13:24:56');
INSERT INTO `log` VALUES ('a2327859d9a711e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 08:02:50');
INSERT INTO `log` VALUES ('a28744a5d4fc11e994e5f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-12 09:28:33');
INSERT INTO `log` VALUES ('a28c899cd9d311e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 13:17:49');
INSERT INTO `log` VALUES ('a2b0dd11d91511e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 14:37:36');
INSERT INTO `log` VALUES ('a32fec11d84f11e9847ef8b156d274ca', '导入excel', null, 'admin', '2019-09-16 15:00:17');
INSERT INTO `log` VALUES ('a3dcd941d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:20');
INSERT INTO `log` VALUES ('a3e13a9fdc4011e9b510f8b156d274ca', '保存需求', null, 'admin', '2019-09-21 15:19:08');
INSERT INTO `log` VALUES ('a3f54368dc3e11e9b510f8b156d274ca', '删除需求', null, 'admin', '2019-09-21 15:08:41');
INSERT INTO `log` VALUES ('a4116170d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:21');
INSERT INTO `log` VALUES ('a4216dc5d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:21');
INSERT INTO `log` VALUES ('a429febfd46611e9bfdef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-11 15:34:52');
INSERT INTO `log` VALUES ('a432d52ed92b11e9b4ccf8b156d274ca', '导入excel', null, 'admin', '2019-09-17 17:15:07');
INSERT INTO `log` VALUES ('a44256e6d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:21');
INSERT INTO `log` VALUES ('a4700e5fd50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:21');
INSERT INTO `log` VALUES ('a476ed75d4fc11e994e5f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-12 09:28:37');
INSERT INTO `log` VALUES ('a480ed8dd50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:21');
INSERT INTO `log` VALUES ('a48d90b9d53e11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 17:21:04');
INSERT INTO `log` VALUES ('a4a3ddd9d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:22');
INSERT INTO `log` VALUES ('a4cc829dd50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:22');
INSERT INTO `log` VALUES ('a4dc7da5d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:22');
INSERT INTO `log` VALUES ('a4f605ded4fc11e994e5f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-12 09:28:38');
INSERT INTO `log` VALUES ('a501eb10d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:22');
INSERT INTO `log` VALUES ('a51cbe74d55111e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 19:37:06');
INSERT INTO `log` VALUES ('a52c9117d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:22');
INSERT INTO `log` VALUES ('a53be3b3d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:23');
INSERT INTO `log` VALUES ('a565cd39d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:23');
INSERT INTO `log` VALUES ('a57b1525d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:23');
INSERT INTO `log` VALUES ('a5a5319ed50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:23');
INSERT INTO `log` VALUES ('a5b109bed9a711e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 08:02:56');
INSERT INTO `log` VALUES ('a5b74984d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:23');
INSERT INTO `log` VALUES ('a5d1299ad84f11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 15:00:21');
INSERT INTO `log` VALUES ('a5da0718d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:24');
INSERT INTO `log` VALUES ('a602bf0ed50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:24');
INSERT INTO `log` VALUES ('a60df63ed50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:24');
INSERT INTO `log` VALUES ('a62b58b4d53d11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 17:13:58');
INSERT INTO `log` VALUES ('a62dff81d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:24');
INSERT INTO `log` VALUES ('a644aef7d84f11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 15:00:22');
INSERT INTO `log` VALUES ('a65ac88cd9d411e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-18 13:25:04');
INSERT INTO `log` VALUES ('a65acf39d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:24');
INSERT INTO `log` VALUES ('a66629b4d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:25');
INSERT INTO `log` VALUES ('a68cbb4bd84f11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 15:00:22');
INSERT INTO `log` VALUES ('a69133b6d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:25');
INSERT INTO `log` VALUES ('a693f70edab411e98ce70cc47a47def0', '删除项目', null, 'admin', '2019-09-19 16:08:33');
INSERT INTO `log` VALUES ('a6a45129d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:25');
INSERT INTO `log` VALUES ('a6b27043d50011e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 09:57:18');
INSERT INTO `log` VALUES ('a6b42160d46d11e9bfdef8b156d274ca', '增加产品', null, 'admin', '2019-09-11 16:25:03');
INSERT INTO `log` VALUES ('a6d1312ad50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:25');
INSERT INTO `log` VALUES ('a7058c8ad50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:26');
INSERT INTO `log` VALUES ('a721f268d4fc11e994e5f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-12 09:28:41');
INSERT INTO `log` VALUES ('a72ec663d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:26');
INSERT INTO `log` VALUES ('a743d512d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:26');
INSERT INTO `log` VALUES ('a764299ad50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:26');
INSERT INTO `log` VALUES ('a78c36a1d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:26');
INSERT INTO `log` VALUES ('a79b25f9d4fd11e994e5f8b156d274ca', '更新产品', null, 'admin', '2019-09-12 09:35:52');
INSERT INTO `log` VALUES ('a79f03fdd50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:27');
INSERT INTO `log` VALUES ('a7a3629bd4fc11e994e5f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-12 09:28:42');
INSERT INTO `log` VALUES ('a7c0ffc0d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:27');
INSERT INTO `log` VALUES ('a7c1b1edd85411e9847ef8b156d274ca', '增加项目', null, 'admin', '2019-09-16 15:36:12');
INSERT INTO `log` VALUES ('a7c41933db4311e98ce70cc47a47def0', '更新需求', null, 'admin', '2019-09-20 09:12:14');
INSERT INTO `log` VALUES ('a8020ad0d46311e9bfdef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-11 15:13:30');
INSERT INTO `log` VALUES ('a8031307d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:27');
INSERT INTO `log` VALUES ('a82d1f64d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:28');
INSERT INTO `log` VALUES ('a8414994d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:28');
INSERT INTO `log` VALUES ('a86649dcd50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:28');
INSERT INTO `log` VALUES ('a890f0fcd50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:28');
INSERT INTO `log` VALUES ('a89a7002d50711e994e5f8b156d274ca', '更新产品', null, 'admin', '2019-09-12 10:47:28');
INSERT INTO `log` VALUES ('a8a1fea2d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:28');
INSERT INTO `log` VALUES ('a8c8eda4d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:29');
INSERT INTO `log` VALUES ('a8d9e96bd92211e9b556f8b156d274ca', '增加产品', null, 'admin', '2019-09-17 16:10:50');
INSERT INTO `log` VALUES ('a8f21dded50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:29');
INSERT INTO `log` VALUES ('a9071467d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:29');
INSERT INTO `log` VALUES ('a92a23d1d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:29');
INSERT INTO `log` VALUES ('a92d4995d91511e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 14:37:47');
INSERT INTO `log` VALUES ('a9444786d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:29');
INSERT INTO `log` VALUES ('a956eb37d4fc11e994e5f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-12 09:28:45');
INSERT INTO `log` VALUES ('a9633823d9b711e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-18 09:56:59');
INSERT INTO `log` VALUES ('a96aef73d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:30');
INSERT INTO `log` VALUES ('a96bb2d7d9b711e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-18 09:56:58');
INSERT INTO `log` VALUES ('a993a1b7d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:30');
INSERT INTO `log` VALUES ('a9a23effdab411e98ce70cc47a47def0', '删除项目', null, 'admin', '2019-09-19 16:08:38');
INSERT INTO `log` VALUES ('a9a769e6d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:30');
INSERT INTO `log` VALUES ('a9cf5753d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:30');
INSERT INTO `log` VALUES ('a9df5880d8f811e9b556f8b156d274ca', '保存需求', null, 'admin', '2019-09-17 11:10:13');
INSERT INTO `log` VALUES ('a9e641f3d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:30');
INSERT INTO `log` VALUES ('aa0da643d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:31');
INSERT INTO `log` VALUES ('aa2382add84411e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 13:41:44');
INSERT INTO `log` VALUES ('aa3674c8d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:31');
INSERT INTO `log` VALUES ('aa4389a4d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:31');
INSERT INTO `log` VALUES ('aa694d66d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:31');
INSERT INTO `log` VALUES ('aa70ed10d84411e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 13:41:44');
INSERT INTO `log` VALUES ('aa743551d84f11e9847ef8b156d274ca', '导入excel', null, 'admin', '2019-09-16 15:00:29');
INSERT INTO `log` VALUES ('aa953b75d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:32');
INSERT INTO `log` VALUES ('aaa2d505d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:32');
INSERT INTO `log` VALUES ('aaabf7fbd91411e9b556f8b156d274ca', '添加一条分类', null, 'admin', '2019-09-17 14:30:40');
INSERT INTO `log` VALUES ('aab67d36d84411e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 13:41:45');
INSERT INTO `log` VALUES ('aadf7abcd50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:32');
INSERT INTO `log` VALUES ('aadfbe9adc4911e9b510f8b156d274ca', '上传文档', null, 'admin', '2019-09-21 16:16:07');
INSERT INTO `log` VALUES ('aafb3b50d84411e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 13:41:45');
INSERT INTO `log` VALUES ('ab08bdc2d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:32');
INSERT INTO `log` VALUES ('ab1fd67cd50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:33');
INSERT INTO `log` VALUES ('ab452e53d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:33');
INSERT INTO `log` VALUES ('ab69f771d50911e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:01:52');
INSERT INTO `log` VALUES ('ab6de9a5d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:33');
INSERT INTO `log` VALUES ('ab7f6c15d84411e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 13:41:46');
INSERT INTO `log` VALUES ('ab8ed928d92f11e9b4ccf8b156d274ca', '增加产品', null, 'admin', '2019-09-17 17:43:58');
INSERT INTO `log` VALUES ('ab96a2abd50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:33');
INSERT INTO `log` VALUES ('ab9e8b07d8fc11e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 11:38:54');
INSERT INTO `log` VALUES ('aba957c9d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:33');
INSERT INTO `log` VALUES ('abab7999d54111e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 17:42:45');
INSERT INTO `log` VALUES ('abc05711d50911e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:01:53');
INSERT INTO `log` VALUES ('abcbe696d84411e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 13:41:47');
INSERT INTO `log` VALUES ('abd1e1f0d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:34');
INSERT INTO `log` VALUES ('abeca5f6d50911e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:01:53');
INSERT INTO `log` VALUES ('abf94248d50911e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:01:53');
INSERT INTO `log` VALUES ('abfafb8cd50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:34');
INSERT INTO `log` VALUES ('abfc6a4bdab411e98ce70cc47a47def0', '删除项目', null, 'admin', '2019-09-19 16:08:42');
INSERT INTO `log` VALUES ('ac077f9ad84411e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 13:41:47');
INSERT INTO `log` VALUES ('ac0bdcdfd50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:34');
INSERT INTO `log` VALUES ('ac16c303d50911e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:01:53');
INSERT INTO `log` VALUES ('ac351a6cd50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:34');
INSERT INTO `log` VALUES ('ac449b8dd84411e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 13:41:47');
INSERT INTO `log` VALUES ('ac5ce53ed50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:35');
INSERT INTO `log` VALUES ('ac6599f6d50911e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:01:54');
INSERT INTO `log` VALUES ('ac74ffdbd50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:35');
INSERT INTO `log` VALUES ('ac7bbd95d9d311e98ce70cc47a47def0', '更新产品', null, 'admin', '2019-09-18 13:18:05');
INSERT INTO `log` VALUES ('ac9b5f4dd50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:35');
INSERT INTO `log` VALUES ('acc9473dd50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:35');
INSERT INTO `log` VALUES ('acd8a24ad50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:35');
INSERT INTO `log` VALUES ('ad0eb45ed50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:36');
INSERT INTO `log` VALUES ('ad3dec61d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:36');
INSERT INTO `log` VALUES ('ad3e4dc9dab411e98ce70cc47a47def0', '删除项目', null, 'admin', '2019-09-19 16:08:44');
INSERT INTO `log` VALUES ('ad6930acd50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:36');
INSERT INTO `log` VALUES ('ad7b9998d53a11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:52:41');
INSERT INTO `log` VALUES ('ad80ec2ad50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:37');
INSERT INTO `log` VALUES ('ada1a1b5d9a711e98ce70cc47a47def0', '更新产品', null, 'admin', '2019-09-18 08:03:09');
INSERT INTO `log` VALUES ('ada999a2d91411e9b556f8b156d274ca', '添加一条分类', null, 'admin', '2019-09-17 14:30:45');
INSERT INTO `log` VALUES ('adab3ce6d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:37');
INSERT INTO `log` VALUES ('adb155ead50911e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:01:56');
INSERT INTO `log` VALUES ('add241d7d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:37');
INSERT INTO `log` VALUES ('ade0995fd45f11e9bfdef8b156d274ca', '上传文档', null, 'admin', '2019-09-11 14:44:51');
INSERT INTO `log` VALUES ('adf7459cd54111e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 17:42:49');
INSERT INTO `log` VALUES ('adfa28bcd50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:37');
INSERT INTO `log` VALUES ('ae036ed4d84411e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 13:41:50');
INSERT INTO `log` VALUES ('ae22d3c0d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:38');
INSERT INTO `log` VALUES ('ae2a33bcd84c11e9847ef8b156d274ca', '删除需求', null, 'admin', '2019-09-16 14:39:07');
INSERT INTO `log` VALUES ('ae2dfc2fd84411e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 13:41:51');
INSERT INTO `log` VALUES ('ae4b7591d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:38');
INSERT INTO `log` VALUES ('ae589662d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:38');
INSERT INTO `log` VALUES ('ae7d1437d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:38');
INSERT INTO `log` VALUES ('ae8d8eb7d84411e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 13:41:51');
INSERT INTO `log` VALUES ('aea5e746d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:38');
INSERT INTO `log` VALUES ('aeaa2f92d54111e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 17:42:50');
INSERT INTO `log` VALUES ('aeb5eba5d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:39');
INSERT INTO `log` VALUES ('aedeeadad50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:39');
INSERT INTO `log` VALUES ('aef6bdf9d84411e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 13:41:52');
INSERT INTO `log` VALUES ('af066a07d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:39');
INSERT INTO `log` VALUES ('af33d7fed50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:39');
INSERT INTO `log` VALUES ('af36b691d54111e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 17:42:51');
INSERT INTO `log` VALUES ('af3b507ed53811e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:38:25');
INSERT INTO `log` VALUES ('af4492e3d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:39');
INSERT INTO `log` VALUES ('af48295cd84411e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 13:41:52');
INSERT INTO `log` VALUES ('af520384db6f11e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-20 14:27:24');
INSERT INTO `log` VALUES ('af58c513d50911e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:01:59');
INSERT INTO `log` VALUES ('af69aad9d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:40');
INSERT INTO `log` VALUES ('af8a421ed84411e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 13:41:53');
INSERT INTO `log` VALUES ('af924628d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:40');
INSERT INTO `log` VALUES ('af9a7f6fd91511e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 14:37:58');
INSERT INTO `log` VALUES ('af9cceb1db6f11e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-20 14:27:25');
INSERT INTO `log` VALUES ('afaaad22d9a911e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-18 08:16:55');
INSERT INTO `log` VALUES ('afbaf2cdd50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:40');
INSERT INTO `log` VALUES ('afe25305d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:40');
INSERT INTO `log` VALUES ('b00b1369d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:41');
INSERT INTO `log` VALUES ('b015bc33db6f11e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-20 14:27:26');
INSERT INTO `log` VALUES ('b034ec4cd50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:41');
INSERT INTO `log` VALUES ('b045f410d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:41');
INSERT INTO `log` VALUES ('b0a24a06d50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:42');
INSERT INTO `log` VALUES ('b0aee8bad8f711e9b556f8b156d274ca', '增加产品', null, 'admin', '2019-09-17 11:03:14');
INSERT INTO `log` VALUES ('b0d1883dd50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:42');
INSERT INTO `log` VALUES ('b0f7900fd50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:42');
INSERT INTO `log` VALUES ('b11e120ad50711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 10:47:43');
INSERT INTO `log` VALUES ('b1b510aed84911e9847ef8b156d274ca', '更新项目', null, 'admin', '2019-09-16 14:17:44');
INSERT INTO `log` VALUES ('b1bf7be4d91a11e9b556f8b156d274ca', '导入excel', null, 'admin', '2019-09-17 15:13:49');
INSERT INTO `log` VALUES ('b1cc2ad7d52411e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 14:15:19');
INSERT INTO `log` VALUES ('b1dd25a6d8f811e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 11:10:26');
INSERT INTO `log` VALUES ('b2528224daad11e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-19 15:18:46');
INSERT INTO `log` VALUES ('b28f74a8d84411e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 13:41:58');
INSERT INTO `log` VALUES ('b29c8598d92d11e9b4ccf8b156d274ca', '添加一条分类', null, 'admin', '2019-09-17 17:29:51');
INSERT INTO `log` VALUES ('b2a292b0dab611e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-19 16:23:12');
INSERT INTO `log` VALUES ('b2b35572db7411e98ce70cc47a47def0', '更新产品', null, 'admin', '2019-09-20 15:03:18');
INSERT INTO `log` VALUES ('b2c213d5dab611e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-19 16:23:12');
INSERT INTO `log` VALUES ('b2cc52c2d84411e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 13:41:58');
INSERT INTO `log` VALUES ('b2f8fde9d84411e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 13:41:59');
INSERT INTO `log` VALUES ('b3003cbcdb4311e98ce70cc47a47def0', '更新需求', null, 'admin', '2019-09-20 09:12:32');
INSERT INTO `log` VALUES ('b30fdf48d52811e994e5f8b156d274ca', '更新需求', null, 'admin', '2019-09-12 14:44:00');
INSERT INTO `log` VALUES ('b32a95f7d84411e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 13:41:59');
INSERT INTO `log` VALUES ('b33a3e0ad54111e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 17:42:57');
INSERT INTO `log` VALUES ('b35f9819d8f711e9b556f8b156d274ca', '增加产品', null, 'admin', '2019-09-17 11:03:19');
INSERT INTO `log` VALUES ('b366bf3dd91011e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 14:02:17');
INSERT INTO `log` VALUES ('b37a1f06daa211e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-19 14:00:03');
INSERT INTO `log` VALUES ('b4a03d28d54111e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 17:43:00');
INSERT INTO `log` VALUES ('b4b2df28db6811e98ce70cc47a47def0', '保存需求', null, 'admin', '2019-09-20 13:37:27');
INSERT INTO `log` VALUES ('b4f46303d92f11e9b4ccf8b156d274ca', '导入excel', null, 'admin', '2019-09-17 17:44:13');
INSERT INTO `log` VALUES ('b50d4c99d91f11e9b556f8b156d274ca', '增加产品', null, 'admin', '2019-09-17 15:49:42');
INSERT INTO `log` VALUES ('b52ae94cd55611e994e5f8b156d274ca', '保存需求', null, null, '2019-09-12 20:10:22');
INSERT INTO `log` VALUES ('b5324578dd9f11e98c39f8b156d274ca', '导入excel', null, 'admin', '2019-09-23 09:16:00');
INSERT INTO `log` VALUES ('b57fe63bd91411e9b556f8b156d274ca', '添加一条分类', null, 'admin', '2019-09-17 14:30:58');
INSERT INTO `log` VALUES ('b5bef6a6d85b11e9847ef8b156d274ca', '增加项目', null, 'admin', '2019-09-16 16:26:42');
INSERT INTO `log` VALUES ('b5cfe2efd91711e9b556f8b156d274ca', '增加产品', null, 'admin', '2019-09-17 14:52:27');
INSERT INTO `log` VALUES ('b62d31c6d90e11e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 13:48:02');
INSERT INTO `log` VALUES ('b634c27edb8011e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-20 16:29:05');
INSERT INTO `log` VALUES ('b64f0b89db8011e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-20 16:28:21');
INSERT INTO `log` VALUES ('b65b985dd91f11e9b556f8b156d274ca', '增加产品', null, 'admin', '2019-09-17 15:49:44');
INSERT INTO `log` VALUES ('b6a351efd84411e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 13:42:05');
INSERT INTO `log` VALUES ('b6dda980d4fc11e994e5f8b156d274ca', '增加产品', null, 'admin', '2019-09-12 09:29:08');
INSERT INTO `log` VALUES ('b6e2b905d84411e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 13:42:05');
INSERT INTO `log` VALUES ('b7712d69d54311e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 17:57:24');
INSERT INTO `log` VALUES ('b7d0a24ddc3411e98ce70cc47a47def0', '删除需求', null, '123456789', '2019-09-21 13:57:50');
INSERT INTO `log` VALUES ('b8cf4672d84a11e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 14:25:05');
INSERT INTO `log` VALUES ('b905f8d7d84a11e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 14:25:06');
INSERT INTO `log` VALUES ('b93906eed9aa11e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 08:24:56');
INSERT INTO `log` VALUES ('b94a70e4d91011e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 14:02:27');
INSERT INTO `log` VALUES ('b9524cc1d84a11e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 14:25:06');
INSERT INTO `log` VALUES ('b9828ccfd84a11e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 14:25:07');
INSERT INTO `log` VALUES ('b9e47272d84a11e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 14:25:07');
INSERT INTO `log` VALUES ('b9fde419d92d11e9b4ccf8b156d274ca', '保存需求', null, 'admin', '2019-09-17 17:30:03');
INSERT INTO `log` VALUES ('ba193e9fd84a11e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 14:25:08');
INSERT INTO `log` VALUES ('ba4979bbd91411e9b556f8b156d274ca', '添加一条分类', null, 'admin', '2019-09-17 14:31:07');
INSERT INTO `log` VALUES ('ba7baafed84a11e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 14:25:08');
INSERT INTO `log` VALUES ('baafd132d84a11e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 14:25:09');
INSERT INTO `log` VALUES ('bac93ce5dc4c11e9b510f8b156d274ca', '增加产品', null, 'admin', '2019-09-21 16:49:33');
INSERT INTO `log` VALUES ('baf46fa3d84a11e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 14:25:09');
INSERT INTO `log` VALUES ('bb415176d50611e994e5f8b156d274ca', '导入excel', null, 'admin', '2019-09-12 10:40:49');
INSERT INTO `log` VALUES ('bb517d24d9e811e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 15:48:50');
INSERT INTO `log` VALUES ('bb6c5047d84a11e9847ef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-16 14:25:10');
INSERT INTO `log` VALUES ('bb8b346ddc3411e98ce70cc47a47def0', '删除需求', null, '123456789', '2019-09-21 13:57:56');
INSERT INTO `log` VALUES ('bc280243dab111e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-19 15:46:45');
INSERT INTO `log` VALUES ('bc6ff501d53811e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:38:47');
INSERT INTO `log` VALUES ('bc8e618ddaaf11e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-19 15:33:22');
INSERT INTO `log` VALUES ('bcad20a1d53911e994e5f8b156d274ca', '添加一条分类', null, 'admin', '2019-09-12 16:45:57');
INSERT INTO `log` VALUES ('bd40210ed83111e9847ef8b156d274ca', '删除项目', null, 'admin', '2019-09-16 11:26:15');
INSERT INTO `log` VALUES ('bd50ea03dabd11e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-19 17:13:37');
INSERT INTO `log` VALUES ('bdc7cf1fd91011e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 14:02:34');
INSERT INTO `log` VALUES ('bddb77f9d8f811e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 11:10:46');
INSERT INTO `log` VALUES ('bde2e510dc3411e98ce70cc47a47def0', '删除需求', null, '123456789', '2019-09-21 13:58:00');
INSERT INTO `log` VALUES ('bde76119d84911e9847ef8b156d274ca', '更新项目', null, 'admin', '2019-09-16 14:18:04');
INSERT INTO `log` VALUES ('bdee0c24d53e11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 17:21:47');
INSERT INTO `log` VALUES ('be3d2fe3d54b11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 18:54:51');
INSERT INTO `log` VALUES ('bf9d1c5ed92a11e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 17:08:44');
INSERT INTO `log` VALUES ('bfa3d6e3dabb11e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-19 16:59:22');
INSERT INTO `log` VALUES ('bfb9c9dbdab411e98ce70cc47a47def0', '增加项目', null, 'admin', '2019-09-19 16:09:15');
INSERT INTO `log` VALUES ('bfdd66d9d91711e9b556f8b156d274ca', '增加产品', null, 'admin', '2019-09-17 14:52:44');
INSERT INTO `log` VALUES ('bff19a1fd9e811e98ce70cc47a47def0', '更新产品', null, 'admin', '2019-09-18 15:48:57');
INSERT INTO `log` VALUES ('c0204e38d46511e9bfdef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-11 15:28:30');
INSERT INTO `log` VALUES ('c05c3e39dc1711e98ce70cc47a47def0', '上传文档', null, '123456789', '2019-09-21 10:29:48');
INSERT INTO `log` VALUES ('c09cce1fd92a11e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 17:08:46');
INSERT INTO `log` VALUES ('c0f906cad54311e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 17:57:40');
INSERT INTO `log` VALUES ('c10a510adc3411e98ce70cc47a47def0', '删除需求', null, '123456789', '2019-09-21 13:58:06');
INSERT INTO `log` VALUES ('c1418166d53911e994e5f8b156d274ca', '添加一条分类', null, 'admin', '2019-09-12 16:46:05');
INSERT INTO `log` VALUES ('c1615766db7e11e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-20 16:14:48');
INSERT INTO `log` VALUES ('c1c1f461d50911e994e5f8b156d274ca', '更新需求', null, 'admin', '2019-09-12 11:02:29');
INSERT INTO `log` VALUES ('c1d77e80dc1611e98ce70cc47a47def0', '上传文档', null, '123456789', '2019-09-21 10:23:22');
INSERT INTO `log` VALUES ('c1f4abe0d8ef11e9b556f8b156d274ca', '增加产品', null, 'admin', '2019-09-17 10:06:28');
INSERT INTO `log` VALUES ('c22df164db5211e98ce70cc47a47def0', '添加一条分类', null, 'admin', '2019-09-20 11:00:20');
INSERT INTO `log` VALUES ('c2c01f1bdc4c11e9b510f8b156d274ca', '增加产品', null, 'admin', '2019-09-21 16:49:46');
INSERT INTO `log` VALUES ('c2dc6e73dc3f11e9b510f8b156d274ca', '保存需求', null, 'admin', '2019-09-21 15:16:42');
INSERT INTO `log` VALUES ('c311843cd8ef11e9b556f8b156d274ca', '增加产品', null, 'admin', '2019-09-17 10:06:29');
INSERT INTO `log` VALUES ('c316bee8d90f11e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 13:55:34');
INSERT INTO `log` VALUES ('c335a7d8d4fc11e994e5f8b156d274ca', '增加产品', null, 'admin', '2019-09-12 09:29:28');
INSERT INTO `log` VALUES ('c33ae3b7db4311e98ce70cc47a47def0', '更新需求', null, 'admin', '2019-09-20 09:13:00');
INSERT INTO `log` VALUES ('c3a39bdad50011e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 09:58:07');
INSERT INTO `log` VALUES ('c3b6a48dd45c11e9bfdef8b156d274ca', '上传文档', null, 'admin', '2019-09-11 14:23:24');
INSERT INTO `log` VALUES ('c4002d80db5111e98ce70cc47a47def0', '保存需求', null, 'admin', '2019-09-20 10:53:14');
INSERT INTO `log` VALUES ('c42c9fded91811e9b556f8b156d274ca', '添加一条分类', null, 'admin', '2019-09-17 15:00:01');
INSERT INTO `log` VALUES ('c43c8cc6daa011e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-19 13:46:12');
INSERT INTO `log` VALUES ('c46b5f3fd9ae11e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 08:53:54');
INSERT INTO `log` VALUES ('c4936095d91011e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 14:02:46');
INSERT INTO `log` VALUES ('c4a576a9d82c11e9847ef8b156d274ca', '更新项目', null, 'admin', '2019-09-16 10:50:40');
INSERT INTO `log` VALUES ('c4dce853d8f711e9b556f8b156d274ca', '添加一条分类', null, 'admin', '2019-09-17 11:03:48');
INSERT INTO `log` VALUES ('c5117877d9a711e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 08:03:48');
INSERT INTO `log` VALUES ('c577e912d53911e994e5f8b156d274ca', '添加一条分类', null, 'admin', '2019-09-12 16:46:12');
INSERT INTO `log` VALUES ('c58b00c8d46511e9bfdef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-11 15:28:39');
INSERT INTO `log` VALUES ('c5b0816dd53811e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:39:03');
INSERT INTO `log` VALUES ('c5df2e90d53a11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:53:22');
INSERT INTO `log` VALUES ('c5f15630d8ef11e9b556f8b156d274ca', '增加产品', null, 'admin', '2019-09-17 10:06:34');
INSERT INTO `log` VALUES ('c60837a8db4211e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-20 09:05:55');
INSERT INTO `log` VALUES ('c61529d5d92211e9b556f8b156d274ca', '增加产品', null, 'admin', '2019-09-17 16:11:39');
INSERT INTO `log` VALUES ('c620a5f9d9ae11e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 08:53:57');
INSERT INTO `log` VALUES ('c62603d6d52e11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 15:27:29');
INSERT INTO `log` VALUES ('c655de10d91411e9b556f8b156d274ca', '保存需求', null, 'admin', '2019-09-17 14:31:27');
INSERT INTO `log` VALUES ('c672e1f2db3e11e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-20 08:36:42');
INSERT INTO `log` VALUES ('c69b8b8bd91e11e9b556f8b156d274ca', '增加产品', null, 'admin', '2019-09-17 15:43:02');
INSERT INTO `log` VALUES ('c6f98a1adab411e98ce70cc47a47def0', '增加项目', null, 'admin', '2019-09-19 16:09:27');
INSERT INTO `log` VALUES ('c70fa3a4d46411e9bfdef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-11 15:21:32');
INSERT INTO `log` VALUES ('c7485eddd52611e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 14:29:10');
INSERT INTO `log` VALUES ('c74e6006d50b11e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:16:58');
INSERT INTO `log` VALUES ('c74ee7bad52611e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 14:30:14');
INSERT INTO `log` VALUES ('c7582acad52611e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 14:30:15');
INSERT INTO `log` VALUES ('c7800a66d9a711e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 08:03:52');
INSERT INTO `log` VALUES ('c7b0e169dd9e11e98c39f8b156d274ca', '上传文档', null, 'admin', '2019-09-23 09:09:20');
INSERT INTO `log` VALUES ('c7df18f0d90f11e9b556f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-17 13:55:42');
INSERT INTO `log` VALUES ('c80f015bd9e811e98ce70cc47a47def0', '更新产品', null, 'admin', '2019-09-18 15:49:11');
INSERT INTO `log` VALUES ('c8154c29d54311e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 17:57:51');
INSERT INTO `log` VALUES ('c81ca8bcd9a711e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 08:03:54');
INSERT INTO `log` VALUES ('c8387b78d90f11e9b556f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-17 13:55:42');
INSERT INTO `log` VALUES ('c855248bd91811e9b556f8b156d274ca', '添加一条分类', null, 'admin', '2019-09-17 15:00:08');
INSERT INTO `log` VALUES ('c86717e8d90f11e9b556f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-17 13:55:43');
INSERT INTO `log` VALUES ('c8f963addabb11e98ce70cc47a47def0', '更新产品', null, 'admin', '2019-09-19 16:59:37');
INSERT INTO `log` VALUES ('c93d5754d8fc11e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 11:39:43');
INSERT INTO `log` VALUES ('c95cc212db6811e98ce70cc47a47def0', '保存需求', null, 'admin', '2019-09-20 13:38:02');
INSERT INTO `log` VALUES ('c96cf626d53911e994e5f8b156d274ca', '添加一条分类', null, 'admin', '2019-09-12 16:46:19');
INSERT INTO `log` VALUES ('c97fb251d50911e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:02:42');
INSERT INTO `log` VALUES ('c997ffb2d9a711e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 08:03:56');
INSERT INTO `log` VALUES ('c9b01d8ddc1611e98ce70cc47a47def0', '上传文档', null, '123456789', '2019-09-21 10:23:35');
INSERT INTO `log` VALUES ('c9e0d2dad50911e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:02:43');
INSERT INTO `log` VALUES ('c9e3500dd91711e9b556f8b156d274ca', '增加产品', null, 'admin', '2019-09-17 14:53:01');
INSERT INTO `log` VALUES ('c9ed5400d8f711e9b556f8b156d274ca', '添加一条分类', null, 'admin', '2019-09-17 11:03:57');
INSERT INTO `log` VALUES ('ca009356d50911e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:02:43');
INSERT INTO `log` VALUES ('ca0b377cd8f911e9b556f8b156d274ca', '保存需求', null, 'admin', '2019-09-17 11:18:16');
INSERT INTO `log` VALUES ('ca19115bd50911e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:02:43');
INSERT INTO `log` VALUES ('ca3073c9d50f11e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:45:40');
INSERT INTO `log` VALUES ('ca44ba36d8fc11e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 11:39:45');
INSERT INTO `log` VALUES ('ca730b1ed91f11e9b556f8b156d274ca', '增加产品', null, 'admin', '2019-09-17 15:50:18');
INSERT INTO `log` VALUES ('cb0e1eaeddf711e98c39f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-23 19:46:35');
INSERT INTO `log` VALUES ('cb359e0bddf711e98c39f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-23 19:46:35');
INSERT INTO `log` VALUES ('cb620946d50911e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:02:46');
INSERT INTO `log` VALUES ('cb6e4566ddf711e98c39f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-23 19:46:36');
INSERT INTO `log` VALUES ('cb6fbb8addf711e98c39f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-23 19:46:36');
INSERT INTO `log` VALUES ('cb83a9a5d85211e9847ef8b156d274ca', '更新项目', null, 'admin', '2019-09-16 15:22:53');
INSERT INTO `log` VALUES ('cbb24d18d54111e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 17:43:39');
INSERT INTO `log` VALUES ('cc127fe9d91711e9b556f8b156d274ca', '增加产品', null, 'admin', '2019-09-17 14:53:05');
INSERT INTO `log` VALUES ('cc5e2434db5211e98ce70cc47a47def0', '保存需求', null, 'admin', '2019-09-20 11:00:38');
INSERT INTO `log` VALUES ('cca98ffed9d411e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-18 13:25:33');
INSERT INTO `log` VALUES ('ccaf4d1ad9d411e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-18 13:25:35');
INSERT INTO `log` VALUES ('ccb3688adaa311e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-19 14:07:55');
INSERT INTO `log` VALUES ('ccca69e2d52411e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 14:16:05');
INSERT INTO `log` VALUES ('cd315a61dc3f11e9b510f8b156d274ca', '删除需求', null, 'admin', '2019-09-21 15:17:00');
INSERT INTO `log` VALUES ('cd4233ffd9a611e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 07:56:53');
INSERT INTO `log` VALUES ('cd443baddc3411e98ce70cc47a47def0', '保存需求', null, '123456789', '2019-09-21 13:58:26');
INSERT INTO `log` VALUES ('cd5546a3d50011e994e5f8b156d274ca', '更新项目', null, 'admin', '2019-09-12 09:58:23');
INSERT INTO `log` VALUES ('cdb486f6d92b11e9b4ccf8b156d274ca', '导入excel', null, 'admin', '2019-09-17 17:16:17');
INSERT INTO `log` VALUES ('cdd08a25d91411e9b556f8b156d274ca', '保存需求', null, 'admin', '2019-09-17 14:31:39');
INSERT INTO `log` VALUES ('ce24c4aad54111e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 17:43:43');
INSERT INTO `log` VALUES ('ce49f239d8f711e9b556f8b156d274ca', '添加一条分类', null, 'admin', '2019-09-17 11:04:04');
INSERT INTO `log` VALUES ('ce6201e3d9dc11e98ce70cc47a47def0', '保存需求', null, 'admin', '2019-09-18 14:23:28');
INSERT INTO `log` VALUES ('ce69349cd92d11e9b4ccf8b156d274ca', '导入excel', null, 'admin', '2019-09-17 17:30:37');
INSERT INTO `log` VALUES ('ce769453d85411e9847ef8b156d274ca', '更新项目', null, 'admin', '2019-09-16 15:37:17');
INSERT INTO `log` VALUES ('ce8dd00ed50011e994e5f8b156d274ca', '更新项目', null, 'admin', '2019-09-12 09:58:25');
INSERT INTO `log` VALUES ('ce8f5632d53811e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:39:18');
INSERT INTO `log` VALUES ('cea72d59dc4b11e9b510f8b156d274ca', '上传文档', null, 'admin', '2019-09-21 16:42:19');
INSERT INTO `log` VALUES ('cedc0e4ddb4a11e98ce70cc47a47def0', '保存需求', null, 'admin', '2019-09-20 10:03:26');
INSERT INTO `log` VALUES ('cef003a0d50011e994e5f8b156d274ca', '更新项目', null, 'admin', '2019-09-12 09:58:26');
INSERT INTO `log` VALUES ('cf19b13bd50011e994e5f8b156d274ca', '更新项目', null, 'admin', '2019-09-12 09:58:26');
INSERT INTO `log` VALUES ('cf3f1d6cd50011e994e5f8b156d274ca', '更新项目', null, 'admin', '2019-09-12 09:58:27');
INSERT INTO `log` VALUES ('cf5c3bccd50011e994e5f8b156d274ca', '更新项目', null, 'admin', '2019-09-12 09:58:27');
INSERT INTO `log` VALUES ('cf66ac82d46511e9bfdef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-11 15:28:55');
INSERT INTO `log` VALUES ('cfacdc25d53a11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:53:39');
INSERT INTO `log` VALUES ('cfd2ac6fd8f811e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 11:11:16');
INSERT INTO `log` VALUES ('cfd5f801d52e11e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 15:27:45');
INSERT INTO `log` VALUES ('d00d50a4d8fc11e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 11:39:55');
INSERT INTO `log` VALUES ('d04c7f62dc3f11e9b510f8b156d274ca', '删除需求', null, 'admin', '2019-09-21 15:17:05');
INSERT INTO `log` VALUES ('d17f6270db6611e98ce70cc47a47def0', '添加一条分类', null, 'admin', '2019-09-20 13:23:56');
INSERT INTO `log` VALUES ('d1b5756dd8f711e9b556f8b156d274ca', '添加一条分类', null, 'admin', '2019-09-17 11:04:10');
INSERT INTO `log` VALUES ('d2331c0ddc3611e98ce70cc47a47def0', '删除需求', null, '123456789', '2019-09-21 14:12:53');
INSERT INTO `log` VALUES ('d24575dfd91811e9b556f8b156d274ca', '保存需求', null, 'admin', '2019-09-17 15:00:25');
INSERT INTO `log` VALUES ('d26becf7d53511e994e5f8b156d274ca', '添加一条分类', null, 'admin', '2019-09-12 16:17:56');
INSERT INTO `log` VALUES ('d2a24d2bd92111e9b556f8b156d274ca', '增加产品', null, 'admin', '2019-09-17 16:04:51');
INSERT INTO `log` VALUES ('d2c8a992d94411e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 20:15:23');
INSERT INTO `log` VALUES ('d2e13082d9d911e98ce70cc47a47def0', '保存需求', null, 'admin', '2019-09-18 14:02:07');
INSERT INTO `log` VALUES ('d310b6a0dab611e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-19 16:24:07');
INSERT INTO `log` VALUES ('d31c776dd53b11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 17:00:54');
INSERT INTO `log` VALUES ('d34b67fed94411e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 20:15:24');
INSERT INTO `log` VALUES ('d34eefa1d54311e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 17:58:10');
INSERT INTO `log` VALUES ('d37f7786d91011e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 14:03:11');
INSERT INTO `log` VALUES ('d39b08a0d9aa11e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 08:25:41');
INSERT INTO `log` VALUES ('d3fbb13dd53b11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 17:00:55');
INSERT INTO `log` VALUES ('d427813fd50411e994e5f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-12 10:27:13');
INSERT INTO `log` VALUES ('d42971c2d50011e994e5f8b156d274ca', '更新项目', null, 'admin', '2019-09-12 09:58:35');
INSERT INTO `log` VALUES ('d46c66c4d9a911e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-18 08:17:59');
INSERT INTO `log` VALUES ('d485764fd90f11e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 13:56:03');
INSERT INTO `log` VALUES ('d4f3aa1ad91511e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 14:39:01');
INSERT INTO `log` VALUES ('d569f6e0d94411e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 20:15:28');
INSERT INTO `log` VALUES ('d5829778d82c11e9847ef8b156d274ca', '更新项目', null, 'admin', '2019-09-16 10:51:08');
INSERT INTO `log` VALUES ('d5fbbf66d46311e9bfdef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-11 15:14:47');
INSERT INTO `log` VALUES ('d62445bad50d11e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:31:08');
INSERT INTO `log` VALUES ('d67053a2d9aa11e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-18 08:25:46');
INSERT INTO `log` VALUES ('d6d7f684d9aa11e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-18 08:25:47');
INSERT INTO `log` VALUES ('d7063930d9aa11e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-18 08:25:47');
INSERT INTO `log` VALUES ('d7346ebfd54b11e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 18:55:33');
INSERT INTO `log` VALUES ('d7607b5bd9aa11e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-18 08:25:48');
INSERT INTO `log` VALUES ('d7ad68d1d92111e9b556f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-17 16:04:59');
INSERT INTO `log` VALUES ('d7b1956fd9aa11e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-18 08:25:48');
INSERT INTO `log` VALUES ('d8175ab2d92111e9b556f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-17 16:05:00');
INSERT INTO `log` VALUES ('d85d2a8ad91411e9b556f8b156d274ca', '保存需求', null, 'admin', '2019-09-17 14:31:57');
INSERT INTO `log` VALUES ('d89329b6d94411e9b4ccf8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-17 20:15:33');
INSERT INTO `log` VALUES ('d8c72c55d9a711e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 08:04:22');
INSERT INTO `log` VALUES ('d8fb0f1cd54b11e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 18:55:36');
INSERT INTO `log` VALUES ('d9044d0cd91011e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 14:03:20');
INSERT INTO `log` VALUES ('da0e44a6dc4911e9b510f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-21 16:28:57');
INSERT INTO `log` VALUES ('da114f37dc4911e9b510f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-21 16:28:56');
INSERT INTO `log` VALUES ('da29a9aedc4911e9b510f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-21 16:28:57');
INSERT INTO `log` VALUES ('da583bb7d53311e994e5f8b156d274ca', '上传文档', null, 'admin', '2019-09-12 16:03:04');
INSERT INTO `log` VALUES ('da58ce9ddc4911e9b510f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-21 16:28:57');
INSERT INTO `log` VALUES ('da757cebdc4911e9b510f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-21 16:28:57');
INSERT INTO `log` VALUES ('da7e6c80dc4911e9b510f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-21 16:28:57');
INSERT INTO `log` VALUES ('dab7ac01d9aa11e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 08:25:53');
INSERT INTO `log` VALUES ('dafb8a13d8f911e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 11:18:44');
INSERT INTO `log` VALUES ('daff687cd9d911e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-18 14:02:20');
INSERT INTO `log` VALUES ('db280cf1d9d911e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-18 14:02:21');
INSERT INTO `log` VALUES ('db3dab56dc3f11e9b510f8b156d274ca', '保存需求', null, 'admin', '2019-09-21 15:17:23');
INSERT INTO `log` VALUES ('db4519f5d9d911e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-18 14:02:21');
INSERT INTO `log` VALUES ('db7b41bfd91611e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 14:46:21');
INSERT INTO `log` VALUES ('db9aca37d9d911e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-18 14:02:21');
INSERT INTO `log` VALUES ('dbd3d3c2d9d911e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-18 14:02:22');
INSERT INTO `log` VALUES ('dbe7902ddc3611e98ce70cc47a47def0', '保存需求', null, '123456789', '2019-09-21 14:13:10');
INSERT INTO `log` VALUES ('dc1836b9d9d911e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-18 14:02:22');
INSERT INTO `log` VALUES ('dc59fcd1d9d911e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-18 14:02:22');
INSERT INTO `log` VALUES ('dc6ad81cd9d911e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-18 14:02:23');
INSERT INTO `log` VALUES ('dc9bc793d9d911e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-18 14:02:23');
INSERT INTO `log` VALUES ('dca6642bd52f11e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 15:35:16');
INSERT INTO `log` VALUES ('dcddd280d53511e994e5f8b156d274ca', '添加一条分类', null, 'admin', '2019-09-12 16:18:13');
INSERT INTO `log` VALUES ('dd3e22f4d50711e994e5f8b156d274ca', '上传文档', null, 'admin', '2019-09-12 10:48:17');
INSERT INTO `log` VALUES ('dd419c58d91711e9b556f8b156d274ca', '导入excel', null, 'admin', '2019-09-17 14:53:33');
INSERT INTO `log` VALUES ('dda5d3aad82c11e9847ef8b156d274ca', '更新项目', null, 'admin', '2019-09-16 10:51:22');
INSERT INTO `log` VALUES ('ddb1421dd45d11e9bfdef8b156d274ca', '导入excel', null, 'admin', '2019-09-11 14:32:01');
INSERT INTO `log` VALUES ('de136ed4d54311e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 17:58:28');
INSERT INTO `log` VALUES ('de245f8ad4f811e994e5f8b156d274ca', '更新需求', null, 'admin', '2019-09-12 09:01:35');
INSERT INTO `log` VALUES ('de6a5ebdd9dc11e98ce70cc47a47def0', '保存需求', null, 'admin', '2019-09-18 14:23:55');
INSERT INTO `log` VALUES ('debbc05ed46511e9bfdef8b156d274ca', '增加产品', null, 'admin', '2019-09-11 15:29:21');
INSERT INTO `log` VALUES ('dfc11d10d50011e994e5f8b156d274ca', '更新项目', null, 'admin', '2019-09-12 09:58:54');
INSERT INTO `log` VALUES ('e0127e1dd48011e9bfdef8b156d274ca', '增加产品', null, 'admin', '2019-09-11 18:42:40');
INSERT INTO `log` VALUES ('e0499743d91411e9b556f8b156d274ca', '保存需求', null, 'admin', '2019-09-17 14:32:10');
INSERT INTO `log` VALUES ('e0b7c329d50011e994e5f8b156d274ca', '更新项目', null, 'admin', '2019-09-12 09:58:56');
INSERT INTO `log` VALUES ('e0c71f05d9ab11e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 08:33:13');
INSERT INTO `log` VALUES ('e0e796b3d92c11e9b4ccf8b156d274ca', '导入excel', null, 'admin', '2019-09-17 17:23:59');
INSERT INTO `log` VALUES ('e0ebb872d91f11e9b556f8b156d274ca', '增加产品', null, 'admin', '2019-09-17 15:50:56');
INSERT INTO `log` VALUES ('e11d7015dc3611e98ce70cc47a47def0', '删除需求', null, '123456789', '2019-09-21 14:13:19');
INSERT INTO `log` VALUES ('e133cb01dc1711e98ce70cc47a47def0', '上传文档', null, '123456789', '2019-09-21 10:30:53');
INSERT INTO `log` VALUES ('e145354eda9d11e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-19 13:25:33');
INSERT INTO `log` VALUES ('e1561c76daa211e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-19 14:01:21');
INSERT INTO `log` VALUES ('e19ca6f0db5211e98ce70cc47a47def0', '保存需求', null, 'admin', '2019-09-20 11:01:13');
INSERT INTO `log` VALUES ('e1cb831edaa211e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-19 14:01:21');
INSERT INTO `log` VALUES ('e1ec2087daa311e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-19 14:08:31');
INSERT INTO `log` VALUES ('e21cdf85daa211e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-19 14:01:22');
INSERT INTO `log` VALUES ('e25e8408d9a711e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 08:04:38');
INSERT INTO `log` VALUES ('e26af2fedaa211e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-19 14:01:22');
INSERT INTO `log` VALUES ('e2ba2922daa211e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-19 14:01:23');
INSERT INTO `log` VALUES ('e31f6764db7c11e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-20 16:01:44');
INSERT INTO `log` VALUES ('e32456d5dc4c11e9b510f8b156d274ca', '导入excel', null, 'admin', '2019-09-21 16:50:40');
INSERT INTO `log` VALUES ('e34a42b3daa211e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-19 14:01:24');
INSERT INTO `log` VALUES ('e3ba1bcdd84a11e9847ef8b156d274ca', '上传文档', null, 'admin', '2019-09-16 14:25:55');
INSERT INTO `log` VALUES ('e43af0addc4911e9b510f8b156d274ca', '增加产品', null, 'admin', '2019-09-21 16:29:13');
INSERT INTO `log` VALUES ('e44f59dfd52211e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 14:02:25');
INSERT INTO `log` VALUES ('e453916ed50211e994e5f8b156d274ca', '增加产品', null, 'admin', '2019-09-12 10:13:21');
INSERT INTO `log` VALUES ('e4afe25cdaa211e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-19 14:01:26');
INSERT INTO `log` VALUES ('e4dc989ddaa211e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-19 14:01:26');
INSERT INTO `log` VALUES ('e4e3bbf9d54311e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 17:58:40');
INSERT INTO `log` VALUES ('e55120fdd83111e9847ef8b156d274ca', '更新需求', null, 'admin', '2019-09-16 11:27:22');
INSERT INTO `log` VALUES ('e5a657a3dc3f11e9b510f8b156d274ca', '删除需求', null, 'admin', '2019-09-21 15:17:41');
INSERT INTO `log` VALUES ('e5c02a18d4fc11e994e5f8b156d274ca', '增加产品', null, 'admin', '2019-09-12 09:30:26');
INSERT INTO `log` VALUES ('e5cc9ecfd92211e9b556f8b156d274ca', '增加产品', null, 'admin', '2019-09-17 16:12:33');
INSERT INTO `log` VALUES ('e65a5680db7f11e98ce70cc47a47def0', '更新横向需求矩阵', null, 'admin', '2019-09-20 16:23:29');
INSERT INTO `log` VALUES ('e6e691a2d82c11e9847ef8b156d274ca', '更新项目', null, 'admin', '2019-09-16 10:51:38');
INSERT INTO `log` VALUES ('e70ad575d52f11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 15:35:33');
INSERT INTO `log` VALUES ('e7844d8ed91411e9b556f8b156d274ca', '保存需求', null, 'admin', '2019-09-17 14:32:22');
INSERT INTO `log` VALUES ('e820b4a7d53711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 16:32:51');
INSERT INTO `log` VALUES ('e83747b0d46311e9bfdef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-11 15:15:18');
INSERT INTO `log` VALUES ('e8b8e5e0db6611e98ce70cc47a47def0', '保存需求', null, 'admin', '2019-09-20 13:24:35');
INSERT INTO `log` VALUES ('e975f47ed46d11e9bfdef8b156d274ca', '增加产品', null, 'admin', '2019-09-11 16:26:55');
INSERT INTO `log` VALUES ('ea52d84cd9d311e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-18 13:19:13');
INSERT INTO `log` VALUES ('ea90b4c3d50a11e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:10:47');
INSERT INTO `log` VALUES ('eaeb2afdd9d311e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-18 13:19:12');
INSERT INTO `log` VALUES ('eb04f8c9d9ab11e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 08:33:30');
INSERT INTO `log` VALUES ('ebb6794cdabd11e98ce70cc47a47def0', '删除需求', null, 'admin', '2019-09-19 17:14:54');
INSERT INTO `log` VALUES ('ebe4b86bdb8011e98ce70cc47a47def0', '上传文档', null, 'admin', '2019-09-20 16:30:13');
INSERT INTO `log` VALUES ('ec33ff07d91b11e9b556f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-17 15:22:37');
INSERT INTO `log` VALUES ('ec340a99d85f11e9847ef8b156d274ca', '增加产品', null, 'admin', '2019-09-16 16:56:51');
INSERT INTO `log` VALUES ('ec5727f1d53a11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:54:27');
INSERT INTO `log` VALUES ('ec888a90dc4b11e9b510f8b156d274ca', '更新需求', null, 'admin', '2019-09-21 16:43:47');
INSERT INTO `log` VALUES ('ec9b2e7bd53711e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 16:32:59');
INSERT INTO `log` VALUES ('ecb21c62d50a11e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:10:51');
INSERT INTO `log` VALUES ('ecb407e5d91b11e9b556f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-17 15:22:38');
INSERT INTO `log` VALUES ('ecd2383dd50a11e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:10:51');
INSERT INTO `log` VALUES ('eceba8f3dda011e98c39f8b156d274ca', '导入excel', null, 'admin', '2019-09-23 09:24:45');
INSERT INTO `log` VALUES ('ecedf576d50a11e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:10:51');
INSERT INTO `log` VALUES ('ed09e04bd50a11e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:10:52');
INSERT INTO `log` VALUES ('ed3a03c4d91b11e9b556f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-17 15:22:39');
INSERT INTO `log` VALUES ('ed44cdb1d9a711e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 08:04:56');
INSERT INTO `log` VALUES ('ed91d8b5d91b11e9b556f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-17 15:22:39');
INSERT INTO `log` VALUES ('eddea1e5d90f11e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 13:56:45');
INSERT INTO `log` VALUES ('ede75ccad48011e9bfdef8b156d274ca', '增加产品', null, 'admin', '2019-09-11 18:43:03');
INSERT INTO `log` VALUES ('ede8f4ffd54311e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 17:58:55');
INSERT INTO `log` VALUES ('edea3d88d91611e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 14:46:52');
INSERT INTO `log` VALUES ('eec1cd5dd50a11e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:10:54');
INSERT INTO `log` VALUES ('eedb6151d50a11e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:10:55');
INSERT INTO `log` VALUES ('eedc2bd0dc1611e98ce70cc47a47def0', '上传文档', null, '123456789', '2019-09-21 10:24:06');
INSERT INTO `log` VALUES ('eefc0bb0d50a11e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:10:55');
INSERT INTO `log` VALUES ('ef8eb14bd91411e9b556f8b156d274ca', '保存需求', null, 'admin', '2019-09-17 14:32:36');
INSERT INTO `log` VALUES ('ef8f80f0d91b11e9b556f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-17 15:22:42');
INSERT INTO `log` VALUES ('f0097657d91b11e9b556f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-17 15:22:43');
INSERT INTO `log` VALUES ('f00b3bd0dc4b11e9b510f8b156d274ca', '更新需求', null, 'admin', '2019-09-21 16:43:52');
INSERT INTO `log` VALUES ('f01feb5ed52111e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 13:55:35');
INSERT INTO `log` VALUES ('f0980e8ad91b11e9b556f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-17 15:22:44');
INSERT INTO `log` VALUES ('f0c2e35ad53911e994e5f8b156d274ca', '添加一条分类', null, 'admin', '2019-09-12 16:47:25');
INSERT INTO `log` VALUES ('f0d10f8fd54b11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 18:56:16');
INSERT INTO `log` VALUES ('f0da001ad91b11e9b556f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-17 15:22:45');
INSERT INTO `log` VALUES ('f16a61f1d53a11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:54:35');
INSERT INTO `log` VALUES ('f17784c7db6c11e98ce70cc47a47def0', '导入excel', null, 'admin', '2019-09-20 14:07:47');
INSERT INTO `log` VALUES ('f179fab4d54f11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 19:24:55');
INSERT INTO `log` VALUES ('f2093daad53a11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:54:36');
INSERT INTO `log` VALUES ('f253d928d53a11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:54:37');
INSERT INTO `log` VALUES ('f27a65f3d53a11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:54:37');
INSERT INTO `log` VALUES ('f291926bd53a11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:54:37');
INSERT INTO `log` VALUES ('f30ab5bcd91b11e9b556f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-17 15:22:48');
INSERT INTO `log` VALUES ('f363a8a7d45d11e9bfdef8b156d274ca', '删除需求', null, 'admin', '2019-09-11 14:32:40');
INSERT INTO `log` VALUES ('f380ee9cd91b11e9b556f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-17 15:22:49');
INSERT INTO `log` VALUES ('f3ae88c4d9d411e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 13:27:14');
INSERT INTO `log` VALUES ('f3f4c07dd8fc11e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 11:40:55');
INSERT INTO `log` VALUES ('f41fdf26d91b11e9b556f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-17 15:22:50');
INSERT INTO `log` VALUES ('f44098e8d55711e994e5f8b156d274ca', '保存需求', null, null, '2019-09-12 20:22:16');
INSERT INTO `log` VALUES ('f463a36fd53b11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 17:01:50');
INSERT INTO `log` VALUES ('f4b4c2c1daa511e98ce70cc47a47def0', '增加项目', null, 'admin', '2019-09-19 14:23:22');
INSERT INTO `log` VALUES ('f4f2a574d53911e994e5f8b156d274ca', '添加一条分类', null, 'admin', '2019-09-12 16:47:32');
INSERT INTO `log` VALUES ('f4f59fe3d50211e994e5f8b156d274ca', '更新产品', null, 'admin', '2019-09-12 10:13:49');
INSERT INTO `log` VALUES ('f53729c4d9d811e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 13:55:55');
INSERT INTO `log` VALUES ('f5a6a2b3d91b11e9b556f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-17 15:22:53');
INSERT INTO `log` VALUES ('f5caab99d9d411e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 13:27:17');
INSERT INTO `log` VALUES ('f5db9dfdd91b11e9b556f8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-17 15:22:53');
INSERT INTO `log` VALUES ('f60d43dddc4711e9b510f8b156d274ca', '上传文档', null, 'admin', '2019-09-21 16:15:24');
INSERT INTO `log` VALUES ('f6211eedd91611e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 14:47:06');
INSERT INTO `log` VALUES ('f642ac0ddc4411e9b510f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-21 15:53:56');
INSERT INTO `log` VALUES ('f64f491ddc4411e9b510f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-21 15:53:56');
INSERT INTO `log` VALUES ('f66468b8d8f911e9b556f8b156d274ca', '删除需求', null, 'admin', '2019-09-17 11:19:31');
INSERT INTO `log` VALUES ('f674720ed53711e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:33:15');
INSERT INTO `log` VALUES ('f6c75a71dc4411e9b510f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-21 15:53:57');
INSERT INTO `log` VALUES ('f6d1a802dc4411e9b510f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-21 15:53:57');
INSERT INTO `log` VALUES ('f7229a09d50b11e994e5f8b156d274ca', '增加项目', null, 'admin', '2019-09-12 11:18:18');
INSERT INTO `log` VALUES ('f728c186dc4411e9b510f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-21 15:53:58');
INSERT INTO `log` VALUES ('f73b8385dc4411e9b510f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-21 15:53:58');
INSERT INTO `log` VALUES ('f746c712d8f911e9b556f8b156d274ca', '删除需求', null, 'admin', '2019-09-17 11:19:32');
INSERT INTO `log` VALUES ('f776a3dedc4411e9b510f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-21 15:53:58');
INSERT INTO `log` VALUES ('f78ec9c4dc4411e9b510f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-21 15:53:59');
INSERT INTO `log` VALUES ('f7da7ab6d53711e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:33:18');
INSERT INTO `log` VALUES ('f7e993a8d53911e994e5f8b156d274ca', '添加一条分类', null, 'admin', '2019-09-12 16:47:37');
INSERT INTO `log` VALUES ('f7fd6092d84b11e9847ef8b156d274ca', '保存需求', null, 'admin', '2019-09-16 14:34:01');
INSERT INTO `log` VALUES ('f8026334d8f911e9b556f8b156d274ca', '删除需求', null, 'admin', '2019-09-17 11:19:33');
INSERT INTO `log` VALUES ('f80b07ddd9a711e98ce70cc47a47def0', '增加产品', null, 'admin', '2019-09-18 08:05:14');
INSERT INTO `log` VALUES ('f8181afbd53b11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 17:01:56');
INSERT INTO `log` VALUES ('f85cee5ad53411e994e5f8b156d274ca', '增加产品', null, 'admin', '2019-09-12 16:11:50');
INSERT INTO `log` VALUES ('f893e335d53b11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 17:01:57');
INSERT INTO `log` VALUES ('f8b6dad7d53b11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 17:01:57');
INSERT INTO `log` VALUES ('f8b92ddcdb6b11e98ce70cc47a47def0', '更新需求', null, 'admin', '2019-09-20 14:00:49');
INSERT INTO `log` VALUES ('f8d10d28d53611e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 16:26:10');
INSERT INTO `log` VALUES ('f8e8adffd53b11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 17:01:57');
INSERT INTO `log` VALUES ('f906cfbed53b11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 17:01:58');
INSERT INTO `log` VALUES ('f92230afd8f911e9b556f8b156d274ca', '删除需求', null, 'admin', '2019-09-17 11:19:35');
INSERT INTO `log` VALUES ('f972fdf4d9a811e98ce70cc47a47def0', '增加项目', null, 'admin', '2019-09-18 08:12:26');
INSERT INTO `log` VALUES ('f98cbd94dc4411e9b510f8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-21 15:54:02');
INSERT INTO `log` VALUES ('fadbd051d46511e9bfdef8b156d274ca', '增加产品', null, 'admin', '2019-09-11 15:30:08');
INSERT INTO `log` VALUES ('fae696fed9d311e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 13:20:17');
INSERT INTO `log` VALUES ('fb2f546cd92111e9b556f8b156d274ca', '增加产品', null, 'admin', '2019-09-17 16:05:59');
INSERT INTO `log` VALUES ('fb7d54dad54f11e994e5f8b156d274ca', '保存需求', null, 'admin', '2019-09-12 19:25:12');
INSERT INTO `log` VALUES ('fb7f89c2d9d311e98ce70cc47a47def0', '根据id删除产品', null, 'admin', '2019-09-18 13:20:18');
INSERT INTO `log` VALUES ('fba58e69d47511e9bfdef8b156d274ca', '更新项目', null, 'admin', '2019-09-11 17:24:41');
INSERT INTO `log` VALUES ('fbbfbf1adc4111e9b510f8b156d274ca', '保存需求', null, 'admin', '2019-09-21 15:32:37');
INSERT INTO `log` VALUES ('fc6be4acd47511e9bfdef8b156d274ca', '更新项目', null, 'admin', '2019-09-11 17:24:43');
INSERT INTO `log` VALUES ('fc7427c7d54b11e994e5f8b156d274ca', '删除需求', null, 'admin', '2019-09-12 18:56:35');
INSERT INTO `log` VALUES ('fcbb4efcd8f711e9b556f8b156d274ca', '保存需求', null, 'admin', '2019-09-17 11:05:22');
INSERT INTO `log` VALUES ('fcc34ff3d9a811e98ce70cc47a47def0', '增加项目', null, 'admin', '2019-09-18 08:12:31');
INSERT INTO `log` VALUES ('fcea96c4dc4111e9b510f8b156d274ca', '保存需求', null, 'admin', '2019-09-21 15:32:39');
INSERT INTO `log` VALUES ('fcf261fcd4f811e994e5f8b156d274ca', '更新需求', null, 'admin', '2019-09-12 09:02:27');
INSERT INTO `log` VALUES ('fd7df03ad46d11e9bfdef8b156d274ca', '根据id删除产品', null, 'admin', '2019-09-11 16:27:29');
INSERT INTO `log` VALUES ('fd8a0708d90f11e9b556f8b156d274ca', '更新需求', null, 'admin', '2019-09-17 13:57:12');
INSERT INTO `log` VALUES ('fdad3320d45e11e9bfdef8b156d274ca', '更新横向需求矩阵', null, 'admin', '2019-09-11 14:40:06');
INSERT INTO `log` VALUES ('fdbd13d7d9e811e98ce70cc47a47def0', '增加项目', null, 'admin', '2019-09-18 15:50:41');
INSERT INTO `log` VALUES ('fdeee302dc4111e9b510f8b156d274ca', '保存需求', null, 'admin', '2019-09-21 15:32:41');
INSERT INTO `log` VALUES ('fe2fda60d85411e9847ef8b156d274ca', '更新项目', null, 'admin', '2019-09-16 15:38:37');
INSERT INTO `log` VALUES ('fe9e3d0ad90e11e9b556f8b156d274ca', '删除需求', null, 'admin', '2019-09-17 13:50:04');
INSERT INTO `log` VALUES ('fee15a39dc4111e9b510f8b156d274ca', '保存需求', null, 'admin', '2019-09-21 15:32:42');
INSERT INTO `log` VALUES ('feea07c0d85f11e9847ef8b156d274ca', '增加产品', null, 'admin', '2019-09-16 16:57:23');
INSERT INTO `log` VALUES ('ff133a60d55511e994e5f8b156d274ca', '保存需求', null, null, '2019-09-12 20:08:15');
INSERT INTO `log` VALUES ('ff18cf48d53311e994e5f8b156d274ca', '上传文档', null, 'admin', '2019-09-12 16:04:12');
INSERT INTO `log` VALUES ('ffd52cdfdc4111e9b510f8b156d274ca', '保存需求', null, 'admin', '2019-09-21 15:32:44');

-- ----------------------------
-- Table structure for norms
-- ----------------------------
DROP TABLE IF EXISTS `norms`;
CREATE TABLE `norms` (
  `norms_id` varchar(32) NOT NULL COMMENT '规格id',
  `norms_num` varchar(100) DEFAULT NULL COMMENT '规格编号',
  `norms_describe` varchar(800) DEFAULT NULL COMMENT '规格描述',
  `norms_event` varchar(800) DEFAULT NULL COMMENT '规格触发事件',
  `norms_baseflow` varchar(800) DEFAULT NULL COMMENT '规格基本流程',
  `norms_extflow` varchar(800) DEFAULT NULL COMMENT '规格扩展流程',
  `norms_excflow` varchar(800) DEFAULT NULL COMMENT '规格异常流程',
  `norms_precondition` varchar(800) DEFAULT NULL COMMENT '规格前置条件',
  `norms_postcondition` varchar(800) DEFAULT NULL COMMENT '规格后置条件',
  `norms_rule` varchar(800) DEFAULT NULL COMMENT '规格业务规则',
  `norms_other` varchar(800) DEFAULT NULL COMMENT '规格其他',
  `norms_user` varchar(255) DEFAULT NULL COMMENT '规格用户',
  `norms_name` varchar(200) DEFAULT NULL COMMENT '规格名字',
  `product_id` varchar(32) DEFAULT NULL,
  `pdf_page` tinyint(4) DEFAULT NULL COMMENT '该产品规格对应的pdf页数',
  `norms_version` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`norms_id`),
  KEY `norms_product_id_fk` (`product_id`),
  CONSTRAINT `norms_product_id_fk` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of norms
-- ----------------------------
INSERT INTO `norms` VALUES ('1e049418dde911e98c39f8b156d274ca', 'S-0010-001', '用户登录系统。', '用户打开系统后，用例启动。', '1.系统显示登录界面。2.用户输入用户名和密码，用户点击登录按钮。3.系统验证用户名和密码，如果验证用户名和密码正确，则登录成功，显示系统主功能界面，并显示已经登录的用户名。', '1.1.如果用户上次登录时已经选择记住密码选项，则可以不用输入用户名和密码，系统使用上次记住的用户名和密码填充输入框。3.1.如果用户选择记录用户名密码，则系统还需要记录用户输入的用户名密码。3.2.如果验证失败，则系统显示具体的错误原因，并停留在登录界面。', '如果服务器掉线，点击登录按钮时，不管用户名、密码是否正确，都会弹出服务器提示或者页面卡死。网络异常', '用户已经打开系统，系统显示登录界面。', '1.用户登录成功，能够使用系统功能。2.登录成功后，系统显示当前用户名，显示系统主功能按钮。', '1.登录失败时需要显示失败原因，失败原因包括用户名或密码错误、连接服务器失败或其他可供用户排查原因的提示。2.密码输入框隐藏实际输入字符，用小圆点代替。3.加密狗无授权或者授权失效时，提示用户无授权相关信息，但仍可登录。', '登录界面提供记住密码选项供用户选择，用户选择该选项后，下次重新打开登录界面不用输入密码，直接点击登录按钮就可以登录。', '操作员、管理员', '登录', '0b44246ddc4c11e9b510f8b156d274ca', '101', 'V1.0');
INSERT INTO `norms` VALUES ('1e15df74dde911e98c39f8b156d274ca', 'S-0010-002', '用户退出系统。', '用户选择退出系统时，用例启动。', '1.用户点击退出按钮。2.系统显示登录界面。', '当直接点击浏览器右上角关闭按钮时，直接退出。当浏览器路由改变时，如果找不到相应路由，直接退出或者404。', '权限过期，自动退出登录。网络异常，自动退出登录。', '用户已经成功登录系统。', '用户退出成功，系统返回登录界面。', '用户退出系统后，将不能再使用系统的除登录外的其他任何功能。', '', '操作员、管理员', '退出', '0b44246ddc4c11e9b510f8b156d274ca', '13', 'V1.0');
INSERT INTO `norms` VALUES ('1e176e79dde911e98c39f8b156d274ca', 'S-0020-001', '在系统中的组织树中新增一个组织。', '用户点击添加组织功能时，用例启动。', '1.用户选择了某个已经存在的组织，点击添加组织按钮。2.系统显示新增组织信息录入界面。3.用户输入组织名称和组织编码，并点击确定。4.系统验证组织名的有效性，如果有效，则添加新的组织到系统中，并在组织树中用户已经选择的组织下显示新增的组织。', '1.1.如果步骤1中用户并没有选择某个已经存在的组织，则提示用户先选择，用例结束。3.1.如果用户点击取消，则用例结束。4.1.如果在用户选择的组织下已经存在相同名字的组织，则添加失败，系统提示失败信息。', '', '用户已经成功登录系统并且已经打开组织管理界面。', '系统中新增了一个组织。', '1.同一个组织下的子组织名称不允许重复。2.组织编码不允许重复。', '', '管理员', '添加组织', '0b44246ddc4c11e9b510f8b156d274ca', '14', 'V1.0');
INSERT INTO `norms` VALUES ('1e1b6f3adde911e98c39f8b156d274ca', 'S-0020-002', '修改一个组织的名字。', '用户点击修改组织功能时，用例启动。', '用户选择了某个已经存在的组织，点击重命名按钮。系统显示带有组织名字的输入框的界面，提供确定和取消界面供用户选择。用户输入组织名称和编码，点击确定。系统验证组织名的有效性，如果有效，则保存新的组织名称，并在组织树中显示新的组织名称。', '1.1如果步骤1中用户并没有选择某个已经存在的组织，则提示用户先选择，用例结束。3.1如果用户点击取消，则用例结束。4.1如果在用户选择的组织下已经存在相同名字的组织，则重命名失败，系统提示失败信息。', '', '用户已经成功登录系统并且已经打开组织管理界面。', '系统修改了一个组织名称', '1.同一个组织下的子组织名称不允许重复。2.组织编码不允许重复。', '', '管理员', '修改组织', '0b44246ddc4c11e9b510f8b156d274ca', '15', 'V1.0');
INSERT INTO `norms` VALUES ('1e3f8367dde911e98c39f8b156d274ca', 'S-0020-003', '从系统中删除一个组织。', '用户点击删除组织功能时，用例启动。', '1.用户选择了某个已经存在的组织，点击删除按钮。2.系统显示是和否的选项供用户选择。3.用户点击是选项。4.系统检查该组织下存在的资源，如果没有存在子组织，则从到系统中删除该组织和其下的所有资源。', '1.1.如果步骤1中用户并没有选择某个已经存在的组织，则提示用户先选择，用例结束。3.1.如果用户点击否，则用例结束。4.1.如果在用户选择的组织下存在子组织，则删除失败，系统提示失败信息。', '', '用户已经成功登录系统并且已经打开组织管理界面。', '系统删除了一个组织及其下的资源。', '只能删除不存在子组织的组织。', '', '管理员', '删除组织', '0b44246ddc4c11e9b510f8b156d274ca', '16', 'V1.0');
INSERT INTO `norms` VALUES ('1e40f5b0dde911e98c39f8b156d274ca', 'S-0020-004', '查看组织所包含的信息。', '用户选择某个组织时，用例启动。', '1.用户选择某个已经存在的组织。2.系统列出该组织下的所有组织及组织下的所有资源。', '', '', '用户已经成功登录系统并且已经打开组织管理界面。', '系统列出该组织下的所有组织及组织下的所有资源。', '用户选择组织下的子组织和资源时，可以对资源进行与资源有关的操作，比如删除和修改。', '', '操作员、管理员', '查看组织', '0b44246ddc4c11e9b510f8b156d274ca', '16', 'V1.0');
INSERT INTO `norms` VALUES ('1e428b0bdde911e98c39f8b156d274ca', 'S-0030-001', '在系统中的组织树中新增一个设备。', '用户点击手动添加设备功能时，用例启动。', '1.用户选择了某个已经存在的组织，点击手动添加设备按钮。2.系统显示新增设备信息录入界面。3.用户输入设备信息，并点击确定。4.系统验证用户输入信息的有效性，如果验证有效，则添加新的设备到系统中，并在组织树中用户已经选择的组织下显示新增的设备。', '1.1.如果步骤1中用户并没有选择某个已经存在的组织，则提示用户先选择，用例结束。3.1.如果用户点击取消，则用例结束。', '4.1.如果验证失败，则添加失败，系统提示失败信息。', '用户已经成功登录系统并且已经打开设备管理界面。', '系统中新增了一个设备。', '1.设备名称在系统内不能重复。2.IP和端口一起唯一标识一个设备，不能添加IP和端口都相同的设备。3.添加设备时，自动添加设备下的所有通道。4.支持添加多通道设备。', '', '管理员', '手动添加设备', '0b44246ddc4c11e9b510f8b156d274ca', '18', 'V1.0');
INSERT INTO `norms` VALUES ('1e44f15bdde911e98c39f8b156d274ca', 'S-0030-002', '用户通过导入的方式在系统中的组织树中新增设备。', '用户点击导入添加设备功能时，用例启动。', '1.用户选择了某个已经存在的组织，点击Excel导入标签。2.用户选择Excel文件，并点击确定。3.系统从Excel文件中导入设备。并在组织树中用户已经选择的组织下显示新增的设备。', '1.1.如果步骤1中用户并没有选择某个已经存在的组织，则提示用户先选择组织，用例结束。2.1.如果用户点击取消，则用例结束。', '读取导入文件错误、导入无效的数据、导入重复的数据，则系统提示用户导入失败。', '用户已经成功登录系统并且已经打开设备管理界面。', '系统中新增了一批设备。', '系统提供导出Excel模板功能，用户通过该模板填写设备信息。', '', '管理员', '导入添加设备', '0b44246ddc4c11e9b510f8b156d274ca', '18', 'V1.0');
INSERT INTO `norms` VALUES ('1e450250dde911e98c39f8b156d274ca', 'S-0030-003', '用户修改一个设备的信息。', '用户点击选择修改设备功能时，用例启动。', '1.用户选择某个已经存在的设备。2.系统显示设备的信息。3.用户修改设备信息，并点击保存。4.系统更新该设备的信息。', '3.1如果用户点击取消，则用例结束。', '', '用户已经成功登录系统并且已经打开设备管理界面。', '系统中修改了一个设备的信息。', '设备名称在系统内不能重复。IP和端口一起唯一标识一个设备，不能修改为其它已经存在的IP和端口都相同的设备。', '', '管理员', '修改设备', '0b44246ddc4c11e9b510f8b156d274ca', '19', 'V1.0');
INSERT INTO `norms` VALUES ('1e452ebfdde911e98c39f8b156d274ca', 'S-0030-004', '从系统中删除一个设备。', '用户选择删除设备功能时，用例启动。', '1.用户选择某个已经存在的设备，点击删除按钮。2.系统显示确定和取消界面供用户选择。3.用户点击确定。4.系统删除该设备。', '1.1如果步骤1中用户并没有选择某个设备，则提示用户先选择设备，用例结束。3.1如果用户点击取消，则用例结束。', '', '用户已经成功登录系统并且已经打开设备管理界面。', '系统删除了用户选定的设备。', '用户删除设备时系统自动把该设备下的所有通道都一起删除。如果该设备已经被分配给引擎分析，则不可以删除，系统给出提示。', '', '管理员', '删除设备', '0b44246ddc4c11e9b510f8b156d274ca', '19', 'V1.0');
INSERT INTO `norms` VALUES ('1e45324edde911e98c39f8b156d274ca', 'S-0030-005', '查看一个设备的信息。', '用户选择某个设备时，用例启动。', '1.用户选择某个已经存在的设备。2.系统显示设备的信息。', '', '', '用户已经成功登录系统并且已经打开设备管理界面。', '系统列出一个设备的信息。', '系统显示的设备信息同手动添加设备中用户所输入的信息。', '', '管理员', '查看设备', '0b44246ddc4c11e9b510f8b156d274ca', '20', 'V1.0');
INSERT INTO `norms` VALUES ('1e455167dde911e98c39f8b156d274ca', 'S-0030-006', '用户查看一个组织的设备列表。', '用户选择某个组织时，用例启动。', '1.用户选择某个组织，并选择查看设备列表功能。2.系统显示该组织的设备列表。', '', '', '用户已经成功登录系统并且已经打开设备管理界面。', '系统列出一个组织的设备列表。', '显示的设备列表不包括子组织中的设备。', '', '管理员', '查看设备列表', '0b44246ddc4c11e9b510f8b156d274ca', '20', 'V1.0');
INSERT INTO `norms` VALUES ('1e464916dde911e98c39f8b156d274ca', 'S-0040-001', '在系统中的组织树中新增一个用户。', '用户点击添加用户功能时，用例启动。', '1.用户选择了某个已经存在的组织，点击添加用户按钮。2.系统显示新增用户信息录入界面。3.用户输入用户名和密码，并点击确定。4.系统验证用户名的有效性，如果系统中不存在该用户名，则添加新的用户到系统中，并在组织树中用户已经选择的组织下显示新增的用户。', '1.1如果步骤1中用户并没有选择某个已经存在的组织，则提示用户先选择组织，用例结束。3.1如果用户点击取消，则用例结束。', '4.1如果在系统中已经存在相同名字的用户，则添加失败，系统提示失败信息。', '用户已经成功登录系统并且已经打开用户管理界面。', '系统中新增了一个用户。', '系统中的用户名称不允许重复。', '', '管理员', '添加用户', '0b44246ddc4c11e9b510f8b156d274ca', '21', 'V1.0');
INSERT INTO `norms` VALUES ('1e4801c2dde911e98c39f8b156d274ca', 'S-0040-002', '用户修改一个用户的信息。', '用户选择修改用户功能时，用例启动。', '1.用户选择某个已经存在的用户。2.系统显示用户的信息。3.用户修改用户信息，并点击保存。4.系统更新该用户的信息。', '3.1如果用户点击取消，则用例结束。', '', '用户已经成功登录系统并且已经打开用户管理界面。', '系统修改了一个用户的信息。', '系统中的用户名称不允许重复。具有用户管理权限的用户可以修改所选择的用户的信息。系统默认内置提供的超级管理员账户只能修改密码、真实姓名、邮箱、手机号码和备注，不能修改其它信息。超级管理员默认具有系统内的所有权限。', '', '管理员', '修改用户', '0b44246ddc4c11e9b510f8b156d274ca', '22', 'V1.0');
INSERT INTO `norms` VALUES ('1e49835fdde911e98c39f8b156d274ca', 'S-0040-003', '用户从系统中删除一个用户。', '用户选择删除用户功能时，用例启动。', '1.用户选择某个已经存在的用户，右键选择删除。2.系统显示是和否选项供用户选择。3.用户点击是。4.系统删除该用户。', '1.1如果步骤1中用户并没有选择某个用户，则提示用户先选择用户，用例结束。3.1如果用户点击否，则用例结束。', '', '用户已经成功登录系统并且已经打开用户管理界面。', '系统删除了用户选定的用户账号。', '', '', '管理员', '删除用户', '0b44246ddc4c11e9b510f8b156d274ca', '23', 'V1.0');
INSERT INTO `norms` VALUES ('1e4a25c4dde911e98c39f8b156d274ca', 'S-0040-004', '用户查看一个用户的信息。', '用户选择某个用户时，用例启动。', '1.用户选择某个已经存在的用户。2.系统显示用户的信息。', '', '', '用户已经成功登录系统并且已经打开用户管理界面。', '系统列出一个用户的信息。', '系统列出的信息同“修改用户”中描述。', '', '管理员', '查看用户', '0b44246ddc4c11e9b510f8b156d274ca', '23', 'V1.0');
INSERT INTO `norms` VALUES ('1e4af53bdde911e98c39f8b156d274ca', 'S-0040-005', '用户查看一个组织的用户列表。', '用户选择某个组织时，用例启动。', '1.用户选择某个组织，并选择查看用户列表功能。2.系统显示该组织的用户列表。', '', '', '用户已经成功登录系统并且已经打开用户管理界面。', '系统列出一个组织的用户列表。', '显示的用户列表不包括子组织中的用户。系统显示列表时，提供分页显示功能。', '', '管理员', '查看用户列表', '0b44246ddc4c11e9b510f8b156d274ca', '24', 'V1.0');
INSERT INTO `norms` VALUES ('1e4bf11adde911e98c39f8b156d274ca', 'S-0050-001', '在系统中的组织树中新增一个角色。', '用户点击添加角色功能时，用例启动。', '用户选择了某个已经存在的组织，点击添加角色按钮。系统显示新增角色信息录入界面。用户输入角色名称，并点击确定。系统验证角色名称的有效性，如果系统中不存在该角色名称，则添加新的角色到系统中，并在组织树中用户已经选择的组织下显示新增的角色。', '1.1如果用户并没有选择某个已经存在的组织，则提示用户先选择组织，用例结束。3.1如果用户点击取消，则用例结束。', '如果在用户选择的组织下已经存在相同名称的角色，则添加失败，系统提示失败信息。', '用户已经成功登录系统并且已经打开角色管理界面。', '系统中新增了一个角色。', '同一个组织下的角色名称不允许重复。角色名称最长32个字符，支持中文、英文大小写字母、数字、可打印特殊字符。', '', '管理员', '添加角色', '0b44246ddc4c11e9b510f8b156d274ca', '25', 'V1.0');
INSERT INTO `norms` VALUES ('1e4cf6e4dde911e98c39f8b156d274ca', 'S-0050-002', '用户修改一个角色的信息。', '用户点击修改角色功能时，用例启动。', '用户选择某个已经存在的角色。系统显示角色的信息。用户修改角色信息，并点击保存。系统验证角色名称的有效性，如果系统中不存在该角色名称，则更新该角色的信息。', '1.1如果用户并没有选择某个已经存在的角色，则提示用户先选择角色，用例结束。3.1如果用户点击取消，则用例结束。', '如果在用户选择的组织下已经存在相同名称的角色，则添加失败，系统提示失败信息。', '用户已经成功登录系统并且已经打开角色管理界面。', '系统修改了一个角色的信息。', '同一个组织下的角色名称不允许重复。用户角色根据分配的权限对系统进行操作，对无权限操作的模块当用户进入时功能灰色不可点击。只有授权的用户角色才能动用和修改系统的信息。可供修改的角色信息有：角色名称，权限列表。权限分为六大类，分别为配置权限、基础权限、考勤权限、签到权限、门禁权限、统计权限。', '', '管理员', '修改角色', '0b44246ddc4c11e9b510f8b156d274ca', '26', 'V1.0');
INSERT INTO `norms` VALUES ('1e5dd5c7dde911e98c39f8b156d274ca', 'S-0050-003', '从系统中删除一个角色。', '用户点击删除角色功能时，用例启动。', '1.用户选择某个已经存在的角色，点击删除按钮。2.系统显示是和否供用户选择。3.用户点击是。4.系统删除该角色。', '1.1如果用户并没有选择某个已经存在的角色，则提示用户先选择角色，用例结束。3.1如果用户点击取消，则用例结束。', '', '用户已经成功登录系统并且已经打开角色管理界面。', '系统删除了用户选定的角色。', '', '', '管理员', '删除角色', '0b44246ddc4c11e9b510f8b156d274ca', '28', 'V1.0');
INSERT INTO `norms` VALUES ('1e5e0238dde911e98c39f8b156d274ca', 'S-0050-004', '用户查看一个角色的信息。', '用户选择某个角色时，用例启动。', '1.用户选择某个已经存在的角色。2.系统显示角色的信息。', '', '', '用户已经成功登录系统并且已经打开角色管理界面。', '系统列出一个角色的信息。', '', '', '管理员', '查看角色', '0b44246ddc4c11e9b510f8b156d274ca', '28', 'V1.0');
INSERT INTO `norms` VALUES ('1e5e10c5dde911e98c39f8b156d274ca', 'S-0050-005', '查看一个组织的角色列表。', '用户选择某个组织时，用例启动。', '1.用户选择某个组织，并选择查看角色列表功能。2.系统显示该组织的角色列表。', '', '', '用户已经成功登录系统并且已经打开角色管理界面。', '系统列出一个组织的角色列表。', '右边列表中显示的角色列表包括子组织中的角色。左边树下面的列表显示的角色列表不包含子组织中的角色。系统显示列表时，提供分页显示功能。', '', '管理员', '查看角色列表', '0b44246ddc4c11e9b510f8b156d274ca', '28', 'V1.0.0');
INSERT INTO `norms` VALUES ('1e5ea8c4dde911e98c39f8b156d274ca', 'S-0060-001', '查看或更新授权，查看软件版本信息。', '用户进入系统管理页面。', '1.能查看授权和软件版本信息2.点击上传license按钮，选择授权文件，点击上传按钮，即上传了授权文件3.点击更新授权按钮', '', '', '用户已经成功登录系统并且已经打开系统管理界面。', '系统会更新授权', '授权信息由机器识别码、摄像机最大接入数、有效期组成', '', '管理员', '授权和软件信息', '0b44246ddc4c11e9b510f8b156d274ca', '30', 'V1.0');
INSERT INTO `norms` VALUES ('1e5eb7a6dde911e98c39f8b156d274ca', 'S-0060-002', '查看和配置系统参数。', '用户进入系统管理页面点击系统参数标签页。', '1.系统显示当前的的参数信息2.用户修改各项参数3.点击保存按钮', '', '', '用户已经成功登录系统并且已经打开系统管理界面。', '保存系统参数。', '', '', '管理员', '系统参数', '0b44246ddc4c11e9b510f8b156d274ca', '30', 'V1.0');
INSERT INTO `norms` VALUES ('1e5ec67edde911e98c39f8b156d274ca', 'S-0060-003', '查看和配置网络参数。', '用户进入系统管理页面网络配置标签页。', '1.用户输入网卡、IP、子网掩码、网关、MAC地址2.点击保存按钮，提示用户需要重启才生效3.点击重启按钮', '', '', '用户已经成功登录系统并且已经打开系统管理界面。', '系统重启后，成功修改了网络信息。', '', '', '管理员', '网络配置', '0b44246ddc4c11e9b510f8b156d274ca', '31', 'V1.0');
INSERT INTO `norms` VALUES ('1e5ec959dde911e98c39f8b156d274ca', 'S-0060-004', '查看和配置日期时间。', '用户进入系统管理页面点击日期时间标签页。', '1.用户点击 同步本地时间2.用户点击 启用NTP，并输入NTP服务器地址3.点击保存按钮4.点击刷新按钮，会更新界面参数', '', '', '用户已经成功登录系统并且已经打开系统管理界面。', '系统会同步本地时间，或与NTP服务器同步时间。', '1.点击同步本地时间会禁用NTP，需要再次点击启用NTP，输入NTP地址并保存，才能启用NTP', '', '管理员', '日期时间', '0b44246ddc4c11e9b510f8b156d274ca', '31', 'V1.0');
INSERT INTO `norms` VALUES ('1e5edd7adde911e98c39f8b156d274ca', 'S-0070-001', '用户在系统中的组织树中新增一个服务器。', '用户点击添加服务器功能时，用例启动。', '1.用户选择了某个已经存在的组织，点击添加服务器按钮。2.系统显示服务器信息输入界面。3.用户输入服务器信息，并点击确定。4.系统验证用户输入信息的有效性，如果验证有效，则添加新的服务器到系统中，并在组织树中用户已经选择的组织下显示新增的服务器。', '1.1如果步骤1中用户并没有选择某个已经存在的组织，则提示用户先选择组织，用例结束。4.1如果验证失败，则添加失败，系统提示失败信息。', '1.新增的服务器URL只能是http协议，如果填写非http协议的地址或地址格式填写有误，系统验证不通过，提示用户失败信息。2.用户提交时，系统验证该服务器地址和用户（类型为FRS时）是否可访问，不可访问时验证失败，提示用户失败信息。', '用户已经成功登录系统并且已经打开服务器管理界面。', '在用户选定的组织中新增了一个服务器。', '服务器类型为系统预设，用户只能从中选择一种。同一种类型的服务器只能添加一个。除了FRS（人脸识别服务器）需要额外配置用户名密码，其它服务器默认使用admin/admin作为用户名密码，不需额外配置。添加服务器填写URL时，界面给出填写提示。', '', '管理员', '添加服务器', '0b44246ddc4c11e9b510f8b156d274ca', '32', 'V1.1');
INSERT INTO `norms` VALUES ('1e5ffc7ddde911e98c39f8b156d274ca', 'S-0070-002', '用户修改一个服务器的信息。', '用户双击选定的服务器时，用例启动。', '1.用户选择某个已经存在的组织。2.系统显示该组织下的服务器。3.用户选择某个服务器双击。4.系统显示服务器修改界面。5.用户修改服务器的信息，点击保存。6.系统验证用户输入信息的有效性，如果验证有效，则更新服务器信息到系统中。', '6.1如果验证失败，则添加失败，系统提示失败信息。', '1.如果填写非http协议的地址或地址格式填写有误，系统验证不通过，提示用户失败信息。', '用户已经成功登录系统并且已经打开服务器管理界面。', '系统更新了一个服务器的信息。', '修改服务器时，类型保持不变，只提供修改服务器名称、URL、用户名、密码。', '', '管理员', '修改服务器', '0b44246ddc4c11e9b510f8b156d274ca', '33', 'V1.1');
INSERT INTO `norms` VALUES ('1e601adadde911e98c39f8b156d274ca', 'S-0070-003', '用户从系统中删除一个服务器。', '用户选择删除服务器功能时，用例启动。', '1.用户选择某个已经存在的组织。2.系统显示该组织下的服务器。3.用户右键选择某个服务器，点击删除按钮。4.系统显示二次确认界面供用户选择确认或取消。5.用户确认删除。4.系统删除服务器并且组织树界面实时刷新显示删除后剩余的服务器。', '4.1如果用户选择取消，则用户结束。', '', '用户已经成功登录系统并且已经打开服务器管理界面。', '系统删除了一个服务器。', '', '', '管理员', '删除服务器', '0b44246ddc4c11e9b510f8b156d274ca', '34', 'V1.1');
INSERT INTO `norms` VALUES ('1e6129b2dde911e98c39f8b156d274ca', 'S-0070-004', '用户查看某个组织下的服务器及服务器详情。', '用户选择查看服务器功能时，用例启动。', '1.用户选择某个已经存在的组织。2.系统显示该组织下的服务器列表。3.用户双击某个服务器。4.系统显示服务器详细信息，同时也是编辑服务器信息的前提。', '', '', '用户已经成功登录系统并且已经打开服务器管理界面。', '系统列出某个组织的所有服务器、显示用户所选服务器详情。', '列出服务器列表时，服务器的在线和不在线状态分开显示。服务器详情同时也是编辑修改服务器的界面。查看服务器详情的同时，可进一步修改服务器。', '', '管理员', '查看服务器', '0b44246ddc4c11e9b510f8b156d274ca', '34', 'V1.1');
INSERT INTO `norms` VALUES ('1e61326cdde911e98c39f8b156d274ca', 'S-0080-001', '配置目标库人员信息可自定义字段模板。', '用户进入模板管理页面下的人员信息模板标签页。', '用户点击增加按钮增加一个人员自定义字段；系统增加一栏字段；3.用户在字段名编辑框中输入字段名称；4.点击字段名后的增加按钮，可以添加该字段的可选字段值；5.重复1-4步骤添加多个自定义字段后，点击保存按钮保存。', '3.1如果想取消新增的字段，直接点击自定义字段一栏的删除按钮；', '如果字段名输入过长，则保存失败，系统提示用户失败信息。', '用户已经成功登录系统并且已经打开模板管理界面下的人员信息模板标签页。', '系统更新人员信息的自定义配置。', '系统默认预设目标等级字段，对目标等级字段只能更新字段值。字段值从左到右等级依次上升，从0开始，每次等级递增1，界面支持显示当前用户填写字段值的等级。更新人员自定义配置后，在目标库管理中，添加目标时，其目标信息（即人员信息）编辑界面将显示上述模板中添加的字段信息。', '', '管理员', '人员信息模板配置', '0b44246ddc4c11e9b510f8b156d274ca', '35', 'V1.1');
INSERT INTO `norms` VALUES ('1e613611dde911e98c39f8b156d274ca', 'S-0080-002', '配置布控计划模板', '用户进入模板管理页面下的布控计划模板标签页。', '1.输入布控计划名称；；2.点击时间轴左上角的增加按钮，选择计划周期；3.双击时间轴双向拉动，确定时间范围；4.点击确定按钮保存；5.浏览布控计划列表，双击列表中的某一项进行布控计划的修改；6.重复1234步骤，点击保存即可修改布控计划。', '4.1.点击清空按钮，则重置输入的名称和时间范围。5.1.浏览布控计划时，点击列表中某一项的删除按钮，系统提示二次确定，用户确认后删除该布控计划。', '如果用户没输入计划名称，保存时提示计划名称必填。', '用户已经成功登录系统并且已经打开模板管理界面下的布控计划模板标签页。', '系统更新了布控计划配置。', '拉动时间轴时，在时间轴上双击不同点，可根据这个点左右拉伸，形成不连续分段（如早上6点到12点，下午14点到18点）。', '', '管理员', '布控计划模板配置', '0b44246ddc4c11e9b510f8b156d274ca', '36', 'V1.1');
INSERT INTO `norms` VALUES ('1e614f50dde911e98c39f8b156d274ca', 'S-0090-001', '查询系统所有部门，以树的层级结构展示。', '用户进入部门管理页面。', '用户点击部门管理进入部门管理页面。系统以树形结构展示现在部门以及层级关系。', '', '', '用户已经成功登录系统并且已经进入后台配置端，打开部门管理界面。', '系统列出树状部门结构', '部门树可以收起展开。', '', '管理员', '查看部门树', '0b44246ddc4c11e9b510f8b156d274ca', '37', 'V1.1');
INSERT INTO `norms` VALUES ('1e6153dadde911e98c39f8b156d274ca', 'S-0090-002', '在系统中新增一个部门', '点击部门管理页面的增加按钮，用例启动。', '用户选中某个部门。点击增加按钮，输入部门名称和组织ID。系统检验部门名称是否重复，不重复则在选中部门下增加一个子部门，重复则提示用户并返回。', '2.1.用户选择取消，则用例结束。', '如果用户未选中部门点击增加按钮，系统提示用户选择组织，用例结束。', '用户已经成功登录系统并且已经进入部门管理页面。', '在某个部门下新增一个子部门', '系统初始化会默认新建一个根部门，位于树结构的最顶点。新建部门时，组织ID一旦录入则不可修改。', '', '管理员', '新建部门', '0b44246ddc4c11e9b510f8b156d274ca', '38', 'V1.1');
INSERT INTO `norms` VALUES ('1e615693dde911e98c39f8b156d274ca', 'S-0090-003', '删除一个部门', '选中部门，点击部门管理页面的删除按钮，用例启动。', '1.用户选中某个部门。2.点击删除按钮。3.系统提示二次确认，用户点击确定，删除部门。', '3.1 用户选择取消，则用例结束。', '如果未选中部门直接点击删除按钮，提示用户先选择部门，用例结束。', '用户已经成功登录系统并且已经进入部门管理页面。', '删除系统中一个子部门', '有子部门的部门不能删除。', '', '管理员', '删除部门', '0b44246ddc4c11e9b510f8b156d274ca', '38', 'V1.1');
INSERT INTO `norms` VALUES ('1e6169f9dde911e98c39f8b156d274ca', 'S-0090-004', '修改一个部门名称', '选中部门，点击部门管理页面的修改按钮，用例启动。', '1.用户选中某个部门。2.点击修改按钮，输入部门名称。3.系统检验部门名称是否重复，不重复则更新部门名称，并应用在所有引用的地方。', '2.1如果用户选择取消，则用例结束。', '如果用户未选择部门点击修改按钮，系统提示用户选择部门，用例结束。', '用户已经成功登录系统并且已经进入部门管理页面。', '系统更新某个部门的名称，并应用在所有引用的地方。', '只能修改部门名称，不支持修改组织ID。', '', '管理员', '修改部门', '0b44246ddc4c11e9b510f8b156d274ca', '39', 'V1.1');
INSERT INTO `norms` VALUES ('1e617100dde911e98c39f8b156d274ca', 'S-0090-005', '查看一个部门的考勤规则并设置考勤规则。', '选中部门，点击部门管理页面的配置规则按钮，用例启动。', '1.用户选中某个部门。2.点击配置规则按钮。3.系统弹框显示该部门已绑定的考勤规则以及显示考勤规则的下拉选项。4.用户选择某个考勤规则，点击保存。5.系统将该部门与用户选择的规则进行绑定。', '2.1如果用户选择取消，则用例结束。', '如果用户未选择部门点击配置规则按钮，系统提示用户选择部门，用例结束。', '用户已经成功登录系统并且已经进入部门管理页面。', '系统更新某个部门的考勤规则，并应用在人员考勤业务活动中。', '不管部门是否已配置规则，用户重新配置后的规则覆盖原有规则，如原来没配置规则，则直接绑定规则。一个部门只能配置一个规则。已绑定规则的部门，查看时，显示该部门绑定的规则。', '', '管理员', '查看和配置考勤规则', '0b44246ddc4c11e9b510f8b156d274ca', '39', 'V1.1');
INSERT INTO `norms` VALUES ('1e6184b7dde911e98c39f8b156d274ca', 'S-0100-001', '在考勤管理中新建一个考勤规则。', '用户进入考勤规则页面启动编辑，用例启动。', '用户勾选每周的上班日；每个工作日提供三个工作时间段配置，用户勾选启动工作时间段；在勾选的工作时间段里面根据需要勾选签到与签退选项，同时配置该工作时间段起止时间；填入对应工作时间段的签到/退调整时间，时间单位为分钟；点击新增按钮；在弹出的规则名称界面输入规则名称，点击保存按钮。', '', '', '用户已经成功登录系统并且已经进入后台配置端，打开考勤管理页面下的考勤规则tab页。', '考勤规则列表增加一项上述名称的规则项。', '', '', '管理员', '添加考勤规则', '0b44246ddc4c11e9b510f8b156d274ca', '41', 'V1.1');
INSERT INTO `norms` VALUES ('1e6187bcdde911e98c39f8b156d274ca', 'S-0100-002', '在考勤管理中删除一个考勤规则。', '用户进入考勤规则页面点击规则列表的删除按钮，用例启动。', '选中一个已经添加考勤规则；在操作列中点击删除按钮；', '', '', '用户已经成功登录系统并且已经进入后台配置端，打开考勤管理页面下的考勤规则tab页。', '上述选中的考勤规则从考勤规则列表中消失，并删除成功。', '', '', '管理员', '删除考勤规则', '0b44246ddc4c11e9b510f8b156d274ca', '41', 'V1.1');
INSERT INTO `norms` VALUES ('1e6194cadde911e98c39f8b156d274ca', 'S-0100-003', '在考勤管理中添加节假日。', '用户进入节假日设置界面点击添加按钮，用例启动。', '用户在日期插件里面选择一个待添加的节假日日期；点击添加按钮', '', '', '用户已经成功登录系统并且已经进入后台配置端，打开考勤管理页面下的节假日tab页。', '该节假日添加成功，并显示在节假日列表中', '', '', '管理员', '添加节假日', '0b44246ddc4c11e9b510f8b156d274ca', '41', 'V1.1');
INSERT INTO `norms` VALUES ('1e61a7badde911e98c39f8b156d274ca', 'S-0100-004', '在考勤管理中删除节假日。', '用户进入节假日设置子界面列表点击删除按钮，用例启动。', '在假日列表中选择待删除节假日项；点击该项操作列中的删除按钮', '', '', '用户已经成功登录系统并且已经进入后台配置端，打开考勤管理页面下的节假日tab页。', '该节假日从节假日列表消失，并且删除成功。', '', '', '管理员', '删除节假日', '0b44246ddc4c11e9b510f8b156d274ca', '42', 'V1.1');
INSERT INTO `norms` VALUES ('1e61b19bdde911e98c39f8b156d274ca', 'S-0100-005', '在考勤管理中添加工作日。', '用户进入工作日设置子界面点击添加按钮，用例启动。', '用户在工作日设置的日期插件里面选择一个待添加的工作日日期；点击添加按钮', '', '', '用户已经成功登录系统并且已经进入后台配置端，打开考勤管理页面下的节假日tab页。', '该工作日添加成功，并显示在工作日列表中', '', '', '管理员', '添加工作日', '0b44246ddc4c11e9b510f8b156d274ca', '42', 'V1.1');
INSERT INTO `norms` VALUES ('1e61bea6dde911e98c39f8b156d274ca', 'S-0100-006', '在考勤管理中删除工作日。', '用户进入工作日设置子界面列表点击删除按钮，用例启动。', '在假日列表中选择待删除工作日项；点击该项操作列中的删除按钮', '', '', '用户已经成功登录系统并且已经进入后台配置端，打开考勤管理页面下的节假日tab页。', '该工作日从工作日列表消失，并且删除成功。', '', '', '管理员', '删除工作日', '0b44246ddc4c11e9b510f8b156d274ca', '43', 'V1.1');
INSERT INTO `norms` VALUES ('1e61cdb5dde911e98c39f8b156d274ca', 'S-0100-007', '在考勤管理中配置正常班迟到和提前时间。', '用户进入正常班设置页面，用例启动。', '输入迟到不算迟到的迟到时间；输入早退不算早退的提前时间；点击确定按钮。', '', '', '用户已经成功登录系统并且已经进入后台配置端，打开考勤管理页面下的正常班tab页。', '正常班设置保存成功。', '', '', '管理员', '正常班设置', '0b44246ddc4c11e9b510f8b156d274ca', '43', 'V1.1');
INSERT INTO `norms` VALUES ('1e62cc05dde911e98c39f8b156d274ca', 'S-0110-001', '用户在实时浏览界面浏览系统的组织树中的摄像机列表。', '当用户选择浏览组织树功能时，用例启动。', '1.用户点击实时播放视频左边缩进栏，弹出组织树节点。2.系统显示组织树的组织节点。3.用户选择某个组织。4.系统显示该组织的所有摄像机列表。', '3.1.用户在组织树弹框中顶部搜索栏摄像机页签输入摄像机关键字，点搜索按钮。3.2.系统显示包含用户输入关键字的摄像机。3.3.用户切换到组织树弹框中顶部搜索栏的布控页签，选择某个布控任务。3.4系统快捷显示该布控任务下各个摄像机。', '输入的关键字没有对应的摄像机时，系统显示内容为空', '用户已经打开实时浏览界面。', '系统显示用户所选择的组织（或布控或关键字）下的所有摄像机。', '系统只显示用户所选择组织的摄像机节点。输入关键字快速查找时，只筛选摄像机，关键字对组织不生效。系统显示摄像机节点时，需要用不同的图标显示摄像机的在线、离线状态。', '此功能在需要选择组织树和摄像机的弹出框中显示，包括实时布控、人脸考勤首页、活动签到首页。', '操作员、管理员', '浏览组织树和摄像机', '0b44246ddc4c11e9b510f8b156d274ca', '44', 'V1.0');
INSERT INTO `norms` VALUES ('1e62d187dde911e98c39f8b156d274ca', 'S-0110-002', '用户在实时浏览界面浏览系统的布控列表。', '当用户选择浏览布控功能时，用例启动。', '系统显示所有的布控任务。用户可以指定任务状态、布控类型和布控名称进行过滤筛选；系统显示用户过滤后的布控任务。', '', '', '用户已经打开实时浏览界面。', '系统列出一个布控任务列表。', '系统显示列表时，提供分页显示功能。', '', '操作员、管理员', '浏览布控列表', '0b44246ddc4c11e9b510f8b156d274ca', '45', 'V1.0');
INSERT INTO `norms` VALUES ('1e62dd2adde911e98c39f8b156d274ca', 'S-0110-003', '用户在系统中播放一个摄像机的实时视频。', '用户点击播放实时视频功能时，用例启动。', '1.用户打开组织树和摄像机弹窗。2.用户从组织树中选择一个摄像机，双击播放视频。3.系统显示视频播放页面，并播放该摄像机的实时视频。', '', '1.选中的视频不在线或离线时，视频画面不播放视频（即黑屏）。', '用户已经成功登录系统并且已经打开实时浏览界面。', '系统在实时视频页面中播放摄像机实时视频。', '用户可以在播放过程中使用主副码流（H265、H264）、开始、停止操作。实时浏览界面包括实时布控、人脸考勤首页、活动签到首页。', '', '操作员、管理员', '播放实时视频', '0b44246ddc4c11e9b510f8b156d274ca', '118', 'V1.1');
INSERT INTO `norms` VALUES ('1e62e115dde911e98c39f8b156d274ca', 'S-0110-004', '用户在系统中选择一个摄像机时查看实时抓拍。', '用户双击一个摄像机时，用例启动。', '1.用户从组织树中双击一个摄像机。2.系统播放用户所选摄像机的实时视频，并在紧挨视频画面下方滚动显示实时抓拍图片并实时统计最新抓拍数量。', '2.1.点击实时抓拍图片右侧的操作图标，选择快速入库功能，再选择目标库，编辑姓名性别，可以将该图片添加到目标库中。2.2 左键点击抓拍图片时，该图片有场景图时，显示抓拍图片场景图及信息（抓拍时间），没有则无反应。2.3.点击以图搜图快捷按钮时，跳转到抓拍记录以图搜图界面，以选择的抓拍图片作为条件创建搜索任务，设置相似度阈值和时间段后进行以图搜图操作。2.3.点击“更多”，跳转到抓拍记录搜索页面。', '', '用户已经成功登录系统并且已经打开实时浏览界面。', '系统在实时视频画面下方显示实时抓拍图片，实时动态变化显示抓拍数量。', '用户切换摄像机后，系统也切换显示实时抓拍图片。抓拍图片显示人脸图片、抓拍时间、快速入库按钮、打开图片地址按钮、抓拍记录以图搜图快捷按钮。快速入库时，判断抓拍图片质量分，如果质量分低于50则拒绝入库。50-65提示二次确认，65以上可直接入库。实时抓拍应用于实时布控、人脸考勤首页、活动签到首页场景。', '', '操作员、管理员', '查看实时抓拍', '0b44246ddc4c11e9b510f8b156d274ca', '46', 'V1.0');
INSERT INTO `norms` VALUES ('1e63a2aadde911e98c39f8b156d274ca', 'S-0110-005', '用户在系统中选择一个摄像机时查看实时比对结果。', '用户双击一个摄像机时，用例启动。', '1.用户从组织树中双击一个摄像机。2.系统播放用户所该摄像机的实时视频，并在实时浏览页面最下方滚动显示实时比对结果并实时统计最新匹配数量。', '2.1.如果配置了报警声音，有比对结果时会播放声音。如果配置了目标级别，比对结果会用不同颜色以区分，比对上的用蓝色框框出，未比对上的用红色框框出。2.2.点击“更多”，跳转到告警记录搜索页面。', '', '用户已经成功登录系统并且已经打开实时浏览界面。', '系统在实时视频画面最下方显示实时比对结果，实时动态变化显示匹配数量。', '用户切换摄像机后，系统也切换显示实时比对结果。实时比对结果包含时间、抓拍图、目标图、目标属性信息，相似度分值、抓拍点位名称。用户可以选择显示目标的哪些属性，可多选：姓名、性别、年龄、籍贯、证件号码、目标级别、目标库名等。当前未播放的摄像机，比对结果会存在历史记录中。实时比对结果应用在实时布控场景。', '', '操作员、管理员', '查看实时比对结果', '0b44246ddc4c11e9b510f8b156d274ca', '47', 'V1.0');
INSERT INTO `norms` VALUES ('1e63ca55dde911e98c39f8b156d274ca', 'S-0110-006', '用户在系统中选择一个摄像机时查看实时统计。', '用户双击一个摄像机时，用例启动。', '1.用户从组织树中双击一个摄像机。2.系统播放用户所该摄像机的实时视频，并在视频画面右侧实时统计数据，统计数据包含：1、当日0点到24点每小时的实时抓拍数；2、目标库人员频次统计TOPN；3、摄像机点位抓拍数量TOPN。', '', '', '用户已经成功登录系统并且已经打开实时浏览界面。', '系统在实时视频画面右侧动态显示各项统计数据。', '折线图时间轴统一显示0点到24点，当日未统计的时间点则填充0。频次统计TOPN和抓拍数量TOPN则基于所有摄像机。', '', '操作员、管理员', '查看实时统计', '0b44246ddc4c11e9b510f8b156d274ca', '47', 'V1.1');
INSERT INTO `norms` VALUES ('1e63d0cedde911e98c39f8b156d274ca', 'S-0120-001', '新建一个布控任务。', '用户选择添加布控任务时，用例启动。', '1.用户选择基础功能中的布控管理入口，进入布控管理界面；2.用户在界面左侧填写输入项，其中带有星号必输项。输入项包括：布控名称、目标库、监控点位、报警阈值、布控方式、布控时间、布控计划、报警联动地址以及近似目标最大数、备注。3.输入完成后，点击新建任务按钮。4.系统校验用户输入，校验成功则成功插入并且右侧布控列表页面实时刷新。校验失败则提示用户失败信息。', '', '当用户输入的报警阈值不在0~1的范围内时，点击确定按钮后会输出“输入条件不符合要求”。当用户输入的近似目标最大数的值不在1~30的范围内时，点击确定按钮会输出“输入条件不符合要求”。当用户填写星号必输项不完整时，点击确定按钮会输出“输入条件不符合要求”。', '用户已经成功登录系统并且已经打开客户端首页界面。', '布控列表里面新增一个布控任务。', '黑名单布控时，系统发现有布控选中的目标库人物出现时发出提示或者报警；白名单布控时，系统发现未在选中目标库的人则发出报警。一个布控任务可以关联一个或多个目标库、一个或多个摄像机；3.报警联动地址每一种类(短信、邮件、I/O)最多只能添加50个地址；4. 配置邮件报警联动时，支持发送：报警类型，报警时间，报警内容，抓拍图片，比对结果（目标库图片）。配置短信时，支持发送：报警类型，报警时间，报警内容。5.设置布控计划时，布控任务支持根据不同的日程来执行；例如，每天6点到10点执行布控任务。布控计划在配置端配置，此用例提供下拉选择。', '', '操作员、管理员', '添加布控任务', '0b44246ddc4c11e9b510f8b156d274ca', '49', 'V1.1');
INSERT INTO `norms` VALUES ('1e63e5c6dde911e98c39f8b156d274ca', 'S-0120-002', '根据条件检索布控任务', '用户进入布控管理界面，用例启动。', '1.用户选择进入布控管理子界面。2.填写所需检索条件。检索条件包括布控名称、任务状态以及布控方式。3.点击搜索按钮。', '如果在填写所需检索条件时信息选择错误，可以点击重置按钮。', '', '用户已经成功登录系统并且已经打开客户端首页界面。', '布控列表显示符合条件的布控信息。包括布控名称、布控方式、状态、布控时间、创建时间、发现次数以及操作栏。操作栏包含启动/暂停布控、编辑布控任务和建立副本几种操作方式。', '当检索的条件在系统中找不到布控任务的时候，显示结果为空白列表。', '', '操作员、管理员', '布控检索', '0b44246ddc4c11e9b510f8b156d274ca', '50', 'V1.0');
INSERT INTO `norms` VALUES ('1e63fc42dde911e98c39f8b156d274ca', 'S-0120-003', '用户查看布控详情页面及结束布控任务。', '用户双击布控列表时，用例启动。', '用户选择布控管理子界面。选择一条布控任务信息，双击。系统显示布控详细信息。', '3.1 用户点击结束任务按钮。3.2 系统弹框向用户确认是否结束以及结束原因。3.3 用户输入结束原因后点击确定。3.4 系统终止布控任务的进行。3.2.1如果用户点击取消，则取消结束任务。', '', '用户已经成功登录系统并且已经打开布控管理界面。', '弹出所选布控项的布控详情页。布控详情包括任务ID、创建人员、创建时间、布控名称、已选目标库、目标库人数、布控时间、监控点位、报警联动地址、报警阈值、发现次数、布控方式以及近似目标最大数。', '结束的任务不再显示在布控列表中。', '', '操作员、管理员', '布控详情', '0b44246ddc4c11e9b510f8b156d274ca', '51', 'V1.0');
INSERT INTO `norms` VALUES ('1e6400a8dde911e98c39f8b156d274ca', 'S-0120-004', '用户在布控管理界面可以对每个布控操作暂停、开始布控。', '用户单击布控列表操作栏下的对应按钮时，触发对应的操作。', '1、用户选择布控管理子界面。2、点击布控列表操作列下的按钮。', '2.1.正在布控的任务可以选择暂停。2.2.已暂停的任务可以选择开启。', '布控已经暂停后再次暂停时，系统忽略本次操作，布控已经启动后再次启动时，系统忽略本次操作。', '用户已经成功登录系统并且已经打开客户端首页界面。', '暂停、开始布控、修改了布控任务。', '开始布控，实时布控画面显示当前抓拍到的布控目标库中的人员信息。暂停布控，实时布控不再显示布控目标库中的人员信息，可以再次启动布控。', '', '操作员、管理员', '布控操作', '0b44246ddc4c11e9b510f8b156d274ca', '51', 'V1.0');
INSERT INTO `norms` VALUES ('1e64b082dde911e98c39f8b156d274ca', 'S-0120-005', '修改一个布控任务信息。', '选择布控任务列表中某个任务的修改按钮时，用例启动。', '1.用户点击某个布控任务的修改按钮。2.系统弹框显示原布控任务的信息和编辑界面。3.用户重新填写布控任务信息，点击确定。3.系统检验用户输入信息，校验成功则更新布控任务。', '2.1如果用户选择取消，则用例结束。', '', '用户已经成功登录系统并且已经进入布控列表页面，查询出布控任务。', '系统更新某个布控的信息，并按照新的设定对选定目标库的人员进行监控。', '修改布控任务后，该布控任务之前产生的报警信息不涉及改变。但后续对目标库的监控，按照修改后的信息进行。布控方式（黑名单、白名单）不允许修改。', '', '管理员', '修改布控', '0b44246ddc4c11e9b510f8b156d274ca', '107', 'V1.1');
INSERT INTO `norms` VALUES ('1e64c040dde911e98c39f8b156d274ca', 'S-0130-001', '在目标库列表中添加一个目标库。', '用户进入目标库管理子界面时，用例启动。', '1、在目标库管理子界面填写目标库名称和备注信息。2、点击一键新建按钮。3、系统校验目标库名称是否重复，未重复则成功创建目标库，重复则提示用户，用户重新输入。', '', '', '用户已经成功登录系统并且已经打开客户端目标库子界面。', '目标库列表中多了一行目标库信息。', '', '', '操作员、管理员', '新建目标库', '0b44246ddc4c11e9b510f8b156d274ca', '97', 'V1.0');
INSERT INTO `norms` VALUES ('1e65633fdde911e98c39f8b156d274ca', 'S-0130-002', '检索出所需条件的目标库列表。', '用户点击目标库子界面或目标库子界面下搜索按钮时，用例启动。', '1、用户填写搜索条件。2、按回车键。', '', '', '用户已经成功登录系统并且已经打开客户端目标库子界面。', '目标库列表出显示符合条件的目标库信息，包括目标库的名称、人数等信息。', '', '', '操作员、管理员', '目标库检索', '0b44246ddc4c11e9b510f8b156d274ca', '54', 'V1.0');
INSERT INTO `norms` VALUES ('1e6572dcdde911e98c39f8b156d274ca', 'S-0130-003', '在目标库列表中删除一个目标库。', '用户点击目标库列表中的删除按钮时，用例启动。', '用户点击删除按钮。系统弹出删除确认，提示输入密码才能删除。用户填写当前登录账户的密码，点击确定。系统提示删除结果。', '2.1、如果用户点击取消，则用例结束。', '', '用户已经成功登录系统并且已经打开客户端目标库子界面。', '目标库列表中删除了该目标库信息。', '', '删除目标库信息，只需点击相应的删除按钮即可，并输入密码确认，无其他输入条件。', '操作员、管理员', '删除目标库', '0b44246ddc4c11e9b510f8b156d274ca', '54', 'V1.0');
INSERT INTO `norms` VALUES ('1e658a35dde911e98c39f8b156d274ca', 'S-0130-004', '在目标库详细页中添加一个目标。', '用户在目标库详细页中点击新建单个目标按钮时，用例启动。', '1、用户点击新建单个目标按钮或点击身份证导入按钮。2、如点击新建单个目标需要填写详细信息；如点击身份证导入，则需要连接身份证设备，刷身份证。3、填写相应的信息，其中带*号的必填，点击保存。', '2.1、如果用户点击取消，则用例结束。2.2、如果使用身份证导入功能，则将身份证放入身份证读取机，会自动导入相应身份证信息，包括姓名、性别、出生日期、证件类型、证件号码、名族、联系地址。2.3、手动录入目标时，需上传人脸图片', '', '用户已经成功登录系统并且已经打开客户端目标库子界面。', '目标库详细页中多了一个目标。', '同一个目标库只能存在同一个身份证号，新建目标或者身份证导入时，系统校验所在目标库是否已存在相同身份证号，存在则不予新建并提示。新建目标时，判断上传的人脸图片质量分，如果质量分低于50则拒绝入库。50-65提示二次确认，65以上可直接入库。当目标填写了有效期时，有效期内则进行人脸比对，有效期外，则不对人员进行人脸比对。', '目标信息字段通过配置客户端可以添加自定义多个字段，当点击显示扩展字段时，在目标信息后面动态显示用户自定义的字段。', '操作员、管理员', '新建目标', '0b44246ddc4c11e9b510f8b156d274ca', '55', 'V1.0');
INSERT INTO `norms` VALUES ('1e659596dde911e98c39f8b156d274ca', 'S-0130-005', '在目标库详细页中导入目标。', '用户在目标库详细页中点击批量导入目标按钮时，用例启动。', '1、用户点击批量导入目标按钮。2、选择所需格式文件（.zip，.tar，.tar.gz）导入。', '2.1、如果用户点击取消，则用例结束。2.2、如果用户点击导入模板，则选取需要导入的信息，导入文件依据选择的导入信息字段进行命名。', '', '用户已经成功登录系统并且已经打开客户端目标库子界面。', '目标库详细页中多了若干导入成功的目标。', '导入的文件须是.zip，.tar，.tar.gz的压缩包，压缩包内的人脸图片命名格式按照模板的规则进行命名，模板默认是姓名_性别_出生日期，也可以点击设置导入模板进行自定义。上传的压缩包文件不能大于500M。批量入库时，判断每一张人脸图片的质量分，如果质量分低于65则拒绝入库，65以上可直接入库。导入完成后提示成功导入多少，失败多少，同时显示导入失败的人脸图片名称列表和失败原因。', '文件命名分隔符可选“_” 或者“-” 符号。', '操作员、管理员', '目标导入', '0b44246ddc4c11e9b510f8b156d274ca', '56', 'V1.0');
INSERT INTO `norms` VALUES ('1e6598d1dde911e98c39f8b156d274ca', 'S-0130-006', '在目标库详细页中导出目标。', '用户点击相应导出按钮时，用例启动。', '用户点击导出当前页按钮，系统导出当前页面的目标人脸图片。用户点击导出全部按钮，系统导出当前目标库所有目标人脸图片。用户选择若干目标，点击批量导出按钮，系统导出用户所选目标人脸图片。用户点击导出报警按钮，选择报警时间范围和报警次数阈值，系统导出满足条件的目标库人脸报警记录。', '', '如果用户未选择目标，点击批量导出时，系统提示用户选择目标，用例回到基本流程3。', '用户已经成功登录系统并且已经打开客户端目标库子界面。', '导出目标库中相应的文件。', '导出当前页和导出全部的格式为zip，内含人脸图片，图片名字为目标信息。导出报警的格式为excel工作薄，每个目标人脸为一个工作表，每个工作表包含该目标的报警信息列表。', '', '操作员、管理员', '目标导出', '0b44246ddc4c11e9b510f8b156d274ca', '57', 'V1.0');
INSERT INTO `norms` VALUES ('1e66ff04dde911e98c39f8b156d274ca', 'S-0130-007', '在目标库详细页中双击一个目标出现目标详情页。', '用户在目标库详细页中双击一个目标时，用例启动。', '用户双击一个目标。系统显示目标详细信息。', '2.1 点击目标详情页面的报警详情按钮，系统跳转到历史报警记录查询页面，并自动填充该目标人员的名称作为搜索条件。', '', '用户已经成功登录系统并且已经打开客户端目标库详情页界面。', '进入选择目标详情页。', '跳转到历史报警记录页面时，自动填充名称为搜索条件，用户再勾选视频源和时间段后点击可快捷查询报警信息。显示目标人脸图片时，需标注其图片质量分。', '', '操作员、管理员', '目标详情', '0b44246ddc4c11e9b510f8b156d274ca', '58', 'V1.0');
INSERT INTO `norms` VALUES ('1e6898ecdde911e98c39f8b156d274ca', 'S-0130-008', '在目标库详细页中搜索目标。', '用户点击搜索按钮时，用例启动。', '1、用户填写所需检索条件。2、点击搜索。3、系统列出查询目标结果。', '搜索条件一栏点击可以收起展开，更好展示查询结果。显示出查询结果目标列表时，界面支持全选和全不选的操作，方便用户批量操作。', '', '用户已经成功登录系统并且已经打开客户端目标库详情页界面。', '列出目标库满足检索条件的目标。', '列出的目标包含目标人脸图片、姓名、总报警次数。当用户输入的查询条件检索不到任何结果时，目标结果列表显示为空。', '', '操作员、管理员', '目标检索', '0b44246ddc4c11e9b510f8b156d274ca', '59', 'V1.0');
INSERT INTO `norms` VALUES ('1e699f7ddde911e98c39f8b156d274ca', 'S-0130-009', '在目标库详细页中批量删除目标。', '用户点击批量删除按钮时，用例启动。', '1、用户选择若干目标库。2、点击批量删除按钮。', '', '', '用户已经成功登录系统并且已经打开客户端目标库详情页界面。', '目标库详情中删除所选的目标。', '单击目标图片时，选中目标，图片边框标为红色。再次单击目标图片时，取消选中状态。当前页面实时显示已选目标个数。', '', '操作员、管理员', '删除目标', '0b44246ddc4c11e9b510f8b156d274ca', '59', 'V1.0');
INSERT INTO `norms` VALUES ('1e69a580dde911e98c39f8b156d274ca', 'S-0140-001', '用户搜索报警记录和导出。', '用户点击历史记录里报警记录页面时，用例开始。', '填写需要检索的条件。点击搜索按钮。点击导出按钮。', '', '', '用户已经成功登录系统并且已经打开客户端历史记录-报警记录界面。', '出现报警比对信息列表、或导出相应的文件。', '', '', '操作员、管理员', '报警记录检索导出', '0b44246ddc4c11e9b510f8b156d274ca', '61', 'V1.0');
INSERT INTO `norms` VALUES ('1e69a7d3dde911e98c39f8b156d274ca', 'S-0140-002', '操作报警记录。', '用户在报警记录列表的每条记录右侧点击报警详情操作按钮。', '用户点击报警详情按钮。进入报警详情页面显示详细信息。用户选择确认或者误报。系统提示输入当前用户密码和处理说明。', '', '', '用户已经成功登录系统并且已经搜索报警记录列表页面。', '成功确认或误报报警或显示报警详情。', '点击确认后，系统将报警记录标记为已确认。点击误报后，系统将报警记录标记为误报。', '', '操作员、管理员', '报警记录操作', '0b44246ddc4c11e9b510f8b156d274ca', '61', 'V1.0');
INSERT INTO `norms` VALUES ('1e69aa7ddde911e98c39f8b156d274ca', 'S-0140-003', '用户搜索抓拍记录和导出。', '用户点击历史记录里抓拍记录页面时，用例开始。', '填写需要检索的条件。点击搜索按钮。点击导出按钮。', '', '', '用户已经成功登录系统并且已经打开客户端历史记录-抓拍记录界面。', '出现抓拍信息列表、或导出相应的文件（Zip或者Excel格式）。', '时间范围不能超过一个月。', '', '操作员、管理员', '抓拍记录检索导出', '0b44246ddc4c11e9b510f8b156d274ca', '62', 'V1.0');
INSERT INTO `norms` VALUES ('1e69bbbedde911e98c39f8b156d274ca', 'S-0140-004', '查看抓拍记录全景图。', '用户在抓拍记录列表出来单击具体的抓拍记录，用例触发。', '用户单击某个抓拍记录。2、有抓拍大图的显示大图和图片信息，同时出现上一张和下一张快捷操作。', '', '', '用户已经成功登录系统并且已经进入抓拍记录页面。', '弹出抓拍记录场景大图。', '有场景图的才支持单击查看场景图，没有场景图的点击无效', '', '操作员、管理员', '抓拍记录查看大图', '0b44246ddc4c11e9b510f8b156d274ca', '63', 'V1.0');
INSERT INTO `norms` VALUES ('1e69bf26dde911e98c39f8b156d274ca', 'S-0150-001', '新建抓拍库以图搜图检索任务。', '用户点击添加任务按钮时，用例启动。', '1.用户上传人脸图片。2.填写任务名称，时间范围，设置相似度，设置显示结果数。3.点击开始检索。', '1.1.图片需要符合配置的最低质量分，如果低于该质量分，弹出提示，不能创建任务', '', '用户已经成功登录系统并且进入以图搜图-抓拍库检索界面。', '任务列表出现新任务。任务列表页面实时更新任务进度，当任务达到100%时，显示检索结果前三名以及相似度。', '', '', '操作员、管理员', '添加抓拍库检索任务', '0b44246ddc4c11e9b510f8b156d274ca', '64', 'V1.1');
INSERT INTO `norms` VALUES ('1e69c1b5dde911e98c39f8b156d274ca', 'S-0150-002', '新建目标库以图搜图检索任务。', '用户点击新建任务按钮时，用例启动。', '1.用户上传人脸图片。2.填写任务名称，选择目标库，设置相似度，设置显示结果数。3.点击开始检索。', '1.1.图片需要符合配置的最低质量分，如果低于该质量分，弹出提示，不能创建任务', '', '用户已经成功登录系统并且进入以图搜图-目标库检索界面。', '任务列表出现新任务。任务列表页面实时更新任务进度，当任务达到100%时，显示检索结果前三名以及相似度。', '', '', '操作员、管理员', '添加目标库检索任务', '0b44246ddc4c11e9b510f8b156d274ca', '65', 'V1.1');
INSERT INTO `norms` VALUES ('1e69c3b9dde911e98c39f8b156d274ca', 'S-0150-003', '搜索抓拍库或目标库以图搜图任务', '用户在目标库检索标签页或抓拍库检索标签页下点击搜索按钮，用例启动。', '用户填写任务搜索条件。点击查询。', '用户根据所需条件，没有检索出以图搜图标签页下的目标库检索任务或抓拍库检索任务，提示用户没有符合项。', '', '用户已经成功登录系统并且进入以图搜图界面。', '显示符合条件的检索任务列表以及相似度最高前三名。', '任务列表分页显示。', '', '操作员、管理员', '搜索检索任务', '0b44246ddc4c11e9b510f8b156d274ca', '66', 'V1.1');
INSERT INTO `norms` VALUES ('1e69c645dde911e98c39f8b156d274ca', 'S-0150-004', '删除检索任务。', '用户点击抓拍库检索标签页或目标库检索标签页下检索任务列表中的删除按钮时，用例启动。', '1.用户选择一条检索任务记录。2.点击删除按钮。3.系统显示是与否选项。4.选择是，删除该任务记录。', '3.1.点击否，则用例取消。', '', '用户已经成功登录系统并且进入以图搜图界面。', '删除了一个任务以及关联的检索结果，刷新任务列表。', '删除任务时，关联删除该任务的检索结果集。', '', '操作员、管理员', '检索任务删除', '0b44246ddc4c11e9b510f8b156d274ca', '66', 'V1.1');
INSERT INTO `norms` VALUES ('1e69ca60dde911e98c39f8b156d274ca', 'S-0150-005', '查看任务详情或导出。', '用户单击目标库检索任务时，用例启动。', '1.用户单击一条任务记录；2.进入任务详情子界面，显示完整检索的结果和任务详细信息；3.点击导出。', '', '', '用户已经成功登录系统并且进入以图搜图子界面下的目标库检索标签页或抓拍库检索标签页。', '显示任务详情界面或导出检索结果。', '检索结果分页显示。导出检索结果以压缩包形式输出，压缩包内文件名称，如果是目标库检索则包含目标名称及相似度；如果是抓拍库检索则包含抓拍时间、摄像机和相似度。', '', '操作员、管理员', '任务详情导出', '0b44246ddc4c11e9b510f8b156d274ca', '67', 'V1.0');
INSERT INTO `norms` VALUES ('1e69cd59dde911e98c39f8b156d274ca', 'S-0150-006', '选择两张人脸图片，比对这两张人脸图片的相似度', '用户进入以图搜图标签页下1：1比对标签页下时，用例启动。', '1.用户先后选择两张有效人脸图片上传。2.点击一键检索。3.系统显示两张人脸图片的相似度。', '2.1、上传一个人脸过小的图片或非人脸的图片，提示人脸识别服务器内部错误。2.2、上传一个部分遮挡的人脸或角度差的人脸，提示人脸图片质量分小于系统最低质量分。', '', '用户已经成功登录系统并且进入以图搜图标签页界面。', '系统显示2张图片的相似度分值。', '', '', '操作员、管理员', '人脸1:1比对', '0b44246ddc4c11e9b510f8b156d274ca', null, 'V1.0');
INSERT INTO `norms` VALUES ('1e69e1e0dde911e98c39f8b156d274ca', 'S-0160-001', '查看实时考勤', '用户从组织树中选择待查看的摄像机双击摄像机时，用例启动。', '用户进入人脸实时考勤首页；系统显示当前时间、考勤实时统计和系统公告。3.用户点击组织树按钮，展开组织树；4.在组织树的布控任务中选中布控任务，系统在组织树下列出该布控任务所绑定的摄像机；5.选择待查看实时考勤的摄像机双击或者拖动该摄像机到视频播放窗口。6.系统显示实时抓拍信息和打卡成功失败信息。', '用户点击全屏展示可全屏查看实时考勤信息。点击抓拍信息一栏的更多按钮时，自动跳转到历史记录查询，查找条件自动填充为用户选择的摄像机，时间默认最近三天。', '如果用户选择的摄像机为离线时，视频画面不播放视频，抓拍信息一栏显示历史数据。', '用户已经成功登录系统并且进入人脸考勤子界面下的实时考勤标签页。', '1.显示摄像机实时视频。2.直观显眼地显示当前时间。3.显示该摄像机视频场景下的实时考勤打卡记录（实时抓拍记录）。4.显示当日该摄像机所属布控任务的实时考勤统计数据。5.显示系统公告。', '实时考勤统计数据包含已打卡人数及比例、未打卡人数及比例。进入实时考勤页面默认显示上一次实时考勤任务，如果是第一次进入则不显示实时考勤任务。人员经过时，显示打卡成功或失败信息。', '', '操作员、管理员', '查看实时考勤', '0b44246ddc4c11e9b510f8b156d274ca', '114', 'V1.1');
INSERT INTO `norms` VALUES ('1e69e601dde911e98c39f8b156d274ca', 'S-0160-002', '查看考勤统计数据。', '用户点击顶部导航栏考勤统计标签，用例启动。', '1.用户点击顶部导航栏考勤统计标签2系统显示考勤统计信息', '不涉及', '没有考勤数据时，页面各版块正常显示，只是没有正常显示有数据情况下的统计图、曲线图。', '用户已经成功登录系统并且进入人脸考勤子界面下的考勤统计标签页。', '显示今日上班考勤分析：正常、异常、迟到人数及比例（环形图显示）；显示今日上班考勤统计：按部门统计正常、异常、迟到人数，形成柱状图。显示当月各部门迟到人数对比统计图；显示当月各部门考勤准点人数对比统计图；显示近20个工作日考勤准点统计曲线图。', '本月指当前月份的月初（1号）到当前时间。', '', '操作员、管理员', '考勤统计', '0b44246ddc4c11e9b510f8b156d274ca', '115', 'V1.1');
INSERT INTO `norms` VALUES ('1e69ef9ddde911e98c39f8b156d274ca', 'S-0160-003', '查询考勤详细信息', '用户在考勤查询页面点击查询按钮，用例启动。', '1.用户在左侧部门资源中选定查询部门或在部门资源搜索框中输入部门名称关键字进行部门搜索并选择；在右侧选择查询条件，查询条件包括人员名称、考勤状态、考勤周期；2.点击搜索按钮3.系统分页显示考勤记录列表。', '', '', '用户已经成功登录系统并且进入人脸考勤子界面下的考勤查询标签页。', '分页显示人员考勤结果列表', '当检索的条件在系统中找不到人员考勤信息的时候，显示结果为空白列表', '', '操作员、管理员', '考勤查询', '0b44246ddc4c11e9b510f8b156d274ca', '71', 'V1.1');
INSERT INTO `norms` VALUES ('1e69f299dde911e98c39f8b156d274ca', 'S-0160-004', '导出考勤记录', '用户点击导出按钮，用例启动。', '1.点击导出当前页按钮，将当前页的考勤记录数据导出成excel。2.点击导出全部按钮，当所有满足条件的考勤记录数据导出成excel。', '', '', '用户已经成功登录系统、进入人脸考勤子界面下的考勤查询标签页，并且已经搜索出考勤记录结果。', '生成数据导出文件', '导出当前页只导出用户当前查询的页面数据，导出的数据与每页显示的条数一致。', '', '操作员、管理员', '导出考勤记录', '0b44246ddc4c11e9b510f8b156d274ca', '72', 'V1.1');
INSERT INTO `norms` VALUES ('1e69f4afdde911e98c39f8b156d274ca', 'S-0160-005', '用户可对考勤有异议的进行手动修改', '用户点击编辑按钮，用例启动。', '1.选择需修改的考勤记录，点击编辑按钮2.用户在系统弹框页面中输入修改内容3.输入当前用户的密码做二次验证，点击确认4.系统验证输入密码，正确则成功修改考勤记录，错误弹出提示。', '', '', '用户已经成功登录系统、进入人脸考勤子界面下的考勤查询标签页，并且已经搜索出考勤记录结果。', '考勤记录信息变更，考勤记录列表刷新', '修改考勤记录可选择两种处理方式：漏打卡和请假。当选择漏打卡时，时间选择框为空；点击确认按钮，系统提交表单只将有数据的时间提交；当选择请假时，时间选择框默认填充该人员所在班次的上下班时间，操作员可以修改上下班时间；', '', '操作员、管理员', '修改考勤记录', '0b44246ddc4c11e9b510f8b156d274ca', '73', 'V1.1');
INSERT INTO `norms` VALUES ('1e69f714dde911e98c39f8b156d274ca', 'S-0160-006', '设置新的排班', '用户点击新建排班按钮，用例启动。', '用户点击人脸考勤子界面下的排班管理标签用户在左侧填写输入项，输入项包括排班名称、目标库、打卡点位、排班时间、报警阈值、报警联动地址及备注用户点击添加按钮系统校验用户输入，校验通过后在右边排班列表新增一条排班记录；失败则提示用户失败信息', '1.1填写联动值时，需点击I/O值输入框的编辑按钮，弹框填写完整的Http接口；1.2 填写打卡点位时，点击选择按钮，弹出组织树和摄像机，可选择组织或摄像机。', '当用户填写的必填项不完整时，点击添加按钮时弹出提示信息提醒用户。当用户填写的信息不合法时，系统新建排班失败，提示用户失败信息。', '用户已经成功登录系统、进入人脸考勤子界面下的排班管理标签页', '右侧排班列表新增一条排班记录', '报警联动限定为IO联动（Http接口）。目标库支持多选。打卡点位选择组织时，表示选择该组织下所有摄像机作为考勤排班的打卡点位。', '', '操作员、管理员', '新建排班', '0b44246ddc4c11e9b510f8b156d274ca', '73', 'V1.1');
INSERT INTO `norms` VALUES ('1e6a0a7cdde911e98c39f8b156d274ca', 'S-0160-007', '用户搜索排班详细列表', '用户点击搜索按钮，用例启动。', '用户点击人脸考勤子界面下的排班管理标签用户在右侧输入排班名称，选择考勤状态，点击搜索排班列表分页显示满足条件的排班信息', '', '', '用户已经成功登录系统、进入人脸考勤子界面下的排班管理标签页', '分页显示具体的排班信息', '搜索条件为选填，可以不输入搜索条件，默认查全部', '', '操作员、管理员', '排班查询', '0b44246ddc4c11e9b510f8b156d274ca', '74', 'V1.1');
INSERT INTO `norms` VALUES ('1e6a12d3dde911e98c39f8b156d274ca', 'S-0160-008', '用户在排班界面可以对每个排班操作暂停、开始排班。', '用户单击排班列表操作栏下的对应按钮时，触发对应的操作。', '1、点击指定排班信息操作列下的按钮。', '2.1.正在进行的排班可以选择暂停。2.2.已暂停的排班可以选择开启。', '', '用户已经成功登录系统，进入人脸考勤子界面下的排班管理标签页并且已查询出排班信息列表。', '排班暂停、开启。', '', '', '操作员、管理员', '排班操作', '0b44246ddc4c11e9b510f8b156d274ca', '74', 'V1.0');
INSERT INTO `norms` VALUES ('1e6a202fdde911e98c39f8b156d274ca', 'S-0160-009', '修改一个考勤排班信息。', '选择考勤排班列表中某个排班的修改按钮时，用例启动。', '1.用户点击某个排班的修改按钮。2.系统弹框显示原排班的信息和编辑界面。3.用户重新填写排班信息，点击确定。3.系统检验用户输入信息，校验成功则更新排班任务。', '2.1如果用户选择取消，则用例结束。', '', '用户已经成功登录系统并且已经进入排班列表页面，查询出排班列表。', '系统更新某个排班的信息，并按照新的排班对选定目标库的人员进行打卡监控。', '修改排班后，该排班之前产生的人员打卡记录不涉及改变。但后续目标库人员的打卡行为，按照新的排班任务进行。', '', '管理员', '修改排班', '0b44246ddc4c11e9b510f8b156d274ca', '75', 'V1.1');
INSERT INTO `norms` VALUES ('1e6a22f7dde911e98c39f8b156d274ca', 'S-0160-010', '用户查看排班详情页面及结束排班任务。', '用户双击排班列表中某个排班时，用例启动。', '1.用户选择排班管理子界面，查出排班列表。2.双击一个排班任务。3.系统显示排班详细信息。', '3.1 用户点击结束任务按钮。3.2 系统弹框向用户确认是否结束以及结束原因。3.3 用户输入结束原因后点击确定。3.4 系统终止排班任务。3.2.1如果用户点击取消，则取消结束排班任务。', '', '用户已经成功登录系统并且已经打开人脸考勤界面。', '弹出所选排班任务的详情信息。', '结束的任务不再显示在排班列表中。', '', '操作员、管理员', '排班详情', '0b44246ddc4c11e9b510f8b156d274ca', '75', 'V1.0');
INSERT INTO `norms` VALUES ('1e6a27c4dde911e98c39f8b156d274ca', 'S-0170-001', '按时间颗粒度查询一段时间内抓拍报警数据统计', '用户选择条件，点击查询按钮，用例启动。', '1.用户选择查询条件，查询条件包括视频源、时间粒度、时间范围；2.点击查询按钮。 3.系统列出时间范围内每个时间粒度下的总的统计数据，以及每个摄像机在时间范围内的统计数据。', '3.1查询的数据可以导出，点击导出当前页或者导出全部，详见导出抓拍报警统计数据用例。', '如果用户选择的开始时间大于结束时间，系统提示开始时间不能大于结束时间，用例结束。', '用户已经成功登录系统并且进入统计分析子界面下的抓拍报警标签页。', '时间颗粒度维度显示每个时间间隔的抓拍总人次、目标库比对成功人次、陌生人抓拍人次的对比统计图；显示各摄像机抓拍抓拍总人次、目标库比对成功人次、陌生人抓拍人次明细列表。', '时间颗粒度分为时、日、月。比如颗粒度为时，时间范围为某一天，则列出这一天每个小时的统计数据。时间颗粒度为日，时间范围为最近三天，则列出这三天每天的统计数据，以此类推。时间颗粒维度的统计数据不分页，摄像机的统计数据分页显示。选择时间范围时，开始时间默认为所选日期00:00点，结束时间默认为所选日期23:59，可另外调整。', '', '操作员、管理员', '查询抓拍报警数据统计', '0b44246ddc4c11e9b510f8b156d274ca', '77', 'V1.1');
INSERT INTO `norms` VALUES ('1e6a35d5dde911e98c39f8b156d274ca', 'S-0170-002', '导出抓拍报警统计数据', '用户点击导出按钮，用例启动。', '1.点击导出当前页按钮，将当前页统计数据导出成excel。2.点击导出全部按钮，当所有满足条件的统计数据导出成excel。', '', '', '用户已经成功登录系统、进入统计分析子界面下的抓拍报警标签页，并且已经搜索出统计结果。', '生成数据导出文件', '导出当前页只导出摄像机的当前页统计数据，时间颗粒度维度的统计数据全部导出。导出的数据分成两个工作表，一个是时间颗粒度维度的统计数据，一个是摄像机的统计数据', '', '操作员、管理员', '导出抓拍报警统计数据', '0b44246ddc4c11e9b510f8b156d274ca', '78', 'V1.1');
INSERT INTO `norms` VALUES ('1e6a3876dde911e98c39f8b156d274ca', 'S-0170-003', '查询一段时间内目标库人员的出现次数统计', '用户选择条件，点击查询按钮，用例启动。', '1.用户选择查询条件，查询条件包括视频源、时间范围、出现频次；2.点击查询按钮。 3.系统列出每个目标库人员在这段时间内出现的次数，如果用户筛选出现频次，则过滤掉不满足频次条件的人员。', '3.1查询的数据可以导出，点击导出当前页或者导出全部，详见导出频次统计数据用例。', '如果用户选择的开始时间大于结束时间，系统提示开始时间不能大于结束时间，用例结束。', '用户已经成功登录系统并且进入统计分析子界面下的频次统计标签页。', '列出目标库人员的人脸图片和出现次数。', '统计数据分页显示。双击人脸图片可查看该人脸图片抓拍历史记录。', '', '操作员、管理员', '频次统计分析', '0b44246ddc4c11e9b510f8b156d274ca', '79', 'V1.1');
INSERT INTO `norms` VALUES ('1e6a3b39dde911e98c39f8b156d274ca', 'S-0170-004', '导出目标库人员频次统计数据', '用户点击导出按钮，用例启动。', '1.点击导出当前页按钮，将当前页统计数据导出成excel。2.点击导出全部按钮，当所有满足条件的统计数据导出成excel。', '', '', '用户已经成功登录系统、进入统计分析子界面下的频次统计标签页，并且已经搜索出统计结果。', '生成数据导出文件', '导出的excel文件名包含用户选择的时间范围。格式为yyyyMMdd-yyyyMMdd，如20190101-20190131', '', '操作员、管理员', '导出频次统计数据', '0b44246ddc4c11e9b510f8b156d274ca', '80', 'V1.1');
INSERT INTO `norms` VALUES ('1e6a3df5dde911e98c39f8b156d274ca', 'S-0170-005', '查看指定的目标在一段时间内的抓拍记录详情', '用户双击人脸图片，用例启动。', '双击任意一张人脸图片。系统列出该人脸图片在时间范围内的所有抓拍记录，并显示该目标的人脸图片、名字、所在目标库、性别、以及抓拍记录中最高相似度的抓拍图片。', '', '', '用户已经成功登录系统、进入统计分析子界面下的频次统计标签页，并且已经搜索出统计结果。', '列出目标库人员的人脸图片和时间范围内所有抓拍记录', '抓拍记录分页显示。用户选择时间范围搜索出结果后，查看详情时限定的时间范围也保持一致。', '', '操作员、管理员', '频次统计详情', '0b44246ddc4c11e9b510f8b156d274ca', '80', 'V1.1');
INSERT INTO `norms` VALUES ('1e6a4011dde911e98c39f8b156d274ca', 'S-0180-001', '查看实时签到情况', '用户浏览组织树和摄像机，选择待查看的摄像机双击摄像机时，用例启动。', '1.用户点击组织树，浏览组织树或筛选查询摄像机2.在组织树中选择一个摄像机双击3.系统显示该摄像机活动签到情况并实时播放视频', '1.用户点击右上角全屏展示按钮则隐藏导航栏。2.点击签到记录的“更多”按钮，跳转到历史抓拍记录并自动填充条件进行查询。', '', '用户已经成功登录系统、进入活动签到子界面。', '1.实时播放视频，并实时显示签到成功人员信息及签到时间。2.显示活动信息。3.显示当前时间和签到统计信息。4.显示签到记录：实时过往签到人脸及签到时间。', '1.签到统计信息包含已签到人数和未签到人数。2.进入签到子页面首页默认显示上一次实时签到任务详情，否则不显示。3.活动人员经过时，在实时签到首页提示签到成功。', '', '操作员、管理员', '查看实时签到', '0b44246ddc4c11e9b510f8b156d274ca', '116', 'V1.1');
INSERT INTO `norms` VALUES ('1e6a42aadde911e98c39f8b156d274ca', 'S-0180-002', '新建签到活动', '用户点击新建活动按钮，用例启动。', '用户在界面左侧填写活动签到信息。.输入完成后，点击新建活动按钮3.系统校验用户输入，校验成功则成功创建活动。', '1.1填写联动地址时，需点击输入框的编辑按钮，弹框填写完整的Http接口；1.2 填写签到点位时，点击选择按钮，弹出组织树和摄像机，可选择组织或摄像机。', '当用户填写的必填项不完整时，点击添加按钮时弹出提示信息提醒用户。', '用户已经成功登录系统、进入活动签到子界面。', '活动列表中新增一个活动', '报警联动限定为IO联动（Http接口）。目标库支持多选。签到点位选择组织时，表示选择该组织下所有摄像机作为活动签到的签到点位。', '', '操作员、管理员', '新建签到活动', '0b44246ddc4c11e9b510f8b156d274ca', '82', 'V1.1');
INSERT INTO `norms` VALUES ('1e6a50e8dde911e98c39f8b156d274ca', 'S-0180-003', '根据条件查询已创建的活动', '用户点击搜索按钮，用例启动。', '1.用户选择进入活动签到子界面2.填写活动名称关键字，选择活动状态3.点击搜索按钮', '', '', '用户已经成功登录系统、进入活动签到子界面。', '活动列表显示符合条件的活动信息，包括活动名称，活动类型，创建时间，活动状态，已签到人数及操作栏。操作栏包括暂停/开启活动、修改活动几种操作方式', '当检索的条件在系统中找不到活动的时候，显示结果为空白列表', '', '操作员、管理员', '签到活动查询', '0b44246ddc4c11e9b510f8b156d274ca', '83', 'V1.1');
INSERT INTO `norms` VALUES ('1e6a5395dde911e98c39f8b156d274ca', 'S-0180-004', '用户在活动管理界面可以对每个活动操作暂停、开始。', '用户单击活动列表操作栏下的对应按钮时，触发对应的操作。', '1、点击指定活动操作列下的按钮。', '2.1.正在进行的签到活动可以选择暂停、终止。2.2.已暂停的签到活动可以选择开启。', '', '用户已经成功登录系统，进入活动签到子界面下的活动管理标签页并且已查询出活动列表。', '活动暂停、开启。', '', '', '操作员、管理员', '签到活动操作', '0b44246ddc4c11e9b510f8b156d274ca', '84', 'V1.0');
INSERT INTO `norms` VALUES ('1e6a55bbdde911e98c39f8b156d274ca', 'S-0180-005', '修改一个签到活动的信息。', '选择活动列表中某个活动的修改按钮时，用例启动。', '1.用户点击某个活动的修改按钮。2.系统弹框显示原活动的信息和编辑界面。3.用户重新填写活动信息，点击确定。3.系统检验用户输入信息，校验成功则更新活动信息。', '2.1如果用户选择取消，则用例结束。', '', '用户已经成功登录系统并且已经进入活动列表页面，查询出活动列表。', '系统更新某个活动的信息，并按照新的活动时间对选定目标库的人员进行签到监控。', '修改活动后，该活动之前产生的签到记录不涉及改变。但后续目标库人员的签到，按照新的活动时间进行。', '', '管理员', '修改签到活动', '0b44246ddc4c11e9b510f8b156d274ca', '84', 'V1.1');
INSERT INTO `norms` VALUES ('1e6b4dc2dde911e98c39f8b156d274ca', 'S-0180-006', '查看签到活动统计详情', '用户点击活动签到子页面顶部导航栏活动详情标签，用例启动。', '1.用户点击顶部导航栏活动详情标签2.在左侧的活动列表中选择活动点击，或者在搜索框中输入活动名称，点击搜索筛选结果后选择一个活动点击。4. 页面右侧显示活动统计详情', '4.1点击签到统计情况的应到总数、已到人数、未到人数按钮时，分页列出每种情况的人员人脸图片和人员名称。', '', '用户已经成功登录系统、进入活动签到子界面。', '显示选择活动的统计详情，包括活动名称，活动地点，活动时间，活动状态，签到统计情况及活动签到态势图。', '签到统计情况包括：应到总数、已到人数、未到人数。点击可查看详情，详情信息分页显示。', '', '操作员、管理员', '签到活动统计', '0b44246ddc4c11e9b510f8b156d274ca', '85', 'V1.1');
INSERT INTO `norms` VALUES ('1e6b6033dde911e98c39f8b156d274ca', 'S-0180-007', '用户查看活动详情页面及结束签到活动。', '用户双击活动列表中某个排班时，用例启动。', '1.用户选择活动管理子界面，查出活动列表。2.双击一个活动。3.系统显示活动详细信息。', '3.1 用户点击结束任务按钮。3.2 系统弹框向用户确认是否结束以及结束原因。3.3 用户输入结束原因后点击确定。3.4 系统终止活动。3.2.1如果用户点击取消，则取消结束活动。', '', '用户已经成功登录系统并且已经打开活动签到界面。', '弹出所选活动的详情信息。', '结束的活动不再显示在活动列表中。', '', '操作员、管理员', '签到活动详情', '0b44246ddc4c11e9b510f8b156d274ca', '86', 'V1.0');
INSERT INTO `norms` VALUES ('1e6b654edde911e98c39f8b156d274ca', 'S-0190-001', '查询门禁刷卡记录', '用户点击搜索按钮，用例启动。', '1.选择门禁搜索条件或输入关键字，点击搜索按钮。 ', '', '', '用户已经成功登录系统、进入人脸门禁子界面下的门禁记录标签页。', '分页显示门禁刷卡记录', '', '', '操作员、管理员', '查询刷卡记录', '0b44246ddc4c11e9b510f8b156d274ca', '87', 'V1.1');
INSERT INTO `norms` VALUES ('1e6cc4f3dde911e98c39f8b156d274ca', 'S-0190-002', '查询门禁点位', '用户选择切换到门禁点标签页，用例启动。', '用户选择门禁点标签页 系统列出现有门禁点位详细信息', '1.用户点击每个门禁点位的开门操作，可以手动远程开门。', '', '用户已经成功登录系统、进入人脸门禁子界面。', '显示门禁点信息列表', '此列表不分页显示', '', '操作员、管理员', '查看门禁点', '0b44246ddc4c11e9b510f8b156d274ca', '88', 'V1.1');
INSERT INTO `norms` VALUES ('1e6cd060dde911e98c39f8b156d274ca', 'S-0190-003', '给每个门禁点位分配摄像机', '用户点击门禁点列表中分配摄像机列中的绑定按钮，用例启动。', '1.用户选择门禁点标签页；2.点击门禁点列表中一个门禁点下绑定按钮，弹出摄像机分配界面；3.选择绑定的摄像机，点击确定。', '', '', '用户已经成功登录系统、进入人脸门禁子界面。', '', '1、一个门禁点可以绑定多个摄像机，一个摄像机也可以被多个门禁点绑定。', '', '操作员、管理员', '摄像机与门禁点绑定', '0b44246ddc4c11e9b510f8b156d274ca', '89', 'V1.1');
INSERT INTO `norms` VALUES ('1e6cd50edde911e98c39f8b156d274ca', 'S-0200-001', '在日志管理界面查询出相关日志。', '用户日志管理页面时，用例启动。', '用户在日志管理界面点击右上角日志按钮，再点击搜索按钮。填写所需搜索条件。点击搜索。', '1、点击搜索后，如果没有满足搜索条件的日志，则系统显示无日志列表的界面。', '', '用户已经成功登录系统并且已经打开日志管理界面。', '显示查询结果列表', '', '', '操作员、管理员', '日志查询', '0b44246ddc4c11e9b510f8b156d274ca', '90', 'V1.0');
INSERT INTO `norms` VALUES ('1e6ce19adde911e98c39f8b156d274ca', 'S-0210-001', '用户点击以图搜图页面右上角处的新建任务，可以新建目标库以图搜图任务。', '用户单击新建任务图标，选择新建目标库以图搜图任务。', '用户打开APP软件进入以图搜图主页面。用户点击新建任务图标，选择新建目标库以图搜图任务。进入新建页面，用户根据页面信息填写指定内容（任务名称，库名，报警阈值，显示结果数）和上传图片，点击提交。', '', '上传的人脸照片不符合系统要求，需要提示给用户。', '当前页面为以图搜图页面。', '创建目标库以图搜图任务成功。', null, null, '用户', '新建目标库以图搜图任务', '0b44246ddc4c11e9b510f8b156d274ca', '93', 'V1.0.0');
INSERT INTO `norms` VALUES ('1e6ce651dde911e98c39f8b156d274ca', 'S-0210-002', '以图搜图，人脸1：1比对显示相似度。', '用户单击新建任务图标，选择新建1:!以图搜图任务，用例启动。', '1.用户点击左边的上传按钮，上传1张有效人脸图片。2.再点击右边的上传按钮，上传1张有效人脸图片。3.点击比对。', '2.1、上传一个人脸过小的图片或非人脸的图片，提示人脸识别服务器内部错误。2.2、上传一个部分遮挡的人脸或角度差的人脸，提示人脸图片质量分小于系统最低质量分。', '', '用户已经成功登录系统并且进入以图搜图界面。', '系统显示2张图片的相似度分值。', null, null, '用户', '新建人脸1:1比对', '0b44246ddc4c11e9b510f8b156d274ca', null, 'V1.0');
INSERT INTO `norms` VALUES ('1e6ce959dde911e98c39f8b156d274ca', 'S-0210-003', '用户点击以图搜图页面右上角处的新建任务，可以新建抓拍以图搜图任务。', '用户单击新建任务图标，选择新建抓拍以图搜图任务。', '用户打开APP软件进入以图搜图主页面。用户点击新建任务图标，选择新建抓拍以图搜图任务。进入新建页面，用户根据页面信息填写指定内容（任务名称，搜索方式，视频源位置，时间范围，相似度，显示结果数）和上传图片，点击提交。', '', '上传的人脸照片不符合系统要求，需要提示给用户。', '当前页面为以图搜图页面。', '创建抓拍以图搜图任务成功。', null, null, '用户', '新建抓拍以图搜图任务', '0b44246ddc4c11e9b510f8b156d274ca', '94', 'V1.0.0');
INSERT INTO `norms` VALUES ('1e6cec0ddde911e98c39f8b156d274ca', 'S-0210-004', '用户从首页点击以图搜图菜单，进入以图搜图页面，默认为目标库以图搜图任务检索。', '用户单击搜索按钮，进行目标库以图搜图任务检索。', '用户打开APP软件进入以图搜图主页面。用户可以选择时间范围、填写目标任务名称作为检索条件。点击搜索按钮，搜出结果列表信息。', '支持删除单个目标库以图搜图任务。可以单击结果列表中的某条任务进入查看任务详细信息(参考UI设计)。在任务详细信息页面点击单个目标图片，可以查看该目标的详细信息（参考UI设计）。', '', '当前页面为以图搜图页面。', '输出符合条件的目标库以图搜图任务列表', null, null, '用户', '目标库以图搜图任务检索', '0b44246ddc4c11e9b510f8b156d274ca', '94', 'V1.0.0');
INSERT INTO `norms` VALUES ('1e6ceee1dde911e98c39f8b156d274ca', 'S-0210-005', '用户从首页点击以图搜图菜单，进入以图搜图页面，切换到抓拍记录以图搜图任务检索。', '用户单击搜索按钮，进行抓拍记录以图搜图任务检索。', '用户打开APP软件进入以图搜图主页面。用户可以选择时间范围、填写目标任务名称作为检索条件。点击搜索按钮，搜出结果列表信息。', '支持删除单个抓拍记录以图搜图任务。可以单击结果列表中的某条任务进入查看任务详细信息(参考UI设计)。在任务详细信息页面点击单个目标图片，可以查看该目标的详细信息（参考UI设计）。', '', '当前页面为以图搜图页面。', '输出符合条件的抓拍记录以图搜图任务', null, null, '用户', '抓拍记录以图搜图任务检索', '0b44246ddc4c11e9b510f8b156d274ca', '94', 'V1.0.0');
INSERT INTO `norms` VALUES ('1e6cf155dde911e98c39f8b156d274ca', 'S-0220-001', '用户对目标库进行搜索。', '用户在目标库以图搜图任务检索页面点击搜索按钮，用例启动。', '输入搜索条件：库名和开始结束时间。点击搜索按钮。', '', '服务器或者网络异常导致搜索失败。', '用户已经设置好搜索条件，用户已经在系统中增加了目标库。', '搜索创建好的目标库。', '目标库列表显示搜索的结果。', null, '用户', '目标库搜索', '0b44246ddc4c11e9b510f8b156d274ca', '97', 'V1.0.0');
INSERT INTO `norms` VALUES ('1e6cf3d2dde911e98c39f8b156d274ca', 'S-0220-002', '增加新的目标库。', '在目标库管理页面点击新建目标库按钮。', '用户在目标库管理页面点击新建库。在弹出的对话框中输入目标库名称和描述信息。完成目标库添加。', '删除检索出来的目标库。', '目标库命名重复添加失败。网络异常导致目标库新建失败。', '用户拥有增加目标库的权限。', '', '新建目标库成功。', null, '用户', '新建目标库', '0b44246ddc4c11e9b510f8b156d274ca', '97', 'V1.0.0');
INSERT INTO `norms` VALUES ('1e6cf649dde911e98c39f8b156d274ca', 'S-0220-003', '用户给目标库增加人脸目标。', '用户在目标库中点击新建目标，用例启动。', '用户点击新建目标。设置新目标参数，包含姓名、性别等信息选择新建目标人脸图片方式：手机摄像头拍摄或者从本地选取照片手机摄像头拍摄自动框选人脸，识别人脸特征后自动拍照；本地选取图片从本地文件夹直接添加提交配置以及图片完成人脸目标添加。', '', '人脸注册时判断人脸图片质量，对无法注册的人脸，提示是什么原因无法注册成功，如角度不对，清晰度不够，人脸不符合像素大小。部分入库失败时，提示是哪些图片入库失败，并给出失败原因。', '用户创建目标库。', '只能添加正面的人脸，旋转后不能正常识别。批量增加人脸目标：批量增加人脸目标仅支持从本地选取人脸照片，最大支持20张，当图片大于5M时压缩为5M，批量的单个目标的姓名采用图片的名称前10个字符。', '目标库增加人脸目标成功，目标库人脸目标数量增加。', null, '用户', '目标库新建目标', '0b44246ddc4c11e9b510f8b156d274ca', '98', 'V1.0.0');
INSERT INTO `norms` VALUES ('1e6cf8eddde911e98c39f8b156d274ca', 'S-0220-004', '用户删除目标库某个或者多个人脸目标。', '用户在目标库中选择目标，点击删除按钮，用例启动。', '在目标库中选择人脸目标。点击删除目标按钮。', '删除一个目标库中多个目标', '', '用户已经成功创建目标库。', '', '成功删除一个或者多个目标。', null, '用户', '目标库删除目标', '0b44246ddc4c11e9b510f8b156d274ca', '99', 'V1.0.0');
INSERT INTO `norms` VALUES ('1e6e9f8edde911e98c39f8b156d274ca', 'S-0220-005', '用户修改目标库某个人脸目标的信息。', '目标库管理页面，点击某个目标，用例启动。', '点击目标进入编辑页面。修改目标相关信息：包含姓名等以及图片信息。图片信息支持手机拍摄和从本地相册选取。手机摄像头拍摄自动框选人脸，识别人脸特征后自动拍照；本地选取图片从本地文件夹直接添加。', '单个目标可增加多张图片', '。', '创建了目标库，目标库创建了目标。', '只能添加正面的人脸，旋转后不能正常识别。', '编辑完成后，目标库的目标信息更新。', null, '用户', '目标库编辑目标', '0b44246ddc4c11e9b510f8b156d274ca', '99', 'V1.0.0');
INSERT INTO `norms` VALUES ('1e6ea4d3dde911e98c39f8b156d274ca', 'S-0230-001', '用户输入用户名和密码登录APP', '用户第一次打开APP或者退出登录后，用例启动', '用户下载手机APP，打开手机APP用户输入用户名、密码和服务器地址，登录系统关闭APP后再次打开APP，保留登录状态（自动重新登录）', '用户信息查看', '1、 用户名或者密码错误2、 服务器地址不可达', '用户在服务器上面有正确的用户名和密码用户的用户名具有登录手机APP的权限', '1、一个用户账号不能同时在多个终端上面登录2、关闭APP后不结束登录状态，退出登录后才结束登录状态', '1、登录成功后才能正常使用APP2、处于登录状态的用户才能接收到报警消息', null, '用户', '登录', '0b44246ddc4c11e9b510f8b156d274ca', '101', 'V1.0.0');
INSERT INTO `norms` VALUES ('1e7178d1dde911e98c39f8b156d274ca', 'S-0230-002', '在登陆状态下点击退出登录，结束登录状态', '在登陆状态下点击退出登录，用例启动。', '用户点击退出登录APP切换到非登录状态', '退出登录后结束报警消息的接收', '', '用户成功登录APP', '退出登录后不关闭APP非登录状态下使用APP的功能，将自动弹出登录页面，成功登录后在自动切换到相应的功能页面', '正常切换到非登录状态', null, '用户', '退出登录', '0b44246ddc4c11e9b510f8b156d274ca', '101', 'V1.0.0');
INSERT INTO `norms` VALUES ('1e839d60dde911e98c39f8b156d274ca', 'S-0240-001', '用户通过手机随时随地地接收报警消息', '用户在布控设置里面设置了报警布控，布控时间段内服务器产生报警，用例启动。', '1、服务器产生报警，并推送通知给用户手机2、手机接收到通知后，用户点击通知，自动打开APP，并且自动切换到报警页面3、APP自动刷新，获取服务器上面用户最新的报警消息', 'APP处于前台时点击报警通知APP处于后台时点击报警通知APP处于关闭状态是点击报警通知', '1、 报警消息推送失败，手机ID不可达2、 手机权限管理禁用此APP接收消息通知', '用户账号在此手机成功登录过后，此账号未在其他手机上面成功登录，且未退出登录', '报警通知通过网络传送到手机，如果手机离线，服务器只会给手机缓存最后一条消息，其他消息将丢弃', '获取用户的报警列表，报警列表显示内容与UI评审结果保持一致。', null, '用户', '报警通知消息接收', '0b44246ddc4c11e9b510f8b156d274ca', '103', 'V1.0.0');
INSERT INTO `norms` VALUES ('1e83a550dde911e98c39f8b156d274ca', 'S-0240-002', '用户对自己的报警信息进行处理', '用户点击某一条具体的报警，用例启动', '1、用户获取到自己的未处理的报警。2、用户点击某一条具体的报警，进入报警详情页面。3、处理报警，信息上传服务器。', '查看报警具体信息，报警详情显示内容与UI评审结果保持一致。', '', '用户成功获取到未处理的报警列表', '用户只能查看和处理自己的未处理的报警', '正常处理报警', null, '用户', '处理报警', '0b44246ddc4c11e9b510f8b156d274ca', '103', 'V1.0.0');
INSERT INTO `norms` VALUES ('1e83a8e6dde911e98c39f8b156d274ca', 'S-0240-003', '用户新建任务后，任务执行完毕时推送消息给APP告知用户任务完成', '用户新建的任务执行完毕时，用例启动', '1、用户通过手机新建一条任务，任务执行完毕时，服务器推送通知给APP。2、用户手机消息通知栏显示任务完成的通知。3、用户点击此消息。4、自动进入APP任务列表页面，并自动过滤其他的任务（只显示此条任务，任务列表内容和UI评审结果保持一致）', '查看任务详情，任务详情内容和UI评审结果保持一致', '', '用户通过手机或者网页新建任务', '用户只能接收到自己发起的任务完成的通知', '正常查看任务，处理任务', null, '用户', '任务完成消息接收', '0b44246ddc4c11e9b510f8b156d274ca', '104', 'V1.0.0');
INSERT INTO `norms` VALUES ('1e859a9edde911e98c39f8b156d274ca', 'S-0250-001', '用户通过过滤条件进行布控搜索', '点击布控管理按钮，填选相关参数后点击搜索，用例启动。', '1、用户成功登录APP2、用户在首页点击布控管理按钮填写布控名称，选择布控状态相关参数进行搜索', '1、搜索结果布控任务列表选中一条点击进入布控任务详情页，页面有结束任务按钮，点击可结束布控任务，如果是已撤控任务，没有此按钮。', '报警阀值超出0-1范围无可用目标库无可用视频源', '用户成功登录APP', '通过布控名称，布控状态进行筛选布控任务。', '结果显示搜索出符合条件的布控任务。', null, '用户', '布控搜索', '0b44246ddc4c11e9b510f8b156d274ca', '106', 'V1.0.0');
INSERT INTO `norms` VALUES ('1e85a6e1dde911e98c39f8b156d274ca', 'S-0250-002', '用户对布控进行结束', '点击布控结束按钮，用例启动', '1、用户成功登录APP2、用户在首页点击布控管理按钮3、选择一个布控点击进入布控详情页面，点击布控结束按钮。', '无', '布控结束失败，给出布控失败原因弹出框提示。', '用户成功登录APP', '无', '布控结束，页面返回到布控列表页面。', null, '用户', '结束布控', '0b44246ddc4c11e9b510f8b156d274ca', '106', 'V1.0.0');
INSERT INTO `norms` VALUES ('1e85ab7ddde911e98c39f8b156d274ca', 'S-0250-003', '用户新建静态布控任务', '用户点击布控管理按钮，然后点击新建静态布控按钮，用例启动', '1、用户登录APP。2、用户点击布控管理进入布控管理页面。3、用户点击新建静态布控按钮，进入新建静态布控页面。4、用户选填布控名称，目标库，视频源位置，报警阀值，布控类型，近似目标最大数等参数 点击确定按钮提交。', '无', '1、报警阀值超出0-1范围2、无可用目标库3、无可用视频源4、视频源已经布控中', '用户成功登录APP', '报警阀值必须符合0-1范围必须有可用目标库必须有可用视频源', '提示布控成功，并且布控任务列表中增加一条布控任务。', null, '用户', '新建静态布控', '0b44246ddc4c11e9b510f8b156d274ca', '107', 'V1.0.0');
INSERT INTO `norms` VALUES ('1e85bc8ddde911e98c39f8b156d274ca', 'S-0250-004', '用户对布控详情信息进行修改', '点击布控详情右上角 编辑按钮，用例启动', '1、用户成功登录APP2、用户在首页点击布控管理按钮3、选择一个布控点击进入布控详情页面，点击右上角编辑按钮。4、视频源位置，报警阀值，布控类型，近似目标最大数等参数修改后，点击下方确定提交按钮。', '无', '修改布控失败，给出修改布控失败原因弹出框提示。', '用户成功登录APP', '无', '修改布控结束，页面返回到布控列表页面。', null, '用户', '修改布控', '0b44246ddc4c11e9b510f8b156d274ca', '107', 'V1.0.0');
INSERT INTO `norms` VALUES ('1e85c2b5dde911e98c39f8b156d274ca', 'S-0260-001', '用户通过获取设备组织架构，进行实时浏览。', '点击实时浏览进入设备资源树页面，展开设备资源树，选中某个设备，点击设备，用例启动。', '1、用户成功登录APP。2、用户在首页点击实时浏览按钮	，进入设备资源树页面。3、用户展开设备资源树，选中某个设备，进行点击。', '无', '1、设备播放失败。', '用户成功登录APP', '通过展开设备资源树，选择某个设备进行点击播放。', '设备正常播放，显示相关视频画面。', null, '用户', '实时浏览', '0b44246ddc4c11e9b510f8b156d274ca', '109', 'V1.0.0');
INSERT INTO `norms` VALUES ('1e85c572dde911e98c39f8b156d274ca', 'S-0270-001', '用户登录TV APP。', '用户打开TV APP后，用例启动。', '1.TV APP显示登录界面。2.用户输入用户名和密码，用户点击登录按钮。3.TV APP验证用户名和密码，如果验证用户名和密码正确，则登录成功，显示TV APP主功能界面，并显示已经登录的用户名。', '1.1.如果用户上次登录时已经选择记住密码选项，则可以不用输入用户名和密码，TV APP使用上次记住的用户名和密码填充输入框。3.1.如果用户选择记录用户名密码，则TV APP还需要记录用户输入的用户名密码。3.2.如果验证失败，则TV APP显示具体的错误原因，并停留在登录界面。', '如果服务器掉线，点击登录按钮时，不管用户名、密码是否正确，都会弹出服务器提示或者页面卡死。网络异常', '用户已经打开TV APP，系统显示登录界面。', '1.用户登录成功，能够使用TV APP功能。2.登录成功后，TV APP显示当前用户名，显示TV APP主功能按钮.', null, null, '用户', '用户登录', '0b44246ddc4c11e9b510f8b156d274ca', '112', 'V1.0');
INSERT INTO `norms` VALUES ('1e85d099dde911e98c39f8b156d274ca', 'S-0280_001', '查看实时考勤', '用户从首页选择人脸考勤选项点击，用例启动。', '1.用户进入人脸实时考勤首页；2.系统显示当前时间、考勤实时统计和系统公告。3.系统显示实时抓拍信息和打卡成功失败信息。', '无', '如果用户选择的摄像机为离线时，视频画面不播放视频。', '用户已经成功登录TV APP。', '1.显示摄像机实时视频。2.直观显眼地显示当前时间。3.显示该摄像机视频场景下的实时考勤打卡记录（实时抓拍记录）。4.显示当日该摄像机所属布控任务的实时考勤统计数据。5.显示系统公告。', '实时考勤统计数据包含已打卡人数及比例、未打卡人数及比例。人员经过时，显示打卡成功或失败信息。', '', '用户', '查看实时考勤', '0b44246ddc4c11e9b510f8b156d274ca', '114', 'V1.1');
INSERT INTO `norms` VALUES ('1e85d5c0dde911e98c39f8b156d274ca', 'S-0280_002', '查看考勤统计数据。', '用户点击顶部导航栏考勤统计标签，用例启动。', '1.用户点击顶部导航栏考勤统计标签2TV APP显示考勤统计信息', '不涉及', '没有考勤数据时，页面各版块正常显示，只是没有正常显示有数据情况下的统计图、曲线图。', '用户已经成功登录TV APP并且进入人脸考勤子界面下的考勤统计标签页。', '1.显示今日上班考勤分析：正常、异常、迟到人数及比例（环形图显示）；2.显示今日上班考勤统计：按部门统计正常、异常、迟到人数，形成柱状图。3.显示当月各部门迟到人数对比统计图；4显示当月各部门考勤准点人数对比统计图；5.显示近20个工作日考勤准点统计曲线图。', '本月指当前月份的月初（1号）到当前时间。', '', '用户', '考勤统计', '0b44246ddc4c11e9b510f8b156d274ca', '115', 'V1.1');
INSERT INTO `norms` VALUES ('1e85d8e9dde911e98c39f8b156d274ca', 'S-0290-001', '查看实时签到情况', '用户在首页选择活动签到选项点击，用例启动。', '1.用户在首页选择活动签到选项点击进入活动签到页面。1.TV APP显示该摄像机活动签到情况并实时播放视频', '无', '无', '用户已经成功登录TV APP、进入首页。', '1.实时播放视频，并实时显示签到成功人员信息及签到时间。2.显示活动信息。3.显示当前时间和签到统计信息。4.实时显示过往签到人脸及签到时间。', '1.签到统计信息包含已签到人数和比例、未签到人数和比例。。2.活动人员经过时，在实时签到首页提示签到成功。', '', '用户', '查看实时签到', '0b44246ddc4c11e9b510f8b156d274ca', '116', 'V1.1');
INSERT INTO `norms` VALUES ('1e85db6cdde911e98c39f8b156d274ca', 'S-0300-001', '用户在TV APP中播放一个摄像机的实时视频。', '用户点击播放实时视频功能时，用例启动。', '1.系统显示视频播放页面，并播放摄像机的实时视频。', '', '1.选中的视频不在线或离线时，视频画面不播放视频（即黑屏）。', '用户已经成功登录系统并且已经打开实时布控界面。', 'TV APP在实时视频页面中播放摄像机实时视频。', '无', '', '用户', '播放实时视频', '0b44246ddc4c11e9b510f8b156d274ca', '118', 'V1.1');
INSERT INTO `norms` VALUES ('1e85de44dde911e98c39f8b156d274ca', 'PF_ELSE_001', '系统型号是V2234。', null, null, null, null, null, null, null, null, null, '非功能性需求', '0b44246ddc4c11e9b510f8b156d274ca', '118', null);
INSERT INTO `norms` VALUES ('1e85e066dde911e98c39f8b156d274ca', 'PF_ELSE_002', '系统提供BS客户端。', null, null, null, null, null, null, null, null, null, '非功能性需求', '0b44246ddc4c11e9b510f8b156d274ca', '118', null);
INSERT INTO `norms` VALUES ('1e85e29bdde911e98c39f8b156d274ca', 'PF_ELSE_003', '本系统的人脸识别引擎具有授权控制，授权方式：与服务器硬件绑定，通过有效期来授权，默认1个月有效期。', null, null, null, null, null, null, null, null, null, '非功能性需求', '0b44246ddc4c11e9b510f8b156d274ca', '118', null);
INSERT INTO `norms` VALUES ('1e85f1cedde911e98c39f8b156d274ca', 'S-0310-001', '不涉及', null, null, null, null, null, null, null, null, null, '标准与规范', '0b44246ddc4c11e9b510f8b156d274ca', '118', null);
INSERT INTO `norms` VALUES ('1e85f759dde911e98c39f8b156d274ca', 'S-0320-001', '服务器操作系统为CentOS 7.2 64位。', null, null, null, null, null, null, null, null, null, '运行环境', '0b44246ddc4c11e9b510f8b156d274ca', '118', null);
INSERT INTO `norms` VALUES ('1e860094dde911e98c39f8b156d274ca', 'S-0320-002', '客户端操作系统为Windows7 32位和64位。', null, null, null, null, null, null, null, null, null, '运行环境', '0b44246ddc4c11e9b510f8b156d274ca', '118', null);
INSERT INTO `norms` VALUES ('1e86029edde911e98c39f8b156d274ca', 'S-0320-003', '客户端浏览器为IE9、IE11。', null, null, null, null, null, null, null, null, null, '运行环境', '0b44246ddc4c11e9b510f8b156d274ca', '118', null);
INSERT INTO `norms` VALUES ('1e860466dde911e98c39f8b156d274ca', 'S-0340-001', '沿用V2233DH-F V2.0的蓝色界面风格；支持1440*900；1920*1080分辨率。', null, null, null, null, null, null, null, null, null, '接口需求', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8715a3dde911e98c39f8b156d274ca', 'S-0350-001', '登录本系统时，从客户端传输到服务器之间的密码需要加密。', null, null, null, null, null, null, null, null, null, '用户界面', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8718a5dde911e98c39f8b156d274ca', 'S-0350-002', '服务故障时可自动重启服务或重启机器，并自动恢复正常工作。', null, null, null, null, null, null, null, null, null, '用户界面', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e871a94dde911e98c39f8b156d274ca', 'S-0360-001', '系统支持用户并发访问数量20（每个用户进行常规操作，如查看视频、查看抓拍、检索记录、以图搜图）。', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e88a4dcdde911e98c39f8b156d274ca', 'S-0360-002', '系统支持的目标库 人脸总容量最大10万张。', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e88a8a2dde911e98c39f8b156d274ca', 'S-0360-003', '系统支持的目标库 数量为最大255个。', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e88aa91dde911e98c39f8b156d274ca', 'S-0360-004', '服务器(摄像机抓拍到客户端)显示时延小于1s', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e88ac3bdde911e98c39f8b156d274ca', 'S-0360-005', '服务器(摄像机抓拍到客户端)显示时延小于2s', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e88addbdde911e98c39f8b156d274ca', 'S-0360-006', '硬件规格A：批量图像特征提取性能50张/S（约16路人脸抓拍摄像机接入）硬件规格B：批量图像特征提取性能150张/S（约48路人脸抓拍摄像机接入）', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e88afa3dde911e98c39f8b156d274ca', 'S-0360-007-001', '硬件需求：\nCPU：I7-7700 处理性能以上\n内存：32G以上\n硬盘：除去系统空间，能提供4T以上图片存储空间\nGPU： NVIDIA GTX 1060 6GB以上\n网口：千兆网口，2个以上USB口\n成本：10000以下', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e89daf3dde911e98c39f8b156d274ca', 'S-0360-007-002', '批量图像特征提取速度（张/秒）：78张/s', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e89ddd3dde911e98c39f8b156d274ca', 'S-0360-007-003', '批量图像特征提取速度（张/秒）：大于100张/s', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e89e038dde911e98c39f8b156d274ca', 'S-0360-007-004', '单张图像特征提取速度（毫秒/张）：11ms/张', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e89e1f1dde911e98c39f8b156d274ca', 'S-0360-007-005', '1:1特征比对速度（张/秒）：150张/秒', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e89e3a3dde911e98c39f8b156d274ca', 'S-0360-007-006', '1:1图像比对速度（张/秒）：3.5张/秒', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e89e547dde911e98c39f8b156d274ca', 'S-0360-007-007', '1:1图像比对速度（张/秒）：100张/秒', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e89e6e5dde911e98c39f8b156d274ca', 'S-0360-007-008', '并发1：N图像搜库速度：60张/秒\n（张/秒，N=10W，返回top10，用特征信息搜库）', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e89e891dde911e98c39f8b156d274ca', 'S-0360-007-009', '并发1：N特征搜库速度：60张/秒\n（张/秒，N=10W，返回top10，用图片搜库）', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e89ea2fdde911e98c39f8b156d274ca', 'S-0360-007-010', '并发1：N特征搜库速度：100张/秒\n（张/秒，N=10W，返回top10，用图片搜库）', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e89ebbadde911e98c39f8b156d274ca', 'S-0360-007-011', '并发1：N特征搜库速度：150张/秒\n（张/秒，N=10W，返回top10，用图片搜库）', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e89ed58dde911e98c39f8b156d274ca', 'S-0360-007-012', '单张图像入库速度：12毫秒/张\n（毫秒/张，完成图像特征提取，特性信息入库）', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e89eefedde911e98c39f8b156d274ca', 'S-0360-007-013', '批量图像入库速度：30万张/小时  （83.6张/秒）\n（张/小时，完成图像特征提取，特性信息入库）', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e89f106dde911e98c39f8b156d274ca', 'S-0360-007-014', '批量图像入库速度：36万张/小时\n（张/小时，完成图像特征提取，特性信息入库）', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e89f2a3dde911e98c39f8b156d274ca', 'S-0360-007-015', '图片流处理能力：44张/秒\n（张/秒，底库10w，完成特征提取，特征搜库及结果入库，稳定运行24小时无明显延时的值）', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e89f453dde911e98c39f8b156d274ca', 'S-0360-007-016', '图片流处理能力：50张/秒\n（张/秒，底库10w，完成特征提取，特征搜库及结果入库，稳定运行24小时无明显延时的值）', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e89f5eddde911e98c39f8b156d274ca', 'S-0360-007-017', '图片流处理能力：60张/秒\n（张/秒，底库10w，完成特征提取，特征搜库及结果入库，稳定运行24小时无明显延时的值）', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e89f776dde911e98c39f8b156d274ca', 'S-0360-007-018', '视频流接入处理能力：至少接入15路\n（路，1080P视频流，完成人脸检测，特征提取比对分析，10万底库）', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e89f919dde911e98c39f8b156d274ca', 'S-0360-007-019', '10万库容下1：N图片检索告警平均响应时间：不大于1秒', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e89faf9dde911e98c39f8b156d274ca', 'S-0360-007-020', '考虑降低成本，设备增加公司LOGO丝印', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e89fca0dde911e98c39f8b156d274ca', 'S-0360-007-021', '屏蔽硬件上无用的接口，如网口2，USB口，VGA口，DP接口，COM口，SIM卡，音频输入输出接口', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e89fe3edde911e98c39f8b156d274ca', 'S-0360-008-001', '硬件需求：\nCPU：双颗E5-2620v3/v4系列以上处理器\n内存：32G以上，支持扩展\nGPU：GTX1080 11G\n硬盘：最大可提供42T图片存储空间\n网卡：双万兆网卡\n其他：9271-8i RAID卡\n成本：23000以下', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e89ffe7dde911e98c39f8b156d274ca', 'S-0360-008-002', '批量图像特征提取速度（张/秒）：281张/s', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a0191dde911e98c39f8b156d274ca', 'S-0360-008-003', '批量图像特征提取速度（张/秒）：大于350张/s', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a0380dde911e98c39f8b156d274ca', 'S-0360-008-004', '单张图像特征提取速度（毫秒/张）：3ms/张', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a051adde911e98c39f8b156d274ca', 'S-0360-008-005', '1:1特征比对速度（张/秒）：450张/秒', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a06fadde911e98c39f8b156d274ca', 'S-0360-008-006', '1:1图像比对速度（张/秒）：2.5张/秒', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a0898dde911e98c39f8b156d274ca', 'S-0360-008-007', '1:1图像比对速度（张/秒）：350张/秒', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a0a29dde911e98c39f8b156d274ca', 'S-0360-008-008', '并发1：N图像搜库速度：200张/秒\n（张/秒，N=10W，返回top10，用特征信息搜库）', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a10a6dde911e98c39f8b156d274ca', 'S-0360-008-009', '并发1：N特征搜库速度：72张/秒\n（张/秒，N=10W，返回top10，用图片搜库）', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a1280dde911e98c39f8b156d274ca', 'S-0360-008-010', '并发1：N特征搜库速度：150张/秒\n（张/秒，N=10W，返回top10，用图片搜库）', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a1500dde911e98c39f8b156d274ca', 'S-0360-008-011', '并发1：N特征搜库速度：300张/秒\n（张/秒，N=10W，返回top10，用图片搜库）', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a177adde911e98c39f8b156d274ca', 'S-0360-008-012', '单张图像入库速度：4毫秒/张\n（毫秒/张，完成图像特征提取，特性信息入库）', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a191adde911e98c39f8b156d274ca', 'S-0360-008-013', '批量图像入库速度：81万张/小时 （226张/秒）\n（张/小时，完成图像特征提取，特性信息入库）', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a1ab2dde911e98c39f8b156d274ca', 'S-0360-008-014', '批量图像入库速度：125万张/小时\n（张/小时，完成图像特征提取，特性信息入库）', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a1c9edde911e98c39f8b156d274ca', 'S-0360-008-015', '图片流处理能力：80张/秒\n（张/秒，底库10w，完成特征提取，特征搜库及结果入库，稳定运行24小时无明显延时的值）', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a1e53dde911e98c39f8b156d274ca', 'S-0360-008-016', '图片流处理能力：100张/秒\n（张/秒，底库10w，完成特征提取，特征搜库及结果入库，稳定运行24小时无明显延时的值）', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a1ff1dde911e98c39f8b156d274ca', 'S-0360-008-017', '图片流处理能力：200张/秒\n（张/秒，底库10w，完成特征提取，特征搜库及结果入库，稳定运行24小时无明显延时的值）', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a2183dde911e98c39f8b156d274ca', 'S-0360-008-018', '视频流接入处理能力：至少接入50路\n（路，1080P视频流，完成人脸检测，特征提取比对分析，10万底库）', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a233bdde911e98c39f8b156d274ca', 'S-0360-008-019', '10万库容下1：N图片检索告警平均响应时间：不大于1秒', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a2567dde911e98c39f8b156d274ca', 'S-0360-008-020', '考虑降低成本，设备增加公司LOGO丝印', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a270adde911e98c39f8b156d274ca', 'S-0360-008-021', '支持硬盘热插拔，支持客户现场自行操作硬盘', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a28a5dde911e98c39f8b156d274ca', 'S-0360-009-001', '单张/批量人脸注册成功率：95%（人脸图片用V1.0的入库图片集测试）', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a2a45dde911e98c39f8b156d274ca', 'S-0360-009-002', '单张/批量人脸注册成功率：99.9%（人脸图片用V1.0的入库图片集测试）', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a2be3dde911e98c39f8b156d274ca', 'S-0360-009-003', '系统注册失败率：不大于0.09%', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a2e5ddde911e98c39f8b156d274ca', 'S-0360-009-004', '1：N人脸检索比对首位命中率不低于95%\n1：N人脸检索比对TOP5命中率不低于97%\n1：N人脸检索比对TOP10命中率不低于99%', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a3013dde911e98c39f8b156d274ca', 'S-0360-009-005', '1：N人脸检索比对首位命中率不低于98%\n1：N人脸检索比对TOP5命中率不低于99%\n1：N人脸检索比对TOP10命中率不低于99.9%', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a3220dde911e98c39f8b156d274ca', 'S-0360-009-006', '非监视名单误报率不大于2%', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a33bddde911e98c39f8b156d274ca', 'S-0360-009-007', '1:1比对，图片相似度准确率不小于99.9%', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a3613dde911e98c39f8b156d274ca', 'S-0360-009-008', '针对视频流，人脸检测偏转角度支持水平方向转动±30°、倾斜方向转动±45°、俯仰方向转动±40°范围内人脸', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a37c0dde911e98c39f8b156d274ca', 'S-0360-009-009', '针对视频流，最小可检测瞳距小于等于15个像素的人脸图片', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a39bedde911e98c39f8b156d274ca', 'S-0360-009-010', '针对视频流，对于遮挡不大于1/3的人脸，检出率大于99%；准确率大于95%', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a3b5edde911e98c39f8b156d274ca', 'S-0360-009-011', '针对视频流，支持检出单张画面人脸数不小于32张', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a3cf9dde911e98c39f8b156d274ca', 'S-0360-009-012', '最小可识别瞳距等于30个像素的人脸图片，提取特征', null, null, null, null, null, null, null, null, null, '安全', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a3e97dde911e98c39f8b156d274ca', 'S-0370-001', '不涉及', null, null, null, null, null, null, null, null, null, '性能', '0b44246ddc4c11e9b510f8b156d274ca', '119', null);
INSERT INTO `norms` VALUES ('1e8a4092dde911e98c39f8b156d274ca', 'S-0380-001', '提供测试指导文档及必要的测试方式、工具', null, null, null, null, null, null, null, null, null, '兼容性', '0b44246ddc4c11e9b510f8b156d274ca', '122', null);
INSERT INTO `norms` VALUES ('1e8a4254dde911e98c39f8b156d274ca', 'S-0380-002', '安卓手机支持Android 5.0以上', null, null, null, null, null, null, null, null, null, '兼容性', '0b44246ddc4c11e9b510f8b156d274ca', '122', null);
INSERT INTO `norms` VALUES ('1e8a442adde911e98c39f8b156d274ca', 'S-0380-003', '苹果手机支持IOS 8.0以上', null, null, null, null, null, null, null, null, null, '兼容性', '0b44246ddc4c11e9b510f8b156d274ca', '122', null);
INSERT INTO `norms` VALUES ('1e8a45b6dde911e98c39f8b156d274ca', 'S-0390-001', '提供生产指导文档、安装包及安装说明文档', null, null, null, null, null, null, null, null, null, '可测试性', '0b44246ddc4c11e9b510f8b156d274ca', '122', null);
INSERT INTO `norms` VALUES ('1e8a4756dde911e98c39f8b156d274ca', 'S-0400-001', '系统应记录完整的运行日志，便于故障时技术工程师排查原因。', null, null, null, null, null, null, null, null, null, '可生产性', '0b44246ddc4c11e9b510f8b156d274ca', '123', null);
INSERT INTO `norms` VALUES ('1e8a4952dde911e98c39f8b156d274ca', 'S-0400-002', '提供说明书。', null, null, null, null, null, null, null, null, null, '可生产性', '0b44246ddc4c11e9b510f8b156d274ca', '123', null);
INSERT INTO `norms` VALUES ('1e8a4ae6dde911e98c39f8b156d274ca', 'S-0410-001', '不涉及', null, null, null, null, null, null, null, null, null, '可维护性', '0b44246ddc4c11e9b510f8b156d274ca', '123', null);
INSERT INTO `norms` VALUES ('1e8a4c69dde911e98c39f8b156d274ca', 'S-0420-001', '不涉及', null, null, null, null, null, null, null, null, null, '可扩展性', '0b44246ddc4c11e9b510f8b156d274ca', '123', null);
INSERT INTO `norms` VALUES ('1e8a4df4dde911e98c39f8b156d274ca', 'S-0430-001', '提供公安一所或三所做委托检验报告（可用V2234的检测报告）', null, null, null, null, null, null, null, null, null, '可移植性', '0b44246ddc4c11e9b510f8b156d274ca', '123', null);
INSERT INTO `norms` VALUES ('1e8a4f8edde911e98c39f8b156d274ca', 'S-0430-002', '软件著作权', null, null, null, null, null, null, null, null, null, '可移植性', '0b44246ddc4c11e9b510f8b156d274ca', '123', null);
INSERT INTO `norms` VALUES ('1e8a5117dde911e98c39f8b156d274ca', 'S-0440-001', '系统提供简体中文版本。', null, null, null, null, null, null, null, null, null, '认证需求', '0b44246ddc4c11e9b510f8b156d274ca', '123', null);
INSERT INTO `norms` VALUES ('1e8a52abdde911e98c39f8b156d274ca', 'S-0440-002', '系统提供英文版本。', null, null, null, null, null, null, null, null, null, '认证需求', '0b44246ddc4c11e9b510f8b156d274ca', '123', null);
INSERT INTO `norms` VALUES ('1e8a546adde911e98c39f8b156d274ca', 'S-0450-001', '不涉及', null, null, null, null, null, null, null, null, null, '国际化需求', '0b44246ddc4c11e9b510f8b156d274ca', '123', null);
INSERT INTO `norms` VALUES ('1e8a55f9dde911e98c39f8b156d274ca', 'S-0460-001', '不涉及', null, null, null, null, null, null, null, null, null, '结构需求', '0b44246ddc4c11e9b510f8b156d274ca', '124', null);

-- ----------------------------
-- Table structure for overall_design
-- ----------------------------
DROP TABLE IF EXISTS `overall_design`;
CREATE TABLE `overall_design` (
  `overall_design_id` varchar(32) DEFAULT NULL COMMENT '总体设计id',
  `overall_design_url` varchar(255) DEFAULT NULL COMMENT '总体设计的url',
  `product_id` varchar(32) DEFAULT NULL COMMENT '产品id',
  `file_md5` varchar(255) DEFAULT NULL COMMENT '文件的md5值',
  KEY `overall_design_product_id_fk` (`product_id`),
  CONSTRAINT `overall_design_product_id_fk` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of overall_design
-- ----------------------------
INSERT INTO `overall_design` VALUES ('539a5911dc4c11e9b510f8b156d274ca', 'C:/depr/files\\产品维护2_总体设计说明.docx', '0b44246ddc4c11e9b510f8b156d274ca', '847acd9c0313e8ac37ba5ab24a241812');

-- ----------------------------
-- Table structure for overall_design_picture
-- ----------------------------
DROP TABLE IF EXISTS `overall_design_picture`;
CREATE TABLE `overall_design_picture` (
  `overall_design_picture_id` varchar(32) NOT NULL COMMENT '总体设计说明书图片id',
  `overall_design_picture_context` longblob COMMENT '总体设计说明书的图片内容',
  `overall_design_rule_id` varchar(32) DEFAULT NULL COMMENT '图片对应的总体设计规格',
  PRIMARY KEY (`overall_design_picture_id`),
  KEY `overall_design_picture_overall_design_rule_id_fk` (`overall_design_rule_id`),
  CONSTRAINT `overall_design_picture_overall_design_rule_id_fk` FOREIGN KEY (`overall_design_rule_id`) REFERENCES `overall_design_rule` (`overall_design_rule_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of overall_design_picture
-- ----------------------------

-- ----------------------------
-- Table structure for overall_design_rule
-- ----------------------------
DROP TABLE IF EXISTS `overall_design_rule`;
CREATE TABLE `overall_design_rule` (
  `overall_design_rule_id` varchar(32) NOT NULL COMMENT '总体设计规则id',
  `overall_design_rule_name` varchar(255) DEFAULT NULL COMMENT '总体设计规则名称',
  `overall_design_rule_num` varchar(100) DEFAULT NULL COMMENT '总体设计规则编号',
  `overall_design_rule_context` varchar(1500) DEFAULT NULL COMMENT '总体设计规则内容',
  `product_id` varchar(32) DEFAULT NULL COMMENT '产品id',
  `pdf_page` tinyint(4) DEFAULT NULL COMMENT '该规则对应的pdf页数',
  PRIMARY KEY (`overall_design_rule_id`),
  KEY `overall_design_rule_product_id_fk` (`product_id`),
  CONSTRAINT `overall_design_rule_product_id_fk` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of overall_design_rule
-- ----------------------------
INSERT INTO `overall_design_rule` VALUES ('538c3ae1dc4c11e9b510f8b156d274ca', '算法库', 'D-001-0010', null, '0b44246ddc4c11e9b510f8b156d274ca', '13');
INSERT INTO `overall_design_rule` VALUES ('538c4051dc4c11e9b510f8b156d274ca', '引擎', 'D-001-0020', null, '0b44246ddc4c11e9b510f8b156d274ca', '14');
INSERT INTO `overall_design_rule` VALUES ('538c41eedc4c11e9b510f8b156d274ca', '平台服务端BRS', 'D-001-0030', null, '0b44246ddc4c11e9b510f8b156d274ca', '16');
INSERT INTO `overall_design_rule` VALUES ('538c4337dc4c11e9b510f8b156d274ca', '网关服务GWS', 'D-001-0040', null, '0b44246ddc4c11e9b510f8b156d274ca', '21');
INSERT INTO `overall_design_rule` VALUES ('538c44d2dc4c11e9b510f8b156d274ca', '人脸考勤服务ATS', 'D-001-0050', null, '0b44246ddc4c11e9b510f8b156d274ca', '22');
INSERT INTO `overall_design_rule` VALUES ('538c4630dc4c11e9b510f8b156d274ca', '告警联动和门禁服务ARS', 'D-001-0060', null, '0b44246ddc4c11e9b510f8b156d274ca', '23');
INSERT INTO `overall_design_rule` VALUES ('538c4743dc4c11e9b510f8b156d274ca', '平台客户端', 'D-001-0070', null, '0b44246ddc4c11e9b510f8b156d274ca', '24');
INSERT INTO `overall_design_rule` VALUES ('538c488fdc4c11e9b510f8b156d274ca', '基础服务平台DBS', 'D-001-0080', null, '0b44246ddc4c11e9b510f8b156d274ca', '25');
INSERT INTO `overall_design_rule` VALUES ('538c4a39dc4c11e9b510f8b156d274ca', '服务端关键技术与实现', 'D-002-0010', null, '0b44246ddc4c11e9b510f8b156d274ca', '25');
INSERT INTO `overall_design_rule` VALUES ('5396dcf2dc4c11e9b510f8b156d274ca', '客户端关键技术与实现', 'D-002-0020', null, '0b44246ddc4c11e9b510f8b156d274ca', '27');
INSERT INTO `overall_design_rule` VALUES ('5396e018dc4c11e9b510f8b156d274ca', '系统外部接口', 'D-003-0010', null, '0b44246ddc4c11e9b510f8b156d274ca', '27');
INSERT INTO `overall_design_rule` VALUES ('5396e19adc4c11e9b510f8b156d274ca', '系统内部接口', 'D-003-0020', null, '0b44246ddc4c11e9b510f8b156d274ca', '27');
INSERT INTO `overall_design_rule` VALUES ('5396e2dadc4c11e9b510f8b156d274ca', '开发组件设计范例', 'D-004-0010', null, '0b44246ddc4c11e9b510f8b156d274ca', '28');
INSERT INTO `overall_design_rule` VALUES ('5396e3eddc4c11e9b510f8b156d274ca', '开发目录设计范例', 'D-004-0020', null, '0b44246ddc4c11e9b510f8b156d274ca', '29');
INSERT INTO `overall_design_rule` VALUES ('5396e4f7dc4c11e9b510f8b156d274ca', '安全', 'D-007-0010', null, '0b44246ddc4c11e9b510f8b156d274ca', '30');
INSERT INTO `overall_design_rule` VALUES ('5396e612dc4c11e9b510f8b156d274ca', '性能', 'D-007-0020', null, '0b44246ddc4c11e9b510f8b156d274ca', '31');
INSERT INTO `overall_design_rule` VALUES ('5396e72bdc4c11e9b510f8b156d274ca', '兼容性', 'D-007-0030', null, '0b44246ddc4c11e9b510f8b156d274ca', '31');
INSERT INTO `overall_design_rule` VALUES ('5396e82cdc4c11e9b510f8b156d274ca', '可测试性', 'D-007-0040', null, '0b44246ddc4c11e9b510f8b156d274ca', '31');
INSERT INTO `overall_design_rule` VALUES ('5396e944dc4c11e9b510f8b156d274ca', '可生产性', 'D-007-0050', null, '0b44246ddc4c11e9b510f8b156d274ca', '32');
INSERT INTO `overall_design_rule` VALUES ('5396ea45dc4c11e9b510f8b156d274ca', '可扩展性', 'D-007-0060', null, '0b44246ddc4c11e9b510f8b156d274ca', '32');
INSERT INTO `overall_design_rule` VALUES ('5396eb46dc4c11e9b510f8b156d274ca', '可移植性', 'D-007-0070', null, '0b44246ddc4c11e9b510f8b156d274ca', '32');
INSERT INTO `overall_design_rule` VALUES ('5396ec40dc4c11e9b510f8b156d274ca', '认证以及国际化', 'D-007-0080', null, '0b44246ddc4c11e9b510f8b156d274ca', '32');

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `product_id` varchar(32) NOT NULL COMMENT '产品id',
  `product_name` varchar(200) DEFAULT NULL COMMENT '产品名称',
  `product_num` varchar(100) DEFAULT NULL COMMENT '产品编号',
  `product_designation` varchar(500) DEFAULT NULL COMMENT '产品型号',
  `product_type` int(11) DEFAULT NULL COMMENT '产品类型,1代表信息发布，2代表技术产品，3代表信息化产品，4代表其他',
  `product_manager_id` varchar(50) DEFAULT NULL COMMENT '产品负责人id',
  `product_line_id` varchar(32) DEFAULT NULL COMMENT '产品线id',
  `product_describe` varchar(500) DEFAULT NULL COMMENT '产品描述',
  `product_state` tinyint(1) DEFAULT '0' COMMENT '产品状态，0代表未上线，1代表运营中，-1代表已关闭',
  `product_order` varchar(12) DEFAULT '0' COMMENT '需求的序号',
  `product_manager_name` varchar(200) DEFAULT NULL COMMENT '产品经理名字',
  `product_line_name` varchar(255) DEFAULT NULL COMMENT '产品线名字',
  PRIMARY KEY (`product_id`),
  KEY `product_line_id_fk` (`product_line_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES ('0b44246ddc4c11e9b510f8b156d274ca', '产品维护2', 'VF-0000000001', '111', '1', '45b22b44-d854-11e9-9412-d4bed997977c', '93', '1111', '0', '0000000001', '产品经理1', '智能设备产品线');
INSERT INTO `product` VALUES ('4634b1a2dd9f11e98c39f8b156d274ca', '产品测试4', 'VF-0000000004', '1111', '1', '45b22b44-d854-11e9-9412-d4bed997977c', '93', '1111', '0', '0000000004', '产品经理1', '智能设备产品线');
INSERT INTO `product` VALUES ('babe6131dc4c11e9b510f8b156d274ca', '产品测试1', 'VF-0000000002', '11', '1', '45b22b44-d854-11e9-9412-d4bed997977c', '93', '11', '0', '0000000002', '产品经理1', '智能设备产品线');
INSERT INTO `product` VALUES ('c2b957d0dc4c11e9b510f8b156d274ca', '产品测试3', 'VF-0000000003', '1111', '3', '49f29d08-6963-11e9-a814-d4bed997977c', '93', '111', '0', '0000000003', '刘清鹏', '智能设备产品线');

-- ----------------------------
-- Table structure for project
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `project_id` varchar(32) NOT NULL COMMENT '项目id',
  `project_name` varchar(200) DEFAULT NULL COMMENT '项目名称',
  `project_num` varchar(200) DEFAULT NULL COMMENT '项目编号',
  `project_time` datetime DEFAULT NULL COMMENT '项目时间',
  `project_manager_id` varchar(50) DEFAULT NULL COMMENT '项目经理id',
  `project_manager_name` varchar(200) DEFAULT NULL COMMENT '项目经理名字',
  `project_type` tinyint(1) DEFAULT NULL COMMENT '项目类型，1代表正式项目，2代表非正式项目，3代表内部项目',
  `product_id` varchar(32) DEFAULT NULL,
  `project_importance` tinyint(1) DEFAULT '0' COMMENT '项目重要度，1代表重要，0代表不重要',
  `project_urgency` tinyint(1) DEFAULT '0' COMMENT '项目紧急度，1代表紧急，0代表不紧急',
  `project_describe` varchar(500) DEFAULT NULL COMMENT '项目描述',
  `project_state` tinyint(1) DEFAULT NULL COMMENT '项目状态，1代表计划阶段，2代表设计阶段，3代表编码阶段，4代表测试阶段，5代表验收阶段',
  `product_line_id` varchar(32) DEFAULT NULL COMMENT '产品线id',
  `product_line_name` varchar(255) DEFAULT NULL COMMENT '产品线名字',
  PRIMARY KEY (`project_id`),
  KEY `project_product_line_id_fk` (`product_line_id`),
  KEY `project_product_id` (`product_id`),
  CONSTRAINT `project_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of project
-- ----------------------------
INSERT INTO `project` VALUES ('03f2f1bfdb3c11e98ce70cc47a47def0', 'P0600 平安城市全球产业化项目之智能大数据平台之智能管理平台_项目V1.0', 'P0603', '2019-09-23 00:00:00', 'b5c51506-d84c-11e9-8ce7-0cc47a47def0', '项目经理1', '1', null, '1', '1', 'P0600 平安城市全球产业化项目之智能大数据平台之智能管理平台_项目计划V1.0--跟进；P0600 平安城市全球产业化项目之智能大数据平台之智能管理平台_项目计划V1.0--跟进；P0600 平安城市全球产业化项目之智能大数据平台之智能管理平台_项目计划V1.0--跟进', '1', '52', null);
INSERT INTO `project` VALUES ('6d944f67dab211e98ce70cc47a47def0', 'VT232系列摄像机人脸抓拍', 'P0211', '2019-09-18 00:00:00', 'b5c51506-d84c-11e9-8ce7-0cc47a47def0', '项目经理1', '1', null, '1', '1', '', '5', '93', null);
INSERT INTO `project` VALUES ('77d6c24bdb6411e98ce70cc47a47def0', '新增项目', 'P0666', '2019-09-20 00:00:00', 'b5c51506-d84c-11e9-8ce7-0cc47a47def0', '项目经理1', '1', null, '1', '1', '新增项目，新增项目；', '1', '52', null);
