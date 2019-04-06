-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 192.168.10.39
-- Thời gian đã tạo: Th4 06, 2019 lúc 12:50 PM
-- Phiên bản máy phục vụ: 10.3.7-MariaDB-1:10.3.7+maria~jessie
-- Phiên bản PHP: 7.3.3-1+ubuntu16.04.1+deb.sury.org+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `gameshow`
--
CREATE DATABASE IF NOT EXISTS `gameshow` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `gameshow`;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `answers`
--

CREATE TABLE `answers` (
  `id` int(10) UNSIGNED NOT NULL,
  `path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tag` tinyint(4) NOT NULL DEFAULT 1,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `question_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2018_09_17_041022_create_sessions_table', 1),
(2, '2018_09_17_041122_create_questions_table', 1),
(3, '2018_09_17_041135_create_answers_table', 1),
(4, '2018_09_19_103207_create_question_session_table', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `questions`
--

CREATE TABLE `questions` (
  `id` int(10) UNSIGNED NOT NULL,
  `content` text COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `tag` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `question_session`
--

CREATE TABLE `question_session` (
  `question_id` int(11) NOT NULL,
  `session_id` int(11) NOT NULL,
  `order` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sessions`
--

CREATE TABLE `sessions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `sessions`
--

INSERT INTO `sessions` (`id`, `name`, `slug`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Nguyễn Quang Huy', NULL, 'tesst', '2019-03-15 00:07:08', '2019-03-15 00:07:08');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `answers`
--
ALTER TABLE `answers`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `answers`
--
ALTER TABLE `answers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `sessions`
--
ALTER TABLE `sessions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- Cơ sở dữ liệu: `myweb_user51c`
--
CREATE DATABASE IF NOT EXISTS `myweb_user51c` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `myweb_user51c`;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `api`
--

CREATE TABLE `api` (
  `api_id` int(10) UNSIGNED NOT NULL,
  `api_method` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `api_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `api_content` text COLLATE utf8_unicode_ci DEFAULT '',
  `api_params` text COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `api_response` text COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `api_status` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
(7, '[Work] [Daily] Công việc ngày 27/3/2019', '<p><strong>Công việc hàng ngày:&nbsp;</strong></p><ul><li>Code tool ghi chú cá nhân (Code insert và update)</li><li>Update git</li><li>Code dự án Vietjet Bảo việt Insurance</li></ul>', '2019-03-27', 0, 1, '2019-03-27 12:00:35', '2019-04-06 10:15:08', 2, NULL, 1),
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
(1, 1, 'Vietjet', 1, '2019-01-28 15:58:14', '2019-01-28 15:58:14'),
(2, 1, 'Gameshow', 1, '2019-01-28 15:58:20', '2019-01-28 15:58:20');

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
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `token`
--

INSERT INTO `token` (`token_id`, `token_value`, `real_token_value`, `user_id`, `created_at`, `updated_at`) VALUES
(1, '8e7566595c21175aacc91345b004bbbf130007ae.d068c67e36f9308cead0eee8ba585d0d6f20b1aa.901cb3761dbe7acf06d104c087654fb44284e415.5ba3e9db3e12bae1520ec84b0120ae833455bdf4', '23c892f826ff7aa2a5804cc4bc5aea4b81b64883.faf35362a75ae34b11fd3c6f221c3f54973263f1.d20692c30b2404de3c6bb2f38f4f1f7dcd2a4830.8da8e7ebddac8e516f0dc4972bce3be94751dea8', 1, '2019-02-15 17:35:12', '2019-02-15 17:35:12'),
(2, 'b3842f303f8fdd91b14d1076cb70e6b4ee620484.1a0af29a6f8f64af9e0b6019b93489e66c6cefba.a635124e482426b03fb0c953cdfc4babd53d13c9.06e956af4720b845c20f8769dea3f879ec540c3f', 'b3842f303f8fdd91b14d1076cb70e6b4ee620484.1a0af29a6f8f64af9e0b6019b93489e66c6cefba.a635124e482426b03fb0c953cdfc4babd53d13c9.06e956af4720b845c20f8769dea3f879ec540c3f', 1, '2019-02-15 17:35:51', '2019-02-15 17:35:51'),
(5, 'efd82d72ddf23f615b0f06a4558f6f8d36675697.e7abfff930e6bd5837ae31d080392da01941b4c0.bf8444b74dc89ba7e0c3d4e79c2e4de2fb842d66.ee6843b8821d564bee2a755afa234a2e2f4ff8a7', 'efd82d72ddf23f615b0f06a4558f6f8d36675697.e7abfff930e6bd5837ae31d080392da01941b4c0.bf8444b74dc89ba7e0c3d4e79c2e4de2fb842d66.ee6843b8821d564bee2a755afa234a2e2f4ff8a7', 1, '2019-02-15 17:48:50', '2019-02-15 17:48:50'),
(6, '227dbcf0f421bd6e9f7b1c561489127c54a73aab.935e794146c73bfbd43d976c1fff6871194e7fe3.9ddd13ed6143b7e6505918bdefebaebfb3b4da4c.c0055281f51491d8eba12c8c44884cc4fac46252', '227dbcf0f421bd6e9f7b1c561489127c54a73aab.935e794146c73bfbd43d976c1fff6871194e7fe3.9ddd13ed6143b7e6505918bdefebaebfb3b4da4c.c0055281f51491d8eba12c8c44884cc4fac46252', 1, '2019-02-15 17:49:31', '2019-02-15 17:49:31'),
(10, '2d43d7194641112896e690f2034cb7e5904cec84.0c65bfd16a86bcc366a2d0c3cfb0c36a5b83e062.b17c41fedc07d78a602a8e27513236b328442744.4a1a01158f6d5b2471914a3bc5c6aa4f6dc203d7', '2d43d7194641112896e690f2034cb7e5904cec84.0c65bfd16a86bcc366a2d0c3cfb0c36a5b83e062.b17c41fedc07d78a602a8e27513236b328442744.4a1a01158f6d5b2471914a3bc5c6aa4f6dc203d7', 1, '2019-02-16 13:33:44', '2019-02-16 13:33:44'),
(15, '5c4b344a94906a0b5d232924afdcbf816eb3784c.b0cd5978cb4e637b19a52e7c41b602460454fb56.c009aa85eba6580ca47440fe685369b605f2e86a.3ae178bb217d67f368d6a206ec539ce3b19c9879', 'b81658c0686914740168f53bd2d1b75bcc33574f.95bf9b2e5a54f4381616e909c1fa1f69b36803e6.de9d47200ed49670c72823432bdcbc1949d833b1.c30fcf668010f04c58ef78e8418087ec8e744c5a', 1, '2019-02-25 04:52:28', '2019-02-25 04:52:28'),
(16, '6608c54df3bdcd2fe275115d054aedf4f9ab49e6.77a585adcd13dd2a90c012935e00960022c43839.2d1e8703d8dc6ba5036d240beefc37ac876e6792.8b11f1fa6809fae174dbef0d2f0bd8945a9e7923', '7065d17193d8c5ec360d028c438f905bf49c3950.cf0b5ef62de825d2189aba8692ab3e2e013515ed.1e15b1fa48e78bec4511505fe60c4bc6d20aa098.b61c608f57ad86edd770f928a83046f6e5a7b13b', 1, '2019-02-26 13:55:30', '2019-02-26 13:55:30'),
(17, 'c38d9d5e15c070e7abee7bd30313e087da1fceed.c656b3fea81ee4d92197c26c345ebf3c0734c0f1.1a204d97ca9a1f0ef2cd5ab7e22049699efdf6a5.6500bf4e469c328a37d9a4ef53435a3b9e8eacaa', 'da9fd1d4a945d48f5abfffda86ed173310742d14.3f3796fa4ad81d0ef3544ff50ce7149cfdaed702.6df9eb04e01de94216ec09bd7103fca92795b26e.d84b95af11caae12d76333a4f5971060a2dd021e', 1, '2019-02-26 14:57:26', '2019-02-26 14:57:26'),
(18, '7b401545d8ffb034dd95181e487a6a9848ed9535.12b6f203099076c6e05a051cc10f61ca0700890b.ba2be86a8ea336d0312ab9a2b64ffbd6aee12f2c.94495df1f02d47abb7435cf555ee8e1ae879e6b8', '7b401545d8ffb034dd95181e487a6a9848ed9535.12b6f203099076c6e05a051cc10f61ca0700890b.ba2be86a8ea336d0312ab9a2b64ffbd6aee12f2c.94495df1f02d47abb7435cf555ee8e1ae879e6b8', 1, '2019-03-09 12:22:22', '2019-03-09 12:22:22'),
(19, '110806a9a3d9db0b72831ed4ec956e87c1b3a881.761c3220cab7143e39d0ab20ec3ac4539a648afa.67cb02edb28a3b20862ce2d586aaefa3181b6054.0ce4c32e22bb0591e1720074abc9e76d3dcb1bcc', '110806a9a3d9db0b72831ed4ec956e87c1b3a881.761c3220cab7143e39d0ab20ec3ac4539a648afa.67cb02edb28a3b20862ce2d586aaefa3181b6054.0ce4c32e22bb0591e1720074abc9e76d3dcb1bcc', 1, '2019-03-17 14:46:22', '2019-03-17 14:46:22'),
(20, '9fbcc189a1147335c8e697a1f02ae2db75b6c93e.36f555771d5a84fdecdfe76ec91b79066ea13639.ef226f77457d1438559a1de6eca56e7ac14c71d6.d7c28e0c4bb18857e2ee1880d31d73fcb5c8d280', '9fbcc189a1147335c8e697a1f02ae2db75b6c93e.36f555771d5a84fdecdfe76ec91b79066ea13639.ef226f77457d1438559a1de6eca56e7ac14c71d6.d7c28e0c4bb18857e2ee1880d31d73fcb5c8d280', 1, '2019-03-17 14:47:59', '2019-03-17 14:47:59'),
(21, '081d0e9b0ef240c0718f797bef2574a5b5f8517e.5101612b0385acbadac2f432c56bbebeea0fe0aa.4338d32fda0c307b99fa136fb496d6d6045a590c.eb2ca3204f54ffe28047711b4292cbdbabb9e642', '081d0e9b0ef240c0718f797bef2574a5b5f8517e.5101612b0385acbadac2f432c56bbebeea0fe0aa.4338d32fda0c307b99fa136fb496d6d6045a590c.eb2ca3204f54ffe28047711b4292cbdbabb9e642', 1, '2019-03-17 14:49:11', '2019-03-17 14:49:11'),
(22, '51c2963ca4fa86fa28d49ec6d067b43ccde8c74b.88adf7ed15b2f2aed1f0df5a8f54f0805442bca1.ddc1e2823b258cba24a1d5ce1a197d67a02d0f98.590a03ea70e2433e8ef0970cecb324763b69add6', '51c2963ca4fa86fa28d49ec6d067b43ccde8c74b.88adf7ed15b2f2aed1f0df5a8f54f0805442bca1.ddc1e2823b258cba24a1d5ce1a197d67a02d0f98.590a03ea70e2433e8ef0970cecb324763b69add6', 1, '2019-03-18 07:50:23', '2019-03-18 07:50:23'),
(23, 'a349c25945b89ae8c50035a79ef0c014c464578e.0ee07fafe4df1e608578fa8c1975d85173572fdf.e063712633d7be6b2e53dee35c4bb6e625f4669b.c294c5aa5ecd9593a8ad354c1b0c37dc42179138', 'a349c25945b89ae8c50035a79ef0c014c464578e.0ee07fafe4df1e608578fa8c1975d85173572fdf.e063712633d7be6b2e53dee35c4bb6e625f4669b.c294c5aa5ecd9593a8ad354c1b0c37dc42179138', 1, '2019-03-20 10:15:54', '2019-03-20 10:15:54');

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
(1, 'Nguyễn Quang Huy', 'admin@gmail.com', '0966033066', '1997-10-13', '101/162/2A Đông Thạnh Hóc Môn', '4297f44b13955235245b2497399d7a93', 1, 1, '2019-01-28 22:54:12', '2019-01-28 22:54:12'),
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
  MODIFY `api_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `project_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `project_api`
--
ALTER TABLE `project_api`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `token`
--
ALTER TABLE `token`
  MODIFY `token_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

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
--
-- Cơ sở dữ liệu: `sso_login_vietjet`
--
CREATE DATABASE IF NOT EXISTS `sso_login_vietjet` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `sso_login_vietjet`;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sso_authentication`
--

CREATE TABLE `sso_authentication` (
  `authentication_id` int(11) NOT NULL COMMENT 'id of an authentication',
  `user_id` int(11) NOT NULL COMMENT 'user id of an user to authentication',
  `access_system_id` smallint(6) NOT NULL,
  `access_token` varchar(256) DEFAULT NULL COMMENT 'authentication access token',
  `accessed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `expired_at` datetime DEFAULT NULL,
  `expire_url` varchar(254) DEFAULT NULL COMMENT 'expire url for each system'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='this table is store all the authentication of the system';

--
-- Đang đổ dữ liệu cho bảng `sso_authentication`
--

INSERT INTO `sso_authentication` (`authentication_id`, `user_id`, `access_system_id`, `access_token`, `accessed_at`, `expired_at`, `expire_url`) VALUES
(1, 1, 1, '9f63989862b70ac081ee542ee7f13af3376e32408fc31b5ab504c026', '2019-03-11 05:03:39', '2019-03-11 14:48:39', '/admin');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sso_authentication_logs`
--

CREATE TABLE `sso_authentication_logs` (
  `log_id` int(11) NOT NULL COMMENT 'system logs id',
  `log_content` varchar(500) DEFAULT NULL COMMENT 'log content of each authentication',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'time when log is created',
  `system_id` smallint(6) DEFAULT NULL COMMENT 'Log system ID'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='human readable logs for authentication\nThis authentication log table will be cleared every month';

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sso_insight_systems`
--

CREATE TABLE `sso_insight_systems` (
  `system_id` smallint(6) NOT NULL COMMENT 'software system id',
  `system_name` varchar(100) NOT NULL,
  `system_access_key` varchar(256) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'date and time when created',
  `modified_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'date and time when the system is modified',
  `expire_time` int(11) NOT NULL COMMENT 'system expired time in seconds\n\n< 0 never expired',
  `system_type_id` tinyint(4) NOT NULL COMMENT 'Type of system in the SSO',
  `authentication_url` varchar(254) DEFAULT NULL COMMENT 'authentication url of the system',
  `expire_url` varchar(254) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `system_status` tinyint(1) DEFAULT 1 COMMENT 'status of the system, used to lock system',
  `sso_user_id` smallint(6) NOT NULL COMMENT 'sso user id'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='software system in the insight eco system';

--
-- Đang đổ dữ liệu cho bảng `sso_insight_systems`
--

INSERT INTO `sso_insight_systems` (`system_id`, `system_name`, `system_access_key`, `created_at`, `modified_at`, `expire_time`, `system_type_id`, `authentication_url`, `expire_url`, `system_status`, `sso_user_id`) VALUES
(1, 'root', 'rootAltamedia', '2019-03-11 04:58:23', '0000-00-00 00:00:00', 9900, 1, '/admin', '/admin', 1, 1);

--
-- Bẫy `sso_insight_systems`
--
DELIMITER $$
CREATE TRIGGER `tg_update_expire_url` BEFORE UPDATE ON `sso_insight_systems` FOR EACH ROW BEGIN
    UPDATE  sso_authentication 
    SET sso_authentication.expire_url = new.expire_url
    WHERE sso_authentication.access_system_id = new.system_id;
   
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sso_insight_system_type`
--

CREATE TABLE `sso_insight_system_type` (
  `system_type_id` tinyint(4) NOT NULL COMMENT 'System type id',
  `system_type_name` varchar(20) NOT NULL COMMENT 'system type name',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `type_expire_time` int(11) DEFAULT -1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='this table store system configuration type';

--
-- Đang đổ dữ liệu cho bảng `sso_insight_system_type`
--

INSERT INTO `sso_insight_system_type` (`system_type_id`, `system_type_name`, `created_at`, `type_expire_time`) VALUES
(1, 'type_root', '2019-03-11 04:54:29', -1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sso_insight_users`
--

CREATE TABLE `sso_insight_users` (
  `user_id` int(11) NOT NULL COMMENT 'user id',
  `user_name` varchar(100) NOT NULL COMMENT 'user name by email format',
  `system_origin_id` smallint(6) NOT NULL COMMENT 'system origins of the user',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'timestamp when the user is created',
  `last_access_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'users last access to the system',
  `last_access_system_id` smallint(6) DEFAULT NULL,
  `user_status` tinyint(1) DEFAULT 1 COMMENT 'status of users'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This table store users information';

--
-- Đang đổ dữ liệu cho bảng `sso_insight_users`
--

INSERT INTO `sso_insight_users` (`user_id`, `user_name`, `system_origin_id`, `created_at`, `last_access_at`, `last_access_system_id`, `user_status`) VALUES
(1, 'altamedia@gmail.com', 1, '2019-03-11 05:03:39', '2019-03-11 05:03:39', 1, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sso_ip_whitelist`
--

CREATE TABLE `sso_ip_whitelist` (
  `ip_whitelist_id` int(11) NOT NULL COMMENT 'whitelist ID',
  `ip_address` varchar(20) DEFAULT NULL,
  `system_domain_name` varchar(40) DEFAULT NULL COMMENT 'Domain name of the system',
  `system_id` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This table is to stored IP whitelist for all systems';

--
-- Đang đổ dữ liệu cho bảng `sso_ip_whitelist`
--

INSERT INTO `sso_ip_whitelist` (`ip_whitelist_id`, `ip_address`, `system_domain_name`, `system_id`) VALUES
(1, '192.168.10.247', 'altamedia.com.vn', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sso_logs`
--

CREATE TABLE `sso_logs` (
  `log_id` int(11) NOT NULL,
  `log_content` text NOT NULL,
  `log_type` varchar(256) DEFAULT NULL,
  `log_event` varchar(256) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sso_system_parameters`
--

CREATE TABLE `sso_system_parameters` (
  `param_id` smallint(6) NOT NULL COMMENT 'parameter id',
  `param_name` varchar(100) DEFAULT NULL COMMENT 'parameter name',
  `param_value` varchar(50) DEFAULT NULL COMMENT 'parameter value',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'time of parameter creation'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='system parameters';

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sso_users`
--

CREATE TABLE `sso_users` (
  `sso_user_id` smallint(6) NOT NULL COMMENT 'users system of sso system',
  `sso_username` varchar(100) NOT NULL COMMENT 'user name system',
  `sso_password` varchar(256) NOT NULL COMMENT 'password',
  `sso_token` varchar(256) DEFAULT NULL COMMENT 'users token',
  `sso_token_expired_time` datetime DEFAULT NULL COMMENT 'the time for token to expire',
  `sso_user_status` tinyint(1) DEFAULT 1 COMMENT 'users status of sso system',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'time to create at',
  `last_access_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'last access at',
  `sso_permission` longtext DEFAULT NULL COMMENT 'sso users permission',
  `sso_user_fullname` varchar(100) DEFAULT NULL COMMENT 'user full name'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Đang đổ dữ liệu cho bảng `sso_users`
--

INSERT INTO `sso_users` (`sso_user_id`, `sso_username`, `sso_password`, `sso_token`, `sso_token_expired_time`, `sso_user_status`, `created_at`, `last_access_at`, `sso_permission`, `sso_user_fullname`) VALUES
(1, 'altamedia@gmail.com', '65d14c448665338384e13b89030ba7bdaea9dfeb150027ff64bc3fe1c8c815d7', '9f63989862b70ac081ee542ee7f13af3376e32408fc31b5ab504c026', '2019-03-11 14:48:39', 1, '2019-03-11 04:58:03', '2019-03-11 04:58:03', NULL, NULL);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `sso_authentication`
--
ALTER TABLE `sso_authentication`
  ADD PRIMARY KEY (`authentication_id`),
  ADD KEY `fk_sso_authentication_sso_insight_systems` (`access_system_id`),
  ADD KEY `fk_sso_authentication_sso_insight_users` (`user_id`);

--
-- Chỉ mục cho bảng `sso_authentication_logs`
--
ALTER TABLE `sso_authentication_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `fk_sso_authentication_logs_sso_insight_systems` (`system_id`);

--
-- Chỉ mục cho bảng `sso_insight_systems`
--
ALTER TABLE `sso_insight_systems`
  ADD PRIMARY KEY (`system_id`),
  ADD UNIQUE KEY `idx_sso_insight_systems_system_access_key` (`system_access_key`),
  ADD KEY `fk_sso_insight_systems_sso_insight_system_type` (`system_type_id`),
  ADD KEY `fk_sso_insight_systems_sso_users` (`sso_user_id`);

--
-- Chỉ mục cho bảng `sso_insight_system_type`
--
ALTER TABLE `sso_insight_system_type`
  ADD PRIMARY KEY (`system_type_id`),
  ADD UNIQUE KEY `unq_system_name_type` (`system_type_name`);

--
-- Chỉ mục cho bảng `sso_insight_users`
--
ALTER TABLE `sso_insight_users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `idx_sso_insight_users_user_name` (`user_name`),
  ADD KEY `fk_sso_insight_users_sso_insight_systems` (`system_origin_id`);

--
-- Chỉ mục cho bảng `sso_ip_whitelist`
--
ALTER TABLE `sso_ip_whitelist`
  ADD PRIMARY KEY (`ip_whitelist_id`),
  ADD KEY `fk_sso_ip_whitelist_sso_insight_systems` (`system_id`);

--
-- Chỉ mục cho bảng `sso_logs`
--
ALTER TABLE `sso_logs`
  ADD PRIMARY KEY (`log_id`);

--
-- Chỉ mục cho bảng `sso_system_parameters`
--
ALTER TABLE `sso_system_parameters`
  ADD PRIMARY KEY (`param_id`),
  ADD UNIQUE KEY `idx_sso_system_parameters_param_name` (`param_name`);

--
-- Chỉ mục cho bảng `sso_users`
--
ALTER TABLE `sso_users`
  ADD PRIMARY KEY (`sso_user_id`),
  ADD UNIQUE KEY `idx_sso_users_sso_username` (`sso_username`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `sso_authentication`
--
ALTER TABLE `sso_authentication`
  MODIFY `authentication_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id of an authentication', AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `sso_authentication_logs`
--
ALTER TABLE `sso_authentication_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'system logs id';

--
-- AUTO_INCREMENT cho bảng `sso_insight_systems`
--
ALTER TABLE `sso_insight_systems`
  MODIFY `system_id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT 'software system id', AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `sso_insight_system_type`
--
ALTER TABLE `sso_insight_system_type`
  MODIFY `system_type_id` tinyint(4) NOT NULL AUTO_INCREMENT COMMENT 'System type id', AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `sso_insight_users`
--
ALTER TABLE `sso_insight_users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'user id', AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `sso_ip_whitelist`
--
ALTER TABLE `sso_ip_whitelist`
  MODIFY `ip_whitelist_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'whitelist ID', AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `sso_logs`
--
ALTER TABLE `sso_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `sso_system_parameters`
--
ALTER TABLE `sso_system_parameters`
  MODIFY `param_id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT 'parameter id', AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `sso_users`
--
ALTER TABLE `sso_users`
  MODIFY `sso_user_id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT 'users system of sso system', AUTO_INCREMENT=2;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `sso_authentication`
--
ALTER TABLE `sso_authentication`
  ADD CONSTRAINT `fk_sso_authentication_sso_insight_systems` FOREIGN KEY (`access_system_id`) REFERENCES `sso_insight_systems` (`system_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_sso_authentication_sso_insight_users` FOREIGN KEY (`user_id`) REFERENCES `sso_insight_users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Các ràng buộc cho bảng `sso_authentication_logs`
--
ALTER TABLE `sso_authentication_logs`
  ADD CONSTRAINT `fk_sso_authentication_logs_sso_insight_systems` FOREIGN KEY (`system_id`) REFERENCES `sso_insight_systems` (`system_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Các ràng buộc cho bảng `sso_insight_systems`
--
ALTER TABLE `sso_insight_systems`
  ADD CONSTRAINT `fk_sso_insight_systems_sso_insight_system_type` FOREIGN KEY (`system_type_id`) REFERENCES `sso_insight_system_type` (`system_type_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_sso_insight_systems_sso_users` FOREIGN KEY (`sso_user_id`) REFERENCES `sso_users` (`sso_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Các ràng buộc cho bảng `sso_insight_users`
--
ALTER TABLE `sso_insight_users`
  ADD CONSTRAINT `fk_sso_insight_users_sso_insight_systems` FOREIGN KEY (`system_origin_id`) REFERENCES `sso_insight_systems` (`system_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Các ràng buộc cho bảng `sso_ip_whitelist`
--
ALTER TABLE `sso_ip_whitelist`
  ADD CONSTRAINT `fk_sso_ip_whitelist_sso_insight_systems` FOREIGN KEY (`system_id`) REFERENCES `sso_insight_systems` (`system_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
--
-- Cơ sở dữ liệu: `Test`
--
CREATE DATABASE IF NOT EXISTS `Test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `Test`;
--
-- Cơ sở dữ liệu: `vietjetlocal`
--
CREATE DATABASE IF NOT EXISTS `vietjetlocal` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `vietjetlocal`;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `booking_imports`
--

CREATE TABLE `booking_imports` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `token_id` int(11) DEFAULT NULL,
  `token_username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `file_path` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `access_token` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `booking_tasks`
--

CREATE TABLE `booking_tasks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `import_id` bigint(20) NOT NULL,
  `ref_id` bigint(20) NOT NULL DEFAULT 0,
  `row` int(11) NOT NULL DEFAULT 0,
  `route` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `base_currency` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `group_type` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `company` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `phone` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `city_pair` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `departure` date NOT NULL,
  `hour` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `real_hour` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `fare_class` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `real_fare_class` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `price` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `amount` int(11) NOT NULL,
  `note` text COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `access_token` text COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `booking_key` text COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `booking_class` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `res_number` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `res_key` text COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `file_passenger` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `is_purchase` tinyint(4) NOT NULL DEFAULT 0,
  `parent` bigint(20) NOT NULL DEFAULT 0,
  `flight_choose` text COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `passenger_key` text COLLATE utf8_unicode_ci NOT NULL,
  `res_key` text COLLATE utf8_unicode_ci NOT NULL,
  `timestamp` text COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `last_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `first_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `address` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `city` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `nation_country` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `gender` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `phone_number` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `mobile_number` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `email` varchar(70) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `buss_phone_number` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `buss_fax_number` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `buss_extension` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `postal_code` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `passport_number` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `passport_expiry_date` date DEFAULT NULL,
  `passport_issuing_country` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `passport_issuing_city` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `passport_issuing_date` date DEFAULT NULL,
  `service_request` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `note` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `fare_city_pairs`
--

CREATE TABLE `fare_city_pairs` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `pair` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `departure_airport_code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `departure_airport_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `arrival_airport_code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `arrival_airport_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fare_class` text COLLATE utf8_unicode_ci NOT NULL,
  `active` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `fare_imports`
--

CREATE TABLE `fare_imports` (
  `id` int(10) UNSIGNED NOT NULL,
  `token_id` bigint(20) NOT NULL DEFAULT 0,
  `token_username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `file_path` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `access_token` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `fare_tasks`
--

CREATE TABLE `fare_tasks` (
  `id` int(10) UNSIGNED NOT NULL,
  `import_id` bigint(20) NOT NULL,
  `ref_id` bigint(20) NOT NULL DEFAULT 0,
  `city_pair_key` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fare_class_key` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city_pair` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fare_class_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `action` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_deleted` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `on_sale_from` datetime NOT NULL,
  `on_sale_to` datetime NOT NULL,
  `travel_from` datetime NOT NULL,
  `travel_to` datetime NOT NULL,
  `base_currency` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `timestamp` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `currency_VND` double DEFAULT NULL,
  `currency_USD` double DEFAULT NULL,
  `currency_CNY` double DEFAULT NULL,
  `currency_HKD` double DEFAULT NULL,
  `currency_IDR` double DEFAULT NULL,
  `currency_INR` double DEFAULT NULL,
  `currency_JPY` double DEFAULT NULL,
  `currency_KHR` double DEFAULT NULL,
  `currency_KRW` double DEFAULT NULL,
  `currency_MMK` double DEFAULT NULL,
  `currency_MYR` double DEFAULT NULL,
  `currency_SGD` double DEFAULT NULL,
  `currency_THB` double DEFAULT NULL,
  `currency_TWD` double DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `note` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `logs`
--

CREATE TABLE `logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `action` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_action` bigint(20) DEFAULT NULL,
  `access_token` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2018_10_08_081358_create_booking_imports_table', 1),
(2, '2018_10_08_081359_create_customers_table', 1),
(3, '2018_10_08_081359_create_service_requests_table', 1),
(4, '2018_10_08_112051_create_booking_tasks_table', 1),
(5, '2018_11_06_091204_create_fare_city_pairs_table', 2),
(6, '2018_11_06_091227_create_fare_imports_table', 2),
(7, '2018_11_06_091232_create_fare_tasks_table', 2),
(8, '2018_10_23_041425_create_tokens_table', 3),
(9, '2018_10_23_050659_create_user_permissions', 3),
(10, '2018_10_08_081359_create_logs_table', 4),
(11, '2014_10_12_100000_create_password_resets_table', 5),
(12, '2018_03_16_102441_create_users_table', 5),
(13, '2018_03_23_184921_create_permission_tables', 5);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `model_id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` int(10) UNSIGNED NOT NULL,
  `model_id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `service_requests`
--

CREATE TABLE `service_requests` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tokens`
--

CREATE TABLE `tokens` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `access_token` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `permission` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `update_new_file` int(11) NOT NULL,
  `real_token` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `refresh_token` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `last_activity` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user_permissions`
--

CREATE TABLE `user_permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `update_new_file` tinyint(1) NOT NULL,
  `permission` int(11) NOT NULL DEFAULT 0,
  `state` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `user_permissions`
--

INSERT INTO `user_permissions` (`id`, `username`, `update_new_file`, `permission`, `state`, `created_at`, `updated_at`) VALUES
(1, 'VIETJETALTAAPI', 1, 3, 1, '2019-03-12 05:12:39', '2019-03-12 05:12:39'),
(2, 'VJCO121', 0, 3, 1, '2019-03-12 05:12:39', '2019-03-12 05:12:39'),
(3, 'VJCO117', 0, 3, 1, '2019-03-12 05:12:39', '2019-03-12 05:12:39'),
(4, 'VJCO02', 0, 3, 1, '2019-03-12 05:12:39', '2019-03-12 05:12:39');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `booking_imports`
--
ALTER TABLE `booking_imports`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `booking_tasks`
--
ALTER TABLE `booking_tasks`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `fare_city_pairs`
--
ALTER TABLE `fare_city_pairs`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `fare_imports`
--
ALTER TABLE `fare_imports`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `fare_tasks`
--
ALTER TABLE `fare_tasks`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Chỉ mục cho bảng `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Chỉ mục cho bảng `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`),
  ADD KEY `password_resets_token_index` (`token`);

--
-- Chỉ mục cho bảng `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Chỉ mục cho bảng `service_requests`
--
ALTER TABLE `service_requests`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tokens`
--
ALTER TABLE `tokens`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Chỉ mục cho bảng `user_permissions`
--
ALTER TABLE `user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_permissions_username_unique` (`username`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `booking_imports`
--
ALTER TABLE `booking_imports`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `booking_tasks`
--
ALTER TABLE `booking_tasks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `fare_city_pairs`
--
ALTER TABLE `fare_city_pairs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `fare_imports`
--
ALTER TABLE `fare_imports`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `fare_tasks`
--
ALTER TABLE `fare_tasks`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `logs`
--
ALTER TABLE `logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT cho bảng `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `service_requests`
--
ALTER TABLE `service_requests`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tokens`
--
ALTER TABLE `tokens`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `user_permissions`
--
ALTER TABLE `user_permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
