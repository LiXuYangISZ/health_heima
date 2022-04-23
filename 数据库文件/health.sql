/*
SQLyog Ultimate v12.08 (64 bit)
MySQL - 5.5.58 : Database - health
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`health` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `health`;

/*Table structure for table `t_checkgroup` */

DROP TABLE IF EXISTS `t_checkgroup`;

CREATE TABLE `t_checkgroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(32) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL,
  `helpCode` varchar(32) DEFAULT NULL,
  `sex` char(1) DEFAULT NULL,
  `remark` varchar(128) DEFAULT NULL,
  `attention` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='�������';

/*Data for the table `t_checkgroup` */

insert  into `t_checkgroup`(`id`,`code`,`name`,`helpCode`,`sex`,`remark`,`attention`) values (5,'0001','一般检查','YBJC.','0','一般检查吼吼吼','无太大注意事项'),(6,'0002','视力色觉','SLSJ','0','视力色觉',NULL),(7,'0003','血常规','XCG','0','血常规',NULL),(8,'0004','尿常规','NCG','0','尿常规',NULL),(9,'0005','肝功三项','GGSX','0','肝功三项',NULL),(10,'0006','肾功三项','NGSX','0','肾功三项',NULL),(11,'0007','血脂四项','XZSX','0','血脂四项',NULL),(12,'0008','心肌酶三项','XJMSX','0','心肌酶三项',NULL),(13,'0009','甲功三项','JGSX','0','甲功三项',NULL),(14,'0010','子宫附件彩超','ZGFJCC','2','子宫附件彩超',NULL),(15,'0011','胆红素三项','DHSSX','0','胆红素三项',NULL),(16,'0012','检查常规','CLMB','0','无','无'),(17,'001012','测试01','CS01','0','无','无'),(18,'0011','测试检查组','CSJCZ','0','无','123456');

/*Table structure for table `t_checkgroup_checkitem` */

DROP TABLE IF EXISTS `t_checkgroup_checkitem`;

CREATE TABLE `t_checkgroup_checkitem` (
  `checkgroup_id` int(11) NOT NULL DEFAULT '0',
  `checkitem_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`checkgroup_id`,`checkitem_id`),
  KEY `FK_Reference_5` (`checkitem_id`),
  CONSTRAINT `FK_Reference_5` FOREIGN KEY (`checkitem_id`) REFERENCES `t_checkitem` (`id`),
  CONSTRAINT `group_id` FOREIGN KEY (`checkgroup_id`) REFERENCES `t_checkgroup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_checkgroup_checkitem` */

insert  into `t_checkgroup_checkitem`(`checkgroup_id`,`checkitem_id`) values (5,28),(16,28),(17,28),(18,28),(5,29),(17,29),(18,29),(5,30),(16,30),(17,30),(18,30),(5,31),(16,31),(17,31),(5,32),(17,32),(18,32),(6,33),(6,34),(17,34),(18,34),(6,35),(17,35),(18,35),(6,36),(17,36),(6,37),(18,37),(7,38),(7,39),(7,40),(7,41),(7,42),(7,43),(7,44),(7,45),(7,46),(7,47),(7,48),(7,49),(7,50),(7,51),(7,52),(7,53),(7,54),(7,55),(7,56),(8,57),(8,58),(8,59),(8,60),(8,61),(8,62),(8,63),(8,64),(8,65),(8,66),(8,67),(8,68),(8,69),(8,70),(8,71),(9,72),(9,73),(9,74),(10,75),(10,76),(10,77),(10,78),(11,78),(11,79),(11,80),(11,81),(12,82),(12,83),(12,84),(13,85),(13,86),(13,87),(14,88),(14,89),(15,90),(15,91),(15,92);

/*Table structure for table `t_checkitem` */

DROP TABLE IF EXISTS `t_checkitem`;

CREATE TABLE `t_checkitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(16) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL,
  `sex` char(1) DEFAULT NULL,
  `age` varchar(32) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `type` char(1) DEFAULT NULL COMMENT '���������,��Ϊ���ͼ�������',
  `attention` varchar(128) DEFAULT NULL,
  `remark` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8 COMMENT='�������';

/*Data for the table `t_checkitem` */

insert  into `t_checkitem`(`id`,`code`,`name`,`sex`,`age`,`price`,`type`,`attention`,`remark`) values (28,'0001','身高','0','0-100',5,'1','无','身高'),(29,'0002','体重','0','0-100',6,'1','请勿检查前暴饮暴食!','体重'),(30,'0003','体重指数','0','0-100',5,'1','无','体重指数'),(31,'0004','收缩压','0','0-100',5,'1','无','收缩压'),(32,'0005','舒张压','0','0-100',5,'1','无','舒张压'),(33,'0006','裸视力（右）','0','0-100',5,'1','无','裸视力（右）'),(34,'0007','裸视力（左）','0','0-100',5,'1','无','裸视力（左）'),(35,'0008','矫正视力（右）','0','0-100',5,'1','无','矫正视力（右）'),(36,'0009','矫正视力（左）','0','0-100',5,'1','无','矫正视力（左）'),(37,'0010','色觉','0','0-100',5,'1','无','色觉'),(38,'0011','白细胞计数','0','0-100',10,'2','无','白细胞计数'),(39,'0012','红细胞计数','0','0-100',10,'2',NULL,'红细胞计数'),(40,'0013','血红蛋白','0','0-100',10,'2',NULL,'血红蛋白'),(41,'0014','红细胞压积','0','0-100',10,'2',NULL,'红细胞压积'),(42,'0015','平均红细胞体积','0','0-100',10,'2',NULL,'平均红细胞体积'),(43,'0016','平均红细胞血红蛋白含量','0','0-100',10,'2',NULL,'平均红细胞血红蛋白含量'),(44,'0017','平均红细胞血红蛋白浓度','0','0-100',10,'2',NULL,'平均红细胞血红蛋白浓度'),(45,'0018','红细胞分布宽度-变异系数','0','0-100',10,'2',NULL,'红细胞分布宽度-变异系数'),(46,'0019','血小板计数','0','0-100',10,'2',NULL,'血小板计数'),(47,'0020','平均血小板体积','0','0-100',10,'2',NULL,'平均血小板体积'),(48,'0021','血小板分布宽度','0','0-100',10,'2',NULL,'血小板分布宽度'),(49,'0022','淋巴细胞百分比','0','0-100',10,'2',NULL,'淋巴细胞百分比'),(50,'0023','中间细胞百分比','0','0-100',10,'2',NULL,'中间细胞百分比'),(51,'0024','中性粒细胞百分比','0','0-100',10,'2',NULL,'中性粒细胞百分比'),(52,'0025','淋巴细胞绝对值','0','0-100',10,'2',NULL,'淋巴细胞绝对值'),(53,'0026','中间细胞绝对值','0','0-100',10,'2',NULL,'中间细胞绝对值'),(54,'0027','中性粒细胞绝对值','0','0-100',10,'2',NULL,'中性粒细胞绝对值'),(55,'0028','红细胞分布宽度-标准差','0','0-100',10,'2',NULL,'红细胞分布宽度-标准差'),(56,'0029','血小板压积','0','0-100',10,'2',NULL,'血小板压积'),(57,'0030','尿比重','0','0-100',10,'2',NULL,'尿比重'),(58,'0031','尿酸碱度','0','0-100',10,'2',NULL,'尿酸碱度'),(59,'0032','尿白细胞','0','0-100',10,'2',NULL,'尿白细胞'),(60,'0033','尿亚硝酸盐','0','0-100',10,'2',NULL,'尿亚硝酸盐'),(61,'0034','尿蛋白质','0','0-100',10,'2',NULL,'尿蛋白质'),(62,'0035','尿糖','0','0-100',10,'2',NULL,'尿糖'),(63,'0036','尿酮体','0','0-100',10,'2',NULL,'尿酮体'),(64,'0037','尿胆原','0','0-100',10,'2',NULL,'尿胆原'),(65,'0038','尿胆红素','0','0-100',10,'2',NULL,'尿胆红素'),(66,'0039','尿隐血','0','0-100',10,'2',NULL,'尿隐血'),(67,'0040','尿镜检红细胞','0','0-100',10,'2',NULL,'尿镜检红细胞'),(68,'0041','尿镜检白细胞','0','0-100',10,'2',NULL,'尿镜检白细胞'),(69,'0042','上皮细胞','0','0-100',10,'2',NULL,'上皮细胞'),(70,'0043','无机盐类','0','0-100',10,'2',NULL,'无机盐类'),(71,'0044','尿镜检蛋白定性','0','0-100',10,'2',NULL,'尿镜检蛋白定性'),(72,'0045','丙氨酸氨基转移酶','0','0-100',10,'2',NULL,'丙氨酸氨基转移酶'),(73,'0046','天门冬氨酸氨基转移酶','0','0-100',10,'2',NULL,'天门冬氨酸氨基转移酶'),(74,'0047','Y-谷氨酰转移酶','0','0-100',10,'2',NULL,'Y-谷氨酰转移酶'),(75,'0048','尿素','0','0-100',10,'2',NULL,'尿素'),(76,'0049','肌酐','0','0-100',10,'2',NULL,'肌酐'),(77,'0050','尿酸','0','0-100',10,'2',NULL,'尿酸'),(78,'0051','总胆固醇','0','0-100',10,'2',NULL,'总胆固醇'),(79,'0052','甘油三酯','0','0-100',10,'2',NULL,'甘油三酯'),(80,'0053','高密度脂蛋白胆固醇','0','0-100',10,'2',NULL,'高密度脂蛋白胆固醇'),(81,'0054','低密度脂蛋白胆固醇','0','0-100',10,'2',NULL,'低密度脂蛋白胆固醇'),(82,'0055','磷酸肌酸激酶','0','0-100',10,'2',NULL,'磷酸肌酸激酶'),(83,'0056','磷酸肌酸激酶同工酶','0','0-100',10,'2',NULL,'磷酸肌酸激酶同工酶'),(84,'0057','乳酸脱氢酶','0','0-100',10,'2',NULL,'乳酸脱氢酶'),(85,'0058','三碘甲状腺原氨酸','0','0-100',10,'2',NULL,'三碘甲状腺原氨酸'),(86,'0059','甲状腺素','0','0-100',10,'2',NULL,'甲状腺素'),(87,'0060','促甲状腺激素','0','0-100',10,'2',NULL,'促甲状腺激素'),(88,'0061','子宫','2','0-100',10,'2',NULL,'子宫'),(89,'0062','附件','2','0-100',10,'2',NULL,'附件'),(90,'0063','总胆红素','0','0-100',10,'2',NULL,'总胆红素'),(91,'0064','直接胆红素','0','0-100',10,'2',NULL,'直接胆红素'),(92,'0065','间接胆红素','0','0-100',10,'2',NULL,'间接胆红素');

/*Table structure for table `t_member` */

DROP TABLE IF EXISTS `t_member`;

CREATE TABLE `t_member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fileNumber` varchar(32) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL,
  `sex` varchar(8) DEFAULT NULL,
  `idCard` varchar(18) DEFAULT NULL,
  `phoneNumber` varchar(11) DEFAULT NULL,
  `regTime` date DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  `email` varchar(32) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `remark` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10035 DEFAULT CHARSET=utf8;

/*Data for the table `t_member` */

insert  into `t_member`(`id`,`fileNumber`,`name`,`sex`,`idCard`,`phoneNumber`,`regTime`,`password`,`email`,`birthday`,`remark`) values (3,NULL,'张三','2','123456789123456',NULL,'2021-12-08',NULL,'2422737092@qq.com',NULL,NULL),(4,NULL,'曹兄','2','123456789123456',NULL,'2021-12-08',NULL,'3112873446@qq.com',NULL,NULL),(5,NULL,'李四','1','123456789123456789',NULL,'2022-02-10',NULL,'1234563789@qq.com',NULL,NULL),(6,NULL,'王五','1','123456789123456789',NULL,'2022-01-13',NULL,'1234562789@qq.com',NULL,NULL),(10034,NULL,'赵六',NULL,'123456789123456',NULL,'2021-11-04',NULL,'1234567189@qq.com',NULL,NULL);

/*Table structure for table `t_menu` */

DROP TABLE IF EXISTS `t_menu`;

CREATE TABLE `t_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `linkUrl` varchar(128) DEFAULT NULL,
  `path` varchar(128) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `icon` varchar(64) DEFAULT NULL,
  `description` varchar(128) DEFAULT NULL,
  `parentMenuId` int(11) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Reference_13` (`parentMenuId`),
  CONSTRAINT `FK_Reference_13` FOREIGN KEY (`parentMenuId`) REFERENCES `t_menu` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

/*Data for the table `t_menu` */

insert  into `t_menu`(`id`,`name`,`linkUrl`,`path`,`priority`,`icon`,`description`,`parentMenuId`,`level`) values (1,'会员管理',NULL,'2',1,'fa-user-md',NULL,NULL,1),(2,'会员档案','member.html','/2-1',1,NULL,NULL,1,2),(3,'体检上传',NULL,'/2-2',2,NULL,NULL,1,2),(4,'会员统计',NULL,'/2-3',3,NULL,NULL,1,2),(5,'预约管理',NULL,'3',2,'fa-tty',NULL,NULL,1),(6,'预约列表','ordersettinglist.html','/3-1',1,NULL,NULL,5,2),(7,'预约设置','ordersetting.html','/3-2',2,NULL,NULL,5,2),(8,'套餐管理','setmeal.html','/3-3',3,NULL,NULL,5,2),(9,'检查组管理','checkgroup.html','/3-4',4,NULL,NULL,5,2),(10,'检查项管理','checkitem.html','/3-5',5,NULL,NULL,5,2),(11,'健康评估',NULL,'4',3,'fa-stethoscope',NULL,NULL,1),(12,'中医体质辨识',NULL,'/4-1',1,NULL,NULL,11,2),(13,'统计分析',NULL,'5',4,'fa-heartbeat',NULL,NULL,1),(14,'会员数量','report_member.html','/5-1',1,NULL,NULL,13,2),(15,'系统设置',NULL,'6',5,'fa-users',NULL,NULL,1),(16,'菜单管理','menu.html','/6-1',1,NULL,NULL,15,2),(17,'权限管理','permission.html','/6-2',2,NULL,NULL,15,2),(18,'角色管理','role.html','/6-3',3,NULL,NULL,15,2),(19,'用户管理','user.html','/6-4',4,NULL,NULL,15,2),(20,'套餐占比','report_setmeal.html','/5-2',2,NULL,NULL,13,2),(21,'运营数据','report_business.html','/5-3',3,NULL,NULL,13,2);

/*Table structure for table `t_order` */

DROP TABLE IF EXISTS `t_order`;

CREATE TABLE `t_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) DEFAULT NULL COMMENT 'Ա��id',
  `orderDate` date DEFAULT NULL COMMENT 'ԼԤ����',
  `orderType` varchar(8) DEFAULT NULL COMMENT 'ԼԤ���� �绰ԤԼ/΢��ԤԼ',
  `orderStatus` varchar(8) DEFAULT NULL COMMENT 'ԤԼ״̬���Ƿ��',
  `setmeal_id` int(11) DEFAULT NULL COMMENT '����id',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_6` (`setmeal_id`),
  KEY `key_member_id` (`member_id`),
  CONSTRAINT `FK_Reference_6` FOREIGN KEY (`setmeal_id`) REFERENCES `t_setmeal` (`id`),
  CONSTRAINT `key_member_id` FOREIGN KEY (`member_id`) REFERENCES `t_member` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

/*Data for the table `t_order` */

insert  into `t_order`(`id`,`member_id`,`orderDate`,`orderType`,`orderStatus`,`setmeal_id`) values (4,3,'2021-12-10','微信预约','未到诊',13),(5,4,'2021-12-13','微信预约','未到诊',13),(6,3,'2021-12-15','微信预约','未到诊',11),(8,3,'2021-12-22','微信预约','未到诊',12),(9,3,'2021-12-22','微信预约','未到诊',11),(10,3,'2021-12-23','微信预约','未到诊',12),(11,3,'2022-02-24','微信预约','未到诊',11),(12,3,'2022-03-05','微信预约','未到诊',18),(13,3,'2022-03-18','微信预约','未到诊',11),(14,3,'2022-03-06','微信预约','未到诊',11),(15,3,'2022-03-10','微信预约','未到诊',11),(16,3,'2022-03-08','微信预约','未到诊',11),(17,3,'2022-03-19','微信预约','未到诊',11),(18,3,'2022-04-18','微信预约','未到诊',25);

/*Table structure for table `t_ordersetting` */

DROP TABLE IF EXISTS `t_ordersetting`;

CREATE TABLE `t_ordersetting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderDate` date DEFAULT NULL COMMENT 'ԼԤ����',
  `number` int(11) DEFAULT NULL COMMENT '��ԤԼ����',
  `reservations` int(11) DEFAULT NULL COMMENT '��ԤԼ����',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=991 DEFAULT CHARSET=utf8 COMMENT='ԤԼ����';

/*Data for the table `t_ordersetting` */

insert  into `t_ordersetting`(`id`,`orderDate`,`number`,`reservations`) values (296,'2021-10-23',500,300),(297,'2021-10-24',500,300),(298,'2021-10-25',500,300),(299,'2021-10-26',500,300),(300,'2021-10-27',500,300),(301,'2021-10-28',500,300),(302,'2021-10-29',500,300),(303,'2021-10-30',500,300),(304,'2021-10-31',500,300),(305,'2021-11-01',500,300),(306,'2021-11-02',500,300),(307,'2021-11-03',500,300),(308,'2021-11-04',500,300),(309,'2021-11-05',500,300),(310,'2021-11-06',500,300),(311,'2021-11-07',500,300),(312,'2021-11-08',500,300),(313,'2021-11-09',500,300),(314,'2021-11-10',500,300),(315,'2021-11-11',500,300),(316,'2021-11-12',500,300),(317,'2021-11-13',500,300),(318,'2021-11-14',500,300),(319,'2021-11-15',500,300),(320,'2021-11-16',500,300),(321,'2021-11-17',500,300),(322,'2021-11-18',500,300),(323,'2021-11-19',500,300),(324,'2021-11-20',500,300),(325,'2021-11-21',500,300),(326,'2021-11-22',500,300),(327,'2021-11-23',500,300),(328,'2021-11-24',500,300),(329,'2021-11-25',500,300),(330,'2021-11-26',500,300),(331,'2021-11-27',500,300),(332,'2021-11-28',500,300),(333,'2021-11-29',500,300),(334,'2021-11-30',500,300),(335,'2021-12-01',500,300),(336,'2021-12-02',500,300),(337,'2021-12-03',500,198),(338,'2021-12-04',500,260),(339,'2021-12-05',500,300),(340,'2021-12-06',500,380),(341,'2021-12-07',500,300),(342,'2021-12-08',500,300),(344,'2021-12-10',500,301),(345,'2021-12-11',500,300),(346,'2021-12-12',500,560),(347,'2021-12-13',500,301),(348,'2021-12-14',500,300),(349,'2021-12-15',500,301),(350,'2021-12-16',500,380),(351,'2021-12-17',500,400),(352,'2021-12-18',500,300),(353,'2021-12-19',500,456),(354,'2021-12-20',500,400),(355,'2021-12-21',500,560),(356,'2021-12-22',500,405),(357,'2021-12-23',300,101),(358,'2021-12-24',301,300),(359,'2021-12-25',500,300),(360,'2021-12-26',500,600),(361,'2021-12-27',500,300),(362,'2021-12-28',500,300),(363,'2021-12-29',500,300),(364,'2021-12-30',500,500),(365,'2021-12-31',500,400),(366,'2022-02-24',100,1),(367,'2022-02-25',100,NULL),(368,'2022-02-27',100,NULL),(369,'2022-02-28',100,NULL),(370,'2022-03-05',100,1),(371,'2022-03-04',100,NULL),(372,'2022-01-01',100,NULL),(373,'2022-01-02',100,NULL),(374,'2022-01-03',100,NULL),(375,'2022-01-04',100,NULL),(376,'2022-01-05',100,NULL),(377,'2022-01-06',100,NULL),(378,'2022-01-07',100,NULL),(379,'2022-01-08',100,NULL),(380,'2022-01-09',100,NULL),(381,'2022-01-10',100,NULL),(382,'2022-01-11',100,NULL),(383,'2022-01-12',100,NULL),(384,'2022-01-13',100,NULL),(385,'2022-01-14',100,NULL),(386,'2022-01-15',100,NULL),(387,'2022-01-16',100,NULL),(388,'2022-01-17',100,NULL),(389,'2022-01-18',100,NULL),(390,'2022-01-19',100,NULL),(391,'2022-01-20',100,NULL),(392,'2022-01-21',100,NULL),(393,'2022-01-22',100,NULL),(394,'2022-01-23',100,NULL),(395,'2022-01-24',100,NULL),(396,'2022-01-25',100,NULL),(397,'2022-01-26',100,NULL),(398,'2022-01-27',100,NULL),(399,'2022-01-28',100,NULL),(400,'2022-01-29',100,NULL),(401,'2022-01-30',100,NULL),(402,'2022-01-31',100,NULL),(403,'2022-02-01',100,NULL),(404,'2022-02-02',100,NULL),(405,'2022-02-03',100,NULL),(406,'2022-02-04',100,NULL),(407,'2022-02-05',100,NULL),(408,'2022-02-06',100,NULL),(409,'2022-02-07',100,NULL),(410,'2022-02-08',100,NULL),(411,'2022-02-09',100,NULL),(412,'2022-02-10',100,NULL),(413,'2022-02-11',100,NULL),(414,'2022-02-12',100,NULL),(415,'2022-02-13',100,NULL),(416,'2022-02-14',100,NULL),(417,'2022-02-15',100,NULL),(418,'2022-02-16',100,NULL),(419,'2022-02-17',100,NULL),(420,'2022-02-18',100,NULL),(421,'2022-02-19',100,NULL),(422,'2022-02-20',100,NULL),(423,'2022-02-21',100,NULL),(424,'2022-02-22',100,NULL),(425,'2022-02-23',100,NULL),(426,'2022-02-26',100,NULL),(427,'2022-03-01',100,120),(428,'2022-03-02',100,57),(429,'2022-03-03',100,46),(430,'2022-03-06',100,90),(431,'2022-03-07',100,120),(432,'2022-03-08',100,19),(434,'2022-03-10',100,31),(435,'2022-03-11',100,NULL),(436,'2022-03-12',150,NULL),(437,'2022-03-13',150,48),(438,'2022-03-14',150,NULL),(439,'2022-03-15',150,NULL),(440,'2022-03-16',150,145),(441,'2022-03-17',150,165),(442,'2022-03-18',150,122),(443,'2022-03-19',150,66),(444,'2022-03-20',150,89),(445,'2022-03-21',150,196),(446,'2022-03-22',150,45),(447,'2022-03-23',150,32),(448,'2022-03-24',150,NULL),(449,'2022-03-25',150,45),(450,'2022-03-26',150,NULL),(452,'2022-03-28',150,NULL),(453,'2022-03-29',150,NULL),(454,'2022-03-30',150,NULL),(455,'2022-03-31',150,NULL),(456,'2022-04-01',150,NULL),(457,'2022-04-02',150,NULL),(458,'2022-04-03',150,NULL),(459,'2022-04-04',150,NULL),(460,'2022-04-05',150,NULL),(461,'2022-04-06',150,NULL),(462,'2022-04-07',150,NULL),(463,'2022-04-08',150,NULL),(464,'2022-04-09',150,NULL),(465,'2022-04-10',150,NULL),(466,'2022-04-11',150,NULL),(467,'2022-04-12',150,NULL),(468,'2022-04-13',150,NULL),(469,'2022-04-14',150,NULL),(470,'2022-04-15',150,NULL),(471,'2022-04-16',150,NULL),(472,'2022-04-17',150,NULL),(473,'2022-04-18',150,1),(732,'2022-03-09',100,NULL),(733,'2022-03-27',150,NULL),(734,'2022-04-19',150,NULL),(735,'2022-04-20',150,NULL),(736,'2022-04-21',150,NULL),(737,'2022-04-22',150,NULL),(738,'2022-04-23',150,NULL),(739,'2022-04-24',150,NULL),(740,'2022-04-25',250,NULL),(741,'2022-04-26',250,NULL),(742,'2022-04-27',250,NULL),(743,'2022-04-28',250,NULL),(744,'2022-04-29',250,NULL),(745,'2022-04-30',250,NULL),(746,'2022-05-01',250,NULL),(747,'2022-05-02',250,NULL),(748,'2022-05-03',250,NULL),(749,'2022-05-04',250,NULL),(750,'2022-05-05',250,NULL),(751,'2022-05-06',250,NULL),(752,'2022-05-07',250,NULL),(753,'2022-05-08',250,NULL),(754,'2022-05-09',250,NULL),(755,'2022-05-10',250,NULL),(756,'2022-05-11',250,NULL),(757,'2022-05-12',250,NULL),(758,'2022-05-13',250,NULL),(759,'2022-05-14',250,NULL),(760,'2022-05-15',250,NULL),(761,'2022-05-16',250,NULL),(762,'2022-05-17',250,NULL),(763,'2022-05-18',250,NULL),(764,'2022-05-19',250,NULL),(765,'2022-05-20',250,NULL),(766,'2022-05-21',250,NULL),(767,'2022-05-22',250,NULL),(768,'2022-05-23',250,NULL),(769,'2022-05-24',250,NULL),(770,'2022-05-25',250,NULL),(771,'2022-05-26',250,NULL),(772,'2022-05-27',250,NULL),(773,'2022-05-28',250,NULL),(774,'2022-05-29',250,NULL),(775,'2022-05-30',250,NULL),(776,'2022-05-31',250,NULL),(777,'2022-06-01',250,NULL),(778,'2022-06-02',250,NULL),(779,'2022-06-03',250,NULL),(780,'2022-06-04',250,NULL),(781,'2022-06-05',250,NULL),(782,'2022-06-06',250,NULL),(783,'2022-06-07',250,NULL),(784,'2022-06-08',250,NULL),(785,'2022-06-09',250,NULL),(786,'2022-06-10',450,NULL),(787,'2022-06-11',450,NULL),(788,'2022-06-12',450,NULL),(789,'2022-06-13',450,NULL),(790,'2022-06-14',450,NULL),(791,'2022-06-15',450,NULL),(792,'2022-06-16',450,NULL),(793,'2022-06-17',450,NULL),(794,'2022-06-18',450,NULL),(795,'2022-06-19',450,NULL),(796,'2022-06-20',450,NULL),(797,'2022-06-21',450,NULL),(798,'2022-06-22',450,NULL),(799,'2022-06-23',450,NULL),(800,'2022-06-24',450,NULL),(801,'2022-06-25',450,NULL),(802,'2022-06-26',450,NULL),(803,'2022-06-27',450,NULL),(804,'2022-06-28',450,NULL),(805,'2022-06-29',450,NULL),(806,'2022-06-30',450,NULL),(807,'2022-07-01',450,NULL),(808,'2022-07-02',450,NULL),(809,'2022-07-03',450,NULL),(810,'2022-07-04',450,NULL),(811,'2022-07-05',450,NULL),(812,'2022-07-06',450,NULL),(813,'2022-07-07',450,NULL),(814,'2022-07-08',450,NULL),(815,'2022-07-09',450,NULL),(816,'2022-07-10',450,NULL),(817,'2022-07-11',450,NULL),(818,'2022-07-12',450,NULL),(819,'2022-07-13',450,NULL),(820,'2022-07-14',450,NULL),(821,'2022-07-15',450,NULL),(822,'2022-07-16',450,NULL),(823,'2022-07-17',450,NULL),(824,'2022-07-18',450,NULL),(825,'2022-07-19',450,NULL),(826,'2022-07-20',450,NULL),(827,'2022-07-21',450,NULL),(828,'2022-07-22',450,NULL),(829,'2022-07-23',450,NULL),(830,'2022-07-24',450,NULL),(831,'2022-07-25',450,NULL),(832,'2022-07-26',450,NULL),(833,'2022-07-27',450,NULL),(834,'2022-07-28',450,NULL),(835,'2022-07-29',450,NULL),(836,'2022-07-30',450,NULL),(837,'2022-07-31',450,NULL),(838,'2022-08-01',450,NULL),(839,'2022-08-02',450,NULL),(840,'2022-08-03',450,NULL),(841,'2022-08-04',450,NULL),(842,'2022-08-05',450,NULL),(843,'2022-08-06',450,NULL),(844,'2022-08-07',450,NULL),(845,'2022-08-08',450,NULL),(846,'2022-08-09',450,NULL),(847,'2022-08-10',450,NULL),(848,'2022-08-11',450,NULL),(849,'2022-08-12',450,NULL),(850,'2022-08-13',450,NULL),(851,'2022-08-14',450,NULL),(852,'2022-08-15',450,NULL),(853,'2022-08-16',450,NULL),(854,'2022-08-17',450,NULL),(855,'2022-08-18',450,NULL),(856,'2022-08-19',450,NULL),(857,'2022-08-20',450,NULL),(858,'2022-08-21',450,NULL),(859,'2022-08-22',450,NULL),(860,'2022-08-23',450,NULL),(861,'2022-08-24',450,NULL),(862,'2022-08-25',450,NULL),(863,'2022-08-26',450,NULL),(864,'2022-08-27',450,NULL),(865,'2022-08-28',450,NULL),(866,'2022-08-29',450,NULL),(867,'2022-08-30',450,NULL),(868,'2022-08-31',450,NULL),(869,'2022-09-01',450,NULL),(870,'2022-09-02',450,NULL),(871,'2022-09-03',450,NULL),(872,'2022-09-04',450,NULL),(873,'2022-09-05',450,NULL),(874,'2022-09-06',450,NULL),(875,'2022-09-07',450,NULL),(876,'2022-09-08',450,NULL),(877,'2022-09-09',450,NULL),(878,'2022-09-10',450,NULL),(879,'2022-09-11',450,NULL),(880,'2022-09-12',450,NULL),(881,'2022-09-13',450,NULL),(882,'2022-09-14',450,NULL),(883,'2022-09-15',450,NULL),(884,'2022-09-16',450,NULL),(885,'2022-09-17',450,NULL),(886,'2022-09-18',450,NULL),(887,'2022-09-19',450,NULL),(888,'2022-09-20',450,NULL),(889,'2022-09-21',450,NULL),(890,'2022-09-22',450,NULL),(891,'2022-09-23',450,NULL),(892,'2022-09-24',450,NULL),(893,'2022-09-25',450,NULL),(894,'2022-09-26',450,NULL),(895,'2022-09-27',450,NULL),(896,'2022-09-28',450,NULL),(897,'2022-09-29',450,NULL),(898,'2022-09-30',450,NULL),(899,'2022-10-01',450,NULL),(900,'2022-10-02',450,NULL),(901,'2022-10-03',450,NULL),(902,'2022-10-04',450,NULL),(903,'2022-10-05',450,NULL),(904,'2022-10-06',450,NULL),(905,'2022-10-07',450,NULL),(906,'2022-10-08',450,NULL),(907,'2022-10-09',450,NULL),(908,'2022-10-10',450,NULL),(909,'2022-10-11',450,NULL),(910,'2022-10-12',450,NULL),(911,'2022-10-13',450,NULL),(912,'2022-10-14',450,NULL),(913,'2022-10-15',450,NULL),(914,'2022-10-16',450,NULL),(915,'2022-10-17',450,NULL),(916,'2022-10-18',450,NULL),(917,'2022-10-19',450,NULL),(918,'2022-10-20',580,NULL),(919,'2022-10-21',580,NULL),(920,'2022-10-22',580,NULL),(921,'2022-10-23',580,NULL),(922,'2022-10-24',580,NULL),(923,'2022-10-25',580,NULL),(924,'2022-10-26',580,NULL),(925,'2022-10-27',580,NULL),(926,'2022-10-28',580,NULL),(927,'2022-10-29',580,NULL),(928,'2022-10-30',580,NULL),(929,'2022-10-31',580,NULL),(930,'2022-11-01',580,NULL),(931,'2022-11-02',580,NULL),(932,'2022-11-03',580,NULL),(933,'2022-11-04',580,NULL),(934,'2022-11-05',580,NULL),(935,'2022-11-06',580,NULL),(936,'2022-11-07',580,NULL),(937,'2022-11-08',580,NULL),(938,'2022-11-09',580,NULL),(939,'2022-11-10',580,NULL),(940,'2022-11-11',580,NULL),(941,'2022-11-12',580,NULL),(942,'2022-11-13',300,NULL),(943,'2022-11-14',300,NULL),(944,'2022-11-15',300,NULL),(945,'2022-11-16',300,NULL),(946,'2022-11-17',300,NULL),(947,'2022-11-18',300,NULL),(948,'2022-11-19',300,NULL),(949,'2022-11-20',300,NULL),(950,'2022-11-21',300,NULL),(951,'2022-11-22',300,NULL),(952,'2022-11-23',300,NULL),(953,'2022-11-24',300,NULL),(954,'2022-11-25',300,NULL),(955,'2022-11-26',300,NULL),(956,'2022-11-27',300,NULL),(957,'2022-11-28',300,NULL),(958,'2022-11-29',300,NULL),(959,'2022-11-30',300,NULL),(960,'2022-12-01',300,NULL),(961,'2022-12-02',300,NULL),(962,'2022-12-03',300,NULL),(963,'2022-12-04',300,NULL),(964,'2022-12-05',300,NULL),(965,'2022-12-06',300,NULL),(966,'2022-12-07',300,NULL),(967,'2022-12-08',300,NULL),(968,'2022-12-09',300,NULL),(969,'2022-12-10',300,NULL),(970,'2022-12-11',300,NULL),(971,'2022-12-12',300,NULL),(972,'2022-12-13',300,NULL),(973,'2022-12-14',300,NULL),(974,'2022-12-15',300,NULL),(975,'2022-12-16',300,NULL),(976,'2022-12-17',300,NULL),(977,'2022-12-18',300,NULL),(978,'2022-12-19',300,NULL),(979,'2022-12-20',300,NULL),(980,'2022-12-21',300,NULL),(981,'2022-12-22',300,NULL),(982,'2022-12-23',300,NULL),(983,'2022-12-24',300,NULL),(984,'2022-12-25',300,NULL),(985,'2022-12-26',300,NULL),(986,'2022-12-27',300,NULL),(987,'2022-12-28',300,NULL),(988,'2022-12-29',300,NULL),(989,'2022-12-30',300,NULL),(990,'2022-12-31',50,NULL);

/*Table structure for table `t_permission` */

DROP TABLE IF EXISTS `t_permission`;

CREATE TABLE `t_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  `keyword` varchar(64) DEFAULT NULL,
  `description` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

/*Data for the table `t_permission` */

insert  into `t_permission`(`id`,`name`,`keyword`,`description`) values (1,'新增检查项','CHECKITEM_ADD',NULL),(2,'删除检查项','CHECKITEM_DELETE',NULL),(3,'编辑检查项','CHECKITEM_EDIT',NULL),(4,'查询检查项','CHECKITEM_QUERY',NULL),(5,'新增检查组','CHECKGROUP_ADD',NULL),(6,'删除检查组','CHECKGROUP_DELETE',NULL),(7,'编辑检查组','CHECKGROUP_EDIT',NULL),(8,'查询检查组','CHECKGROUP_QUERY',NULL),(9,'新增套餐','SETMEAL_ADD',NULL),(10,'删除套餐','SETMEAL_DELETE',NULL),(11,'编辑套餐','SETMEAL_EDIT',NULL),(12,'查询套餐','SETMEAL_QUERY',NULL),(13,'预约设置','ORDERSETTING',NULL),(14,'查看统计报表','REPORT_VIEW',NULL),(15,'新增菜单','MENU_ADD',NULL),(16,'删除菜单','MENU_DELETE',NULL),(17,'编辑菜单','MENU_EDIT',NULL),(18,'查询菜单','MENU_QUERY',NULL),(19,'新增角色','ROLE_ADD',NULL),(20,'删除角色','ROLE_DELETE',NULL),(21,'编辑角色','ROLE_EDIT',NULL),(22,'查询角色','ROLE_QUERY',NULL),(23,'新增用户','USER_ADD',NULL),(24,'删除用户','USER_DELETE',NULL),(25,'编辑用户','USER_EDIT',NULL),(26,'查询用户','USER_QUERY',NULL);

/*Table structure for table `t_role` */

DROP TABLE IF EXISTS `t_role`;

CREATE TABLE `t_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  `keyword` varchar(64) DEFAULT NULL,
  `description` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `t_role` */

insert  into `t_role`(`id`,`name`,`keyword`,`description`) values (1,'系统管理员','ROLE_ADMIN',NULL),(2,'健康管理师','ROLE_HEALTH_MANAGER',NULL),(3,'健康治疗师','ROLE_HEALTH_TREATMENT',NULL),(4,'健康咨询师','ROLE_HEALTH_ASK',NULL);

/*Table structure for table `t_role_menu` */

DROP TABLE IF EXISTS `t_role_menu`;

CREATE TABLE `t_role_menu` (
  `role_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  PRIMARY KEY (`role_id`,`menu_id`),
  KEY `FK_Reference_10` (`menu_id`),
  CONSTRAINT `FK_Reference_10` FOREIGN KEY (`menu_id`) REFERENCES `t_menu` (`id`),
  CONSTRAINT `FK_Reference_9` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_role_menu` */

insert  into `t_role_menu`(`role_id`,`menu_id`) values (1,1),(2,1),(1,2),(2,2),(1,3),(2,3),(1,4),(2,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(1,17),(1,18),(1,19),(1,20),(1,21);

/*Table structure for table `t_role_permission` */

DROP TABLE IF EXISTS `t_role_permission`;

CREATE TABLE `t_role_permission` (
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`role_id`,`permission_id`),
  KEY `FK_Reference_12` (`permission_id`),
  CONSTRAINT `FK_Reference_11` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`id`),
  CONSTRAINT `FK_Reference_12` FOREIGN KEY (`permission_id`) REFERENCES `t_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_role_permission` */

insert  into `t_role_permission`(`role_id`,`permission_id`) values (1,1),(2,1),(3,1),(1,2),(2,2),(1,3),(2,3),(3,3),(1,4),(2,4),(3,4),(4,4),(1,5),(2,5),(3,5),(1,6),(2,6),(1,7),(2,7),(3,7),(1,8),(2,8),(3,8),(4,8),(1,9),(2,9),(3,9),(1,10),(2,10),(1,11),(2,11),(3,11),(1,12),(2,12),(3,12),(4,12),(1,13),(2,13),(1,14),(2,14),(3,14),(4,14),(1,15),(1,16),(1,17),(1,18),(1,19),(1,20),(1,21),(1,22),(1,23),(1,24),(1,25),(1,26);

/*Table structure for table `t_setmeal` */

DROP TABLE IF EXISTS `t_setmeal`;

CREATE TABLE `t_setmeal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `code` varchar(8) DEFAULT NULL,
  `helpCode` varchar(16) DEFAULT NULL,
  `sex` char(1) DEFAULT NULL,
  `age` varchar(32) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `remark` varchar(128) DEFAULT NULL,
  `attention` varchar(128) DEFAULT NULL,
  `img` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COMMENT='����ײ�';

/*Data for the table `t_setmeal` */

insert  into `t_setmeal`(`id`,`name`,`code`,`helpCode`,`sex`,`age`,`price`,`remark`,`attention`,`img`) values (11,'入职无忧体检套餐（男女通用）','0001','RZTJ','0','18-60',300,'适合进入公司之前的入职体检,科学可靠','体检的前一顿饮食,少饮少事物','4e7bf3a0-a042-455f-af08-aa605dd106ed.jpg'),(12,'粉红珍爱(女)升级TM12项筛查体检套餐','0002','FHZA','2','18-60',1000,'本套餐针对宫颈(TCT检查、HPV乳头瘤病毒筛查）、乳腺（彩超，癌抗125），甲状腺（彩超，甲功验血）以及胸片，血常规肝功等有全面检查，非常适合女性全面疾病筛查使用。','体检过程中请保持开心的心情,心理不要有太大的负担','4fde4491-d401-4c9f-842a-da0a1e688d26.jpg'),(13,'阳光爸妈升级肿瘤12项筛查（男女单人）体检套餐','0003','YGBM','0','55-100',1400,'本套餐主要针对常见肿瘤筛查，肝肾、颈动脉、脑血栓、颅内血流筛查，以及风湿、颈椎、骨密度检查','体检过程中请保持积极的心情,建议家人陪伴下进行检查','d1dc6094-721c-4bab-862a-528ce7b3cd21.jpg'),(14,'珍爱高端升级肿瘤12项筛查（男女单人）','0004','ZAGD','0','18-80',2400,'本套餐是一款针对生化五项检查，心，肝，胆，胃，甲状腺，颈椎，肺功能，脑部检查（经颅多普勒）以及癌症筛查，适合大众人群体检的套餐','检查过程中请保持愉悦的心情,建议体检前少饮少食!','c0bb1d18-f31f-4fe5-81b9-605391993db1.jpg'),(18,'入学体检','0006','RXTJ','0','5-100',50,'无','无','ae77f613-29cb-4b98-a147-b42aa04cd7f7.jpeg'),(25,'测试0001','测试0001','测试0001','0','1-100',20,'无','无','3edb62cf-53d8-4e86-8395-7e8cfe7b1764.jpeg');

/*Table structure for table `t_setmeal_checkgroup` */

DROP TABLE IF EXISTS `t_setmeal_checkgroup`;

CREATE TABLE `t_setmeal_checkgroup` (
  `setmeal_id` int(11) NOT NULL DEFAULT '0',
  `checkgroup_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`setmeal_id`,`checkgroup_id`),
  KEY `checkgroup_key` (`checkgroup_id`),
  CONSTRAINT `checkgroup_key` FOREIGN KEY (`checkgroup_id`) REFERENCES `t_checkgroup` (`id`),
  CONSTRAINT `setmeal_key` FOREIGN KEY (`setmeal_id`) REFERENCES `t_setmeal` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_setmeal_checkgroup` */

insert  into `t_setmeal_checkgroup`(`setmeal_id`,`checkgroup_id`) values (11,5),(18,5),(25,5),(11,6),(18,6),(25,6),(11,7),(18,7),(11,8),(18,8),(11,9),(14,9),(11,10),(11,11),(13,11),(13,12),(14,12),(12,13),(13,13),(14,13),(12,14),(12,15),(25,16),(25,17);

/*Table structure for table `t_user` */

DROP TABLE IF EXISTS `t_user`;

CREATE TABLE `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `birthday` date DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `username` varchar(32) DEFAULT NULL,
  `password` varchar(256) DEFAULT NULL,
  `remark` varchar(32) DEFAULT NULL,
  `station` varchar(1) DEFAULT NULL,
  `telephone` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `t_user` */

insert  into `t_user`(`id`,`birthday`,`gender`,`username`,`password`,`remark`,`station`,`telephone`) values (1,NULL,NULL,'admin','$2a$10$LPbhiutR34wKvjv3Qb8zBu7piw5hG3.IlQMAI3e/D1Y0DJ/mMSkYa',NULL,NULL,NULL),(2,NULL,NULL,'xiaoming','$2a$10$t2tAeL9Cq9tWhh9iELLoVOuqjcM.nA/9fqW8ttPBhmGY9skL7WKaK',NULL,NULL,NULL),(3,NULL,NULL,'zhangsan','$2a$10$t2tAeL9Cq9tWhh9iELLoVOuqjcM.nA/9fqW8ttPBhmGY9skL7WKaK',NULL,NULL,NULL),(4,NULL,NULL,'tom','$2a$10$t2tAeL9Cq9tWhh9iELLoVOuqjcM.nA/9fqW8ttPBhmGY9skL7WKaK',NULL,NULL,NULL);

/*Table structure for table `t_user_role` */

DROP TABLE IF EXISTS `t_user_role`;

CREATE TABLE `t_user_role` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `FK_Reference_8` (`role_id`),
  CONSTRAINT `FK_Reference_7` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`),
  CONSTRAINT `FK_Reference_8` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_user_role` */

insert  into `t_user_role`(`user_id`,`role_id`) values (1,1),(2,2),(3,3),(4,4);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
