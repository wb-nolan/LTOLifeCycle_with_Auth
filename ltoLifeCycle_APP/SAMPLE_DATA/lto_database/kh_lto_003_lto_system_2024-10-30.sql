# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: khlto-003 (MySQL 5.5.5-10.4.27-MariaDB)
# Database: lto_system
# Generation Time: 2024-10-30 15:32:35 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table clean_tracking
# ------------------------------------------------------------

DROP TABLE IF EXISTS `clean_tracking`;

CREATE TABLE `clean_tracking` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `hostname` varchar(255) DEFAULT NULL,
  `type` enum('drive','tape') NOT NULL DEFAULT 'drive',
  `variable` varchar(11) DEFAULT NULL,
  `serial` varchar(55) DEFAULT NULL,
  `count` int(11) NOT NULL DEFAULT 0,
  `last_cleaned` timestamp NULL DEFAULT NULL,
  `date_modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp(),
  `notes` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `se` (`serial`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

LOCK TABLES `clean_tracking` WRITE;
/*!40000 ALTER TABLE `clean_tracking` DISABLE KEYS */;

INSERT INTO `clean_tracking` (`id`, `hostname`, `type`, `variable`, `serial`, `count`, `last_cleaned`, `date_modified`, `notes`)
VALUES
	(1,NULL,'tape',NULL,'CLN003C7',27,'2022-04-27 10:40:55','2022-04-27 10:40:55',NULL),
	(4,NULL,'drive',NULL,'116C93206F',0,'2022-04-21 22:45:22','2022-04-21 22:45:22',NULL),
	(5,NULL,'drive',NULL,'116C93205B',0,'2022-04-21 22:47:22','2022-04-21 22:47:22',NULL),
	(6,NULL,'drive',NULL,'116C932065',0,'2022-04-21 22:49:20','2022-04-21 22:49:20',NULL),
	(7,NULL,'drive',NULL,'116C932079',0,'2022-04-27 10:40:55','2022-04-27 10:40:55',NULL);

/*!40000 ALTER TABLE `clean_tracking` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table devices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `devices`;

CREATE TABLE `devices` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `hostname` varchar(255) DEFAULT NULL,
  `dev_id` varchar(11) DEFAULT NULL,
  `drive_slot` int(11) DEFAULT NULL,
  `dev_type` varchar(50) DEFAULT NULL,
  `status` enum('ACTIVE','DISABLED') NOT NULL DEFAULT 'ACTIVE',
  `serial` varchar(50) DEFAULT NULL,
  `vendorid` varchar(50) DEFAULT NULL,
  `productid` varchar(50) DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp(),
  `notes` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

LOCK TABLES `devices` WRITE;
/*!40000 ALTER TABLE `devices` DISABLE KEYS */;

INSERT INTO `devices` (`id`, `hostname`, `dev_id`, `drive_slot`, `dev_type`, `status`, `serial`, `vendorid`, `productid`, `date_added`, `date_modified`, `notes`)
VALUES
	(60,NULL,'/dev/sg1',3,'tape','ACTIVE','1H10021110','IBM','ULT3580-HH3','2023-02-13 16:09:06','2023-06-27 13:12:08','3'),
	(61,NULL,'/dev/sg2',2,'tape','ACTIVE','1H10009285','IBM','ULT3580-HH3','2023-02-13 16:09:06','2023-07-11 14:27:37',NULL),
	(62,NULL,'/dev/sg5',1,'tape','ACTIVE','1H10004816','IBM','ULT3580-HH3','2023-02-13 16:09:06','2024-03-21 14:11:35',NULL),
	(63,NULL,'/dev/sg3',0,'tape','ACTIVE','1H10005257','IBM','ULT3580-HH3','2023-02-13 16:09:06','2024-03-21 14:11:35','0'),
	(64,NULL,'/dev/sg4',NULL,'mediumx','ACTIVE','00MXA219Z003LL0','IBM','3573-TL','2023-02-13 16:09:06','2024-03-21 14:11:36',NULL);

/*!40000 ALTER TABLE `devices` ENABLE KEYS */;
UNLOCK TABLES;

DELIMITER ;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`root`@`localhost` */ /*!50003 TRIGGER `devices_date_added` BEFORE INSERT ON `devices` FOR EACH ROW set new.date_added=CURRENT_TIMESTAMP() */;;
DELIMITER ;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;


# Dump of table tape_info
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tape_info`;

CREATE TABLE `tape_info` (
  `id` float unsigned NOT NULL AUTO_INCREMENT,
  `tape_type` varchar(11) DEFAULT NULL,
  `maxsize` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

LOCK TABLES `tape_info` WRITE;
/*!40000 ALTER TABLE `tape_info` DISABLE KEYS */;

INSERT INTO `tape_info` (`id`, `tape_type`, `maxsize`)
VALUES
	(1,'LTO6',21000000000),
	(2,'LTO7',51000000000);

/*!40000 ALTER TABLE `tape_info` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tapes_in_device
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tapes_in_device`;

CREATE TABLE `tapes_in_device` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `dev_id` int(11) DEFAULT NULL,
  `slot` int(255) DEFAULT NULL,
  `drive_slot` int(11) NOT NULL DEFAULT 999,
  `taskid` int(11) NOT NULL DEFAULT 0,
  `barcode` varchar(11) DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

LOCK TABLES `tapes_in_device` WRITE;
/*!40000 ALTER TABLE `tapes_in_device` DISABLE KEYS */;

INSERT INTO `tapes_in_device` (`id`, `dev_id`, `slot`, `drive_slot`, `taskid`, `barcode`, `date_added`, `date_modified`)
VALUES
	(1,NULL,38,999,0,'OOA021L3','2024-10-17 16:12:02','0000-00-00 00:00:00'),
	(2,NULL,41,999,0,'CLNU44CU','2024-10-17 16:12:02','0000-00-00 00:00:00'),
	(3,NULL,46,999,0,'AIF098L1','2024-10-17 16:13:02','0000-00-00 00:00:00'),
	(4,NULL,4,2,0,'ABF100L1','2024-10-17 16:13:02','2024-10-29 11:05:07');

/*!40000 ALTER TABLE `tapes_in_device` ENABLE KEYS */;
UNLOCK TABLES;

DELIMITER ;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`root`@`localhost` */ /*!50003 TRIGGER `tapes_date_added` BEFORE INSERT ON `tapes_in_device` FOR EACH ROW set new.date_added=CURRENT_TIMESTAMP() */;;
DELIMITER ;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;


# Dump of table tasks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tasks`;

CREATE TABLE `tasks` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `priority` enum('NORMAL','HIGH','LOW') NOT NULL DEFAULT 'NORMAL',
  `task_type` enum('ARCHIVE','RESTORE','VERIFY','EDL_PULL','QUICK_LTO_CHECK','CREATE_TOC','COPY_ALES','TAR_RESTORE_VERIFY','FULL_PATH_EDL_PULL','ALFRED_PULL','NETBACKUP_TAR') NOT NULL DEFAULT 'ARCHIVE',
  `assigned_drive` enum('0','1','2','3') DEFAULT NULL,
  `drive_id` enum('0','1','2','3') DEFAULT NULL,
  `dev_id` varchar(11) DEFAULT NULL,
  `drive_serial` varchar(11) DEFAULT NULL,
  `slot` int(11) DEFAULT NULL,
  `barcode` varchar(11) NOT NULL DEFAULT '',
  `wbbarcode` varchar(55) DEFAULT NULL,
  `pull_paths` longtext DEFAULT NULL,
  `task_name` varchar(255) DEFAULT NULL,
  `project` varchar(55) NOT NULL,
  `tape_copy` varchar(1) DEFAULT NULL,
  `status` enum('PENDING','READY','TAPE_LOADED','IN_PROGRESS','WRITING','RESTORING','VERIFYING','COMPLETE','ERROR','FAILED','CANCEL','WAITING','PENDING_EJECT') NOT NULL DEFAULT 'PENDING',
  `verify` enum('PENDING','IN_PROGRESS','SUCCESS','FAIL','ERROR','NA') DEFAULT 'NA',
  `process` enum('NA','CREATING TOC-MD5','LOADING','FORMATING TAPE','MOUNTING','ARCHIVING','RESTORING','VERIFYING','COMPARING','DELETING','UNMOUNTING','UNLOADING') NOT NULL DEFAULT 'NA',
  `progress` varchar(255) DEFAULT NULL,
  `task_error` mediumtext DEFAULT NULL,
  `tocid` int(11) DEFAULT NULL,
  `md5id` int(11) DEFAULT NULL,
  `md5_comp` enum('YES','NO','IN_PROGRESS','READY') NOT NULL DEFAULT 'NO',
  `character_check` enum('NO','PASS','FAIL') NOT NULL DEFAULT 'NO',
  `archive_comp` enum('NO','YES') NOT NULL DEFAULT 'NO',
  `restore_comp` enum('NO','YES') NOT NULL DEFAULT 'NO',
  `verify_comp` enum('NO','YES') NOT NULL DEFAULT 'NO',
  `tape_format` enum('LTFS','TAR') NOT NULL DEFAULT 'LTFS',
  `blk_size` int(4) NOT NULL DEFAULT 0,
  `fsf` int(1) NOT NULL DEFAULT 0,
  `md5` enum('YES','NO') NOT NULL DEFAULT 'YES',
  `email_sent` enum('NO','YES') NOT NULL DEFAULT 'NO',
  `log` longtext DEFAULT NULL,
  `src_path` varchar(255) DEFAULT NULL,
  `src_count` varchar(11) DEFAULT NULL,
  `src_size` varchar(55) DEFAULT NULL,
  `destsize` bigint(55) DEFAULT NULL,
  `src_sizeGB` varchar(11) DEFAULT NULL,
  `edl_path` varchar(255) DEFAULT NULL,
  `dest_path` varchar(255) NOT NULL DEFAULT '/mmfs3/dataio/lto_restores',
  `dest_count` int(11) DEFAULT NULL,
  `host` varchar(255) DEFAULT NULL,
  `user` varchar(30) DEFAULT NULL,
  `extensions` varchar(30) DEFAULT NULL,
  `exclusions` varchar(11) DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp(),
  `process_start` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `pull_file_type` enum('NA','IMAGE_SEQ','FILES','FOLDERS','ALL') NOT NULL DEFAULT 'NA',
  `fps` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;

INSERT INTO `tasks` (`id`, `priority`, `task_type`, `assigned_drive`, `drive_id`, `dev_id`, `drive_serial`, `slot`, `barcode`, `wbbarcode`, `pull_paths`, `task_name`, `project`, `tape_copy`, `status`, `verify`, `process`, `progress`, `task_error`, `tocid`, `md5id`, `md5_comp`, `character_check`, `archive_comp`, `restore_comp`, `verify_comp`, `tape_format`, `blk_size`, `fsf`, `md5`, `email_sent`, `log`, `src_path`, `src_count`, `src_size`, `destsize`, `src_sizeGB`, `edl_path`, `dest_path`, `dest_count`, `host`, `user`, `extensions`, `exclusions`, `date_added`, `date_modified`, `process_start`, `pull_file_type`, `fps`)
VALUES
	(1,'NORMAL','NETBACKUP_TAR','3','3','/dev/nst0','1H10021110',NULL,'002214L2',NULL,NULL,'002214L2','TEST',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,0,'YES','NO',NULL,NULL,NULL,NULL,222810248,NULL,NULL,'/mmfs1/projects/test_test_archive_project/test_restore/tar_test',4471,NULL,NULL,NULL,NULL,'2023-06-27 13:08:43','2023-06-28 01:26:18','2023-06-27 13:20:56','NA',NULL),
	(22,'NORMAL','NETBACKUP_TAR','0','0','/dev/nst2','1H10005257',NULL,'001721L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001721L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,228312203,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore',4581,NULL,NULL,NULL,NULL,'2023-07-11 11:21:58','2023-07-11 17:23:05','2023-07-11 14:38:33','NA',NULL),
	(23,'NORMAL','NETBACKUP_TAR','1','1','/dev/nst3','1H10004816',NULL,'001722L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001722L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,220323592,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore',4420,NULL,NULL,NULL,NULL,'2023-07-11 11:21:58','2023-07-11 17:30:14','2023-07-11 14:46:02','NA',NULL),
	(24,'NORMAL','NETBACKUP_TAR','2','2','/dev/nst1','1H10009285',NULL,'001725L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001725L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,221342856,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore',4442,NULL,NULL,NULL,NULL,'2023-07-11 11:21:58','2023-07-11 17:37:08','2023-07-11 14:53:02','NA',NULL),
	(25,'NORMAL','NETBACKUP_TAR','0','0','/dev/nst2','1H10005257',NULL,'001727L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001727L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,217083784,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore',4359,NULL,NULL,NULL,NULL,'2023-07-11 11:21:58','2023-07-11 21:37:04','2023-07-11 18:53:02','NA',NULL),
	(26,'NORMAL','NETBACKUP_TAR','0','0','/dev/nst2','1H10005257',NULL,'001732L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001732L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,218438536,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore',4383,NULL,NULL,NULL,NULL,'2023-07-11 11:21:58','2023-07-12 00:22:05','2023-07-11 21:38:02','NA',NULL),
	(27,'NORMAL','NETBACKUP_TAR','0','0','/dev/nst2','1H10005257',NULL,'001737L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001737L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,257731595,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore',5173,NULL,NULL,NULL,NULL,'2023-07-11 11:21:58','2023-07-12 03:07:09','2023-07-12 00:23:01','NA',NULL),
	(28,'NORMAL','NETBACKUP_TAR','0','0','/dev/nst2','1H10005257',NULL,'001740L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001740L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,220477320,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore',4424,NULL,NULL,NULL,NULL,'2023-07-11 11:21:58','2023-07-12 05:52:09','2023-07-12 03:08:02','NA',NULL),
	(29,'NORMAL','NETBACKUP_TAR','2','2','/dev/nst1','1H10009285',NULL,'001741L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001741L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,225978121,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore',4535,NULL,NULL,NULL,NULL,'2023-07-11 11:21:58','2023-07-11 21:42:04','2023-07-11 18:56:02','NA',NULL),
	(30,'NORMAL','NETBACKUP_TAR','1','1','/dev/nst3','1H10004816',NULL,'001745L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001745L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,219164936,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore',4398,NULL,NULL,NULL,NULL,'2023-07-11 11:21:58','2023-07-11 21:39:06','2023-07-11 18:55:01','NA',NULL),
	(31,'NORMAL','NETBACKUP_TAR','1','1','/dev/nst3','1H10004816',NULL,'001750L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001750L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,233610121,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore',4691,NULL,NULL,NULL,NULL,'2023-07-11 11:21:58','2023-07-12 03:09:07','2023-07-12 00:25:01','NA',NULL),
	(32,'NORMAL','NETBACKUP_TAR','1','1','/dev/nst3','1H10004816',NULL,'001753L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001753L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,223153544,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore',4480,NULL,NULL,NULL,NULL,'2023-07-11 11:21:58','2023-07-12 00:24:06','2023-07-11 21:40:02','NA',NULL),
	(33,'NORMAL','NETBACKUP_TAR','3','3','/dev/nst0','1H10021110',NULL,'001756L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001756L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,234929291,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore',4718,NULL,NULL,NULL,NULL,'2023-07-11 11:21:58','2023-07-11 21:44:03','2023-07-11 18:57:01','NA',NULL),
	(34,'NORMAL','NETBACKUP_TAR','2','2','/dev/nst1','1H10009285',NULL,'001760L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001760L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,218369544,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore',4385,NULL,NULL,NULL,NULL,'2023-07-11 11:21:58','2023-07-12 03:12:02','2023-07-12 00:28:01','NA',NULL),
	(35,'NORMAL','NETBACKUP_TAR','2','2','/dev/nst1','1H10009285',NULL,'001882L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001882L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,218213896,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore',4382,NULL,NULL,NULL,NULL,'2023-07-11 11:21:58','2023-07-12 05:57:07','2023-07-12 03:13:01','NA',NULL),
	(36,'NORMAL','NETBACKUP_TAR','3','3','/dev/nst0','1H10021110',NULL,'001883L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001883L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,233448971,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore',4687,NULL,NULL,NULL,NULL,'2023-07-11 11:21:58','2023-07-12 00:29:03','2023-07-11 21:45:02','NA',NULL),
	(37,'NORMAL','NETBACKUP_TAR','2','2','/dev/nst1','1H10009285',NULL,'001891L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001891L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,124602120,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore',2501,NULL,NULL,NULL,NULL,'2023-07-11 11:21:58','2023-07-12 07:31:00','2023-07-12 05:58:01','NA',NULL),
	(38,'NORMAL','NETBACKUP_TAR','3','3','/dev/nst0','1H10021110',NULL,'001893L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001893L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,85046425,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore',1648,NULL,NULL,NULL,NULL,'2023-07-11 11:21:58','2023-07-12 01:32:00','2023-07-12 00:30:02','NA',NULL),
	(39,'NORMAL','NETBACKUP_TAR','2','2','/dev/nst1','1H10009285',NULL,'001894L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001894L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,217872392,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore',4375,NULL,NULL,NULL,NULL,'2023-07-11 11:21:58','2023-07-12 00:27:04','2023-07-11 21:43:01','NA',NULL),
	(40,'NORMAL','NETBACKUP_TAR','1','1','/dev/nst3','1H10004816',NULL,'001925L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001925L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,218787208,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore',4390,NULL,NULL,NULL,NULL,'2023-07-11 11:23:49','2023-07-12 05:54:14','2023-07-12 03:10:01','NA',NULL),
	(41,'NORMAL','NETBACKUP_TAR','0','0','/dev/nst2','1H10005257',NULL,'000050L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 000050L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,24611016,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007843/',494,NULL,NULL,NULL,NULL,'2023-07-12 13:30:02','2023-07-12 14:00:10','2023-07-12 13:42:02','NA',NULL),
	(42,'NORMAL','NETBACKUP_TAR','1','1','/dev/nst3','1H10004816',NULL,'001064L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001064L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,223764248,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007843/',4495,NULL,NULL,NULL,NULL,'2023-07-12 13:30:02','2023-07-12 16:27:08','2023-07-12 13:43:01','NA',NULL),
	(43,'NORMAL','NETBACKUP_TAR','2','2','/dev/nst1','1H10009285',NULL,'001091L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001091L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,223474953,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007843/',4488,NULL,NULL,NULL,NULL,'2023-07-12 13:30:02','2023-07-12 16:30:09','2023-07-12 13:44:02','NA',NULL),
	(44,'NORMAL','NETBACKUP_TAR','3','3','/dev/nst0','1H10021110',NULL,'001184L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001184L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,214561943,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007843/',4310,NULL,NULL,NULL,NULL,'2023-07-12 13:30:02','2023-07-12 16:33:03','2023-07-12 13:45:02','NA',NULL),
	(45,'NORMAL','NETBACKUP_TAR','0','0','/dev/nst2','1H10005257',NULL,'001186L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001186L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,216155784,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007843/',4340,NULL,NULL,NULL,NULL,'2023-07-12 13:30:02','2023-07-12 16:45:26','2023-07-12 14:01:02','NA',NULL),
	(46,'NORMAL','NETBACKUP_TAR','1','1','/dev/nst3','1H10004816',NULL,'001190L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001190L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,235455450,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007843/',4729,NULL,NULL,NULL,NULL,'2023-07-12 13:30:02','2023-07-12 19:12:08','2023-07-12 16:28:01','NA',NULL),
	(47,'NORMAL','NETBACKUP_TAR','2','2','/dev/nst1','1H10009285',NULL,'001191L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001191L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,233864474,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007843/',4697,NULL,NULL,NULL,NULL,'2023-07-12 13:30:02','2023-07-12 19:16:04','2023-07-12 16:32:02','NA',NULL),
	(48,'NORMAL','NETBACKUP_TAR','3','3','/dev/nst0','1H10021110',NULL,'001198L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001198L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,238598039,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007843/',4791,NULL,NULL,NULL,NULL,'2023-07-12 13:30:02','2023-07-12 19:19:02','2023-07-12 16:34:01','NA',NULL),
	(49,'NORMAL','NETBACKUP_TAR','0','0','/dev/nst2','1H10005257',NULL,'001199L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001199L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,216155528,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007843/',4340,NULL,NULL,NULL,NULL,'2023-07-12 13:30:02','2023-07-12 19:31:07','2023-07-12 16:47:02','NA',NULL),
	(50,'NORMAL','NETBACKUP_TAR','1','1','/dev/nst3','1H10004816',NULL,'001208L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001208L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,214505224,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007843/',4307,NULL,NULL,NULL,NULL,'2023-07-12 13:30:02','2023-07-12 21:57:07','2023-07-12 19:13:02','NA',NULL),
	(51,'NORMAL','NETBACKUP_TAR','2','2','/dev/nst1','1H10009285',NULL,'001761L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001761L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,215973768,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007843/',4337,NULL,NULL,NULL,NULL,'2023-07-12 13:30:02','2023-07-12 22:01:04','2023-07-12 19:17:02','NA',NULL),
	(52,'NORMAL','NETBACKUP_TAR','3','3','/dev/nst0','1H10021110',NULL,'001765L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001765L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,214037000,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007843/',4297,NULL,NULL,NULL,NULL,'2023-07-12 13:30:02','2023-07-12 22:06:02','2023-07-12 19:20:02','NA',NULL),
	(53,'NORMAL','NETBACKUP_TAR','0','0','/dev/nst2','1H10005257',NULL,'001766L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001766L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,218520200,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007843/',4386,NULL,NULL,NULL,NULL,'2023-07-12 13:30:02','2023-07-12 22:16:07','2023-07-12 19:32:01','NA',NULL),
	(54,'NORMAL','NETBACKUP_TAR','1','1','/dev/nst3','1H10004816',NULL,'001774L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001774L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,231677851,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007843/',4648,NULL,NULL,NULL,NULL,'2023-07-12 13:30:02','2023-07-13 00:42:06','2023-07-12 21:58:01','NA',NULL),
	(55,'NORMAL','NETBACKUP_TAR','2','2','/dev/nst1','1H10009285',NULL,'001775L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001775L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,226001166,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007843/',4536,NULL,NULL,NULL,NULL,'2023-07-12 13:30:02','2023-07-13 00:46:05','2023-07-12 22:02:01','NA',NULL),
	(56,'NORMAL','NETBACKUP_TAR','3','3','/dev/nst0','1H10021110',NULL,'001823L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001823L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,215719432,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007843/',4329,NULL,NULL,NULL,NULL,'2023-07-12 13:30:02','2023-07-13 00:54:02','2023-07-12 22:07:01','NA',NULL),
	(57,'NORMAL','NETBACKUP_TAR','0','0','/dev/nst2','1H10005257',NULL,'001824L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001824L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,214463624,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007843/',4304,NULL,NULL,NULL,NULL,'2023-07-12 13:30:02','2023-07-13 01:01:10','2023-07-12 22:17:01','NA',NULL),
	(58,'NORMAL','NETBACKUP_TAR','1','1','/dev/nst3','1H10004816',NULL,'001832L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001832L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,37924953,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007843/',699,NULL,NULL,NULL,NULL,'2023-07-12 13:30:02','2023-07-13 01:09:13','2023-07-13 00:43:01','NA',NULL),
	(59,'NORMAL','NETBACKUP_TAR','2','2','/dev/nst1','1H10009285',NULL,'001833L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001833L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,219678600,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007843/',4408,NULL,NULL,NULL,NULL,'2023-07-12 13:30:02','2023-07-13 03:31:12','2023-07-13 00:47:02','NA',NULL),
	(60,'NORMAL','NETBACKUP_TAR','0','0','/dev/nst2','1H10005257',NULL,'000042L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 000042L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,15974568,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007852/',321,NULL,NULL,NULL,NULL,'2023-07-13 15:26:19','2023-07-13 15:43:09','2023-07-13 15:29:01','NA',NULL),
	(61,'NORMAL','NETBACKUP_TAR','1','1','/dev/nst3','1H10004816',NULL,'000044L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 000044L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,222475016,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007852/',4464,NULL,NULL,NULL,NULL,'2023-07-13 15:26:19','2023-07-13 18:14:08','2023-07-13 15:30:02','NA',NULL),
	(62,'NORMAL','NETBACKUP_TAR','2','2','/dev/nst1','1H10009285',NULL,'001057L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001057L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,225031561,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007852/',4517,NULL,NULL,NULL,NULL,'2023-07-13 15:26:19','2023-07-13 18:17:09','2023-07-13 15:31:01','NA',NULL),
	(63,'NORMAL','NETBACKUP_TAR','3','3','/dev/nst0','1H10021110',NULL,'001058L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001058L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,230155273,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007852/',4620,NULL,NULL,NULL,NULL,'2023-07-13 15:26:19','2023-07-13 18:20:06','2023-07-13 15:32:02','NA',NULL),
	(64,'NORMAL','NETBACKUP_TAR','0','0','/dev/nst2','1H10005257',NULL,'001062L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001062L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,222199688,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007852/',4459,NULL,NULL,NULL,NULL,'2023-07-13 15:26:19','2023-07-13 18:32:09','2023-07-13 15:48:02','NA',NULL),
	(65,'NORMAL','NETBACKUP_TAR','1','1','/dev/nst3','1H10004816',NULL,'001086L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001086L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,223799432,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007852/',4492,NULL,NULL,NULL,NULL,'2023-07-13 15:26:19','2023-07-13 20:59:24','2023-07-13 18:15:01','NA',NULL),
	(66,'NORMAL','NETBACKUP_TAR','2','2','/dev/nst1','1H10009285',NULL,'001183L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001183L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,241625690,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007852/',4854,NULL,NULL,NULL,NULL,'2023-07-13 15:26:19','2023-07-13 21:02:05','2023-07-13 18:18:02','NA',NULL),
	(67,'NORMAL','NETBACKUP_TAR','3','3','/dev/nst0','1H10021110',NULL,'001189L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001189L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,246024968,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007852/',4937,NULL,NULL,NULL,NULL,'2023-07-13 15:26:19','2023-07-13 21:05:05','2023-07-13 18:21:01','NA',NULL),
	(68,'NORMAL','NETBACKUP_TAR','0','0','/dev/nst2','1H10005257',NULL,'001194L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001194L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,222371208,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007852/',4463,NULL,NULL,NULL,NULL,'2023-07-13 15:26:19','2023-07-13 21:17:10','2023-07-13 18:33:01','NA',NULL),
	(69,'NORMAL','NETBACKUP_TAR','1','1','/dev/nst3','1H10004816',NULL,'001197L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001197L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,218249864,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007852/',4380,NULL,NULL,NULL,NULL,'2023-07-13 15:26:19','2023-07-13 23:45:08','2023-07-13 21:01:01','NA',NULL),
	(70,'NORMAL','NETBACKUP_TAR','2','2','/dev/nst1','1H10009285',NULL,'001201L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001201L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,223404808,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007852/',4483,NULL,NULL,NULL,NULL,'2023-07-13 15:26:19','2023-07-13 23:48:05','2023-07-13 21:03:01','NA',NULL),
	(71,'NORMAL','NETBACKUP_TAR','3','3','/dev/nst0','1H10021110',NULL,'001202L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001202L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,220685064,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007852/',4429,NULL,NULL,NULL,NULL,'2023-07-13 15:26:19','2023-07-13 23:52:05','2023-07-13 21:06:01','NA',NULL),
	(72,'NORMAL','NETBACKUP_TAR','0','0','/dev/nst2','1H10005257',NULL,'001204L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001204L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,224049032,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007852/',4497,NULL,NULL,NULL,NULL,'2023-07-13 15:26:19','2023-07-14 00:03:11','2023-07-13 21:18:02','NA',NULL),
	(73,'NORMAL','NETBACKUP_TAR','1','1','/dev/nst3','1H10004816',NULL,'001206L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001206L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,227972026,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007852/',4593,NULL,NULL,NULL,NULL,'2023-07-13 15:26:19','2023-07-14 02:30:08','2023-07-13 23:46:01','NA',NULL),
	(74,'NORMAL','NETBACKUP_TAR','2','2','/dev/nst1','1H10009285',NULL,'001451L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001451L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,226007067,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007852/',4537,NULL,NULL,NULL,NULL,'2023-07-13 15:26:19','2023-07-14 02:33:08','2023-07-13 23:49:02','NA',NULL),
	(75,'NORMAL','NETBACKUP_TAR','3','3','/dev/nst0','1H10021110',NULL,'001762L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001762L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,233669963,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007852/',4689,NULL,NULL,NULL,NULL,'2023-07-13 15:26:19','2023-07-14 11:51:05','2023-07-14 08:52:01','NA',NULL),
	(76,'NORMAL','NETBACKUP_TAR','0','0','/dev/nst2','1H10005257',NULL,'001771L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001771L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,222389128,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007852/',4462,NULL,NULL,NULL,NULL,'2023-07-13 15:26:19','2023-07-14 02:49:08','2023-07-14 00:05:01','NA',NULL),
	(77,'NORMAL','NETBACKUP_TAR','1','1','/dev/nst3','1H10004816',NULL,'001821L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001821L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,179770378,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007852/',3548,NULL,NULL,NULL,NULL,'2023-07-13 15:26:19','2023-07-14 04:42:11','2023-07-14 02:32:02','NA',NULL),
	(79,'NORMAL','NETBACKUP_TAR','0','0','/dev/nst2','1H10005257',NULL,'000037L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 000037L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,224036745,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007851/',4499,NULL,NULL,NULL,NULL,'2023-07-14 13:16:58','2023-07-14 16:07:10','2023-07-14 13:23:01','NA',NULL),
	(80,'NORMAL','NETBACKUP_TAR','1','1','/dev/nst3','1H10004816',NULL,'000038L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 000038L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,226159113,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007851/',4542,NULL,NULL,NULL,NULL,'2023-07-14 13:16:58','2023-07-14 16:09:15','2023-07-14 13:24:01','NA',NULL),
	(81,'NORMAL','NETBACKUP_TAR','2','2','/dev/nst1','1H10009285',NULL,'001187L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001187L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,220966792,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007851/',4437,NULL,NULL,NULL,NULL,'2023-07-14 13:16:58','2023-07-14 16:11:16','2023-07-14 13:25:01','NA',NULL),
	(82,'NORMAL','NETBACKUP_TAR','3','3','/dev/nst0','1H10021110',NULL,'001188L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001188L2','mcs3_medical_center_s03',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,233370635,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007851/',4685,NULL,NULL,NULL,NULL,'2023-07-14 13:16:58','2023-07-14 16:13:13','2023-07-14 13:26:02','NA',NULL),
	(83,'NORMAL','NETBACKUP_TAR',NULL,NULL,NULL,NULL,NULL,'001192L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001192L2','mcs3_medical_center_s03',NULL,'PENDING','NA','NA',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,'',NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007851/',NULL,NULL,NULL,NULL,NULL,'2023-07-14 13:16:58','0000-00-00 00:00:00','0000-00-00 00:00:00','NA',NULL),
	(84,'NORMAL','NETBACKUP_TAR',NULL,NULL,NULL,NULL,NULL,'001193L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001193L2','mcs3_medical_center_s03',NULL,'PENDING','NA','NA',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,'',NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007851/',NULL,NULL,NULL,NULL,NULL,'2023-07-14 13:16:58','0000-00-00 00:00:00','0000-00-00 00:00:00','NA',NULL),
	(85,'NORMAL','NETBACKUP_TAR',NULL,NULL,NULL,NULL,NULL,'001200L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001200L2','mcs3_medical_center_s03',NULL,'PENDING','NA','NA',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,'',NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007851/',NULL,NULL,NULL,NULL,NULL,'2023-07-14 13:16:58','0000-00-00 00:00:00','0000-00-00 00:00:00','NA',NULL),
	(86,'NORMAL','NETBACKUP_TAR',NULL,NULL,NULL,NULL,NULL,'001205L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001205L2','mcs3_medical_center_s03',NULL,'PENDING','NA','NA',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,'',NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007851/',NULL,NULL,NULL,NULL,NULL,'2023-07-14 13:16:58','0000-00-00 00:00:00','0000-00-00 00:00:00','NA',NULL),
	(87,'NORMAL','NETBACKUP_TAR',NULL,NULL,NULL,NULL,NULL,'001207L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001207L2','mcs3_medical_center_s03',NULL,'PENDING','NA','NA',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,'',NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007851/',NULL,NULL,NULL,NULL,NULL,'2023-07-14 13:16:58','0000-00-00 00:00:00','0000-00-00 00:00:00','NA',NULL),
	(88,'NORMAL','NETBACKUP_TAR',NULL,NULL,NULL,NULL,NULL,'001443L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001443L2','mcs3_medical_center_s03',NULL,'PENDING','NA','NA',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,'',NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007851/',NULL,NULL,NULL,NULL,NULL,'2023-07-14 13:16:58','0000-00-00 00:00:00','0000-00-00 00:00:00','NA',NULL),
	(89,'NORMAL','NETBACKUP_TAR',NULL,NULL,NULL,NULL,NULL,'001446L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001446L2','mcs3_medical_center_s03',NULL,'PENDING','NA','NA',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,'',NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007851/',NULL,NULL,NULL,NULL,NULL,'2023-07-14 13:16:58','0000-00-00 00:00:00','0000-00-00 00:00:00','NA',NULL),
	(90,'NORMAL','NETBACKUP_TAR',NULL,NULL,NULL,NULL,NULL,'001763L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001763L2','mcs3_medical_center_s03',NULL,'PENDING','NA','NA',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,'',NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007851/',NULL,NULL,NULL,NULL,NULL,'2023-07-14 13:16:58','0000-00-00 00:00:00','0000-00-00 00:00:00','NA',NULL),
	(91,'NORMAL','NETBACKUP_TAR',NULL,NULL,NULL,NULL,NULL,'001764L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001764L2','mcs3_medical_center_s03',NULL,'PENDING','NA','NA',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,'',NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007851/',NULL,NULL,NULL,NULL,NULL,'2023-07-14 13:16:58','0000-00-00 00:00:00','0000-00-00 00:00:00','NA',NULL),
	(92,'NORMAL','NETBACKUP_TAR',NULL,NULL,NULL,NULL,NULL,'001772L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001772L2','mcs3_medical_center_s03',NULL,'PENDING','NA','NA',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,'',NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007851/',NULL,NULL,NULL,NULL,NULL,'2023-07-14 13:16:58','0000-00-00 00:00:00','0000-00-00 00:00:00','NA',NULL),
	(93,'NORMAL','NETBACKUP_TAR',NULL,NULL,NULL,NULL,NULL,'001773L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001773L2','mcs3_medical_center_s03',NULL,'PENDING','NA','NA',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,'',NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007851/',NULL,NULL,NULL,NULL,NULL,'2023-07-14 13:16:58','0000-00-00 00:00:00','0000-00-00 00:00:00','NA',NULL),
	(94,'NORMAL','NETBACKUP_TAR',NULL,NULL,NULL,NULL,NULL,'001822L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001822L2','mcs3_medical_center_s03',NULL,'PENDING','NA','NA',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,'',NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007851/',NULL,NULL,NULL,NULL,NULL,'2023-07-14 13:16:58','0000-00-00 00:00:00','0000-00-00 00:00:00','NA',NULL),
	(95,'NORMAL','NETBACKUP_TAR',NULL,NULL,NULL,NULL,NULL,'001825L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001825L2','mcs3_medical_center_s03',NULL,'PENDING','NA','NA',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,'',NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007851/',NULL,NULL,NULL,NULL,NULL,'2023-07-14 13:17:00','0000-00-00 00:00:00','0000-00-00 00:00:00','NA',NULL),
	(96,'NORMAL','NETBACKUP_TAR',NULL,NULL,NULL,NULL,NULL,'001203L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001203L2','mcs3_medical_center_s03',NULL,'PENDING','NA','NA',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,'',NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007851/',NULL,NULL,NULL,NULL,NULL,'2023-07-14 13:18:20','0000-00-00 00:00:00','0000-00-00 00:00:00','NA',NULL),
	(97,'NORMAL','NETBACKUP_TAR',NULL,NULL,NULL,NULL,NULL,'000005L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 000005L2','mcs3_medical_center_s03',NULL,'PENDING','NA','NA',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,'',NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007848/',NULL,NULL,NULL,NULL,NULL,'2023-07-14 13:20:38','0000-00-00 00:00:00','0000-00-00 00:00:00','NA',NULL),
	(98,'NORMAL','NETBACKUP_TAR',NULL,NULL,NULL,NULL,NULL,'000013L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 000013L2','mcs3_medical_center_s03',NULL,'PENDING','NA','NA',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,'',NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007848/',NULL,NULL,NULL,NULL,NULL,'2023-07-14 13:20:38','0000-00-00 00:00:00','0000-00-00 00:00:00','NA',NULL),
	(99,'NORMAL','NETBACKUP_TAR',NULL,NULL,NULL,NULL,NULL,'000045L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 000045L2','mcs3_medical_center_s03',NULL,'PENDING','NA','NA',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,'',NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007848/',NULL,NULL,NULL,NULL,NULL,'2023-07-14 13:20:38','0000-00-00 00:00:00','0000-00-00 00:00:00','NA',NULL),
	(100,'NORMAL','NETBACKUP_TAR',NULL,NULL,NULL,NULL,NULL,'000047L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 000047L2','mcs3_medical_center_s03',NULL,'PENDING','NA','NA',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,'',NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007848/',NULL,NULL,NULL,NULL,NULL,'2023-07-14 13:20:38','0000-00-00 00:00:00','0000-00-00 00:00:00','NA',NULL),
	(101,'NORMAL','NETBACKUP_TAR',NULL,NULL,NULL,NULL,NULL,'000206L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 000206L2','mcs3_medical_center_s03',NULL,'PENDING','NA','NA',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,'',NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007848/',NULL,NULL,NULL,NULL,NULL,'2023-07-14 13:20:38','0000-00-00 00:00:00','0000-00-00 00:00:00','NA',NULL),
	(102,'NORMAL','NETBACKUP_TAR',NULL,NULL,NULL,NULL,NULL,'000207L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 000207L2','mcs3_medical_center_s03',NULL,'PENDING','NA','NA',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,'',NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007848/',NULL,NULL,NULL,NULL,NULL,'2023-07-14 13:20:39','0000-00-00 00:00:00','0000-00-00 00:00:00','NA',NULL),
	(103,'NORMAL','NETBACKUP_TAR',NULL,NULL,NULL,NULL,NULL,'000213L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 000213L2','mcs3_medical_center_s03',NULL,'PENDING','NA','NA',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,'',NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007848/',NULL,NULL,NULL,NULL,NULL,'2023-07-14 13:20:39','0000-00-00 00:00:00','0000-00-00 00:00:00','NA',NULL),
	(104,'NORMAL','NETBACKUP_TAR',NULL,NULL,NULL,NULL,NULL,'000220L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 000220L2','mcs3_medical_center_s03',NULL,'PENDING','NA','NA',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,'',NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007848/',NULL,NULL,NULL,NULL,NULL,'2023-07-14 13:20:39','0000-00-00 00:00:00','0000-00-00 00:00:00','NA',NULL),
	(105,'NORMAL','NETBACKUP_TAR',NULL,NULL,NULL,NULL,NULL,'000222L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 000222L2','mcs3_medical_center_s03',NULL,'PENDING','NA','NA',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,'',NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007848/',NULL,NULL,NULL,NULL,NULL,'2023-07-14 13:20:39','0000-00-00 00:00:00','0000-00-00 00:00:00','NA',NULL),
	(106,'NORMAL','NETBACKUP_TAR',NULL,NULL,NULL,NULL,NULL,'001826L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001826L2','mcs3_medical_center_s03',NULL,'PENDING','NA','NA',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,'',NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007848/',NULL,NULL,NULL,NULL,NULL,'2023-07-14 13:20:39','0000-00-00 00:00:00','0000-00-00 00:00:00','NA',NULL),
	(107,'NORMAL','NETBACKUP_TAR',NULL,NULL,NULL,NULL,NULL,'001837L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001837L2','mcs3_medical_center_s03',NULL,'PENDING','NA','NA',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,'',NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007848/',NULL,NULL,NULL,NULL,NULL,'2023-07-14 13:20:39','0000-00-00 00:00:00','0000-00-00 00:00:00','NA',NULL),
	(108,'NORMAL','NETBACKUP_TAR',NULL,NULL,NULL,NULL,NULL,'001838L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001838L2','mcs3_medical_center_s03',NULL,'PENDING','NA','NA',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,'',NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007848/',NULL,NULL,NULL,NULL,NULL,'2023-07-14 13:20:39','0000-00-00 00:00:00','0000-00-00 00:00:00','NA',NULL),
	(109,'NORMAL','NETBACKUP_TAR',NULL,NULL,NULL,NULL,NULL,'001864L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001864L2','mcs3_medical_center_s03',NULL,'PENDING','NA','NA',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,'',NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007848/',NULL,NULL,NULL,NULL,NULL,'2023-07-14 13:20:39','0000-00-00 00:00:00','0000-00-00 00:00:00','NA',NULL),
	(110,'NORMAL','NETBACKUP_TAR',NULL,NULL,NULL,NULL,NULL,'001870L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001870L2','mcs3_medical_center_s03',NULL,'PENDING','NA','NA',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,'',NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007848/',NULL,NULL,NULL,NULL,NULL,'2023-07-14 13:20:39','0000-00-00 00:00:00','0000-00-00 00:00:00','NA',NULL),
	(111,'NORMAL','NETBACKUP_TAR',NULL,NULL,NULL,NULL,NULL,'001874L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001874L2','mcs3_medical_center_s03',NULL,'PENDING','NA','NA',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,'',NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007848/',NULL,NULL,NULL,NULL,NULL,'2023-07-14 13:20:39','0000-00-00 00:00:00','0000-00-00 00:00:00','NA',NULL),
	(112,'NORMAL','NETBACKUP_TAR',NULL,NULL,NULL,NULL,NULL,'001878L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001878L2','mcs3_medical_center_s03',NULL,'PENDING','NA','NA',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,'',NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007848/',NULL,NULL,NULL,NULL,NULL,'2023-07-14 13:20:39','0000-00-00 00:00:00','0000-00-00 00:00:00','NA',NULL),
	(113,'NORMAL','NETBACKUP_TAR',NULL,NULL,NULL,NULL,NULL,'001880L2',NULL,NULL,'mcs3_medical_center_s03 NETBACKUP_TAR 001880L2','mcs3_medical_center_s03',NULL,'PENDING','NA','NA',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,'',NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mcs3_medical_center_s03/mcs3_restore/ep007848/',NULL,NULL,NULL,NULL,NULL,'2023-07-14 13:20:39','0000-00-00 00:00:00','0000-00-00 00:00:00','NA',NULL),
	(114,'NORMAL','RESTORE','1','1','/dev/nst3','1H10004816',NULL,'OOA008L3',NULL,NULL,'mm2x_magic_mike_xxl_2015 Restore OOA008L3','mm2x_magic_mike_xxl_2015',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,1,NULL,NULL,'/mmfs1/projects/mm2x_magic_mike_xxl_2015/mm2x_restore/',0,NULL,NULL,NULL,NULL,'2023-08-16 17:07:01','2023-08-16 17:17:13','2023-08-16 17:10:02','NA',NULL),
	(115,'NORMAL','RESTORE','0','0','/dev/nst2','1H10005257',NULL,'OOA009L3',NULL,NULL,'mm2x_magic_mike_xxl_2015 Restore OOA009L3','mm2x_magic_mike_xxl_2015',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,1,NULL,NULL,'/mmfs1/projects/mm2x_magic_mike_xxl_2015/mm2x_restore/',0,NULL,NULL,NULL,NULL,'2023-08-16 17:07:01','2023-08-16 17:15:04','2023-08-16 17:11:02','NA',NULL),
	(116,'NORMAL','RESTORE','0','0','/dev/sg3','1H10005257',NULL,'OOA009L3',NULL,NULL,'mm2x_magic_mike_xxl_2015 Restore OOA009L3','mm2x_magic_mike_xxl_2015',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','NO','NO','LTFS',0,1,'YES','NO',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mm2x_magic_mike_xxl_2015/mm2x_restore/',NULL,NULL,NULL,NULL,NULL,'2023-08-16 17:16:38','2023-08-16 17:20:03','0000-00-00 00:00:00','NA',NULL),
	(117,'NORMAL','RESTORE','2','2','/dev/sg2','1H10009285',NULL,'OOA008L3',NULL,NULL,'mm2x_magic_mike_xxl_2015 Restore OOA008L3','mm2x_magic_mike_xxl_2015',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','NO','NO','LTFS',0,1,'YES','NO',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mm2x_magic_mike_xxl_2015/mm2x_restore/',NULL,NULL,NULL,NULL,NULL,'2023-08-16 17:22:19','2023-08-16 17:25:02','0000-00-00 00:00:00','NA',NULL),
	(118,'NORMAL','RESTORE','3','3','/dev/sg1','1H10021110',NULL,'OOA009L3',NULL,NULL,'mm2x_magic_mike_xxl_2015 Restore OOA009L3','mm2x_magic_mike_xxl_2015',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','NO','NO','LTFS',0,1,'YES','NO',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/mm2x_magic_mike_xxl_2015/mm2x_restore/',NULL,NULL,NULL,NULL,NULL,'2023-08-16 17:22:19','2023-08-16 17:28:04','0000-00-00 00:00:00','NA',NULL),
	(119,'NORMAL','RESTORE','0','0','/dev/nst2','1H10005257',NULL,'OOA008L3',NULL,NULL,'mm2x_magic_mike_xxl_2015 Restore OOA008L3','mm2x_magic_mike_xxl_2015',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',128,1,'YES','NO',NULL,NULL,NULL,NULL,1,NULL,NULL,'/mmfs1/projects/mm2x_magic_mike_xxl_2015/mm2x_restore/',0,NULL,NULL,NULL,NULL,'2023-08-17 08:26:33','2023-08-17 08:36:11','2023-08-17 08:29:02','NA',NULL),
	(120,'NORMAL','RESTORE','1','1','/dev/nst3','1H10004816',NULL,'OOA009L3',NULL,NULL,'mm2x_magic_mike_xxl_2015 Restore OOA009L3','mm2x_magic_mike_xxl_2015',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',128,1,'YES','NO',NULL,NULL,NULL,NULL,1,NULL,NULL,'/mmfs1/projects/mm2x_magic_mike_xxl_2015/mm2x_restore/',0,NULL,NULL,NULL,NULL,'2023-08-17 08:26:33','2023-08-17 08:34:04','2023-08-17 08:30:01','NA',NULL),
	(121,'NORMAL','RESTORE','2','2','/dev/nst1','1H10009285',NULL,'OOA008L3',NULL,NULL,'mm2x_magic_mike_xxl_2015 Restore OOA008L3','mm2x_magic_mike_xxl_2015',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',64,1,'YES','NO',NULL,NULL,NULL,NULL,1,NULL,NULL,'/mmfs1/projects/mm2x_magic_mike_xxl_2015/mm2x_restore/',0,NULL,NULL,NULL,NULL,'2023-08-17 08:37:45','2023-08-17 08:46:05','2023-08-17 08:40:01','NA',NULL),
	(122,'NORMAL','RESTORE','3','3','/dev/nst0','1H10021110',NULL,'OOA009L3',NULL,NULL,'mm2x_magic_mike_xxl_2015 Restore OOA009L3','mm2x_magic_mike_xxl_2015',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',64,1,'YES','NO',NULL,NULL,NULL,NULL,1,NULL,NULL,'/mmfs1/projects/mm2x_magic_mike_xxl_2015/mm2x_restore/',0,NULL,NULL,NULL,NULL,'2023-08-17 08:37:45','2023-08-17 08:49:15','2023-08-17 08:45:01','NA',NULL),
	(123,'NORMAL','RESTORE','0','0','/dev/nst2','1H10005257',NULL,'OOA008L3',NULL,NULL,'mm2x_magic_mike_xxl_2015 Restore OOA008L3','mm2x_magic_mike_xxl_2015',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',512,1,'YES','NO',NULL,NULL,NULL,NULL,1,NULL,NULL,'/mmfs1/projects/mm2x_magic_mike_xxl_2015/mm2x_restore/',0,NULL,NULL,NULL,NULL,'2023-08-17 08:46:54','2023-08-17 08:56:04','2023-08-17 08:50:01','NA',NULL),
	(124,'NORMAL','RESTORE','1','1','/dev/nst3','1H10004816',NULL,'OOA009L3',NULL,NULL,'mm2x_magic_mike_xxl_2015 Restore OOA009L3','mm2x_magic_mike_xxl_2015',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',0,1,'YES','NO',NULL,NULL,NULL,NULL,1,NULL,NULL,'/mmfs1/projects/mm2x_magic_mike_xxl_2015/mm2x_restore/',0,NULL,NULL,NULL,NULL,'2023-08-17 08:52:10','2023-11-15 12:53:14','2023-08-17 08:57:02','NA',NULL),
	(125,'NORMAL','RESTORE','2','2','/dev/nst1','1H10009285',48,'OOA017L3','V00724977',NULL,'invs_invasion_the_2007 Restore OOA017L3','invs_invasion_the_2007',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,306792706,NULL,NULL,'/mmfs1/projects/invs_invasion_the_2007/invs_restore',24457,NULL,NULL,NULL,NULL,'2024-03-21 14:25:12','2024-04-16 15:54:48','2024-03-21 14:28:01','NA',NULL),
	(126,'NORMAL','RESTORE','3','3','/dev/nst0','1H10021110',47,'OOA019L3','V00724974',NULL,'invs_invasion_the_2007 Restore OOA019L3','invs_invasion_the_2007',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,382182146,NULL,NULL,'/mmfs1/projects/invs_invasion_the_2007/invs_restore',30467,NULL,NULL,NULL,NULL,'2024-03-21 14:25:12','2024-04-16 16:06:20','2024-03-21 14:29:02','NA',NULL),
	(127,'NORMAL','RESTORE','2','2','/dev/nst1','1H10009285',46,'OOA027L3','V00726973',NULL,'invs_invasion_the_2007 Restore OOA027L3','invs_invasion_the_2007',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,250900,NULL,NULL,'/mmfs1/projects/invs_invasion_the_2007/invs_restore',20,NULL,NULL,NULL,NULL,'2024-03-25 16:28:45','2024-04-16 15:53:04','2024-03-25 16:31:01','NA',NULL),
	(128,'NORMAL','RESTORE','3','3','/dev/nst0','1H10021110',46,'OOA016L3','V00724975',NULL,'invs_invasion_the_2007 Restore OOA016L3','invs_invasion_the_2007',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,298777090,NULL,NULL,'/mmfs1/projects/invs_invasion_the_2007/invs_restore',23818,NULL,NULL,NULL,NULL,'2024-04-03 22:34:12','2024-04-16 16:06:11','2024-04-03 22:37:01','NA',NULL),
	(129,'NORMAL','RESTORE','2','2','/dev/nst1','1H10009285',47,'OOA018L3','V00724976',NULL,'invs_invasion_the_2007 Restore OOA018L3','invs_invasion_the_2007',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,212348930,NULL,NULL,'/mmfs1/projects/invs_invasion_the_2007/invs_restore',16928,NULL,NULL,NULL,NULL,'2024-04-03 22:34:12','2024-04-16 15:57:57','2024-04-03 22:38:01','NA',NULL),
	(130,'NORMAL','RESTORE','1','1','/dev/nst3','1H10004816',48,'OOA020L3','V00725025',NULL,'invs_invasion_the_2007 Restore OOA020L3','invs_invasion_the_2007',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,381379330,NULL,NULL,'/mmfs1/projects/invs_invasion_the_2007/invs_restore',30403,NULL,NULL,NULL,NULL,'2024-04-03 22:34:12','2024-04-16 16:06:31','2024-04-03 22:36:01','NA',NULL),
	(131,'NORMAL','RESTORE','1','1','/dev/nst3','1H10004816',NULL,'ABC001L1',NULL,NULL,'lich_little_children_2006 Restore ABC001L1','lich_little_children_2006',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',256,1,'YES','NO',NULL,NULL,NULL,NULL,1,NULL,NULL,'/mmfs1/projects/lich_little_children_2006/lich_restore',0,NULL,NULL,NULL,NULL,'2024-05-17 18:54:25','2024-05-17 19:01:01','2024-05-17 18:57:01','NA',NULL),
	(132,'NORMAL','RESTORE','2','2','/dev/nst1','1H10009285',47,'ABG995L1',NULL,NULL,'lich_little_children_2006 Restore ABG995L1','lich_little_children_2006',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',256,1,'YES','NO',NULL,NULL,NULL,NULL,1,NULL,NULL,'/mmfs1/projects/lich_little_children_2006/lich_restore',0,NULL,NULL,NULL,NULL,'2024-05-22 16:05:25','2024-05-22 16:12:02','2024-05-22 16:07:01','NA',NULL),
	(133,'NORMAL','RESTORE','1','1','/dev/nst3','1H10004816',NULL,'BB2597L3',NULL,NULL,'orph_orphan_2009 Restore BB2597L3','orph_orphan_2009',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,341501954,NULL,NULL,'/mmfs1/projects/orph_orphan_2009/orph_restore/',27224,NULL,NULL,NULL,NULL,'2024-07-22 13:51:46','2024-07-22 15:38:09','2024-07-22 13:57:01','NA',NULL),
	(134,'NORMAL','RESTORE','2','2','/dev/nst1','1H10009285',NULL,'MPI091L3',NULL,NULL,'orph_orphan_2009 Restore MPI091L3','orph_orphan_2009',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,338190338,NULL,NULL,'/mmfs1/projects/orph_orphan_2009/orph_restore/',26960,NULL,NULL,NULL,NULL,'2024-07-22 13:51:46','2024-07-22 15:36:05','2024-07-22 13:58:01','NA',NULL),
	(135,'NORMAL','RESTORE','3','3','/dev/nst0','1H10021110',NULL,'MPI092L3',NULL,NULL,'orph_orphan_2009 Restore MPI092L3','orph_orphan_2009',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,405729282,NULL,NULL,'/mmfs1/projects/orph_orphan_2009/orph_restore/',32344,NULL,NULL,NULL,NULL,'2024-07-22 13:51:46','2024-07-22 16:00:17','2024-07-22 13:59:02','NA',NULL),
	(136,'NORMAL','RESTORE','0','0','/dev/nst2','1H10005257',48,'MPI093L3',NULL,NULL,'orph_orphan_2009 Restore MPI093L3','orph_orphan_2009',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,398804482,NULL,NULL,'/mmfs1/projects/orph_orphan_2009/orph_restore/',31792,NULL,NULL,NULL,NULL,'2024-07-22 13:51:46','2024-07-22 16:03:08','2024-07-22 14:00:01','NA',NULL),
	(137,'NORMAL','RESTORE','2','2','/dev/nst1','1H10009285',47,'MPI094L3',NULL,NULL,'orph_orphan_2009 Restore MPI094L3','orph_orphan_2009',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,397097474,NULL,NULL,'/mmfs1/projects/orph_orphan_2009/orph_restore/',31656,NULL,NULL,NULL,NULL,'2024-07-22 13:51:46','2024-07-22 18:34:10','2024-07-22 16:38:01','NA',NULL),
	(138,'NORMAL','RESTORE','1','1','/dev/nst3','1H10004816',NULL,'MPI095L3',NULL,NULL,'orph_orphan_2009 Restore MPI095L3','orph_orphan_2009',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,378519427,NULL,NULL,'/mmfs1/projects/orph_orphan_2009/orph_restore/',30175,NULL,NULL,NULL,NULL,'2024-07-22 13:51:46','2024-07-22 17:19:07','2024-07-22 15:39:02','NA',NULL),
	(139,'NORMAL','RESTORE','3',NULL,NULL,NULL,NULL,'OOA029L3',NULL,NULL,'orph_orphan_2009 Restore OOA029L3','orph_orphan_2009',NULL,'PENDING','NA','LOADING',NULL,NULL,NULL,NULL,'NO','NO','NO','NO','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'/mmfs1/projects/orph_orphan_2009/orph_restore/',NULL,NULL,NULL,NULL,NULL,'2024-07-22 17:04:53','2024-07-22 17:16:49','0000-00-00 00:00:00','NA',NULL),
	(140,'NORMAL','RESTORE','0','0','/dev/nst2','1H10005257',NULL,'OOA030L3',NULL,NULL,'orph_orphan_2009 Restore OOA030L3','orph_orphan_2009',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,153075201,NULL,NULL,'/mmfs1/projects/orph_orphan_2009/orph_restore/',14764,NULL,NULL,NULL,NULL,'2024-07-22 17:04:53','2024-07-22 17:55:06','2024-07-22 17:11:01','NA',NULL),
	(141,'NORMAL','RESTORE','3','3','/dev/nst0','1H10021110',NULL,'OOA029L3',NULL,NULL,'orph_orphan_2009 Restore OOA029L3','orph_orphan_2009',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,1,NULL,NULL,'/mmfs1/projects/orph_orphan_2009/orph_restore/',0,NULL,NULL,NULL,NULL,'2024-07-22 17:17:54','2024-07-22 17:23:02','2024-07-22 17:20:01','NA',NULL),
	(142,'NORMAL','RESTORE','1','1','/dev/nst3','1H10004816',46,'MPI096L3',NULL,NULL,'orph_orphan_2009 Restore MPI096L3','orph_orphan_2009',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,166563457,NULL,NULL,'/mmfs1/projects/orph_orphan_2009/orph_restore/',16065,NULL,NULL,NULL,NULL,'2024-08-02 13:12:06','2024-08-02 14:44:03','2024-08-02 13:15:01','NA',NULL),
	(143,'NORMAL','RESTORE','1','1','/dev/nst3','1H10004816',NULL,'ABF100L1',NULL,NULL,'ahov_history_of_violence_a_2005 Restore ABF100L1','ahov_history_of_violence_a_2005',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,1,NULL,NULL,'/mmfs1/projects/ahov_history_of_violence_a_2005/ahov_restore/',0,NULL,NULL,NULL,NULL,'2024-10-16 10:55:41','2024-10-16 11:17:06','2024-10-16 11:14:01','NA',NULL),
	(144,'NORMAL','RESTORE','2','2','/dev/nst1','1H10009285',NULL,'AIF098L1',NULL,NULL,'ahov_history_of_violence_a_2005 Restore AIF098L1','ahov_history_of_violence_a_2005',NULL,'COMPLETE','NA','NA','',NULL,NULL,NULL,'NO','NO','NO','YES','NO','TAR',1024,1,'YES','NO',NULL,NULL,NULL,NULL,1,NULL,NULL,'/mmfs1/projects/ahov_history_of_violence_a_2005/ahov_restore/',0,NULL,NULL,NULL,NULL,'2024-10-16 10:55:41','2024-10-16 11:20:13','2024-10-16 11:15:01','NA',NULL);

/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
