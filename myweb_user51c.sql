-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 192.168.100.10
-- Thời gian đã tạo: Th4 16, 2019 lúc 11:49 PM
-- Phiên bản máy phục vụ: 10.3.7-MariaDB-1:10.3.7+maria~jessie
-- Phiên bản PHP: 7.3.4-1+ubuntu16.04.1+deb.sury.org+3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `myweb_user51c`
--

DELIMITER $$
--
-- Thủ tục
--
CREATE DEFINER=`` PROCEDURE `sp_add_api` (IN `project_id` INT, IN `method` VARCHAR(255), IN `name` VARCHAR(255), IN `content` VARCHAR(255), IN `params` LONGTEXT, IN `response` LONGTEXT)  NO SQL
BEGIN 
	DECLARE last_insert_id INT;
	INSERT INTO api (api_method, api_name, api_content, api_params, api_response, api_status, created_at, updated_at) VALUES (method, name, content, params, response, 1, Now(), Now());
    SELECT LAST_INSERT_ID() INTO last_insert_id;
    INSERT INTO project_api (project_id, api_id, created_at, updated_at) VALUES (project_id, last_insert_id, Now(), Now());
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `sp_add_user` (IN `name` VARCHAR(255), IN `birthday` DATE, IN `phone` VARCHAR(255), IN `email` VARCHAR(255), IN `address` VARCHAR(255), IN `permission` VARCHAR(255))  NO SQL
BEGIN
	INSERT INTO `users` (`name`, `email`, `phone`, `birthday`, `address`, `password`, `permission`, `status`, `created_at`, `updated_at`) VALUES (name, email, phone, birthday, address, md5('12345'), permission, 1, Now(), Now());
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `sp_create_token` (IN `var_username` VARCHAR(255), OUT `token` VARCHAR(200))  READS SQL DATA
BEGIN
	DECLARE var_name varchar(200) CHARACTER SET 'utf8';
    DECLARE var_id int;
	SELECT users.user_name, users.user_id INTO var_name, var_id FROM users WHERE users.user_email=var_username;
	IF var_name IS NULL
    THEN 
    	SET token = -1;
    ELSE 
		SET token = CONCAT(sha(CONCAT(var_username, CAST(RAND() AS CHARACTER))),'.', sha(CONCAT(var_username, CAST(RAND() AS CHARACTER))),'.', sha(CONCAT(var_username, CAST(RAND() AS CHARACTER))),'.',sha(CONCAT(var_username, CAST(RAND() AS CHARACTER))));
        INSERT INTO `token`(`token_value`, `real_token_value`, `token_expired_at`, `user_id`, `created_at`, `updated_at`) VALUES (token, token, DATE_ADD(NOW(), INTERVAL 1 HOUR), var_id, NOW(), NOW());
    END IF;
END$$

CREATE DEFINER=`` PROCEDURE `sp_delete_api` (IN `id` INT)  NO SQL
BEGIN
	DELETE FROM project_api WHERE api_id=id;
	DELETE FROM api WHERE api_id=id;
END$$

CREATE DEFINER=`` PROCEDURE `sp_edit_api` (IN `id` INT, IN `method` VARCHAR(255), IN `name` VARCHAR(255), IN `content` VARCHAR(255), IN `params` LONGTEXT, IN `response` LONGTEXT)  NO SQL
BEGIN 
	UPDATE api SET api_method=method, api_name=name, api_content=content, api_params=params, api_response=response, updated_at=NOW() WHERE api_id = id;
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `sp_get_user` (IN `token_value` VARCHAR(255))  NO SQL
SELECT users.user_name, users.user_email, users.user_phone, users.user_birthday, users.permission_id, users.user_address, token.token_value
FROM token, users 
WHERE (token.token_value = token_value or token.real_token_value )
	AND token.user_id = users.user_id$$

CREATE DEFINER=`root`@`%` PROCEDURE `sp_nodejs_change_info_user` (IN `name` VARCHAR(255), IN `email` VARCHAR(2255), IN `birthday` DATE, IN `address` VARCHAR(255), IN `phone` VARCHAR(255))  NO SQL
UPDATE users SET users.user_name = name, users.user_phone=phone, users.user_birthday=birthday, users.user_address = address WHERE users.user_email=email$$

CREATE DEFINER=`root`@`%` PROCEDURE `sp_nodejs_change_pass_user` (IN `email` VARCHAR(255), IN `old_pass` VARCHAR(255), IN `new_pass` VARCHAR(255), OUT `status_code` INT)  NO SQL
BEGIN
	DECLARE id INT;
    SET status_code = 0;
	SELECT users.user_id INTO id FROM users WHERE users.user_password = md5(old_pass) AND users.user_email = email;
    
    IF id IS NULL
    THEN
    	SET status_code = 401;
    ELSE
    	UPDATE users SET users.user_password = md5(new_pass), users.updated_at = NOW() WHERE users.user_id = id;
    	SET status_code = 200;
    END IF;
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `sp_nodejs_checklogin` (IN `username` VARCHAR(255), IN `password` VARCHAR(255))  NO SQL
SELECT * FROM users WHERE users.user_email = username AND users.user_password = md5(password)$$

CREATE DEFINER=`root`@`%` PROCEDURE `sp_nodejs_show_user` (IN `username` VARCHAR(255))  NO SQL
SELECT users.user_name, users.user_email, users.user_phone, users.user_birthday, users.user_address, users.user_status FROM users WHERE users.user_email = username$$

CREATE DEFINER=`root`@`%` PROCEDURE `sp_refresh_token` (IN `old_token` VARCHAR(255), OUT `new_token` VARCHAR(255))  BEGIN
	DECLARE var_name varchar(255);
	SELECT users.user_email INTO var_name FROM token, users WHERE users.user_id = token.user_id AND token.token_value = old_token;
   	IF var_name is null
    THEN 
    	SET new_token = -1;
    ELSE
		SET new_token = CONCAT(sha(CONCAT(var_name, CAST(RAND() AS CHARACTER))),'.', sha(CONCAT(var_name, CAST(RAND() AS CHARACTER))),'.', sha(CONCAT(var_name, CAST(RAND() AS CHARACTER))),'.',sha(CONCAT(var_name, CAST(RAND() AS CHARACTER))));
		UPDATE token SET token_value = new_token, token_expired_at = DATE_ADD(NOW(), INTERVAL 1 HOUR) WHERE token_value = old_token;
    END IF;
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `sp_show_all_project` ()  NO SQL
SELECT project.project_name, project.project_id, COUNT(project_api.api_id) as 'count_project' 
	FROM project LEFT JOIN project_api ON project.project_id = project_api.project_id
	GROUP BY project.project_name, project.project_id$$

CREATE DEFINER=`` PROCEDURE `sp_show_detail_project` (IN `id` INT)  NO SQL
SELECT api.* FROM api, project_api WHERE project_api.project_id = id AND project_api.api_id = api.api_id$$

CREATE DEFINER=`root`@`%` PROCEDURE `sp_show_detail_project` (IN `id` INT)  NO SQL
SELECT * FROM api, project_api WHERE api.api_id = project_api.api_id AND project_api.project_id = id$$

CREATE DEFINER=`root`@`%` PROCEDURE `sp_show_log` ()  NO SQL
SELECT log.*, users.user_name FROM log, users WHERE log.user_id = users.user_id$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `api`
--

CREATE TABLE `api` (
  `api_id` int(10) UNSIGNED NOT NULL,
  `api_method` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `api_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `api_content` text COLLATE utf8_unicode_ci DEFAULT '',
  `api_params` longtext COLLATE utf8_unicode_ci NOT NULL DEFAULT '\'\'',
  `api_response` longtext COLLATE utf8_unicode_ci NOT NULL DEFAULT '\'\'',
  `api_status` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `api`
--

INSERT INTO `api` (`api_id`, `api_method`, `api_name`, `api_content`, `api_params`, `api_response`, `api_status`, `created_at`, `updated_at`) VALUES
(20, 'Post', 'Login', '<p>Api login (Intelisys vietjet maint)</p>', '<ul><li>username: vietjetaltaapi</li><li>password: qazxswedc</li></ul>', '<ul><li>data:<ul><li>token: dasda1sd213a1s3d21as32d</li><li>permission: Superadmin</li></ul></li><li>message: Login success</li><li>status_code: 200</li></ul><blockquote><p>status code: 403 not have permission</p><p>status code: 401 wrong username, password</p></blockquote>', 1, '2019-04-09 10:36:58', '2019-04-09 10:47:05');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `level`
--

CREATE TABLE `level` (
  `level_id` int(10) UNSIGNED NOT NULL,
  `level_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Level name'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Level of  note';

--
-- Đang đổ dữ liệu cho bảng `level`
--

INSERT INTO `level` (`level_id`, `level_name`) VALUES
(1, 'Thông tin'),
(2, 'Nhắc nhở'),
(3, 'Trung bình'),
(4, 'Gấp');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `log`
--

CREATE TABLE `log` (
  `log_id` bigint(20) NOT NULL,
  `log_content` varchar(255) NOT NULL,
  `user_id` int(11) UNSIGNED NOT NULL,
  `log_token` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp(),
  `log_note` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `log`
--

INSERT INTO `log` (`log_id`, `log_content`, `user_id`, `log_token`, `created_at`, `updated_at`, `log_note`) VALUES
(2, 'Is login', 1, '1068e3eb21f1a93b4ae480b18ab6d9f15a95dae1.e22711e088f3ce0308d82e55fe9f9a64a2cc1045.da8e0d94e1b0ed1137872f8634c4767781cb7dd6.30061c2a5a2c7979254720e2ea38f5a0f2277944', '2019-02-15 17:53:07', '2019-02-15 17:53:07', ''),
(3, 'Is login', 2, '99f5e4426e8fca313651d665f0c9df67e5e671be.e9cd357c7329295d7ef84890a71a78d3c9d9961a.b2ea0885782465ea11d7bf71d7b50783d9731bcf.808e1b669a641b56483dd175177836327a6b78b8', '2019-02-16 20:16:32', '2019-02-16 20:16:32', ''),
(4, 'Is login', 2, '0a07a169f49b93ea51d1053b6a469efd7040ca13.c2cd46ffc34a0f00d9514df6de6d98ea8f2cfc0f.2d12dc8eaf8b056ebd6486e473916a71f5bc7f65.eb39e768450e4db22825c9b0e46f20df550813f8', '2019-02-16 20:31:13', '2019-02-16 20:31:13', ''),
(5, 'Is logout', 2, '0a07a169f49b93ea51d1053b6a469efd7040ca13.c2cd46ffc34a0f00d9514df6de6d98ea8f2cfc0f.2d12dc8eaf8b056ebd6486e473916a71f5bc7f65.eb39e768450e4db22825c9b0e46f20df550813f8', '2019-02-16 20:31:22', '2019-02-16 20:31:22', ''),
(6, 'Is login', 1, '2d43d7194641112896e690f2034cb7e5904cec84.0c65bfd16a86bcc366a2d0c3cfb0c36a5b83e062.b17c41fedc07d78a602a8e27513236b328442744.4a1a01158f6d5b2471914a3bc5c6aa4f6dc203d7', '2019-02-16 20:33:44', '2019-02-16 20:33:44', ''),
(7, 'Is change infomation', 1, '2d43d7194641112896e690f2034cb7e5904cec84.0c65bfd16a86bcc366a2d0c3cfb0c36a5b83e062.b17c41fedc07d78a602a8e27513236b328442744.4a1a01158f6d5b2471914a3bc5c6aa4f6dc203d7', '2019-02-16 21:17:03', '2019-02-16 21:17:03', ''),
(8, 'Is change password', 1, '2d43d7194641112896e690f2034cb7e5904cec84.0c65bfd16a86bcc366a2d0c3cfb0c36a5b83e062.b17c41fedc07d78a602a8e27513236b328442744.4a1a01158f6d5b2471914a3bc5c6aa4f6dc203d7', '2019-02-16 21:17:21', '2019-02-16 21:17:21', ''),
(9, 'Is logout', 1, '1068e3eb21f1a93b4ae480b18ab6d9f15a95dae1.e22711e088f3ce0308d82e55fe9f9a64a2cc1045.da8e0d94e1b0ed1137872f8634c4767781cb7dd6.30061c2a5a2c7979254720e2ea38f5a0f2277944', '2019-02-23 18:09:17', '2019-02-23 18:09:17', ''),
(10, 'Is login', 2, 'df7145414c800207e862dd3a30684d08184a895a.02e8f5660570614bb5aa55a19b80132f7c9bcf13.74eee7485680013527de8371d0b020c3a14ad136.05859f81cdada8f8e9617f8585cbc3750187caad', '2019-02-23 18:09:27', '2019-02-23 18:09:27', ''),
(11, 'Is logout', 2, 'df7145414c800207e862dd3a30684d08184a895a.02e8f5660570614bb5aa55a19b80132f7c9bcf13.74eee7485680013527de8371d0b020c3a14ad136.05859f81cdada8f8e9617f8585cbc3750187caad', '2019-02-23 18:09:31', '2019-02-23 18:09:31', ''),
(12, 'Is login', 1, '22b56e19a7ff7495abe8ea3c72e28d28fa9e3275.5eabe7a2331fa64be3c7e4e936593c4193a00b1c.fcd3c67f28891178e84463b7ab9ed720cd166663.db2a0e2f30453b4704edaf4e88b99f7db4179faa', '2019-02-23 18:09:51', '2019-02-23 18:09:51', ''),
(13, 'Is logout', 1, '22b56e19a7ff7495abe8ea3c72e28d28fa9e3275.5eabe7a2331fa64be3c7e4e936593c4193a00b1c.fcd3c67f28891178e84463b7ab9ed720cd166663.db2a0e2f30453b4704edaf4e88b99f7db4179faa', '2019-02-25 04:29:45', '2019-02-25 04:29:45', ''),
(14, 'Is login', 2, '5e9af35f52d2acb19fbd723a151746315f73ec41.b2ee600ed764728a6079755f03ac5298ab07c5d8.3dbad52c2b87828c309f90bccfadfe1806b8fde5.d1c69964c70a0c6e764cc12c4a783f8cfdcf693f', '2019-02-25 04:29:58', '2019-02-25 04:29:58', ''),
(15, 'Is logout', 2, '5e9af35f52d2acb19fbd723a151746315f73ec41.b2ee600ed764728a6079755f03ac5298ab07c5d8.3dbad52c2b87828c309f90bccfadfe1806b8fde5.d1c69964c70a0c6e764cc12c4a783f8cfdcf693f', '2019-02-25 04:30:03', '2019-02-25 04:30:03', ''),
(16, 'Is login', 1, 'd7e553de16c92b18df2bc6fbef56f156bf5cfd86.738990d32fa351cdbceb4c75a4fedff8bf83be35.f0f32bd324c56e16b539846c28137d209422791c.07c1dfed8218d93f2603d701c890121f479b8bbb', '2019-02-25 04:30:11', '2019-02-25 04:30:11', ''),
(17, 'Is logout', 1, 'd7e553de16c92b18df2bc6fbef56f156bf5cfd86.738990d32fa351cdbceb4c75a4fedff8bf83be35.f0f32bd324c56e16b539846c28137d209422791c.07c1dfed8218d93f2603d701c890121f479b8bbb', '2019-02-25 11:52:17', '2019-02-25 11:52:17', ''),
(18, 'Is login', 1, 'b81658c0686914740168f53bd2d1b75bcc33574f.95bf9b2e5a54f4381616e909c1fa1f69b36803e6.de9d47200ed49670c72823432bdcbc1949d833b1.c30fcf668010f04c58ef78e8418087ec8e744c5a', '2019-02-25 11:52:28', '2019-02-25 11:52:28', ''),
(19, 'Is login', 1, '7065d17193d8c5ec360d028c438f905bf49c3950.cf0b5ef62de825d2189aba8692ab3e2e013515ed.1e15b1fa48e78bec4511505fe60c4bc6d20aa098.b61c608f57ad86edd770f928a83046f6e5a7b13b', '2019-02-26 20:55:30', '2019-02-26 20:55:30', ''),
(20, 'Is login', 1, 'da9fd1d4a945d48f5abfffda86ed173310742d14.3f3796fa4ad81d0ef3544ff50ce7149cfdaed702.6df9eb04e01de94216ec09bd7103fca92795b26e.d84b95af11caae12d76333a4f5971060a2dd021e', '2019-02-26 21:57:27', '2019-02-26 21:57:27', ''),
(21, 'Is login', 1, '7b401545d8ffb034dd95181e487a6a9848ed9535.12b6f203099076c6e05a051cc10f61ca0700890b.ba2be86a8ea336d0312ab9a2b64ffbd6aee12f2c.94495df1f02d47abb7435cf555ee8e1ae879e6b8', '2019-03-09 19:22:22', '2019-03-09 19:22:22', ''),
(22, 'Is change infomation', 1, '7b401545d8ffb034dd95181e487a6a9848ed9535.12b6f203099076c6e05a051cc10f61ca0700890b.ba2be86a8ea336d0312ab9a2b64ffbd6aee12f2c.94495df1f02d47abb7435cf555ee8e1ae879e6b8', '2019-03-09 22:33:51', '2019-03-09 22:33:51', ''),
(23, 'Is login', 1, '081d0e9b0ef240c0718f797bef2574a5b5f8517e.5101612b0385acbadac2f432c56bbebeea0fe0aa.4338d32fda0c307b99fa136fb496d6d6045a590c.eb2ca3204f54ffe28047711b4292cbdbabb9e642', '2019-03-17 14:49:11', '2019-03-17 14:49:11', ''),
(24, 'Is login', 1, '51c2963ca4fa86fa28d49ec6d067b43ccde8c74b.88adf7ed15b2f2aed1f0df5a8f54f0805442bca1.ddc1e2823b258cba24a1d5ce1a197d67a02d0f98.590a03ea70e2433e8ef0970cecb324763b69add6', '2019-03-18 14:50:23', '2019-03-18 14:50:23', ''),
(25, 'Is login', 1, 'a349c25945b89ae8c50035a79ef0c014c464578e.0ee07fafe4df1e608578fa8c1975d85173572fdf.e063712633d7be6b2e53dee35c4bb6e625f4669b.c294c5aa5ecd9593a8ad354c1b0c37dc42179138', '2019-03-20 17:15:55', '2019-03-20 17:15:55', '');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `my_note`
--

CREATE TABLE `my_note` (
  `note_id` int(11) NOT NULL,
  `title` text COLLATE utf8_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `status` int(11) NOT NULL,
  `user` int(10) UNSIGNED NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `level_id` int(10) UNSIGNED NOT NULL,
  `tag` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `orders` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `my_note`
--

INSERT INTO `my_note` (`note_id`, `title`, `content`, `date`, `status`, `user`, `created_at`, `updated_at`, `level_id`, `tag`, `orders`) VALUES
(7, '[Work] [Daily] Công việc ngày 27/3/2019', '<p><strong>Công việc hàng ngày:&nbsp;</strong></p><ul><li>Code tool ghi chú cá nhân (Code insert và update)</li><li>Update git</li><li>Code dự án Vietjet Bảo việt Insurance</li></ul>', '2019-03-27', 0, 1, '2019-03-27 12:00:35', '2019-04-06 17:22:27', 2, NULL, 1),
(8, '[Work] [Daily] Công việc ngày 28/3/2019', '<p><strong>Công việc hàng ngày:</strong></p><ul><li>Tiếp tục code BHBV</li><li>Chỉnh sửa quản lí ghi chú cá nhân (code tình trạng ghi chú, chuyển đổi qua OOP)</li></ul>', '2019-03-28', 0, 1, '2019-03-28 14:38:22', '2019-03-29 10:10:53', 2, NULL, 1),
(9, '[Info] [Vietjet] [Server] Thông tin server Vietjet', '<p><strong>Server Dev: (Training, Maint Intelisys, Demo group, BaoViet Insurance)</strong></p><ul><li>Host: 192.168.11.22</li><li>Port: 22</li><li>Username: Altamedia</li><li>Password: Altnmqa23</li><li>PhpMyadmin: <a href=\"http://192.168.11.22:8080/phpadm/\">http://192.168.11.22:8080/phpadm/</a></li><li>User: root / 123123</li></ul>', '2019-03-01', 0, 1, '2019-03-27 12:17:40', '2019-03-29 10:11:05', 1, NULL, 3),
(10, '[Work] [Nhắc nhở] Những việc chưa làm', '<ul><li>Viết báo cáo tuần team backend</li><li><i>Nhận passport.</i></li><li>Kí hợp đồng lao động Altamedia (3 tháng)(27-3-2019 -&gt; 27-6-2019)</li><li>Chờ bảo hiểm Bảo Việt feedback lỗi API bên BHBV</li><li><strong>Tiếp tục code quản lí cá nhân</strong><ul><li><strong>Thêm chức năng tag để dễ dàng lọc</strong></li><li><strong>Thêm chức năng tìm kiếm</strong></li></ul></li></ul>', '2019-03-29', 0, 1, '2019-03-27 12:21:18', '2019-03-29 17:40:14', 4, NULL, 2),
(14, '[Thực tập] [Training]Hướng dẫn thực tập', '<p><strong>Chuẩn bị làm:</strong></p><ul><li>Làm bài test kiến thức vào thứ 2 (31/3)</li></ul><p><strong>Đang làm:&nbsp;</strong></p><ul><li>Thay đổi mật khẩu, thay đổi thông tin cá nhân (R)</li></ul><p><strong>Đã làm:</strong></p><ul><li>Đăng nhập, đăng kí, đăng xuất</li><li>Hiển thị thông tin cá nhân.</li><li>Gửi mail đổi mật khẩu</li><li>Đổi mật khẩu (chờ test)</li><li>Đổi thông tin cá nhân (chờ test)</li></ul>', '2019-03-29', 0, 1, '2019-03-27 16:13:33', '2019-03-29 10:11:17', 3, NULL, 2),
(15, '[Info] [Vietjet] [Bảo Việt Insurance] Thông tin dự án', '<h4><strong>Thông tin server:</strong></h4><ul><li><i>IP</i>: 192.168.11.22</li><li><i>Username</i>: altamedia</li><li><i>Password</i>: Altnmqa23</li><li><i>Path</i>:<ul><li>Front end: /data/seriestraining_web/vietjetair-insurance.dev-altamedia.com</li><li>Back end: /data/seriestraining_web/vietjetair-insurance-api.dev-altamedia.com</li></ul></li><li><i>Serverside</i>:<ul><li>Front-end: http://vietjetair-insurance.dev-altamedia.com/</li><li>Back-end: http://vietjetair-insurance-api.dev-altamedia.com/api</li></ul></li><li><i>User</i> <i>login</i>: Y như seriesbooking vietjet<ul><li>Username: vietjetaltaapi</li><li>Password: qazxswedc</li></ul></li><li><i>API info: </i>https://docs.google.com/spreadsheets/d/12YRGwaPLi58ykzda0DPyVQD792UNBEfEhctfMFUfwiQ/edit?usp=sharing</li><li><i>Ngày bắt đầu</i>: 25/3/2019</li><li><i>Ngày kết thúc dự kiến</i>: 20/4/2019</li></ul>', '2019-04-17', 0, 1, '2019-03-28 10:18:29', '2019-03-29 10:11:29', 1, NULL, 3),
(20, '[Work] [Daily] Công việc ngày 29/3/2019', '<p><strong>Công việc hàng ngày:</strong></p><ul><li>Code tiếp BHBV</li><li>Tìm hiểu code SSO login insight</li><li>Nhận passport (đã nhận)</li></ul>', '2019-03-29', 0, 1, '2019-03-29 10:27:11', '2019-03-29 13:35:45', 2, NULL, 1),
(21, '[Work] [Daily] Công việc ngày 01/04/2019', '<p>Công việc hàng ngày</p><ul><li>Code tiếp dự án</li><li>Nhận thay đổi skin Flairair</li></ul>', '2019-04-01', 0, 1, '2019-04-01 10:16:47', '2019-04-01 10:21:02', 2, NULL, 1),
(22, '[Info] [Flairair] [Series Booking] Thông tin dự án', '<p><strong>Training:</strong></p><p><a href=\"https://flairair-api.intelisystraining.ca/RESTv1\">https://flairair-api.intelisystraining.ca/RESTv1</a><br>UID: FAREIMPORT-F8<br>Pass: 1qazxsw2</p><p><strong>Prod:</strong></p><p><a href=\"https://flairair-api.intelisystraining.ca/RESTv1\">https://flairair-api.intelisystraining.ca/RESTv1</a><br>UID: FAREIMPORT-F8<br>Pass: 1qazxsw2</p>', '2019-04-01', 0, 1, '2019-04-01 10:22:23', '2019-04-01 10:22:23', 1, NULL, 3),
(23, '[Info] [Nodejs] Cách cài NodeJs 10.x trên Ubuntu 18.04', '<blockquote><p>sudo apt install curl</p></blockquote><blockquote><p>curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -</p></blockquote><blockquote><p>sudo apt install nodejs</p></blockquote>', '2019-04-01', 0, 1, '2019-04-01 11:16:22', '2019-04-01 11:16:22', 1, NULL, 3),
(24, '[Note][Kiểu nhà đẹp] Các kiểu nhà ở đẹp', '<p>https://www.facebook.com/DothiDV/videos/563254780852339/</p>', '2019-04-02', 0, 1, '2019-04-02 12:49:17', '2019-04-02 12:50:03', 1, NULL, 4);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `permission`
--

CREATE TABLE `permission` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `permission_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `permission`
--

INSERT INTO `permission` (`permission_id`, `permission_name`, `created_at`, `updated_at`) VALUES
(1, 'Administrator', '2019-01-29 14:54:06', '2019-01-29 14:54:06'),
(2, 'User', '2019-01-29 14:54:28', '2019-01-29 14:54:28'),
(3, 'Guest', '2019-01-29 14:54:28', '2019-01-29 14:54:28');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `project`
--

CREATE TABLE `project` (
  `project_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `project_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `project_status` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `project`
--

INSERT INTO `project` (`project_id`, `user_id`, `project_name`, `project_status`, `created_at`, `updated_at`) VALUES
(7, 1, 'Vietjet Bảo hiểm Bảo Việt Tool', 1, '2019-04-09 08:18:37', '2019-04-09 08:18:37'),
(11, 1, 'Vietjet booking managed tool', 1, '2019-04-09 10:32:38', '2019-04-09 10:32:38');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `project_api`
--

CREATE TABLE `project_api` (
  `id` int(10) UNSIGNED NOT NULL,
  `project_id` int(10) UNSIGNED NOT NULL,
  `api_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `project_api`
--

INSERT INTO `project_api` (`id`, `project_id`, `api_id`, `created_at`, `updated_at`) VALUES
(7, 11, 20, '2019-04-09 10:36:58', '2019-04-09 10:36:58');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tag`
--

CREATE TABLE `tag` (
  `tag_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `token`
--

CREATE TABLE `token` (
  `token_id` int(10) UNSIGNED NOT NULL,
  `token_value` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `real_token_value` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `token_expired_at` datetime NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `token`
--

INSERT INTO `token` (`token_id`, `token_value`, `real_token_value`, `token_expired_at`, `user_id`, `created_at`, `updated_at`) VALUES
(1, '8e7566595c21175aacc91345b004bbbf130007ae.d068c67e36f9308cead0eee8ba585d0d6f20b1aa.901cb3761dbe7acf06d104c087654fb44284e415.5ba3e9db3e12bae1520ec84b0120ae833455bdf4', '23c892f826ff7aa2a5804cc4bc5aea4b81b64883.faf35362a75ae34b11fd3c6f221c3f54973263f1.d20692c30b2404de3c6bb2f38f4f1f7dcd2a4830.8da8e7ebddac8e516f0dc4972bce3be94751dea8', '0000-00-00 00:00:00', 1, '2019-02-15 17:35:12', '2019-02-15 17:35:12'),
(2, 'b3842f303f8fdd91b14d1076cb70e6b4ee620484.1a0af29a6f8f64af9e0b6019b93489e66c6cefba.a635124e482426b03fb0c953cdfc4babd53d13c9.06e956af4720b845c20f8769dea3f879ec540c3f', 'b3842f303f8fdd91b14d1076cb70e6b4ee620484.1a0af29a6f8f64af9e0b6019b93489e66c6cefba.a635124e482426b03fb0c953cdfc4babd53d13c9.06e956af4720b845c20f8769dea3f879ec540c3f', '0000-00-00 00:00:00', 1, '2019-02-15 17:35:51', '2019-02-15 17:35:51'),
(5, 'efd82d72ddf23f615b0f06a4558f6f8d36675697.e7abfff930e6bd5837ae31d080392da01941b4c0.bf8444b74dc89ba7e0c3d4e79c2e4de2fb842d66.ee6843b8821d564bee2a755afa234a2e2f4ff8a7', 'efd82d72ddf23f615b0f06a4558f6f8d36675697.e7abfff930e6bd5837ae31d080392da01941b4c0.bf8444b74dc89ba7e0c3d4e79c2e4de2fb842d66.ee6843b8821d564bee2a755afa234a2e2f4ff8a7', '0000-00-00 00:00:00', 1, '2019-02-15 17:48:50', '2019-02-15 17:48:50'),
(6, '227dbcf0f421bd6e9f7b1c561489127c54a73aab.935e794146c73bfbd43d976c1fff6871194e7fe3.9ddd13ed6143b7e6505918bdefebaebfb3b4da4c.c0055281f51491d8eba12c8c44884cc4fac46252', '227dbcf0f421bd6e9f7b1c561489127c54a73aab.935e794146c73bfbd43d976c1fff6871194e7fe3.9ddd13ed6143b7e6505918bdefebaebfb3b4da4c.c0055281f51491d8eba12c8c44884cc4fac46252', '0000-00-00 00:00:00', 1, '2019-02-15 17:49:31', '2019-02-15 17:49:31'),
(10, '2d43d7194641112896e690f2034cb7e5904cec84.0c65bfd16a86bcc366a2d0c3cfb0c36a5b83e062.b17c41fedc07d78a602a8e27513236b328442744.4a1a01158f6d5b2471914a3bc5c6aa4f6dc203d7', '2d43d7194641112896e690f2034cb7e5904cec84.0c65bfd16a86bcc366a2d0c3cfb0c36a5b83e062.b17c41fedc07d78a602a8e27513236b328442744.4a1a01158f6d5b2471914a3bc5c6aa4f6dc203d7', '0000-00-00 00:00:00', 1, '2019-02-16 13:33:44', '2019-02-16 13:33:44'),
(15, '5c4b344a94906a0b5d232924afdcbf816eb3784c.b0cd5978cb4e637b19a52e7c41b602460454fb56.c009aa85eba6580ca47440fe685369b605f2e86a.3ae178bb217d67f368d6a206ec539ce3b19c9879', 'b81658c0686914740168f53bd2d1b75bcc33574f.95bf9b2e5a54f4381616e909c1fa1f69b36803e6.de9d47200ed49670c72823432bdcbc1949d833b1.c30fcf668010f04c58ef78e8418087ec8e744c5a', '0000-00-00 00:00:00', 1, '2019-02-25 04:52:28', '2019-02-25 04:52:28'),
(16, '6608c54df3bdcd2fe275115d054aedf4f9ab49e6.77a585adcd13dd2a90c012935e00960022c43839.2d1e8703d8dc6ba5036d240beefc37ac876e6792.8b11f1fa6809fae174dbef0d2f0bd8945a9e7923', '7065d17193d8c5ec360d028c438f905bf49c3950.cf0b5ef62de825d2189aba8692ab3e2e013515ed.1e15b1fa48e78bec4511505fe60c4bc6d20aa098.b61c608f57ad86edd770f928a83046f6e5a7b13b', '0000-00-00 00:00:00', 1, '2019-02-26 13:55:30', '2019-02-26 13:55:30'),
(17, 'c38d9d5e15c070e7abee7bd30313e087da1fceed.c656b3fea81ee4d92197c26c345ebf3c0734c0f1.1a204d97ca9a1f0ef2cd5ab7e22049699efdf6a5.6500bf4e469c328a37d9a4ef53435a3b9e8eacaa', 'da9fd1d4a945d48f5abfffda86ed173310742d14.3f3796fa4ad81d0ef3544ff50ce7149cfdaed702.6df9eb04e01de94216ec09bd7103fca92795b26e.d84b95af11caae12d76333a4f5971060a2dd021e', '0000-00-00 00:00:00', 1, '2019-02-26 14:57:26', '2019-02-26 14:57:26'),
(18, '7b401545d8ffb034dd95181e487a6a9848ed9535.12b6f203099076c6e05a051cc10f61ca0700890b.ba2be86a8ea336d0312ab9a2b64ffbd6aee12f2c.94495df1f02d47abb7435cf555ee8e1ae879e6b8', '7b401545d8ffb034dd95181e487a6a9848ed9535.12b6f203099076c6e05a051cc10f61ca0700890b.ba2be86a8ea336d0312ab9a2b64ffbd6aee12f2c.94495df1f02d47abb7435cf555ee8e1ae879e6b8', '0000-00-00 00:00:00', 1, '2019-03-09 12:22:22', '2019-03-09 12:22:22'),
(19, '110806a9a3d9db0b72831ed4ec956e87c1b3a881.761c3220cab7143e39d0ab20ec3ac4539a648afa.67cb02edb28a3b20862ce2d586aaefa3181b6054.0ce4c32e22bb0591e1720074abc9e76d3dcb1bcc', '110806a9a3d9db0b72831ed4ec956e87c1b3a881.761c3220cab7143e39d0ab20ec3ac4539a648afa.67cb02edb28a3b20862ce2d586aaefa3181b6054.0ce4c32e22bb0591e1720074abc9e76d3dcb1bcc', '0000-00-00 00:00:00', 1, '2019-03-17 14:46:22', '2019-03-17 14:46:22'),
(20, '9fbcc189a1147335c8e697a1f02ae2db75b6c93e.36f555771d5a84fdecdfe76ec91b79066ea13639.ef226f77457d1438559a1de6eca56e7ac14c71d6.d7c28e0c4bb18857e2ee1880d31d73fcb5c8d280', '9fbcc189a1147335c8e697a1f02ae2db75b6c93e.36f555771d5a84fdecdfe76ec91b79066ea13639.ef226f77457d1438559a1de6eca56e7ac14c71d6.d7c28e0c4bb18857e2ee1880d31d73fcb5c8d280', '0000-00-00 00:00:00', 1, '2019-03-17 14:47:59', '2019-03-17 14:47:59'),
(21, '081d0e9b0ef240c0718f797bef2574a5b5f8517e.5101612b0385acbadac2f432c56bbebeea0fe0aa.4338d32fda0c307b99fa136fb496d6d6045a590c.eb2ca3204f54ffe28047711b4292cbdbabb9e642', '081d0e9b0ef240c0718f797bef2574a5b5f8517e.5101612b0385acbadac2f432c56bbebeea0fe0aa.4338d32fda0c307b99fa136fb496d6d6045a590c.eb2ca3204f54ffe28047711b4292cbdbabb9e642', '0000-00-00 00:00:00', 1, '2019-03-17 14:49:11', '2019-03-17 14:49:11'),
(22, '51c2963ca4fa86fa28d49ec6d067b43ccde8c74b.88adf7ed15b2f2aed1f0df5a8f54f0805442bca1.ddc1e2823b258cba24a1d5ce1a197d67a02d0f98.590a03ea70e2433e8ef0970cecb324763b69add6', '51c2963ca4fa86fa28d49ec6d067b43ccde8c74b.88adf7ed15b2f2aed1f0df5a8f54f0805442bca1.ddc1e2823b258cba24a1d5ce1a197d67a02d0f98.590a03ea70e2433e8ef0970cecb324763b69add6', '0000-00-00 00:00:00', 1, '2019-03-18 07:50:23', '2019-03-18 07:50:23'),
(23, 'a349c25945b89ae8c50035a79ef0c014c464578e.0ee07fafe4df1e608578fa8c1975d85173572fdf.e063712633d7be6b2e53dee35c4bb6e625f4669b.c294c5aa5ecd9593a8ad354c1b0c37dc42179138', 'a349c25945b89ae8c50035a79ef0c014c464578e.0ee07fafe4df1e608578fa8c1975d85173572fdf.e063712633d7be6b2e53dee35c4bb6e625f4669b.c294c5aa5ecd9593a8ad354c1b0c37dc42179138', '0000-00-00 00:00:00', 1, '2019-03-20 10:15:54', '2019-03-20 10:15:54'),
(24, '1ad43b04f5a94f1fd4cfc112f6f5c1ddbba2d4f5.005dcd5102d3e4467d68585a5ca1a2f21a5ccc96.a68d7ba330c20032152a6cdfe9584f04ecebfb2a.95f47daad92c4a5b94a7c999e34bd6762b884de5', '1ad43b04f5a94f1fd4cfc112f6f5c1ddbba2d4f5.005dcd5102d3e4467d68585a5ca1a2f21a5ccc96.a68d7ba330c20032152a6cdfe9584f04ecebfb2a.95f47daad92c4a5b94a7c999e34bd6762b884de5', '0000-00-00 00:00:00', 1, '2019-04-15 14:50:59', '2019-04-15 14:50:59'),
(25, 'a246109a3554057d73a3529a12fdc98a9c80ac7e.5d4cc73c27c84e0839adaa8e68f1aa633f19ac35.3107fd92699d1122b7f75655f8b261102e55fd3b.b77fead9cad10697ee8d92dd8eeb9db8fd88da9d', 'a246109a3554057d73a3529a12fdc98a9c80ac7e.5d4cc73c27c84e0839adaa8e68f1aa633f19ac35.3107fd92699d1122b7f75655f8b261102e55fd3b.b77fead9cad10697ee8d92dd8eeb9db8fd88da9d', '0000-00-00 00:00:00', 1, '2019-04-15 15:00:39', '2019-04-15 15:00:39'),
(26, '648ae2d3420c0918dc0df417d7a01c2213b0a5ad.fe0c6e1f3dc16071df090a25a36c049f9ce63641.d4157f9d12ed645e6a8c22db764d454707c72c31.669b2db82a1f3fb4301579fdf8428cbb7054a55d', '648ae2d3420c0918dc0df417d7a01c2213b0a5ad.fe0c6e1f3dc16071df090a25a36c049f9ce63641.d4157f9d12ed645e6a8c22db764d454707c72c31.669b2db82a1f3fb4301579fdf8428cbb7054a55d', '0000-00-00 00:00:00', 1, '2019-04-15 15:01:34', '2019-04-15 15:01:34'),
(27, 'ac4d0a3bba0437c99c0b36fb6b15547541ab7705.def69c2d0ab0cb2ab5c9329299077558079af2d3.3f2fd9e19e5640787258181deade42ceaf6e3364.38c0aa21884d4ce7b2b788674ec37a29a4594289', 'ac4d0a3bba0437c99c0b36fb6b15547541ab7705.def69c2d0ab0cb2ab5c9329299077558079af2d3.3f2fd9e19e5640787258181deade42ceaf6e3364.38c0aa21884d4ce7b2b788674ec37a29a4594289', '0000-00-00 00:00:00', 1, '2019-04-15 15:01:37', '2019-04-15 15:01:37'),
(28, '2b10a99f9095d26510792080378cf754f2ca2411.8d6f643c112714df94afb96eb92a49fdfb78ea0f.f15b71162c4258e2744c829f297f60e72d4be719.6cce2ae36957f6775b01316b3180e345fd4c95b1', '2b10a99f9095d26510792080378cf754f2ca2411.8d6f643c112714df94afb96eb92a49fdfb78ea0f.f15b71162c4258e2744c829f297f60e72d4be719.6cce2ae36957f6775b01316b3180e345fd4c95b1', '0000-00-00 00:00:00', 1, '2019-04-15 15:01:37', '2019-04-15 15:01:37'),
(29, 'b08d3178a71709ed41c5dfc193dc0570f8605359.a333b622953b5dc9e8b51023664c27c0bc69f42c.1a961720c504b5ae6a423590c07506715402e79c.97692f4dccb6277842bdf2c9a15ffa9571e9d68e', 'b08d3178a71709ed41c5dfc193dc0570f8605359.a333b622953b5dc9e8b51023664c27c0bc69f42c.1a961720c504b5ae6a423590c07506715402e79c.97692f4dccb6277842bdf2c9a15ffa9571e9d68e', '0000-00-00 00:00:00', 1, '2019-04-15 15:01:37', '2019-04-15 15:01:37'),
(30, '419b69b405bbd19ed32d9cbc42808247a58b5273.c3fe32e69d6b1183c8410c22f94970071cedb83b.ac676feb84ff577c1b9d4c179d767df729a5d04e.b3cf10c3a62fc506d82ea0cd149d820ea0285dcc', '419b69b405bbd19ed32d9cbc42808247a58b5273.c3fe32e69d6b1183c8410c22f94970071cedb83b.ac676feb84ff577c1b9d4c179d767df729a5d04e.b3cf10c3a62fc506d82ea0cd149d820ea0285dcc', '0000-00-00 00:00:00', 1, '2019-04-15 15:03:41', '2019-04-15 15:03:41'),
(31, '18ae1d6fcbe64763e0c3415358317acd0f3bacf2.1bc953e681116e9aa683c789ca1ff50c8859a372.252db2b0b52130aab8d9c0a90b9af4cb162c05d8.f0da38c816aa6eb38522d1b087ec2a1cdcbb6b6e', '18ae1d6fcbe64763e0c3415358317acd0f3bacf2.1bc953e681116e9aa683c789ca1ff50c8859a372.252db2b0b52130aab8d9c0a90b9af4cb162c05d8.f0da38c816aa6eb38522d1b087ec2a1cdcbb6b6e', '0000-00-00 00:00:00', 1, '2019-04-15 15:04:45', '2019-04-15 15:04:45'),
(32, 'c9cdf241f74a7239a5c21bff7cb0c9fe3ea2d570.20410b213765dff32102ef6bfc55c00399d45e26.498105e73262f36830d0a9e99aa64f5c3558aabf.f3c7f4361908bd405e33d390a802079acbb0051c', 'c9cdf241f74a7239a5c21bff7cb0c9fe3ea2d570.20410b213765dff32102ef6bfc55c00399d45e26.498105e73262f36830d0a9e99aa64f5c3558aabf.f3c7f4361908bd405e33d390a802079acbb0051c', '0000-00-00 00:00:00', 1, '2019-04-15 15:05:11', '2019-04-15 15:05:11'),
(33, '117506c25e286cff2dc4242041308e27d18ccdf7.8bbafb3d0decb57c8cea84706b5739ab54575bfe.0cf96cca49f4cfb6daae05fb4f5486800076a0ca.d7044c64c6da5a6f0d08fbdd2b9b0b34675f078a', '117506c25e286cff2dc4242041308e27d18ccdf7.8bbafb3d0decb57c8cea84706b5739ab54575bfe.0cf96cca49f4cfb6daae05fb4f5486800076a0ca.d7044c64c6da5a6f0d08fbdd2b9b0b34675f078a', '2019-04-16 23:22:15', 1, '2019-04-16 15:22:15', '2019-04-16 15:22:15'),
(34, 'cb5043c3a81345ac8ac62a893c32647afea05e6c.1d850054d7b067d496054d9e7d93987f30df8b8d.8c62e23d684ac7a67aba09e2ece611921563676f.8f3bfe069c15836e49ff9372b913824d2f0dff58', 'cb5043c3a81345ac8ac62a893c32647afea05e6c.1d850054d7b067d496054d9e7d93987f30df8b8d.8c62e23d684ac7a67aba09e2ece611921563676f.8f3bfe069c15836e49ff9372b913824d2f0dff58', '2019-04-16 00:00:00', 1, '2019-04-16 16:00:00', '2019-04-16 16:00:00'),
(35, '56936f641b1f013f9a2b17c7237cdcee2ea5b38a.7437d2a58add7990002b6c6316202d60d73178ee.b11e1cb6521912d1feb98b308812a54b1b9fa6f4.a85afca23456b8bb0e24cba1a834a6cc061d0cad', '56936f641b1f013f9a2b17c7237cdcee2ea5b38a.7437d2a58add7990002b6c6316202d60d73178ee.b11e1cb6521912d1feb98b308812a54b1b9fa6f4.a85afca23456b8bb0e24cba1a834a6cc061d0cad', '2019-04-17 00:03:12', 1, '2019-04-16 16:03:12', '2019-04-16 16:03:12'),
(36, 'b6662d56897e2f8f961d95f62fca9c4fa5388451.df0d06675582d290ae2348825f9a14c42a72bce8.62cf4854844a35c75cf73eee1af163650a089f73.afcd4b79576e85ff79575506d6de53fdd49683e1', '55e5f3fce9d6fbc29c822c52ad659ef1d44c0778.81b0b82debe6e1d1fe59c56edc82cc7df2157c75.537a6c4ce425ef98df1bc7c40cd4a505ca381d93.5fe78f36e7ba663f1c091facac66cad1df914918', '2019-04-17 00:33:20', 1, '2019-04-16 16:03:57', '2019-04-16 16:03:57');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `user_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_phone` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_birthday` date NOT NULL,
  `user_address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `permission_id` int(10) UNSIGNED NOT NULL,
  `user_status` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`user_id`, `user_name`, `user_email`, `user_phone`, `user_birthday`, `user_address`, `user_password`, `permission_id`, `user_status`, `created_at`, `updated_at`) VALUES
(1, 'Nguyễn Quang Huy', 'admin@gmail.com', '0966033066', '1997-10-13', '101/162/2A Đông Thạnh Hóc Môn', '$2y$10$lh.T6Y2mDLqkPgzNHuQoQensUFdsj3mSs6mYA4Vb2tSkGFOkiFUfm', 1, 1, '2019-01-28 22:54:12', '2019-04-07 05:45:36'),
(2, 'Nguyễn Quang Huy User', 'huynvp@gmail.com', '0123456789', '1997-10-13', '101/162/2a Ấp 4 xã Đông Thạnh huyện Hóc Môn', '4297f44b13955235245b2497399d7a93', 2, 1, '2019-01-29 21:58:53', '2019-01-29 21:58:53'),
(5, 'User test', '123@gmail.com', '0285969587', '1996-12-10', '123 123 ', '827ccb0eea8a706c4c34a16891f84e7b', 3, 1, '2019-02-21 04:57:53', '2019-02-21 04:57:53'),
(10, 'qưeqưeưqe', 'eưqeqwe', 'ưqe', '2019-02-07', 'ưqeưqe', '827ccb0eea8a706c4c34a16891f84e7b', 2, 1, '2019-02-21 14:51:45', '2019-02-21 14:51:45'),
(11, 'Test ', '11', '11', '1999-11-11', '123', '827ccb0eea8a706c4c34a16891f84e7b', 3, 1, '2019-02-22 16:16:41', '2019-02-22 16:16:41'),
(12, 'eqưeqưeqw', 'eqưeqưe', 'ưqeqưe', '1987-12-21', 'qưeqweq', '827ccb0eea8a706c4c34a16891f84e7b', 3, 1, '2019-02-22 16:19:10', '2019-02-22 16:19:10'),
(13, '1eqw', '11111111', '111', '1998-12-11', 'eeqe', '827ccb0eea8a706c4c34a16891f84e7b', 3, 1, '2019-02-22 17:01:15', '2019-02-22 17:01:15'),
(14, 'cc', 'cc', 'cc', '1998-12-11', 'cc', '827ccb0eea8a706c4c34a16891f84e7b', 3, 1, '2019-02-22 17:01:47', '2019-02-22 17:01:47'),
(15, '1', '131313', '131313', '1988-12-03', '1', '827ccb0eea8a706c4c34a16891f84e7b', 3, 1, '2019-02-26 15:23:13', '2019-02-26 15:23:13'),
(16, '1', 'b', 'b', '2019-03-13', '1', '$2y$10$Y03.BoIwsslOXYZFvkPRF.BegaAPdlf.MNwRvC/2w/ucBS2I41obO', 3, 1, '2019-03-17 22:00:33', '2019-03-17 22:00:33');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `api`
--
ALTER TABLE `api`
  ADD PRIMARY KEY (`api_id`);

--
-- Chỉ mục cho bảng `level`
--
ALTER TABLE `level`
  ADD PRIMARY KEY (`level_id`);

--
-- Chỉ mục cho bảng `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `FK_Log_User` (`user_id`);

--
-- Chỉ mục cho bảng `my_note`
--
ALTER TABLE `my_note`
  ADD PRIMARY KEY (`note_id`),
  ADD KEY `FK_Note_User` (`user`),
  ADD KEY `fk_my_note_level` (`level_id`);

--
-- Chỉ mục cho bảng `permission`
--
ALTER TABLE `permission`
  ADD PRIMARY KEY (`permission_id`);

--
-- Chỉ mục cho bảng `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`project_id`),
  ADD UNIQUE KEY `project_name` (`project_name`),
  ADD KEY `FK_Project_User` (`user_id`);

--
-- Chỉ mục cho bảng `project_api`
--
ALTER TABLE `project_api`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_Project` (`project_id`),
  ADD KEY `FK_Api` (`api_id`);

--
-- Chỉ mục cho bảng `tag`
--
ALTER TABLE `tag`
  ADD PRIMARY KEY (`tag_name`);

--
-- Chỉ mục cho bảng `token`
--
ALTER TABLE `token`
  ADD PRIMARY KEY (`token_id`),
  ADD KEY `FK_Token_User` (`user_id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `users_email_unique` (`user_email`),
  ADD KEY `FK_User_Permission` (`permission_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `api`
--
ALTER TABLE `api`
  MODIFY `api_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT cho bảng `level`
--
ALTER TABLE `level`
  MODIFY `level_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `log`
--
ALTER TABLE `log`
  MODIFY `log_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT cho bảng `my_note`
--
ALTER TABLE `my_note`
  MODIFY `note_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT cho bảng `permission`
--
ALTER TABLE `permission`
  MODIFY `permission_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `project`
--
ALTER TABLE `project`
  MODIFY `project_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT cho bảng `project_api`
--
ALTER TABLE `project_api`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT cho bảng `token`
--
ALTER TABLE `token`
  MODIFY `token_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `log`
--
ALTER TABLE `log`
  ADD CONSTRAINT `FK_Log_User` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Các ràng buộc cho bảng `my_note`
--
ALTER TABLE `my_note`
  ADD CONSTRAINT `FK_Note_User` FOREIGN KEY (`user`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `fk_my_note_level` FOREIGN KEY (`level_id`) REFERENCES `level` (`level_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Các ràng buộc cho bảng `project`
--
ALTER TABLE `project`
  ADD CONSTRAINT `FK_Project_User` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Các ràng buộc cho bảng `project_api`
--
ALTER TABLE `project_api`
  ADD CONSTRAINT `FK_Api` FOREIGN KEY (`api_id`) REFERENCES `api` (`api_id`),
  ADD CONSTRAINT `FK_Project` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`);

--
-- Các ràng buộc cho bảng `token`
--
ALTER TABLE `token`
  ADD CONSTRAINT `FK_Token_User` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Các ràng buộc cho bảng `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `FK_User_Permission` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`permission_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
