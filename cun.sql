/*
Navicat MySQL Data Transfer

Source Server         : my
Source Server Version : 50625
Source Host           : localhost:3306
Source Database       : cun

Target Server Type    : MYSQL
Target Server Version : 50625
File Encoding         : 65001

Date: 2017-05-10 10:31:00
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `commentitem`
-- ----------------------------
DROP TABLE IF EXISTS `commentitem`;
CREATE TABLE `commentitem` (
`id`  int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键' ,
`weiboId`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '对微博的唯一标识' ,
`comment`  text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '微博评论的原文' ,
`emot`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表情符号特征' ,
`c_zang`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论的藏语部分' ,
`c_han`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论的汉语部分' ,
`c_zang_feature`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '藏语的特征词' ,
`c_han_feature`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '汉语的特征词' ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=1

;

-- ----------------------------
-- Table structure for `corpus`
-- ----------------------------
DROP TABLE IF EXISTS `corpus`;
CREATE TABLE `corpus` (
`id`  int(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
`username`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`timestamp`  datetime NULL DEFAULT NULL ,
`context`  text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`addition`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`tagging`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL ,
`tendency`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`flag_tendency`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`feature`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`type`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`negative`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`degree`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=42926

;

-- ----------------------------
-- Table structure for `corpus_tmp`
-- ----------------------------
DROP TABLE IF EXISTS `corpus_tmp`;
CREATE TABLE `corpus_tmp` (
`id`  int(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
`username`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`timestamp`  datetime NULL DEFAULT NULL ,
`context`  text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`addition`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`tagging`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL ,
`tendency`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`flag_tendency`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`feature`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`type`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`negative`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`degree`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=49272

;

-- ----------------------------
-- Table structure for `corpusitem`
-- ----------------------------
DROP TABLE IF EXISTS `corpusitem`;
CREATE TABLE `corpusitem` (
`id`  int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键' ,
`itemId`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '微博id' ,
`weibo`  text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '藏语微博原句子' ,
`zang`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '藏语文本' ,
`han`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '辅助中文信息' ,
`topic`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '#主题#这里使用;分号隔开' ,
`aux_emot`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '辅助表情符号' ,
`aux_feature`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '汉语情感特征词' ,
`aux_tendency`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通过表情符号或者中文特征进行情感标注' ,
`tendency`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '算法计算情感' ,
`flag`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用来进行训练情感标注  1 rep 可以用于训练 0 rep 不可以训练' ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=1

;

-- ----------------------------
-- Table structure for `dictitem`
-- ----------------------------
DROP TABLE IF EXISTS `dictitem`;
CREATE TABLE `dictitem` (
`id`  int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键' ,
`word`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '词组' ,
`pos`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '词性列' ,
`type`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类别区分' ,
`flag`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0 rep 藏语  1 rep 汉语词汇' COMMENT '0 rep 藏语  1 rep 汉语词汇' ,
`tendency`  tinyint(4) NOT NULL COMMENT '正负倾向' ,
`intensity`  double NULL DEFAULT NULL COMMENT '通过对微博预料进行训练得出的结果' ,
`aux`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '中文辅助信息' ,
`strength`  int(11) NOT NULL COMMENT '中文的对照情感强度' ,
`weibo_flag`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标准微博情感' ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=46610

;

-- ----------------------------
-- Table structure for `g_tmp`
-- ----------------------------
DROP TABLE IF EXISTS `g_tmp`;
CREATE TABLE `g_tmp` (
`id`  int(11) UNSIGNED NOT NULL DEFAULT 0 ,
`username`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`timestamp`  datetime NULL DEFAULT NULL ,
`context`  text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`addition`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`tagging`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL ,
`tendency`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`flag_tendency`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`feature`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`type`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`negative`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`degree`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Table structure for `opinion`
-- ----------------------------
DROP TABLE IF EXISTS `opinion`;
CREATE TABLE `opinion` (
`ID`  int(11) NOT NULL ,
`USERNAME`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`CONTEXT`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`TIMESTAMP`  timestamp NULL DEFAULT NULL ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
`id`  int(11) NOT NULL AUTO_INCREMENT ,
`username`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`password`  varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`sex`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`phone`  varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`email`  varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`type`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`status`  varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`createtime`  timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP ,
`name`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`bcid`  varchar(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`uid`  varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=38

;

-- ----------------------------
-- Auto increment value for `commentitem`
-- ----------------------------
ALTER TABLE `commentitem` AUTO_INCREMENT=1;

-- ----------------------------
-- Auto increment value for `corpus`
-- ----------------------------
ALTER TABLE `corpus` AUTO_INCREMENT=42926;

-- ----------------------------
-- Auto increment value for `corpus_tmp`
-- ----------------------------
ALTER TABLE `corpus_tmp` AUTO_INCREMENT=49272;

-- ----------------------------
-- Auto increment value for `corpusitem`
-- ----------------------------
ALTER TABLE `corpusitem` AUTO_INCREMENT=1;

-- ----------------------------
-- Auto increment value for `dictitem`
-- ----------------------------
ALTER TABLE `dictitem` AUTO_INCREMENT=46610;

-- ----------------------------
-- Auto increment value for `user`
-- ----------------------------
ALTER TABLE `user` AUTO_INCREMENT=38;
