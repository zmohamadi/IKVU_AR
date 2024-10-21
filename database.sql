-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 20, 2024 at 05:50 PM
-- Server version: 11.4.2-MariaDB-2
-- PHP Version: 8.2.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ikvulms`
--

-- --------------------------------------------------------

--
-- Table structure for table `assignments`
--

CREATE TABLE `assignments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL COMMENT 'عنوان',
  `course_id` int(11) NOT NULL DEFAULT 1 COMMENT 'کد درس',
  `group` varchar(255) NOT NULL DEFAULT '0' COMMENT 'گروه(سال و ترم و گروه)',
  `for_students` text DEFAULT NULL COMMENT 'آرایه جیسون از دانشجویان جهت اختصاص تکلیف',
  `to_students` int(1) NOT NULL DEFAULT 0 COMMENT 'نمایش(نمره،سوال،پاسخ ها)به دانشجویان در هرتکلیف مقدار 1 در غیر اینصورت مقدار 0',
  `session` int(2) DEFAULT NULL COMMENT 'شماره جلسه ای که تکلیف مختص آنست',
  `files` varchar(255) DEFAULT NULL COMMENT 'بارگزاری ها',
  `question_type_id` int(11) NOT NULL DEFAULT 1 COMMENT 'شناسه نوع سئوال',
  `correct_option_id` int(11) NOT NULL DEFAULT 1 COMMENT 'شناسه پاسخ صحیح',
  `start_date` varchar(255) DEFAULT NULL COMMENT 'تاریخ شروع',
  `expire_date` varchar(255) DEFAULT NULL COMMENT 'تاریخ پایان',
  `score` varchar(5) NOT NULL DEFAULT '0' COMMENT 'نمره',
  `creator_id` int(11) DEFAULT NULL COMMENT 'شناسه کاربر ثبت کننده',
  `editor_id` int(11) DEFAULT NULL COMMENT 'شناسه کاربر ویرایش کننده',
  `description` text DEFAULT NULL COMMENT 'توضیحات',
  `answer_count` int(11) NOT NULL DEFAULT 0 COMMENT 'تعداد پاسخ',
  `corrected_count` int(11) NOT NULL DEFAULT 0 COMMENT 'تعداد پاسخ صحیح',
  `avg` int(11) DEFAULT NULL COMMENT 'میانگین',
  `max` int(11) DEFAULT NULL COMMENT 'حداکثر',
  `min` int(11) DEFAULT NULL COMMENT 'حداقل',
  `order` int(11) DEFAULT NULL COMMENT 'ترتیب',
  `status_id` int(11) NOT NULL DEFAULT 1 COMMENT 'شناسه وضعیت فعال/غیر فعال',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

--
-- Dumping data for table `assignments`
--

INSERT INTO `assignments` (`id`, `title`, `course_id`, `group`, `for_students`, `to_students`, `session`, `files`, `question_type_id`, `correct_option_id`, `start_date`, `expire_date`, `score`, `creator_id`, `editor_id`, `description`, `answer_count`, `corrected_count`, `avg`, `max`, `min`, `order`, `status_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'تحقیق درس پندهای امام صادق', 11111, '1403101', '[{\"id\":147,\"fullname\":\"علی رشیدی\",\"studentID\":\"09338863567\"}]', 0, 1, NULL, 1, 1, '1403/07/21', '1403/07/22', '2', 18, 18, 'سلام علیکم\nلطفا تحقیق 4 صفحه ای طبق مهلت خواسته شده ارسال کنید', 0, 0, NULL, NULL, NULL, 1, 0, NULL, '2024-10-12 07:30:41', '2024-10-12 12:59:39'),
(2, 'تکلیف عمومی', 11111, '1403101', NULL, 0, 2, NULL, 1, 1, '1403/07/20', '1403/07/25', '2', 18, 1, 'لطفا پاسخ این تکلیف را سریعتر ارسال نمائید.', 1, 0, NULL, NULL, NULL, 1, 1, NULL, '2024-10-12 13:01:51', '2024-10-13 10:04:00');

-- --------------------------------------------------------

--
-- Table structure for table `assignment_answers`
--

CREATE TABLE `assignment_answers` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL COMMENT 'شناسه کاربر پاسخ دهنده',
  `assignment_id` int(11) DEFAULT NULL COMMENT 'شناسه تکلیف',
  `course_id` int(11) DEFAULT NULL COMMENT 'شناسه درس',
  `score` varchar(200) DEFAULT NULL COMMENT 'نمره',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

--
-- Dumping data for table `assignment_answers`
--

INSERT INTO `assignment_answers` (`id`, `user_id`, `assignment_id`, `course_id`, `score`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 71, 2, 11111, NULL, NULL, '2024-10-13 09:33:28', '2024-10-13 09:33:28');

-- --------------------------------------------------------

--
-- Table structure for table `assignment_answers_detail`
--

CREATE TABLE `assignment_answers_detail` (
  `id` int(10) UNSIGNED NOT NULL,
  `answer_id` int(11) DEFAULT NULL COMMENT 'شناسه پاسخ اصلی',
  `user_id` int(11) DEFAULT NULL COMMENT 'شناسه دانشجو | شناسه استاد',
  `answer_text` text DEFAULT NULL COMMENT 'پاسخ دانشجو | پیام استاد در پاسخ',
  `answer_option_id` int(11) DEFAULT NULL COMMENT 'شناسه گزینه انتخاب شده در پاسخ',
  `seeing` int(1) NOT NULL DEFAULT 0 COMMENT 'مشاهده پاسخ توسط گیرنده مقدار 1 درغیر این صورت مقدار 0',
  `files` varchar(255) DEFAULT NULL COMMENT 'بارگزاری ها',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

--
-- Dumping data for table `assignment_answers_detail`
--

INSERT INTO `assignment_answers_detail` (`id`, `answer_id`, `user_id`, `answer_text`, `answer_option_id`, `seeing`, `files`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 71, 'تست پاسخ - مفتاح', NULL, 1, 'image41181728799407.jpg###', NULL, '2024-10-13 09:33:28', '2024-10-19 10:17:14');

-- --------------------------------------------------------

--
-- Table structure for table `assignment_options`
--

CREATE TABLE `assignment_options` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL COMMENT 'عنوان',
  `assignment_id` int(11) DEFAULT NULL COMMENT 'شناسه تکلیف',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `base_counts`
--

CREATE TABLE `base_counts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `count` int(11) NOT NULL DEFAULT 0,
  `icon` int(11) DEFAULT NULL,
  `color` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `base_counts`
--

INSERT INTO `base_counts` (`id`, `title`, `count`, `icon`, `color`, `created_at`, `updated_at`) VALUES
(1, 'courses', 9, NULL, NULL, NULL, NULL),
(2, 'categories', 0, NULL, NULL, NULL, NULL),
(3, 'teachers', 8, NULL, NULL, NULL, NULL),
(4, 'students', 81, NULL, NULL, NULL, NULL),
(5, 'quizs', 0, NULL, NULL, NULL, NULL),
(6, 'online_classrooms', 73, NULL, NULL, NULL, NULL),
(7, 'surveys', 0, NULL, NULL, NULL, NULL),
(8, 'learnpaths', 80, NULL, NULL, NULL, NULL),
(9, 'assignments', 2, NULL, NULL, NULL, NULL),
(10, 'assistants', 1, NULL, NULL, NULL, NULL),
(11, 'perssonel', 17, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `base_file_categories`
--

CREATE TABLE `base_file_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(50) DEFAULT NULL COMMENT 'عنوان',
  `name` varchar(50) DEFAULT NULL COMMENT 'نام',
  `description` mediumtext DEFAULT NULL COMMENT 'توضیحات',
  `status_id` int(11) NOT NULL DEFAULT 1 COMMENT 'شناسه وضعیت فعال/غیر فعال',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_persian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `base_file_types`
--

CREATE TABLE `base_file_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(50) DEFAULT NULL COMMENT 'عنوان',
  `title_en` varchar(50) DEFAULT NULL COMMENT 'عنوان',
  `title_ar` varchar(50) DEFAULT NULL COMMENT 'عنوان',
  `description` mediumtext DEFAULT NULL COMMENT 'توضیحات',
  `status_id` int(11) NOT NULL DEFAULT 1 COMMENT 'شناسه وضعیت فعال/غیر فعال',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_persian_ci;

--
-- Dumping data for table `base_file_types`
--

INSERT INTO `base_file_types` (`id`, `title`, `title_en`, `title_ar`, `description`, `status_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'img', 'img', 'صورة', 'png,jpg,tif,gif,jpeg,WebP,AVIF', 1, NULL, '2024-04-14 02:37:06', '2024-04-14 02:37:06'),
(2, 'audio', 'audio', 'سمعي', 'wave,mp3', 1, NULL, '2024-04-14 02:37:06', '2024-04-14 02:37:06'),
(3, 'video', 'video', 'فيديو', 'mov,mp4,flv,avi,wmv', 1, NULL, '2024-04-14 02:37:06', '2024-04-14 02:37:06'),
(4, 'document', 'document', 'وثيقة', 'pdf,doc,docx,ppt', 1, NULL, '2024-04-14 02:37:06', '2024-04-14 02:37:06');

-- --------------------------------------------------------

--
-- Table structure for table `base_genders`
--

CREATE TABLE `base_genders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title_fa` varchar(100) DEFAULT NULL,
  `title_en` varchar(100) DEFAULT NULL,
  `status_id` int(11) NOT NULL DEFAULT 1 COMMENT 'شناسه وضعیت فعال/غیر فعال ',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

--
-- Dumping data for table `base_genders`
--

INSERT INTO `base_genders` (`id`, `title_fa`, `title_en`, `status_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'آقا', 'male', 1, '2024-07-06 15:52:35', '2024-07-06 15:52:35', NULL),
(2, 'خانم', 'femail', 1, '2024-07-06 15:52:35', '2024-07-06 15:52:35', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `base_keywords`
--

CREATE TABLE `base_keywords` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(50) DEFAULT NULL COMMENT 'عنوان',
  `order` int(11) DEFAULT NULL COMMENT 'ترتیب',
  `lang` varchar(255) NOT NULL DEFAULT 'en' COMMENT 'زبان',
  `status_id` int(11) NOT NULL DEFAULT 1 COMMENT 'شناسه وضعیت فعال/غیر فعال',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `base_languages`
--

CREATE TABLE `base_languages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(10) DEFAULT NULL COMMENT 'عنوان',
  `symbol` varchar(5) DEFAULT NULL COMMENT 'عنوان اختصاری',
  `dir` varchar(3) NOT NULL DEFAULT 'rtl' COMMENT 'چینش',
  `icon` varchar(50) DEFAULT NULL COMMENT 'آیکون',
  `status_id` int(11) NOT NULL DEFAULT 1 COMMENT 'شناسه وضعیت فعال/غیر فعال',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

--
-- Dumping data for table `base_languages`
--

INSERT INTO `base_languages` (`id`, `title`, `symbol`, `dir`, `icon`, `status_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'فارسی', 'fa', 'rtl', 'fa.png', 1, NULL, '2024-07-06 15:52:35', '2024-07-06 15:52:35'),
(2, 'English', 'en', 'ltr', 'en.png', 0, NULL, '2024-07-06 15:52:35', '2024-07-06 15:52:35'),
(3, 'عربی', 'ar', 'rtl', 'ar.png', 0, NULL, '2024-07-06 15:52:35', '2024-07-06 15:52:35');

-- --------------------------------------------------------

--
-- Table structure for table `base_question_types`
--

CREATE TABLE `base_question_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title_fa` varchar(255) NOT NULL,
  `title_en` varchar(255) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

--
-- Dumping data for table `base_question_types`
--

INSERT INTO `base_question_types` (`id`, `title_fa`, `title_en`, `status_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'تشریحی', 'Descriptive', 1, NULL, '2024-07-06 15:52:35', '2024-07-06 15:52:35'),
(2, 'چند گزینه ای', 'Multiple choice', 1, NULL, '2024-07-06 15:52:35', '2024-07-06 15:52:35');

-- --------------------------------------------------------

--
-- Table structure for table `base_statuses`
--

CREATE TABLE `base_statuses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title_fa` varchar(200) DEFAULT NULL COMMENT 'عنوان به زبان فارسی',
  `title_en` varchar(200) DEFAULT NULL COMMENT 'عنوان به زبان عربی',
  `group_id` int(11) DEFAULT NULL COMMENT 'شناسه گروه وضعیت',
  `code` varchar(3) DEFAULT NULL COMMENT 'کد وضعیت',
  `color` varchar(20) DEFAULT NULL COMMENT 'رنگ',
  `status_id` int(11) NOT NULL DEFAULT 1 COMMENT 'شناسه وضعیت فعال/غیر فعال',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

--
-- Dumping data for table `base_statuses`
--

INSERT INTO `base_statuses` (`id`, `title_fa`, `title_en`, `group_id`, `code`, `color`, `status_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'وضعیت فعالی', 'active status', NULL, NULL, NULL, 1, NULL, '2024-07-06 15:52:35', '2024-07-06 15:52:35'),
(2, 'فعال', 'active', 1, '1', 'theme-10', 1, NULL, '2024-07-06 15:52:35', '2024-07-06 15:52:35'),
(3, 'غیر فعال', 'inactive', 1, '0', 'theme-24', 1, NULL, '2024-07-06 15:52:35', '2024-07-06 15:52:35'),
(4, 'وضعیت پست پیامگاه', 'Message post status', NULL, NULL, NULL, 1, NULL, '2024-07-18 08:25:10', '2024-07-18 08:25:10'),
(5, 'نیاز به بررسی', 'Need to check', 4, '0', 'theme-23', 1, NULL, '2024-07-18 08:25:10', '2024-07-18 08:25:10'),
(6, 'عمومی', 'General', 4, '1', 'theme-17', 1, NULL, '2024-07-18 08:25:10', '2024-07-18 08:25:10'),
(7, 'خصوصی', 'private', 4, '2', 'theme-10', 1, NULL, '2024-07-18 08:25:10', '2024-07-18 08:25:10'),
(8, 'رد', 'rejection', 4, '3', 'theme-24', 1, NULL, '2024-07-18 08:25:10', '2024-07-18 08:25:10'),
(9, 'نوع عملکرد پست', 'Post function type', NULL, NULL, NULL, 1, NULL, '2024-07-18 08:25:10', '2024-07-18 08:25:10'),
(10, 'لایک', 'like', 9, '1', 'theme-24', 1, NULL, '2024-07-18 08:25:10', '2024-07-18 08:25:10'),
(11, 'لایک نکردن', 'Dislike', 9, '0', 'theme-10', 1, NULL, '2024-07-18 08:25:10', '2024-07-18 08:25:10');

-- --------------------------------------------------------

--
-- Table structure for table `base_systems`
--

CREATE TABLE `base_systems` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `api_key` varchar(255) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `domain` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `creator_id` int(11) DEFAULT NULL COMMENT 'شناسه کاربر ثبت کننده',
  `editor_id` int(11) DEFAULT NULL COMMENT 'شناسه کاربر ویرایش کننده',
  `description` text DEFAULT NULL,
  `status_id` int(11) NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

--
-- Dumping data for table `base_systems`
--

INSERT INTO `base_systems` (`id`, `title`, `api_key`, `ip`, `domain`, `photo`, `creator_id`, `editor_id`, `description`, `status_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'سامانه سدف', '127.0.0.1', '172.18.49.62', 'www.sadaf.ir', 'sadaf.png', 1, NULL, ' سيستم جامع خدمات آموزش دانشگاه ها و موسسات آموزش عالي كه درسال هزاروسيصدوهفتاد وچهار طراحي و با نام سيستم جامع آموزشي و تحصيلي نصر معروف شد، در چندين دانشگاه و موسسه آموزش عالي در اقصي نقاط كشور مورد استفاده قرار گرفت. اين سيستم در سال هشتا دودو توسط متخصصين اين شركت و با همكاري دانشگاه فردوسي مشهد و مجددا طراحي و با نام جديد سدف به صورت متن باز در اختيار جامعه دانشگاهي کشور قرار گرفت. کليه خدمات پشتيباني سيستم به اعتبار تفاهم نامه موجود بين مرکز کامپيوتر دانشگاه فردوسي مشهد و شرکت مهندسي داده پردازان معاصر به شرکت مهندسي داده.پردازان معاصر واگذار گرديده است . ', 1, NULL, '2024-07-06 15:52:35', '2024-07-06 15:52:35'),
(2, 'سامانه گلستان', '1234234567', '127.4.3.2', 'www.golestan.ir', 'golestan.png', 1, NULL, ' سيستم جامع آموزش گلستان، در دانشگاه صنعتي اصفهان و در راستاي اجراي مکانيزه کليه امور اجرايي آموزشي دانشگاه در کليه سطوح، طراحي و پياده سازي شده است. تجزيه و تحليل، طراحي، پياده سازي، تست و تحويل اين سيستم از اسفند ماه 1379 شروع و در تابستان 1382 به پايان رسيده است. در مدت 30 ماه کارشناسان مختلف با همکاري مديريت محترم دانشگاه صنعتي اصفهان در طرح مذکور فعاليت طاقت فرسايي را دنبال کرده‌اند. هم اکنون سيستم گلستان در کليه امور اجرايي آموزش دانشگاه مورد استفاده قرار مي گيرد. همچنین در سال‌های اخیر بخش پژوهش آن هم فعال شده و هم‌اکنون بیشتر فعالیت‌های پژوهشی اساتید از طریق آن صورت می‌گیرد. ', 1, '2024-09-15 10:17:21', '2024-07-06 15:52:35', '2024-09-15 10:17:21'),
(3, 'سامانه ویترین', '12666', '127.168.3.3', 'Vitrin.com', 'image11351725102373.png', 1, NULL, '<p>توضیحات بابت درست کردن موارد سامانه باید داده شود</p>', 1, '2024-08-31 14:50:09', '2024-08-31 14:36:44', '2024-08-31 14:50:09');

-- --------------------------------------------------------

--
-- Table structure for table `base_year_semesters`
--

CREATE TABLE `base_year_semesters` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `year` varchar(255) DEFAULT NULL,
  `semester` varchar(255) DEFAULT NULL,
  `start_date` varchar(255) DEFAULT NULL,
  `end_date` varchar(255) DEFAULT NULL,
  `creator_id` int(11) DEFAULT NULL COMMENT 'شناسه کاربر ثبت کننده',
  `editor_id` int(11) DEFAULT NULL COMMENT 'شناسه کاربر ویرایش کننده',
  `course_count` int(11) DEFAULT NULL,
  `status_id` int(11) NOT NULL DEFAULT 1 COMMENT 'شناسه وضعیت فعال/غیر فعال',
  `current` int(11) DEFAULT 0 COMMENT 'سال و ترم جاری برای کل سیستم',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

--
-- Dumping data for table `base_year_semesters`
--

INSERT INTO `base_year_semesters` (`id`, `year`, `semester`, `start_date`, `end_date`, `creator_id`, `editor_id`, `course_count`, `status_id`, `current`, `deleted_at`, `created_at`, `updated_at`) VALUES
(6, '1403', '1', '1403/07/01', '1403/10/30', 1, NULL, NULL, 1, 1, NULL, '2024-07-06 15:52:35', '2024-09-15 10:18:58');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `config`
--

CREATE TABLE `config` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `config_group_id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `configs`
--

CREATE TABLE `configs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `label` varchar(255) DEFAULT NULL COMMENT 'لیبل تنظیمات',
  `value` varchar(255) DEFAULT NULL COMMENT 'مقدار تنظیمات',
  `code` int(11) DEFAULT NULL COMMENT 'کد گروه تنظیمات',
  `status_id` int(11) NOT NULL DEFAULT 1 COMMENT 'شناسه وضعیت فعال/غیر فعال',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `config_group`
--

CREATE TABLE `config_group` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `id` int(11) NOT NULL,
  `code` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `count_presented` int(11) DEFAULT 0,
  `category_id` int(11) DEFAULT NULL,
  `system_id` int(11) NOT NULL DEFAULT 1,
  `thumbnail` varchar(255) DEFAULT NULL,
  `learnpath` int(11) NOT NULL DEFAULT 1,
  `online_classroom` int(11) NOT NULL DEFAULT 1,
  `online_archives` int(11) NOT NULL DEFAULT 1,
  `online_past_archives` int(11) NOT NULL DEFAULT 1,
  `quiz` int(11) NOT NULL DEFAULT 1,
  `assignments` int(11) NOT NULL DEFAULT 1,
  `forum` int(11) NOT NULL DEFAULT 1,
  `inbox` int(11) NOT NULL DEFAULT 0,
  `survey` int(11) NOT NULL DEFAULT 1,
  `less_id` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `editor_id` int(11) DEFAULT NULL COMMENT 'شناسه کاربر ویرایش کننده',
  `creator_id` int(11) DEFAULT NULL COMMENT 'شناسه کاربر ثبت کننده',
  `status_id` int(11) NOT NULL DEFAULT 1,
  `lang` varchar(2) NOT NULL DEFAULT 'fa',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`id`, `code`, `title`, `count_presented`, `category_id`, `system_id`, `thumbnail`, `learnpath`, `online_classroom`, `online_archives`, `online_past_archives`, `quiz`, `assignments`, `forum`, `inbox`, `survey`, `less_id`, `description`, `editor_id`, `creator_id`, `status_id`, `lang`, `deleted_at`, `created_at`, `updated_at`) VALUES
(9, '38309', 'روش تحقیق در قرآن (تفسیر موضوعی در قرآن)', 1, 9, 1, 'image9411727345251.png', 1, 1, 1, 1, 1, 1, 1, 1, 1, '38309', '<p>درباره روش تحقیق در قرآن و سنت</p>', 19, 18, 1, 'fa', NULL, '2024-09-16 09:38:09', '2024-09-26 13:37:33'),
(10, '38421', 'سیر تطور وجوه اعجاز قرآن', 1, 9, 1, 'image89251727345323.png', 1, 1, 1, 1, 1, 1, 1, 1, 1, '38421', '<p>درباره <span style=\"color:black;\">سیر تطور وجوه اعجاز قرآن</span></p>', 19, 18, 1, 'fa', NULL, '2024-09-16 09:43:52', '2024-09-26 13:38:45'),
(11, '38422', 'اعجاز ادبی', 1, 9, 1, 'image25871727345586.png', 1, 1, 1, 1, 1, 1, 1, 1, 1, '38422', '<p>درباره اعجاز ادبی</p>', 19, 18, 1, 'fa', NULL, '2024-09-16 09:53:32', '2024-09-26 13:43:08'),
(12, '38423', 'اعجاز علمی (1) علوم طبیعی', 1, 9, 1, 'image89861727345569.png', 1, 1, 1, 1, 1, 1, 1, 1, 1, '38423', '<p>در باره <span style=\"color:black;\">اعجاز علمی (1) علوم طبیعی</span></p>', 18, 18, 1, 'fa', NULL, '2024-09-16 09:56:33', '2024-09-29 12:45:50'),
(13, '31301', 'معرفت شناسی', 1, 9, 1, 'image5771727345371.png', 1, 1, 1, 1, 1, 1, 1, 1, 1, '31301', '<p>درباره <span style=\"color:black;\">معرفت شناسی</span></p>', 19, 18, 1, 'fa', NULL, '2024-09-16 10:08:00', '2024-09-26 13:39:34'),
(14, '31302', 'خداشناسی', 1, 9, 1, 'image98971727345344.png', 1, 1, 1, 1, 1, 1, 0, 1, 0, '31302', '<p>خداشناسی</p>', 19, 18, 1, 'fa', NULL, '2024-09-16 10:09:33', '2024-10-13 17:58:21'),
(15, '1233', 'تست', 0, 8, 1, 'image76401726647747.gif', 1, 1, 1, 1, 1, 1, 1, 1, 1, '1233', '<p>تست</p>', 1, 1, 1, 'fa', '2024-09-18 12:09:31', '2024-09-18 11:52:29', '2024-09-18 12:09:31'),
(16, '11111', 'پندهای امام صادق (ع)', 2, 8, 1, 'image39511727605713.jpg', 1, 1, 1, 1, 1, 1, 1, 1, 1, '11111', '<p>پندهای امام صادق (ع) در روایات … رشته فلسفه دین</p><p>پندهای امام صادق (ع) در سنت شفاهی …. رشته علوم قرآن</p><p>پندهای امام صادق (ع) &nbsp;در درس اخلاق علامه مصباح</p>', 71, 1, 1, 'fa', NULL, '2024-09-29 13:58:39', '2024-10-08 10:51:09'),
(17, '001', 'معرفة الله', 1, 8, 1, 'image70051729161071.jpg', 1, 1, 1, 1, 1, 1, 1, 0, 1, '001', '<p style=\"text-align:right;\">إنّ (معرفة الله) هي المحور الأساسي في المباحث الدينية والنصوص القرآنية، والسؤال الذي يطرح نفسه هنا هو: ما هي الطرق التي &nbsp;يُعرف الله بها، وكيف؟</p><p style=\"text-align:right;\">&nbsp;</p><p style=\"text-align:right;\">هذا الدرس یحتوی علی:&nbsp;</p><p style=\"text-align:right;\">أنواع المعرفة، وطرق معرفة الله.</p><p style=\"text-align:right;\">الاستدلال بالقرآن على إثبات معرفة الإنسان بالله.<br>مفاد آية الميثاق.<br>بيان أصل التوحيد.<br>مراتب التوحيد.<br>نصاب الاعتقاد بالتوحيد للمسلمين الموحِّدين.<br>الانسجام بين الاعتقاد بالربوبية التشريعية وحكومة الأنبياء والأولياء الإلهيين.<br>الفرق بين الشفاعة الاستقلالية والشفاعة بالإذن.<br>بعض الأدلة القرآنية على التوحيد بينها القرآن بالأسلوب المنطقي والطريقة القياسية.<br>معاني التوحيد الذاتي عند الفلاسفة، والمتكلّمين، والعرفاء.<br>معاني التوحيد الصفاتي عند الفلاسفة، والمتكلّمين، والعرفاء.<br>الفرق بين رأي الفلاسفة ورأي العرفاء في معنى التوحيد الأفعالي.<br>النظريات المختلفة حول أسماء الله وصفاته.<br>النظرية الصحيحة حول الأفعال الإلهية.<br>بيان أنّ الله هو علّة العِلل.<br>بيان كيفية ارتباط واستناد ظواهر العالم إلى العِلل والعوامل الطبيعية وإلى الله في نفس الوقت.<br>الجواب على بعض الاسئلة المهمّة حول أصل العلّية ونسبتها الى علم الله وقدرته.<br>رأي الأشاعرة والعدلية حول الحسن والقبح.</p><p style=\"text-align:right;\">الإجابة على السؤال القائل: هل يستطيع الله أن يفعل المحال أو القبيح؟<br>النظرية الصحيحة حول وجود الشرور في العالم.<br>الهدف من خلق العالم والإنسان.<br>حقيقة الفعل الإلهي.<br>خصائص العلم كصفة للذات الإلهية وللفعل الإلهي.<br>معاني الإذن التكويني والتشريعي والتفاوت بينهما.<br>معاني المشيئة والإرادة والتفاوت بينهما.<br>معنى التقدير وموارد استعماله في القرآن الكريم.<br>بيان كيفية تغير التقدير بواسطة الصدَقَة، وصلة الرحم، والدعاء و....<br>معاني القضاء بالنسبة للأفعال الإلهية.</p>', 71, 71, 1, 'fa', NULL, '2024-10-15 14:47:30', '2024-10-19 11:12:33'),
(18, '002', 'History of Infallible Imams', 1, 8, 1, 'image97851729325125.png', 1, 1, 1, 1, 1, 1, 1, 0, 1, '002', '<p style=\"text-align:justify;\"><strong>History of Infallible Imams</strong></p><p style=\"text-align:justify;\">&nbsp;</p>', 71, 71, 1, 'fa', NULL, '2024-10-16 08:24:58', '2024-10-19 11:35:26');

-- --------------------------------------------------------

--
-- Table structure for table `course_categories`
--

CREATE TABLE `course_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title_fa` varchar(255) DEFAULT NULL,
  `title_en` varchar(255) DEFAULT NULL,
  `pic` varchar(255) DEFAULT NULL,
  `creator_id` int(11) DEFAULT NULL COMMENT 'شناسه کاربر ثبت کننده',
  `editor_id` int(11) DEFAULT NULL COMMENT 'شناسه کاربر ویرایش کننده',
  `status_id` int(11) NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

--
-- Dumping data for table `course_categories`
--

INSERT INTO `course_categories` (`id`, `title_fa`, `title_en`, `pic`, `creator_id`, `editor_id`, `status_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(8, 'آزاد', NULL, NULL, NULL, NULL, 1, NULL, '2024-09-15 10:14:22', '2024-09-15 10:43:49'),
(9, 'رسمی', NULL, NULL, NULL, NULL, 1, NULL, '2024-09-15 10:23:07', '2024-09-15 10:43:37');

-- --------------------------------------------------------

--
-- Table structure for table `course_keyword`
--

CREATE TABLE `course_keyword` (
  `course_id` int(11) DEFAULT NULL,
  `keyword_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `course_presented`
--

CREATE TABLE `course_presented` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `group` varchar(255) DEFAULT '0',
  `teacher_person_id` int(11) DEFAULT NULL,
  `count_students` int(11) DEFAULT 0,
  `creator_id` int(11) DEFAULT NULL COMMENT 'شناسه کاربر ثبت کننده',
  `editor_id` int(11) DEFAULT NULL COMMENT 'شناسه کاربر ویرایش کننده',
  `status_id` int(11) DEFAULT NULL,
  `system_id` int(11) DEFAULT NULL,
  `less_id` varchar(255) DEFAULT NULL,
  `start_date` varchar(255) DEFAULT NULL,
  `end_date` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

--
-- Dumping data for table `course_presented`
--

INSERT INTO `course_presented` (`id`, `code`, `group`, `teacher_person_id`, `count_students`, `creator_id`, `editor_id`, `status_id`, `system_id`, `less_id`, `start_date`, `end_date`, `created_at`, `deleted_at`, `updated_at`) VALUES
(22, '11111', '1403102', 138, 0, 1, 1, NULL, 1, '11111', '1403/07/01', '1403/10/30', '2024-09-29 13:59:13', NULL, '2024-10-05 13:32:41'),
(12, '38423', '1403101', 24, 60, 18, 18, NULL, 1, '38423', '1403/07/01', '1403/10/30', '2024-09-16 11:13:22', NULL, '2024-10-16 08:20:09'),
(13, '38422', '1403101', 23, 60, 18, 18, NULL, 1, '38422', '1403/07/01', '1403/10/30', '2024-09-16 11:14:04', NULL, '2024-10-15 10:20:48'),
(14, '38421', '1403101', 22, 61, 18, 18, NULL, 1, '38421', '1403/07/01', '1403/10/30', '2024-09-16 11:14:33', NULL, '2024-10-15 10:22:26'),
(15, '38309', '1403101', 21, 65, 18, 18, NULL, 1, '38309', '1403/07/01', '1403/10/30', '2024-09-16 11:15:03', NULL, '2024-10-16 08:19:45'),
(18, '31302', '1403102', 28, 57, 18, 18, NULL, 1, '31302', '1403/07/01', '1403/10/30', '2024-09-16 14:03:06', NULL, '2024-10-16 08:19:22'),
(19, '31301', '1403102', 27, 58, 18, 18, NULL, 1, '31301', '1403/07/01', '1403/10/30', '2024-09-16 14:03:35', NULL, '2024-10-16 08:19:05'),
(24, '002', '0', 138, 3, 71, NULL, NULL, 1, '002', '1403/07/01', '1403/10/30', '2024-10-16 09:47:32', NULL, '2024-10-17 10:09:09'),
(23, '11111', '1403101', 138, 16, 18, 1, NULL, 1, '11111', '1403/07/01', '1403/10/30', '2024-10-01 13:11:40', NULL, '2024-10-15 10:59:37'),
(25, '001', '0', 138, 3, 71, NULL, NULL, 1, '001', '1403/07/01', '1403/10/30', '2024-10-16 09:49:24', NULL, '2024-10-17 12:21:38');

-- --------------------------------------------------------

--
-- Table structure for table `course_users`
--

CREATE TABLE `course_users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `group` varchar(255) DEFAULT '0',
  `course_presented` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `less_id` varchar(255) DEFAULT NULL,
  `main_code` varchar(255) DEFAULT NULL,
  `start_date` varchar(255) DEFAULT NULL,
  `end_date` varchar(255) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

--
-- Dumping data for table `course_users`
--

INSERT INTO `course_users` (`id`, `user_id`, `code`, `group`, `course_presented`, `role_id`, `title`, `less_id`, `main_code`, `start_date`, `end_date`, `status_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(303, 61, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 08:57:03', NULL, NULL),
(35, 24, '38423', '1403101', 12, 1, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, NULL, NULL, NULL),
(36, 23, '38422', '1403101', 13, 1, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, NULL, NULL, NULL),
(37, 22, '38421', '1403101', 14, 1, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, NULL, NULL, NULL),
(38, 21, '38309', '1403101', 15, 1, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, NULL, NULL, NULL),
(71, 98, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:11:26', NULL, NULL),
(43, 27, '31301', '1403102', 19, 1, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, NULL, NULL, NULL),
(44, 9, '31301', '1403102', 19, 3, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, NULL, NULL, NULL),
(47, 28, '31302', '1403102', 18, 1, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, NULL, NULL, NULL),
(302, 60, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 08:56:45', NULL, NULL),
(66, 30, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 05:47:06', NULL, NULL),
(50, 30, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, NULL, NULL, NULL),
(78, 103, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:17:17', NULL, NULL),
(301, 48, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:42:27', NULL, NULL),
(67, 30, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 05:47:55', NULL, NULL),
(245, 45, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:12:12', NULL, NULL),
(244, 40, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:11:59', NULL, NULL),
(77, 102, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:17:06', NULL, NULL),
(76, 100, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:14:44', NULL, NULL),
(75, 96, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:14:27', NULL, NULL),
(74, 95, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:14:10', NULL, NULL),
(73, 30, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:13:53', NULL, NULL),
(72, 99, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:11:42', NULL, NULL),
(79, 104, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:17:27', NULL, NULL),
(80, 105, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:17:38', NULL, NULL),
(81, 106, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:17:50', NULL, NULL),
(82, 107, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:18:03', NULL, NULL),
(83, 108, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:18:12', NULL, NULL),
(84, 110, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:19:20', NULL, NULL),
(85, 111, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:19:31', NULL, NULL),
(86, 112, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:19:44', NULL, NULL),
(87, 113, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:20:07', NULL, NULL),
(88, 114, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:20:18', NULL, NULL),
(89, 115, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:20:29', NULL, NULL),
(90, 116, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:20:41', NULL, NULL),
(91, 117, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:20:51', NULL, NULL),
(92, 118, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:21:01', NULL, NULL),
(93, 119, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:21:13', NULL, NULL),
(94, 131, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:21:24', NULL, NULL),
(95, 132, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:21:34', NULL, NULL),
(96, 120, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:21:46', NULL, NULL),
(97, 121, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:21:56', NULL, NULL),
(98, 122, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:22:06', NULL, NULL),
(99, 123, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:22:16', NULL, NULL),
(100, 124, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:22:26', NULL, NULL),
(101, 125, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:22:35', NULL, NULL),
(102, 126, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:22:45', NULL, NULL),
(103, 127, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:22:59', NULL, NULL),
(104, 128, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:23:09', NULL, NULL),
(105, 39, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:23:35', NULL, NULL),
(106, 40, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:23:45', NULL, NULL),
(107, 45, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:23:55', NULL, NULL),
(108, 54, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:24:06', NULL, NULL),
(109, 55, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:24:17', NULL, NULL),
(110, 58, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:24:26', NULL, NULL),
(111, 60, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:24:36', NULL, NULL),
(112, 61, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:24:45', NULL, NULL),
(113, 62, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:24:56', NULL, NULL),
(114, 63, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:25:09', NULL, NULL),
(115, 64, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:25:21', NULL, NULL),
(116, 65, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:25:30', NULL, NULL),
(117, 66, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:25:39', NULL, NULL),
(118, 67, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:25:48', NULL, NULL),
(119, 68, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:25:57', NULL, NULL),
(120, 69, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:26:08', NULL, NULL),
(121, 81, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:26:17', NULL, NULL),
(122, 82, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:26:26', NULL, NULL),
(123, 84, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:26:40', NULL, NULL),
(124, 85, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:26:49', NULL, NULL),
(125, 86, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:27:00', NULL, NULL),
(126, 88, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:27:10', NULL, NULL),
(127, 89, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:27:20', NULL, NULL),
(128, 90, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:27:30', NULL, NULL),
(129, 91, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:27:40', NULL, NULL),
(130, 93, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:27:50', NULL, NULL),
(131, 40, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:30:42', NULL, NULL),
(132, 45, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:31:25', NULL, NULL),
(133, 60, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:31:36', NULL, NULL),
(134, 61, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:31:45', NULL, NULL),
(135, 62, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:31:55', NULL, NULL),
(136, 63, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:32:04', NULL, NULL),
(137, 64, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:32:14', NULL, NULL),
(138, 65, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:32:23', NULL, NULL),
(139, 66, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:32:34', NULL, NULL),
(140, 67, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:32:44', NULL, NULL),
(141, 68, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:32:57', NULL, NULL),
(142, 81, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:33:07', NULL, NULL),
(143, 82, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:33:16', NULL, NULL),
(144, 84, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:33:25', NULL, NULL),
(145, 85, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:33:34', NULL, NULL),
(146, 86, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:33:43', NULL, NULL),
(147, 88, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:33:51', NULL, NULL),
(148, 89, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:34:01', NULL, NULL),
(149, 90, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:34:12', NULL, NULL),
(150, 91, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:34:22', NULL, NULL),
(151, 93, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:34:35', NULL, NULL),
(152, 30, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:34:50', NULL, NULL),
(153, 95, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:35:02', NULL, NULL),
(154, 96, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:35:16', NULL, NULL),
(155, 97, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:35:25', NULL, NULL),
(156, 98, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:35:36', NULL, NULL),
(157, 99, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:35:44', NULL, NULL),
(158, 100, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:35:53', NULL, NULL),
(159, 102, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:36:23', NULL, NULL),
(160, 103, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:36:33', NULL, NULL),
(161, 104, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:36:44', NULL, NULL),
(162, 105, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:36:57', NULL, NULL),
(163, 106, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:37:08', NULL, NULL),
(164, 107, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:37:16', NULL, NULL),
(165, 108, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:37:26', NULL, NULL),
(166, 110, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:37:38', NULL, NULL),
(167, 111, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:37:52', NULL, NULL),
(168, 112, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:38:02', NULL, NULL),
(169, 113, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:38:11', NULL, NULL),
(170, 114, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:38:20', NULL, NULL),
(171, 115, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:38:37', NULL, NULL),
(172, 116, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:38:46', NULL, NULL),
(173, 117, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:38:54', NULL, NULL),
(174, 118, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:39:02', NULL, NULL),
(175, 119, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:39:11', NULL, NULL),
(176, 131, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:39:21', NULL, NULL),
(177, 132, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:39:29', NULL, NULL),
(178, 120, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:39:38', NULL, NULL),
(179, 121, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:39:47', NULL, NULL),
(180, 122, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:39:55', NULL, NULL),
(181, 123, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:40:04', NULL, NULL),
(182, 124, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:40:12', NULL, NULL),
(183, 125, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:40:20', NULL, NULL),
(184, 126, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:40:30', NULL, NULL),
(185, 127, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:40:38', NULL, NULL),
(186, 128, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:40:46', NULL, NULL),
(187, 40, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:48:43', NULL, NULL),
(188, 45, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:48:56', NULL, NULL),
(189, 55, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:49:05', NULL, NULL),
(190, 60, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:49:13', NULL, NULL),
(191, 61, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:49:22', NULL, NULL),
(192, 62, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:49:31', NULL, NULL),
(193, 63, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:49:39', NULL, NULL),
(194, 64, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:49:49', NULL, NULL),
(195, 65, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:50:31', NULL, NULL),
(196, 66, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:50:40', NULL, NULL),
(197, 67, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 06:50:52', NULL, NULL),
(198, 68, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:01:54', NULL, NULL),
(199, 69, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:02:03', NULL, NULL),
(200, 81, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:02:10', NULL, NULL),
(201, 82, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:02:18', NULL, NULL),
(202, 84, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:02:27', NULL, NULL),
(203, 85, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:02:34', NULL, NULL),
(204, 86, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:02:43', NULL, NULL),
(205, 89, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:02:50', NULL, NULL),
(206, 90, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:02:58', NULL, NULL),
(207, 91, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:03:08', NULL, NULL),
(208, 93, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:03:16', NULL, NULL),
(209, 18, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:03:24', NULL, NULL),
(210, 95, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:03:35', NULL, NULL),
(211, 96, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:03:44', NULL, NULL),
(212, 97, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:03:53', NULL, NULL),
(213, 98, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:04:02', NULL, NULL),
(214, 99, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:04:12', NULL, NULL),
(215, 100, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:04:23', NULL, NULL),
(216, 102, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:04:42', NULL, NULL),
(217, 103, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:04:51', NULL, NULL),
(218, 104, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:04:59', NULL, NULL),
(219, 105, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:05:07', NULL, NULL),
(220, 106, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:05:16', NULL, NULL),
(221, 107, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:05:25', NULL, NULL),
(222, 108, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:05:35', NULL, NULL),
(223, 110, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:05:45', NULL, NULL),
(224, 111, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:05:54', NULL, NULL),
(225, 112, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:06:01', NULL, NULL),
(226, 113, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:06:09', NULL, NULL),
(227, 114, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:06:18', NULL, NULL),
(228, 115, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:06:30', NULL, NULL),
(229, 116, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:06:38', NULL, NULL),
(230, 117, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:06:47', NULL, NULL),
(231, 118, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:07:04', NULL, NULL),
(232, 119, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:07:14', NULL, NULL),
(233, 131, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:07:22', NULL, NULL),
(234, 132, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:07:32', NULL, NULL),
(235, 120, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:07:42', NULL, NULL),
(236, 121, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:07:53', NULL, NULL),
(237, 122, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:08:02', NULL, NULL),
(238, 123, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:08:11', NULL, NULL),
(239, 124, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:08:19', NULL, NULL),
(240, 125, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:08:27', NULL, NULL),
(241, 126, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:08:35', NULL, NULL),
(242, 127, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:08:43', NULL, NULL),
(243, 128, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:08:52', NULL, NULL),
(246, 52, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:12:21', NULL, NULL),
(247, 58, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:12:29', NULL, NULL),
(248, 60, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:12:39', NULL, NULL),
(249, 61, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:12:48', NULL, NULL),
(250, 62, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:12:56', NULL, NULL),
(251, 63, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:13:05', NULL, NULL),
(252, 64, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:13:14', NULL, NULL),
(253, 65, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:13:24', NULL, NULL),
(254, 66, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:13:50', NULL, NULL),
(255, 67, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:15:52', NULL, NULL),
(256, 68, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:16:00', NULL, NULL),
(257, 81, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:16:07', NULL, NULL),
(258, 82, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:16:16', NULL, NULL),
(259, 84, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:16:24', NULL, NULL),
(260, 85, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:16:32', NULL, NULL),
(261, 86, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:17:00', NULL, NULL),
(262, 89, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:17:10', NULL, NULL),
(263, 90, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:17:20', NULL, NULL),
(264, 91, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:17:38', NULL, NULL),
(265, 93, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:17:45', NULL, NULL),
(266, 18, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:17:55', NULL, NULL),
(267, 95, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:18:05', NULL, NULL),
(268, 96, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:18:17', NULL, NULL),
(269, 97, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:18:26', NULL, NULL),
(270, 98, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:18:34', NULL, NULL),
(271, 99, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:18:42', NULL, NULL),
(272, 100, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:18:51', NULL, NULL),
(273, 102, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:19:11', NULL, NULL),
(274, 103, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:19:19', NULL, NULL),
(275, 104, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:19:27', NULL, NULL),
(276, 105, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:19:35', NULL, NULL),
(277, 106, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:19:43', NULL, NULL),
(278, 107, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:19:54', NULL, NULL),
(279, 108, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:20:02', NULL, NULL),
(280, 110, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:20:19', NULL, NULL),
(281, 111, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:20:27', NULL, NULL),
(282, 112, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:20:37', NULL, NULL),
(283, 113, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:20:45', NULL, NULL),
(284, 114, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:20:54', NULL, NULL),
(285, 115, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:21:02', NULL, NULL),
(286, 116, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:21:11', NULL, NULL),
(287, 117, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:21:20', NULL, NULL),
(288, 118, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:21:30', NULL, NULL),
(289, 119, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:21:38', NULL, NULL),
(290, 131, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:21:47', NULL, NULL),
(291, 132, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:21:55', NULL, NULL),
(292, 120, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:22:11', NULL, NULL),
(293, 121, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:22:21', NULL, NULL),
(294, 122, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:22:33', NULL, NULL),
(295, 123, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:22:42', NULL, NULL),
(296, 124, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:22:50', NULL, NULL),
(297, 125, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:23:05', NULL, NULL),
(298, 126, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:23:14', NULL, NULL),
(299, 127, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:23:22', NULL, NULL),
(300, 128, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 07:23:32', NULL, NULL),
(304, 62, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 08:57:14', NULL, NULL),
(305, 63, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 08:57:21', NULL, NULL),
(306, 64, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 08:57:31', NULL, NULL),
(307, 65, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 08:57:41', NULL, NULL),
(308, 66, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 08:57:49', NULL, NULL),
(309, 67, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 08:57:57', NULL, NULL),
(310, 81, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 08:58:06', NULL, NULL),
(311, 82, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 08:58:18', NULL, NULL),
(312, 84, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 08:58:29', NULL, NULL),
(313, 85, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 08:58:41', NULL, NULL),
(314, 88, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:01:02', NULL, NULL),
(315, 90, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:01:13', NULL, NULL),
(316, 93, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:01:26', NULL, NULL),
(317, 18, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:01:36', NULL, NULL),
(318, 95, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:01:45', NULL, NULL),
(319, 96, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:01:56', NULL, NULL),
(320, 97, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:02:06', NULL, NULL),
(321, 98, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:02:15', NULL, NULL),
(322, 99, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:02:28', NULL, NULL),
(323, 100, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:02:37', NULL, NULL),
(324, 101, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:03:41', NULL, NULL),
(325, 102, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:05:39', NULL, NULL),
(326, 103, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:06:12', NULL, NULL),
(327, 104, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:06:23', NULL, NULL),
(328, 105, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:06:32', NULL, NULL),
(329, 106, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:06:40', NULL, NULL),
(330, 107, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:07:25', NULL, NULL),
(331, 108, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:07:33', NULL, NULL),
(332, 109, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:08:01', NULL, NULL),
(333, 110, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:08:16', NULL, NULL),
(334, 111, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:08:24', NULL, NULL),
(335, 112, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:08:34', NULL, NULL),
(336, 113, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:08:49', NULL, NULL),
(337, 114, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:08:59', NULL, NULL),
(338, 115, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:09:11', NULL, NULL),
(339, 116, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:09:19', NULL, NULL),
(340, 117, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:09:33', NULL, NULL),
(341, 118, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:09:42', NULL, NULL),
(342, 119, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:09:52', NULL, NULL),
(343, 131, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:10:04', NULL, NULL),
(344, 132, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:10:16', NULL, NULL),
(345, 120, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:11:16', NULL, NULL),
(346, 121, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:11:25', NULL, NULL),
(347, 122, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:11:33', NULL, NULL),
(348, 123, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:11:42', NULL, NULL),
(349, 124, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:11:53', NULL, NULL),
(350, 125, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:12:01', NULL, NULL),
(351, 126, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:12:09', NULL, NULL),
(352, 127, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:12:18', NULL, NULL),
(353, 128, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:12:25', NULL, NULL),
(354, 93, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:21:27', NULL, NULL),
(355, 90, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:21:38', NULL, NULL),
(356, 88, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:21:51', NULL, NULL),
(357, 95, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:22:32', NULL, NULL),
(358, 96, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:22:49', NULL, NULL),
(359, 97, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:22:58', NULL, NULL),
(360, 98, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:23:07', NULL, NULL),
(361, 99, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:23:17', NULL, NULL),
(362, 100, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:23:24', NULL, NULL),
(363, 101, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:23:41', NULL, NULL),
(364, 109, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:23:48', NULL, NULL),
(365, 102, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:24:05', NULL, NULL),
(366, 103, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:24:16', NULL, NULL),
(367, 104, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:24:26', NULL, NULL),
(368, 105, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:24:52', NULL, NULL),
(369, 106, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:25:00', NULL, NULL),
(370, 107, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:25:10', NULL, NULL),
(371, 108, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:25:18', NULL, NULL),
(372, 110, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:25:29', NULL, NULL),
(373, 111, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:25:53', NULL, NULL),
(374, 112, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:26:02', NULL, NULL),
(375, 113, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:26:09', NULL, NULL),
(376, 114, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:26:18', NULL, NULL),
(377, 115, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:26:26', NULL, NULL),
(378, 116, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:26:35', NULL, NULL),
(379, 117, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:26:54', NULL, NULL),
(380, 118, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:27:00', NULL, NULL),
(381, 119, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:27:11', NULL, NULL),
(382, 131, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:27:19', NULL, NULL),
(383, 132, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:27:28', NULL, NULL),
(384, 120, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:27:53', NULL, NULL),
(385, 121, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:28:01', NULL, NULL),
(386, 122, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:28:09', NULL, NULL),
(387, 123, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:28:17', NULL, NULL),
(388, 124, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:28:24', NULL, NULL),
(389, 125, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:28:40', NULL, NULL),
(390, 126, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:28:47', NULL, NULL),
(391, 127, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:28:56', NULL, NULL),
(392, 128, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:29:04', NULL, NULL),
(393, 85, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:29:25', NULL, NULL),
(394, 48, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:29:36', NULL, NULL),
(395, 61, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:34:29', NULL, NULL),
(396, 62, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:34:42', NULL, NULL),
(397, 63, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:34:57', NULL, NULL),
(398, 64, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:35:07', NULL, NULL),
(399, 65, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:35:15', NULL, NULL),
(400, 66, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:35:25', NULL, NULL),
(401, 67, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:35:45', NULL, NULL),
(402, 81, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:35:54', NULL, NULL),
(403, 82, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:36:01', NULL, NULL),
(404, 84, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:36:09', NULL, NULL),
(405, 101, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:38:20', NULL, NULL),
(406, 109, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:38:29', NULL, NULL),
(407, 101, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:39:19', NULL, NULL),
(408, 101, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:39:55', NULL, NULL),
(409, 109, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:40:03', NULL, NULL),
(410, 101, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:40:55', NULL, NULL),
(411, 109, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-24 09:41:02', NULL, NULL),
(412, 135, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-09-26 16:33:23', NULL, NULL),
(431, 75, '11111', '1403101', 23, 2, NULL, '11111', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-05 10:11:15', NULL, NULL),
(430, 76, '11111', '1403101', 23, 2, NULL, '11111', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-05 10:11:07', NULL, NULL),
(427, 89, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-02 04:12:47', NULL, NULL),
(426, 89, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-02 04:12:29', NULL, NULL),
(425, 91, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-01 09:45:32', NULL, NULL),
(424, 91, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-01 09:44:36', NULL, NULL),
(428, 138, '11111', '1403101', 23, 1, NULL, '11111', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-05 10:02:31', NULL, NULL),
(429, 138, '11111', '1403101', 22, 1, NULL, '11111', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-05 10:02:31', NULL, NULL),
(421, 97, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-01 04:48:49', NULL, NULL),
(432, 71, '11111', '1403101', 23, 2, NULL, '11111', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-05 10:11:27', NULL, NULL),
(433, 136, '11111', '1403101', 23, 2, NULL, '11111', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-05 10:11:42', NULL, NULL),
(434, 19, '11111', '1403101', 23, 2, NULL, '11111', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-05 10:11:59', NULL, NULL),
(435, 109, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-07 09:00:59', NULL, NULL),
(436, 1, '11111', '1403101', 23, 2, NULL, '11111', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-09 03:13:38', NULL, NULL),
(437, 147, '11111', '1403101', 23, 2, NULL, '11111', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-12 03:51:15', NULL, NULL),
(438, 87, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-15 06:49:17', NULL, NULL),
(439, 87, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-15 06:50:02', NULL, NULL),
(440, 87, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-15 06:50:25', NULL, NULL),
(441, 87, '38422', '1403101', 13, 2, NULL, '38422', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-15 06:50:48', NULL, NULL),
(442, 87, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-15 06:51:16', NULL, NULL),
(443, 87, '38421', '1403101', 14, 2, NULL, '38421', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-15 06:52:26', NULL, NULL),
(444, 137, '11111', '1403101', 23, 2, NULL, '11111', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-15 07:26:01', NULL, NULL),
(445, 145, '11111', '1403101', 23, 2, NULL, '11111', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-15 07:26:10', NULL, NULL),
(446, 144, '11111', '1403101', 23, 2, NULL, '11111', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-15 07:28:39', NULL, NULL),
(447, 143, '11111', '1403101', 23, 2, NULL, '11111', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-15 07:28:51', NULL, NULL),
(448, 139, '11111', '1403101', 23, 2, NULL, '11111', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-15 07:29:03', NULL, NULL),
(449, 141, '11111', '1403101', 23, 2, NULL, '11111', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-15 07:29:11', NULL, NULL),
(450, 140, '11111', '1403101', 23, 2, NULL, '11111', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-15 07:29:19', NULL, NULL),
(451, 78, '11111', '1403101', 23, 2, NULL, '11111', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-15 07:29:28', NULL, NULL),
(452, 29, '11111', '1403101', 23, 2, NULL, '11111', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-15 07:29:37', NULL, NULL),
(453, 70, '31301', '1403102', 19, 2, NULL, '31301', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-16 04:49:05', NULL, NULL),
(454, 70, '31302', '1403102', 18, 2, NULL, '31302', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-16 04:49:22', NULL, NULL),
(455, 70, '38309', '1403101', 15, 2, NULL, '38309', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-16 04:49:45', NULL, NULL),
(456, 70, '38423', '1403101', 12, 2, NULL, '38423', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-16 04:50:09', NULL, NULL),
(457, 138, '002', '0', 24, 1, NULL, '002', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-16 06:17:32', NULL, NULL),
(458, 147, '002', '0', 24, 2, NULL, '002', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-16 06:18:33', NULL, NULL),
(459, 71, '002', '0', 24, 2, NULL, '002', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-16 06:18:48', NULL, NULL),
(460, 138, '001', '0', 25, 1, NULL, '001', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-16 06:19:24', NULL, NULL),
(461, 147, '001', '0', 25, 2, NULL, '001', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-16 06:19:41', NULL, NULL),
(462, 71, '001', '0', 25, 2, NULL, '001', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-16 06:24:41', NULL, NULL),
(463, 148, '001', '0', 25, 2, NULL, '001', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-17 06:38:48', NULL, NULL),
(464, 148, '002', '0', 24, 2, NULL, '002', NULL, '1403/07/01', '1403/10/30', NULL, '2024-10-17 06:39:09', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `forums`
--

CREATE TABLE `forums` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(200) DEFAULT NULL COMMENT 'عنوان',
  `course_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'کد درس',
  `group` varchar(255) DEFAULT '0' COMMENT 'گروه(سال و ترم و گروه)',
  `creator_id` int(11) DEFAULT NULL COMMENT 'شناسه کاربر ثبت کننده',
  `editor_id` int(11) DEFAULT NULL COMMENT 'شناسه کاربر ویرایش کننده',
  `last_post_id` int(11) DEFAULT NULL COMMENT 'شناسه آخرین گفتگوی ثبت شده',
  `last_post_general` varchar(200) DEFAULT NULL COMMENT 'شناسه آخرین گفتگوی ثبت شده ',
  `last_post_general_id` int(11) DEFAULT NULL COMMENT 'شناسه آخرین گفتگوی عمومی ثبت شده',
  `last_post` varchar(200) DEFAULT NULL COMMENT 'نام فرستنده و تاریخ ثبت آخرین گفتگو ',
  `description` text DEFAULT NULL COMMENT 'توضیح',
  `lock` int(11) NOT NULL DEFAULT 1 COMMENT 'پیام قفل است؟',
  `need_to_apply` int(11) NOT NULL DEFAULT 1 COMMENT 'پیام ها نیاز به تایید دارد؟',
  `count_post` int(11) NOT NULL DEFAULT 0 COMMENT 'تعداد پست',
  `count_post_not_check` int(11) NOT NULL DEFAULT 0 COMMENT 'تعداد پست بررسی نشده',
  `count_post_parent` int(11) NOT NULL DEFAULT 0 COMMENT 'تعداد پست والد(موضوعات)',
  `lang` varchar(2) NOT NULL DEFAULT 'fa' COMMENT 'زبان',
  `status_id` int(11) NOT NULL DEFAULT 1 COMMENT 'شناسه وضعیت فعال/غیر فعال',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

--
-- Dumping data for table `forums`
--

INSERT INTO `forums` (`id`, `title`, `course_id`, `group`, `creator_id`, `editor_id`, `last_post_id`, `last_post_general`, `last_post_general_id`, `last_post`, `description`, `lock`, `need_to_apply`, `count_post`, `count_post_not_check`, `count_post_parent`, `lang`, `status_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'پیامگاه سال تحصیلی 1404-1403', 38423, '1403101', 18, 18, NULL, NULL, NULL, NULL, 'درس اعجاز علمی', 0, 0, 0, 0, 0, 'fa', 0, NULL, '2024-10-09 14:01:34', '2024-10-09 14:02:33'),
(2, 'سال تحصیلی 1404-1403', 11111, '1403101', 18, 18, 11, 'علی رشیدپور&nbsp2024-10-19 14:48:37', 10, 'علی رشیدپور&nbsp2024-10-19 14:51:25', 'تست پیامگاه درس پندهای امام صادق', 0, 1, 11, 1, 2, 'fa', 1, NULL, '2024-10-12 07:18:53', '2024-10-19 14:51:25');

-- --------------------------------------------------------

--
-- Table structure for table `forum_attachments`
--

CREATE TABLE `forum_attachments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `post_id` int(11) DEFAULT NULL COMMENT 'شناسه پست تالار',
  `file_type_id` int(11) DEFAULT NULL COMMENT 'شناسه نوع فایل از جدول انواع فایل',
  `file_category_id` int(11) DEFAULT NULL COMMENT 'شناسه دسته بندی',
  `name` varchar(50) DEFAULT NULL COMMENT 'نام فایل و پسوند',
  `url` varchar(50) DEFAULT NULL COMMENT 'نام فایل',
  `extension` varchar(5) DEFAULT NULL COMMENT 'پسوند',
  `size` varchar(10) DEFAULT NULL COMMENT 'سایز',
  `width` varchar(5) DEFAULT NULL COMMENT 'عرض عکس',
  `height` varchar(5) DEFAULT NULL COMMENT 'ارتفاع عکس',
  `status_id` int(11) NOT NULL DEFAULT 1 COMMENT 'شناسه وضعیت فعال/غیر فعال',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

--
-- Dumping data for table `forum_attachments`
--

INSERT INTO `forum_attachments` (`id`, `post_id`, `file_type_id`, `file_category_id`, `name`, `url`, `extension`, `size`, `width`, `height`, `status_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 'image95701728705208.jpg', 'image95701728705208', 'jpg', '264 KB', '1380', '1883', 1, NULL, '2024-10-12 07:23:32', '2024-10-12 07:23:32'),
(2, 6, 1, 1, 'image87641728725853.jpg', 'image87641728725853', 'jpg', '42 KB', '1280', '720', 1, NULL, '2024-10-12 13:07:34', '2024-10-12 13:07:34'),
(3, 8, 1, 1, 'image3741728726047.jpg', 'image3741728726047', 'jpg', '51 KB', '1280', '720', 1, NULL, '2024-10-12 13:10:49', '2024-10-12 13:10:49'),
(4, 9, 1, 1, 'image61991728726075.jpg', 'image61991728726075', 'jpg', '51 KB', '1280', '720', 1, NULL, '2024-10-12 13:11:16', '2024-10-12 13:11:16'),
(5, 10, 1, 1, 'image84961729336716.gif', 'image84961729336716', 'gif', '395 KB', '150', '150', 1, NULL, '2024-10-19 14:48:37', '2024-10-19 14:48:37');

-- --------------------------------------------------------

--
-- Table structure for table `forum_likes`
--

CREATE TABLE `forum_likes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL COMMENT 'شناسه کاربر',
  `post_id` int(11) DEFAULT NULL COMMENT 'شناسه پیام تالار',
  `like_type_id` int(11) DEFAULT NULL COMMENT 'شناسه ثبت کننده',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

--
-- Dumping data for table `forum_likes`
--

INSERT INTO `forum_likes` (`id`, `user_id`, `post_id`, `like_type_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 18, 2, 1, NULL, '2024-10-12 13:04:21', '2024-10-12 13:04:21'),
(2, 18, 5, 1, NULL, '2024-10-12 13:04:27', '2024-10-12 13:04:27'),
(3, 71, 2, 0, NULL, '2024-10-12 13:06:29', '2024-10-12 13:06:29'),
(4, 147, 6, 0, NULL, '2024-10-12 13:09:36', '2024-10-12 13:09:36'),
(5, 147, 5, 1, NULL, '2024-10-12 13:09:39', '2024-10-12 13:09:39');

-- --------------------------------------------------------

--
-- Table structure for table `forum_posts`
--

CREATE TABLE `forum_posts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sender_id` int(11) DEFAULT NULL COMMENT 'شناسه ارسال کننده',
  `forum_id` int(11) DEFAULT NULL COMMENT 'شناسه تالار',
  `parent_id` int(11) NOT NULL DEFAULT 0 COMMENT 'شناسه پیام اصلی',
  `reply_to` int(11) DEFAULT 0 COMMENT 'پاسخ به پیام منظور',
  `last_post_id` int(11) DEFAULT NULL COMMENT 'شناسه آخرین گفتگوی ثبت شده برای موضوع یا والد',
  `last_post_general` varchar(200) DEFAULT NULL COMMENT 'ام فرستنده و تاریخ ثبت آخرین گفتگوی عمومی برای موضوع یا والد 	',
  `last_post_general_id` int(11) DEFAULT NULL COMMENT 'ام فرستنده و تاریخ ثبت آخرین گفتگوی عمومی برای موضوع یا والد 	',
  `last_post` varchar(200) DEFAULT NULL COMMENT 'نام فرستنده و تاریخ ثبت آخرین گفتگو برای موضوع یا والد',
  `title` text DEFAULT NULL COMMENT 'عنوان (موضوع)',
  `message` text DEFAULT NULL COMMENT 'متن پیام',
  `type_id` int(11) NOT NULL DEFAULT 0 COMMENT 'شناسه نوع پیام کابر(ثبت، عمومی،خصوصی،رد)',
  `count_view` int(11) NOT NULL DEFAULT 0 COMMENT 'تعداد بازدید',
  `count_like` int(11) NOT NULL DEFAULT 0 COMMENT 'تعداد لایک',
  `count_dislike` int(11) NOT NULL DEFAULT 0 COMMENT 'تعداد دیس لایک',
  `count_attachment` int(11) NOT NULL DEFAULT 0 COMMENT 'تعداد فایل',
  `lang` varchar(2) NOT NULL DEFAULT 'fa' COMMENT 'زبان',
  `status_id` int(11) NOT NULL DEFAULT 1 COMMENT 'شناسه وضعیت فعال/غیر فعال',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

--
-- Dumping data for table `forum_posts`
--

INSERT INTO `forum_posts` (`id`, `sender_id`, `forum_id`, `parent_id`, `reply_to`, `last_post_id`, `last_post_general`, `last_post_general_id`, `last_post`, `title`, `message`, `type_id`, `count_view`, `count_like`, `count_dislike`, `count_attachment`, `lang`, `status_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 18, 2, 0, 0, 11, 'علی رشیدپور&nbsp2024-10-19 14:48:37', 10, 'علی رشیدپور&nbsp2024-10-19 14:51:25', 'تست برای همکاران', 'سلام علیکم وقت شما بخیر \nان شاالله که همه سلامت و بدون دغدغه هفته خود را شروع کرده باشید', 1, 13, 0, 0, 1, 'fa', 1, NULL, '2024-10-12 07:23:32', '2024-10-19 14:51:25'),
(2, 18, 2, 1, 1, NULL, NULL, NULL, NULL, NULL, 'سلام وقت شما هم بخیر\nممنون از لطف شما', 1, 0, 1, 1, 0, 'fa', 1, NULL, '2024-10-12 07:24:08', '2024-10-12 07:24:08'),
(3, 147, 2, 0, 0, 4, 'حمید شاه محمدی&nbsp2024-10-12 07:26:23', 4, 'حمید شاه محمدی&nbsp2024-10-12 07:26:23', 'تست پیامگاه', 'سلام استاد وقت شما بخیر', 1, 2, 0, 0, 0, 'fa', 1, NULL, '2024-10-12 07:25:33', '2024-10-15 09:31:37'),
(4, 18, 2, 3, 3, NULL, NULL, NULL, NULL, NULL, 'سلام جناب رشیدی عزیز\nحال و احوال شما', 1, 0, 0, 0, 0, 'fa', 1, NULL, '2024-10-12 07:26:23', '2024-10-12 07:26:23'),
(5, 1, 2, 1, 0, NULL, NULL, NULL, NULL, NULL, 'سلام حمید بزرگوار', 1, 0, 2, 0, 0, 'fa', 1, NULL, '2024-10-12 13:03:55', '2024-10-12 13:06:51'),
(6, 71, 2, 1, 5, NULL, NULL, NULL, NULL, NULL, 'سلام. تست مفتاح', 1, 0, 0, 1, 1, 'fa', 1, NULL, '2024-10-12 13:07:34', '2024-10-12 13:07:34'),
(7, 147, 2, 1, 6, NULL, NULL, NULL, NULL, NULL, 'تست موفق بود از طرف دانشجو', 1, 0, 0, 0, 0, 'fa', 1, NULL, '2024-10-12 13:10:03', '2024-10-12 13:10:03'),
(8, 147, 2, 1, 1, NULL, NULL, NULL, NULL, NULL, 'پاسخ دانشجو  و ارسال فایل', 1, 0, 0, 0, 1, 'fa', 1, NULL, '2024-10-12 13:10:49', '2024-10-12 13:10:49'),
(9, 147, 2, 1, 7, NULL, NULL, NULL, NULL, NULL, 'تست ۲', 1, 0, 0, 0, 1, 'fa', 1, NULL, '2024-10-12 13:11:16', '2024-10-12 13:11:16'),
(10, 147, 2, 1, 0, NULL, NULL, NULL, NULL, NULL, 'پیام جهت بررسی ویرایش', 1, 0, 0, 0, 1, 'fa', 1, NULL, '2024-10-19 14:48:37', '2024-10-19 14:48:37'),
(11, 147, 2, 1, 9, NULL, NULL, NULL, NULL, NULL, 'تست تا قبل از تایید ویرایش', 0, 0, 0, 0, 0, 'fa', 1, NULL, '2024-10-19 14:51:25', '2024-10-19 14:52:34');

-- --------------------------------------------------------

--
-- Table structure for table `inbox`
--

CREATE TABLE `inbox` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `creator_id` int(11) DEFAULT NULL COMMENT 'شناسه کاربر ثبت کننده',
  `editor_id` int(11) DEFAULT NULL COMMENT 'شناسه کاربر ویرایش کننده',
  `text` text DEFAULT NULL,
  `sender` int(11) DEFAULT NULL,
  `receiver` int(11) DEFAULT NULL,
  `reply` text DEFAULT NULL,
  `group` varchar(255) DEFAULT '0',
  `course_id` int(11) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inbox_files`
--

CREATE TABLE `inbox_files` (
  `id` int(10) UNSIGNED NOT NULL,
  `inbox_id` int(11) DEFAULT NULL,
  `name` varchar(200) NOT NULL COMMENT 'نام فایل',
  `url` varchar(200) NOT NULL COMMENT 'مسیر فایل',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `learnpaths`
--

CREATE TABLE `learnpaths` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `duration` varchar(255) DEFAULT NULL,
  `description` text NOT NULL,
  `group` varchar(255) DEFAULT '0',
  `youtube` text DEFAULT NULL,
  `view_count` int(11) NOT NULL DEFAULT 0,
  `course_id` int(11) NOT NULL,
  `image_pdf` text DEFAULT NULL,
  `mobile_pdf` text DEFAULT NULL,
  `video` text DEFAULT NULL,
  `audio` text DEFAULT NULL,
  `status_id` int(11) NOT NULL DEFAULT 1,
  `order` int(11) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

--
-- Dumping data for table `learnpaths`
--

INSERT INTO `learnpaths` (`id`, `title`, `duration`, `description`, `group`, `youtube`, `view_count`, `course_id`, `image_pdf`, `mobile_pdf`, `video`, `audio`, `status_id`, `order`, `deleted_at`, `created_at`, `updated_at`) VALUES
(15, 'شناسنامه و فهرست مطالب کتاب', NULL, 'محتوای آموزشی : روش تفسیر موضوعی \nمؤلف : مصطفی کریمی\nمقطع تحصیلی: کارشناسی ارشد\nتعداد درس: 12', '0', NULL, 42, 38309, 'application88601728897013.pdf###', NULL, NULL, NULL, 1, 1, NULL, '2024-09-19 16:02:59', '2024-10-15 11:22:06'),
(16, 'درس اول: مفهوم‌شناسی', NULL, 'فهرست مطالب درس اول\nتفسير	13\nموضوعی	15\nتفسير موضوعی 	15\nتعريف موردنظر	15\nفرايند	17\nفرايند تفسير موضوعی	17\nبرخی مفاهيم همسو	18\n1. روش تفسير موضوعی	18\n2. قواعد تفسير موضوعی	19\n3. منابع تفسير موضوعی	20\n4. نظريه	20\nمراتب تفسير موضوعی	22\n1. مرتبهٔ استخراج نظريهٔ قرآن در يک مسئله يا موضوع	22\n2. مرتبهٔ سنجش نظریه‌ها در درون يک نظام	23\n3. کشف نظامی از نظام‌های قرآنی	23\n4. مرتبهٔ ارتباطسنجی بين نظام‌های قرآنی	23\n5. مرتبهٔ نظام‌سازی کلان	23', '0', NULL, 56, 38309, 'application55821728709392.pdf###', 'application11311729421532.pdf###', NULL, 'audio71071727847414.mp3###audio15231727847424.mp3###audio52741727847433.mp3###', 1, 2, NULL, '2024-09-19 16:03:42', '2024-10-20 14:22:26'),
(17, 'درس دوم: کارکردها و پيشينهٔ عملی تفسير موضوعی', NULL, 'فهرست مطالب درس دوم \nاهمیت و کارکردهای تفسير موضوعی	25\n1. بهره‌مندی کامل از قرآن با استخراج نظريههای آن	25\n2. بهتر نمايان‌تر شدن هماهنگی درونی قرآن	27\n3. زمینه‌سازی برای رفع ‌برخی اختلاف‌ها از میان مسلمانان	27\n4. نمايان شدن بُعدی از اعجاز بلاغی قرآن کريم	28', '0', NULL, 32, 38309, 'application25791728709436.pdf###', 'application80661729421592.pdf###', NULL, 'audio76701727847480.mp3###audio1401727847491.mp3###', 1, 3, NULL, '2024-09-19 16:07:07', '2024-10-20 14:32:34'),
(18, 'درس سوم: انتخاب مسئله و عنوانسازی', NULL, 'فهرست مطالب درس سوم\nراهکار‌ها	35\n1. راهکارهای انتخاب مسئله	35\n2. راهکار انتخاب عنوان	38\nآسيب‌ها	39\n1. انتخاب مسئله يا موضوع خارج از قلمرو قرآن	39\n2. انتخاب موضوع بسيار کلی	40', '0', NULL, 24, 38309, 'application69991728709479.pdf###', 'application86341729421608.pdf###', NULL, 'audio81971727847521.mp3###audio53971727847532.mp3###', 1, 4, NULL, '2024-09-19 16:07:42', '2024-10-20 14:33:34'),
(19, 'درس چهارم: مفهومشناسی مسئله', NULL, 'فهرست مطالب درس چهارم\nراهکار ايضاح مفهومی مسئله	44\n1. مشخص کردن گونهٔ مفهوم	44\n2. استفاده از گونه‌های تعريف	44\nآسيب اين مرحله	45', '0', NULL, 26, 38309, 'application21291728709586.pdf###', 'application37551729421659.pdf###', NULL, 'audio45501727847562.mp3###', 1, 5, NULL, '2024-09-19 16:08:07', '2024-10-20 14:34:16'),
(20, 'درس پنجم: تهيهٔ ساختار', NULL, 'فهرست مطالب درس پنجم\nراهکار تهيهٔ ساختار	48\n1. مشخص کردن گونهٔ تحقيق	48\n2. تهيهٔ ريزعناوين	49\n3. دسته‌بندی و مرتب‌سازی ريزعناوين	50\nآسيب اين مرحله:‌ نبود ملاک درست در دسته‌بندی عنوان‌ها	52', '0', NULL, 28, 38309, 'application37031728709615.pdf###', 'application28431729421696.pdf###', NULL, 'audio99811727847680.mp3###', 1, 6, NULL, '2024-09-19 16:08:43', '2024-10-20 14:31:20'),
(21, 'درس ششم: دستيابی به پيشينه و دستاوردهای بشری در مسئله', NULL, 'فهرست مطالب درس ششم \nراهکار دستيابی به پيشينه	56\n1. شناخت اقسام منابع	56\n2. جمع‌آوری منابع و راهکارهای آن	57\n3. اعتبارسنجی منابع	58\n4. استفادهٔ درست از منابع	59\n5. راهکارهای بررسی منابع در پيشينه	59\nشناخت دستاورد‌های بشری در مسئله	60\nآسيب‌های اين مرحله	60\n1. شتابزدگى و بسنده کردن به ‌آشنايی شناسنامه‌ای منابع	60\n2. دست نيافتن به آخرين نظريه	61', '0', NULL, 20, 38309, 'application4701728709843.pdf###', 'application21881729421717.pdf###', NULL, 'audio53671727847817.mp3###audio7281727847827.mp3###', 1, 7, NULL, '2024-09-19 16:09:17', '2024-10-20 14:30:32'),
(22, 'درس هفتم: استخراج آيات و دسته‌بندی آن‌ها', NULL, 'فهرست مطالب درس هفتم\nراهکار جست‌وجوی آيات با انواع دلالت‌ها	64\n1. آيات با انواع دلالت‌های منطوقی و مفهومی‌	64\n2. آيات بيانگر «هست» و «بايد»	69\n3. آيات متناظر	70\n4. آيات با دلالت استقلالی و پيوندی	79\n5. آيات با معنای ظاهری و معنای باطنی	81\nبهره‌گيری از همهٔ شيوه‌های جست‌وجوی آيات	82\n1. جست‌وجوی لفظی در آيات	82\n2. جست‌وجوی مفهومی در آيات	87\nاستفاده از ابزارها و منابع گوناگون	87\n1. معاجم لفظی	88\n2. معاجم موضوعی	88\n3. تفاسير موضوعی	89\n4. معاجم روايات تفسيری (تفسير روايی محض)	89\n5. مطالعهٔ دقيق کل قرآن کريم	90\nمعيارهای جداسازی آيات مربوط	90\n1. حفظ شدن پيوستگی ادبی میان فرازها	90\n2. حفظ شدن واقع‌نمايی قرآن	92\nدسته‌بندی آيات	93\nآسيب‌های اين مرحله	93\n1. مطالعه برای شناسايی و جمع‌آوری همزمان آيات برای چند مسئله	94\n2. بسنده کردن به يک ابزار و يک شيوه	94\n3. سهلگيری يا سخت‌گيری بی‌مورد	94\n4. جدا کردن فراز‌های غير مستقل	95\n5. بسنده كردن به يک مورد از آياتِ همانند	95\n6. تحمیل ساختار بر قرآن	96', '0', NULL, 24, 38309, 'application64881728709932.pdf###', 'application74011729421736.pdf###', NULL, 'audio47361727847898.mp3###audio75501727847923.mp3###', 1, 8, NULL, '2024-09-19 16:10:04', '2024-10-20 14:30:17'),
(23, 'درس هشتم: ارائهٔ فرضيه', NULL, 'فهرست مطالب درس هشتم\nضرورت فرضيه در تفسير موضوعی	99\nراهکار‌های فرضيه‌سازی	100\nآسيب‌ها	101\n1. ارائهٔ فرضيه بدون پشتوانهٔ علمی‌	101\n2. تحمیل فرضيه بر قرآن	101', '0', NULL, 22, 38309, 'application45881728710010.pdf###', 'application1741729421775.pdf###', NULL, 'audio32231727847975.mp3###audio10861727847982.mp3###', 1, 9, NULL, '2024-09-19 16:10:36', '2024-10-20 14:29:59'),
(24, 'درس نهم: فهم آيات در جايگاه خود', NULL, 'فهرست مطالب درس نهم\nگام اول: کسب اطمینان از الهی بودن متن آيه و قرائت آن	106\nراهکارهای به‌ دست آوردن قرائت واقعی	109\nگام دوم: شناخت معانی واژگان	110\nراهکارها	110\nآسيب‌های‌ اين گام	116\nگام سوم: به‌ دست آوردن موقعيت ادبی واژگان و عبارت‌ها در آيات	117\nراهکار‌ها	117\nآسيب اين گام	118\nگام چهارم: کشف مفاد استعمالی آيات	119\nراهکارها	120\nآسيب‌ اين گام	126\nگام پنجم: به ‌دست آوردن مراد جدی الهی از آيات	127\nراهکارها	127\nآسيب اين گام	131\nآسيب‌های عمومی اين مرحله	134', '0', NULL, 18, 38309, 'application97461728710038.pdf###', 'application49651729421853.pdf###', NULL, 'audio39411727848059.mp3###audio53421727848068.mp3###', 1, 10, NULL, '2024-09-19 16:11:38', '2024-10-20 14:29:49'),
(25, 'درس دهم: مشخص كردن حد دلالت آيات بر مسئله', NULL, 'فهرست مطالب درس دهم\n1. راهکار مشخص کردن حد دلالت آيات	140\n1 _ 1. بررسی اصل دلالت آيات بر مسئله	140\n2 _ 1. بررسی درجهٔ دلالت آيات	140\n2. راهکارهای مرتبسازی آيات	141\n1 _ 2. تقدم و تأخر منطقی	141\n2 _ 2. قوت در دلالت	141\n3 _ 2. تقدم زمان نزول	142\nآسيب	151\nتشخيص ندادن وجوه معنايی واژگان	151', '0', NULL, 20, 38309, 'application66711728710172.pdf###', 'application19151729421872.pdf###', NULL, 'audio17151727848117.mp3###audio22081727848167.mp3###', 1, 11, NULL, '2024-09-19 16:18:07', '2024-10-20 14:29:20'),
(26, 'درس یازدهم: استخراج نظريه', NULL, 'فهرست مطالب درس یازدهم\nراهکارها	153\n1. به‌ دست آوردن مفهوم مجموعی آيات	154\n2. استفاده از سکوت قرآن کريم	173\nآسيب‌ها	173\n1. التزام نداشتن به قرآن كريم	174\n2. غفلت از بخشی از آیات قرآن	174\n3. عدم بهر‌هبری درست از دستاورد بشری	176', '0', NULL, 18, 38309, 'application95841728710220.pdf###', 'application50411729421892.pdf###', NULL, 'audio93071727848246.mp3###', 1, 12, NULL, '2024-09-19 16:18:53', '2024-10-20 14:29:06'),
(27, 'درس دوازدهم: ارزيابی نظريه', NULL, 'فهرست مطالب درس دوازدهم\nارزيابی درونی نظريه	179\nارزيابی بيرونی نظريه	180\n1. ارزيابی از جهت مخالفت نکردن با مسلمات قرآن و روايات	180\n2. ارزيابی نظريهٔ قرآنی با قطعيات دانش بشری	180\n3. ارزيابی با واقعيت خارجی	181', '0', NULL, 28, 38309, 'application39251728710242.pdf###', 'application29711729421916.pdf###', NULL, 'audio18891727848330.mp3###', 1, 13, NULL, '2024-09-19 16:19:33', '2024-10-20 14:34:28'),
(28, 'شناسنامه و فهرست مطالب کتاب', NULL, 'محتوای آموزشی :اعجاز ادبی قرآن کریم\nگردآوری و تنظیم: محمد نقیب‌زاده\nمقطع تحصیلی: کارشناسی ارشد\nتعداد درس: 12', '0', NULL, 40, 38422, 'application51571728896890.pdf###', NULL, NULL, NULL, 1, 1, NULL, '2024-09-19 16:25:19', '2024-10-20 14:53:59'),
(29, 'درس اول: اعجاز قرٱن', NULL, 'فهرست مطالب درس اول\nمفهوم‌شناسی اعجاز قرآن	9\nچیستی اعجاز قرآن	9\nپیشینهٔ پژوهش	14', '0', NULL, 48, 38422, 'application57841728707214.pdf###', 'application38521727941877.pdf###', NULL, 'audio61161727781318.mp3###', 1, 2, NULL, '2024-09-19 16:26:05', '2024-10-19 14:16:38'),
(30, 'درس دوم: قرآن و علوم ادبی', NULL, 'فهرست مطالب درس  دوم\nقرآن سرچشمهٔ علوم ادبی	21\nنفش‌آفرینی قرآن در ادبیات عرب و مهجوریت آن در میان ادیبان	21\nپیرایش فرهنگ و ادبیات عرب	22\nحفظ، توسعه و انتشار ادبیات عرب	24\nنقش‌آفرینی قرآن در علوم ادبی	25\nوارد کردن مفاهیم جدید لغوی	32\nصدور لغت عرب به دیگر فرهنگ‌ها	33', '0', NULL, 34, 38422, 'application95701728707346.pdf###', 'application68801727941892.pdf###', NULL, 'audio20011727781339.mp3###audio2681727781350.mp3###audio36081727781359.mp3###', 1, 3, NULL, '2024-09-19 16:27:06', '2024-10-20 14:07:43'),
(31, 'درس سوم: معانی بیان و تمثیلات', NULL, 'فهرست مطالب درس سوم\nنحو	35\nزمینه‌سازی برای تدوین	35\nارائهٔ تراکیب کلامی متنوع در حد اعجاز	36\nتسهیل آموزش قواعد نحو به سبب قداست و زیبایی آیات قرآن	36\nعلوم بلاغی	37', '0', NULL, 14, 38422, 'application21701728707385.pdf###', 'application67721727941910.pdf###', NULL, 'audio85401727781434.mp3###', 1, 4, NULL, '2024-09-19 16:28:47', '2024-10-15 09:26:14'),
(32, 'درس چهارم: اعجاز بلاغی قرآن', NULL, 'فهرست مطالب درس چهارم\nفصاحت و بلاغت، مهم‌ترین وجه اعجاز	45\nجایگاه و اهمیت وجه فصاحت و بلاغت	45\nتعریف فصاحت و بلاغت	46\nگزینش الفاظ	47\nشرایط فصاحت و بلاغت تام و کامل در کلام	49', '0', NULL, 20, 38422, 'application44001728707489.pdf###', 'application4041727941924.pdf###', NULL, 'audio97461727867666.mp3###', 1, 5, NULL, '2024-09-19 16:29:20', '2024-10-20 14:34:53'),
(33, 'درس ششم: اعجاز بیانی قرآن (2)', NULL, 'فهرست مطالب درس ششم\nنکته‌رسانی و نکته‌پردازی در گزینش واژه‌ها	59\nنکته‌رسانی در گزینش جمع و مفرد	61\nفراگیری واژه‌ها	63\nهماهنگی لفظ و معنی	66', '0', NULL, 18, 38422, 'application29401728707548.pdf###', 'application88861729422375.pdf###', NULL, 'audio77681727867724.mp3###', 1, 7, NULL, '2024-09-19 16:30:11', '2024-10-20 14:36:28'),
(34, 'درس هفتم: حالات مختلف واژگان (1)', NULL, 'فهرست مطالب درس هفتم\nتقابل واژه‌ها	67\nترکیب واژه‌ها	67\nچینش استوار قرآن	69\nخوش‌ادایی	70\nبیانگری و روشنی نظم قرآن	70\nتبیین انگیزه‌های کلی در تقدم و تأخر	74\nانگیزه‌های ادبی تقدیم‌ها	76\nهم‌آغوشی واژه‌ها	77', '0', NULL, 28, 38422, 'application90311728707753.pdf###', 'application13281729422423.pdf###', NULL, 'audio46771727867794.mp3###audio70091727867808.mp3###', 1, 8, NULL, '2024-09-19 16:30:51', '2024-10-20 14:37:18'),
(35, 'درس هشتم: حالات مختلف واژگان (2)', NULL, 'فهرست مطالب درس هشتم\nهم‌آغوشی محتوای ژرف با زیبایی و فریبایی هنری و ادبی	79\nصنایع ادبی	81\nابتکار و استقلال	89\nابعاد ابتکاری قرآن	90\nابتکار در ارائهٔ معارف و استقلال در آن	92', '0', NULL, 14, 38422, 'application92421728707945.pdf###', 'application83701729422468.pdf###', NULL, 'audio38521727867850.mp3###audio16321727867866.mp3###', 1, 9, NULL, '2024-09-19 16:31:53', '2024-10-20 14:37:58'),
(36, 'درس نهم: تحدی قرآن', NULL, 'فهرست مطالب درس نهم\nنقد دیدگاه بنت‌الشاطی	95\nدامنهٔ تحدّی	95\nپاسخ به چند شبهه	97\nقرآن و ادبیات عرب	100\nقرآن و اشتباه نحوی	102', '0', NULL, 22, 38422, 'application88581728707992.pdf###', 'application4821729422500.pdf###', NULL, 'audio4511727867888.mp3###audio33641727867897.mp3###', 1, 10, NULL, '2024-09-19 16:32:55', '2024-10-20 14:38:33'),
(37, 'درس دهم: واقع‌گرایی، التفات و ...', NULL, 'فهرست مطالب درس دهم\nقرآن و واقعیت‌های علمی، تاریخی و ادبی	105\nالتفات یا دیگرگونی سخن	105\nحدود الهی	113\nزبان عربی روشن	113', '0', NULL, 14, 38422, 'application87811728708072.pdf###', 'application99411729422535.pdf###', NULL, 'audio89191727868031.mp3###audio83701727868041.mp3###', 1, 11, NULL, '2024-09-19 16:33:51', '2024-10-20 14:39:22'),
(38, 'درس یازدهم: اعجاز صرفی و نحوی قرآن', NULL, 'نمونه‌های قرآنی	119', '0', NULL, 24, 38422, 'application11481728708230.pdf###', 'application1401729422555.pdf###', NULL, 'audio44731727868098.mp3###audio83471727868113.mp3###', 1, 12, NULL, '2024-09-19 16:35:11', '2024-10-20 14:39:38'),
(39, 'درس دوازدهم: احتمالات در تفسیر', NULL, '1. آثار اعتقادی	125\n2. آثار تربیتی	129\n3. آثار تفسیری	135', '0', NULL, 22, 38422, 'application74061728708269.pdf###', 'application63031729422598.pdf###', NULL, 'audio29351727868223.mp3###audio81161727868236.mp3###', 1, 13, NULL, '2024-09-19 16:36:16', '2024-10-20 14:40:53'),
(40, 'شناسنامه و فهرست مطالب کتاب  اعجاز علمی قرآن کریم، علوم طبیعی', NULL, 'مؤلف: حسن صادقی\nمقطع تحصیلی: كارشناسی ارشد \nتعداد درس‌ها: 12', '0', NULL, 34, 38423, 'application28391728896789.pdf###', 'application68841727967122.pdf###', NULL, NULL, 1, 0, NULL, '2024-09-19 17:23:51', '2024-10-17 22:21:56'),
(41, 'درس اول: کلیات (1)؛ تعاریف و آثار اعجاز علمی', NULL, 'فهرست مطالب درس اول\n1. تعریف معجزه و اعجاز قرآن	11\n2. وجوه اعجاز قرآن	13\n1 _ 2. از جهت آورندهٔ آن	13\n2 _ 2. اعجاز بیانی	13\n3 _ 2. هماهنگی و انسجام	13\n4 _ 2. معارف	14\n5 _ 2. اخبار غیبی	14\n6 _ 2. علمی	14\n3. تعریف علم و علوم طبیعی	14\n4. تعریف اعجاز علمی	15\n5. آثار اعجاز علمی	17\n1 _ 5. نسبت به غیر مسلمانان	17\n2 _ 5. نسبت به مسلمانان	27', '0', NULL, 50, 38423, 'application81101728705800.pdf###', 'application62701727967179.pdf###', NULL, 'audio7551727778753.mp3###audio76501727778762.mp3###', 1, 1, NULL, '2024-09-19 17:24:57', '2024-10-19 18:46:58'),
(42, 'درس دوم: کلیات (2)؛ پیشینهٔ اعجاز علمی', NULL, 'فهرست مطالب درس دوم\n1. تفاسیر	32\n2. کتابهای علوم قرآنی	35\n3. تک‌نگارههای مستقل	37\n4. موسوعه‌ها	38\n5. مجلات	42\n6. پایگاه‌های اینترنتی	43', '0', NULL, 26, 38423, 'application31821728705827.pdf###', 'application1411727967803.pdf###', NULL, 'audio53891727778788.mp3###', 1, 2, NULL, '2024-09-19 17:26:24', '2024-10-19 18:51:23'),
(43, 'درس سوم: کلیات (3)؛ دیدگاه‌ها، مبانی و قواعد اعجاز علمی', NULL, 'فهرست مطالب درس سوم\n1. دیدگاه‌ها در اعجاز علمی	45\n1 _ 1. انکار اعجاز علمی	45\n2 _ 1. پذیرش اعجاز علمی	46\n2. مبانی اعجاز علمی	48\n1 _ 2. برخی مبانی عام تفسیر	49\n2 _ 2. مبانی خاص اعجاز علمی	49\n3. قواعد اعجاز علمی	52\n1 _ 3. قواعد عام تفسیر	52\n2 _ 3. قواعد خاص اعجاز علمی	59', '0', NULL, 26, 38423, 'application78711728705856.pdf###', 'application73091727967825.pdf###', NULL, 'audio39731727778876.mp3###audio76881727778893.mp3###', 1, 3, NULL, '2024-09-19 17:27:39', '2024-10-19 19:07:39'),
(44, 'درس چهارم: کلیات(4)؛ شبهات اعجاز علمی', NULL, 'فهرست مطالب درس چهارم\n1. شبهات اعجاز علمی از جهت دلالت آیات	63\n1 _ 1. امتناع کاربرد لفظ در معانی جدید در آینده	64\n2 _ 1. رعایت نکردن بلاغت در اعجاز علمی	65\n3 _ 1. نبود اعجاز علمی در همهٔ سوره‏ها	66\n4 _ 1.عدم اثبات معجزه بودن قرآن مانند تورات و انجیل	67\n5 _ 1. تفاوت علم تفسیر با علم اعجاز قرآن	68\n6 _ 1. وابستگی اعجاز علمی قرآن به پیشرفت علوم بشری	69\n7 _ 1. روشن نبودن تفاوت معجزه علمى با خبر غيبى	69\n2. شبهات اعجاز علمی از جهت مخاطب	70\n1 _ 2. عدم تحدی مخاطبان نخستین قرآن به اعجاز علمی	70\n2 _ 2. اختصاص اعجاز علمی به دانشمندان و متخصصان علوم تجربی	71\n3 _ 2. احراز نشدن ناتوانی مخاطب در اعجاز علمی	72\n3. شبهات اعجاز علمی از جهت آثار	73\n1 _ 3. باطل شدن اعجاز علمی در صورت تغییر علوم	73\n2 _ 3. تزلزل اعتقادی در صورت بطلان نظریه‌های علمی	74\n3 _ 3. عدم اثبات اعجاز قرآن با مطالب علمی	74\n4 _ 3. تأویل متکلفانه برای اثبات اعجاز علمی	75', '0', NULL, 18, 38423, 'application81851728705886.pdf###', 'application5481727967878.pdf###', NULL, 'audio69661728117472.mp3###', 1, 4, NULL, '2024-09-19 17:29:12', '2024-10-15 09:04:28'),
(45, 'درس پنجم: اعجاز پزشکی (مراحل آفرینش جنین انسان)', NULL, 'فهرست مطالب درس پنجم\n1. نطفه	78\n1 _ 1. نکات تفسیری	78\n2 _ 1. اسرار علمی	83\n3 _ 1. بررسی	84\n2. علقه	84\n1 _ 2. نکات تفسیری	84\n2 _ 2. اسرار علمی	85\n3 _ 2. بررسی	86\n3. مضغه	87\n1 _ 3. نکات تفسیری	87\n2 _ 3. اسرار علمی	89\n3 _ 3. بررسی	90\n4. استخوان‌بندی	90\n1 _ 4. نکات تفسیری	90\n2 _ 4. اسرار علمی	90\n3 _ 4. بررسی	91\n5. گوشت	91\n1 _ 5. نکات تفسیری	91\n2 _ 5. اسرار علمی	92\n3 _ 5. بررسی	92\n6. نفخ روح	93\n1 _ 6. نکات تفسیری	93\n2 _ 6. اسرار علمی	94\n3 _ 6. بررسی	94', '0', NULL, 16, 38423, 'application5571728705930.pdf###', 'application82351727968254.pdf###', NULL, NULL, 1, 5, NULL, '2024-09-19 17:30:06', '2024-10-15 09:05:34'),
(46, 'درس ششم: اعجاز زیست شناسی (1) (شیر و عسل)', NULL, 'فهرست مطالب درس ششم\n1. شیر	97\n1 _ 1. نکات تفسیری	98\n2 _ 1. اسرار علمی	100\n3 _ 1. بررسی	104\n2. عسل	104\n1 _ 2. نکات تفسیری	104\n2 _ 2. اسرار علمی	110', '0', NULL, 18, 38423, 'application97061728706041.pdf###', 'application47371727968268.pdf###', NULL, 'audio70211728117520.mp3###audio8581728117527.mp3###audio44811728117577.mp3###', 1, 6, NULL, '2024-09-19 17:32:24', '2024-10-15 09:06:14'),
(47, 'درس هفتم: اعجاز زیست شناسی (2) (مردار و خون)', NULL, 'فهرست مطالب درس هفتم\n1. مردار	117\n1 _ 1. نکات تفسیری	118\n2 _ 1. اسرار علمی	122\n2. خون	125\n1 _ 2. نکات تفسیری	126\n2 _ 2. اسرار علمی	128', '0', NULL, 18, 38423, 'application61371728706216.pdf###', 'application95231727968286.pdf###', NULL, 'audio77331728117609.mp3###audio43081728117616.mp3###', 1, 7, NULL, '2024-09-19 17:33:16', '2024-10-15 11:35:41'),
(48, 'درس هشتم: اعجاز زیست شناسی (3) (خوک و شراب)', NULL, 'فهرست مطالب درس هشتم\n1. خوک	133\n1 _ 1. نکات تفسیری	134\n2 _ 1. اسرار علمی	135\n3 _ 1. بررسی	136\n2. شراب	136\n1 _ 2. نکات تفسیری	137\n2 _ 2. اسرار علمی	141', '0', NULL, 18, 38423, 'application35961728706343.pdf###', 'application63691727968297.pdf###', NULL, 'audio64891728117657.mp3###audio44831728117669.mp3###', 1, 8, NULL, '2024-09-19 17:34:04', '2024-10-15 11:25:14'),
(49, 'درس نهم: اعجاز زمین شناسی', NULL, 'فهرست مطالب درس نهم\n1. زمین جایگاه امن و آرامش	148\n1 _ 1. نکات تفسیری	148\n2 _ 1. اسرار علمی	149\n2. کوهها مایهٔ ثبات زمین	151\n1 _ 2. نکات تفسیری	151\n2 _ 2. اسرار علمی	156\n3. آب‌های زیرزمینی	158\n1 _ 3. نکات تفسیری	159\n2 _ 3. اسرار علمی	161', '0', NULL, 30, 38423, 'application21141728706459.pdf###', 'application92741729423490.pdf###', NULL, 'audio65681728117749.mp3###audio5971728117758.mp3###', 1, 9, NULL, '2024-09-19 17:34:49', '2024-10-20 14:54:57'),
(50, 'درس دهم: اعجاز هواشناسی', NULL, 'فهرست مطالب درس دهم\n1. حفظ آسمان از پدیده‌های خطرناک	166\n1 _ 1. نکات تفسیری	166\n2 _ 1. اسرار علمی	167\n2. دشوارى تنفس در هوا با افزايش ارتفاع	171\n1 _ 2. نکات تفسیری	171\n2 _ 2. اسرار علمی	173\n3 _ 2. بررسی	175\n3. نقش بادها در لقاح و باروری	175\n1 _ 3. نکات تفسیری	176\n2 _ 3. اسرار علمی	177\n4. ابرهاى كوه‌وار و تگرگ	179\n1 _ 4. نکات تفسیری	179\n2 _ 4. اسرار علمی	181\n3 _ 4. بررسی	182', '0', NULL, 18, 38423, 'application37141728706588.pdf###', 'application52471727968322.pdf###', NULL, 'audio91181728117811.mp3###audio11431728117832.mp3###', 1, 10, NULL, '2024-09-19 17:35:26', '2024-10-15 09:14:29'),
(51, 'درس یازدهم: اعجاز کیهان شناسی', NULL, 'فهرست مطالب درس یازدهم\n1. گسترش زمين	185\n1 _ 1. نکات تفسیری	185\n2 _ 1. اسرار علمی	187\n3 _ 1. بررسی	188\n2. حركت زمين	189\n1 _ 2. نکات تفسیری	190\n2 _ 2. اسرار علمی	194\n3 _ 2. بررسی	194\n3. حرکت خورشید	196\n1 _ 3. نکات تفسیری	196\n2 _ 3. اسرار علمی	200\n3 _ 3. بررسی	200\n4. گسترش جهان	201\n1 _ 4. نکات تفسیری	201\n2 _ 4. اسرار علمی	202\n3 _ 4. بررسی	204', '0', NULL, 14, 38423, 'application39041728706704.pdf###', 'application56861727968334.pdf###', NULL, 'audio18121728117894.mp3###', 1, 11, NULL, '2024-09-19 17:36:08', '2024-10-15 09:15:22'),
(52, 'درس دوازدهم: اعجاز عددی و ریاضی', NULL, 'فهرست مطالب درس دوازدهم\n1. پیشینهٔ تاریخی	207\n1 _ 1. برخی آثار موافق با اعجاز عددی و ریاضی	208\n2 _ 1. آثار مخالف با اعجاز عددی	211\n2. نمونه‌هایی از اعجاز عددی و اشکالات آن	213\n1 _ 2. اعجاز عدد نوزده	213\n2 _ 2. حروف مقطعه	217\n3 _ 2. تناسب در تکرار کلمات	219\n4 _ 2. سازگاری شمارش کلمات با امور دیگر	224\n3. بررسی نهایی	227', '0', NULL, 18, 38423, 'application89111728706738.pdf###', 'application21231727968346.pdf###', NULL, 'audio58621728118006.mp3###', 1, 12, NULL, '2024-09-19 17:36:51', '2024-10-15 11:39:20'),
(53, 'شناسنامه و فهرست مطالب کتاب  سیر تطور وجوه اعجاز قرآن کریم', NULL, 'مؤلف محتوای آموزشی: اسماعیل سلطانی\nمقطع کارشناسی ارشد\nتعداد درس ها: 9', '0', NULL, 66, 38421, 'application56951728892365.pdf###', 'application39051728903026.pdf###', NULL, NULL, 1, 0, NULL, '2024-09-19 17:46:33', '2024-10-15 10:08:43'),
(54, 'درس اول: مفاهیم و کلیات', NULL, 'فهرست مطالب درس اول\nمفهومشناسی اعجاز و معجزه	8\nمفهوم لغوی اعجاز و معجزه	9\nکاربردهای قرآنی اعجاز و مشتقات آن	9\nتعريف اصطلاحی معجزه	10\nتوضیح برخی از قیود تعریف	10\nاهميت و جايگاه اعجاز قرآن	11\nدستنيافتنی بودن کنه اعجاز	12\nتعریف وجوه اعجاز	13\nگسترۀ وجوه اعجاز	14\nعوامل اختلاف دانشمندان در بيان وجوه اعجاز	16\nعوامل برونقرآنی	16\nعوامل درونقرآنی	17\nاقسام وجوه اعجاز	17\nراه‌های شناخت وجوه اعجاز	18\nاهمیت و ضرورت پرداختن به سیر تطور وجوه اعجاز	19', '0', NULL, 62, 38421, 'application5361728708437.pdf###', 'application49921728901331.pdf###', NULL, 'audio58661727776089.mp3###', 1, 1, NULL, '2024-09-19 17:47:12', '2024-10-16 15:06:39'),
(55, 'درس دوم: وجوه اعجاز در قرن اول', NULL, 'فهرست مطالب درس دوم\n1. اولین برخورد مشرکان با قرآن، انکار اعجاز قرآن	22\n2. تحدی قرآن	24\n1 _ 2. تحدی عام و کلی	25\n2 _ 2. تحدی خاص	25\n3. ناتوانی مشرکان از معارضه با قرآن	27\n1 _ 3. شهادت بر ناتوانی	27\n2 _ 3. آزار و اذيت‌های زبانی و عملی	30\n3 _ 3. ایجاد مانع از گوش کردن به سخنان پیامبر	32\n4 _ 3. معارضۀ سخیفانه با قرآن	34\n4. اعتراف به اعجاز قرآن با تأکید بر اعجاز بیانی	35\n5. مراد از اعجاز بیانی	36', '0', NULL, 38, 38421, 'application84501728708607.pdf###', 'application58031728901401.pdf###', NULL, 'audio96441727776144.mp3###audio80581727776153.mp3###', 1, 2, NULL, '2024-09-19 17:47:47', '2024-10-16 15:48:47'),
(56, 'درس سوم: وجوه اعجاز در قرن دوم و سوم', NULL, 'فهرست مطالب درس سوم\nنظریه پردازان قرن دوم	41\n1. واصل‎بن‏عطاء (م. 131ق.)	41\n2. ابومحمد عبدالله‎بن‏مقفّع (م. 142ق.)	42\nنظریهپردازان قرن سوم	43\n1. ابواسحاق نظّام (م. 244 يا 231ق.)	43\n2. ابوعثمان جاحظ (م. 255ق.)	48\n3. ابوالحسن علی‎بن‏رَبَّن الطبری (م.247ق.)	50\n4. عبداللّه‎بن‏مسلم‏‎بن‏قتيبه دينوری (م. 276ق.)	51', '0', NULL, 42, 38421, 'application93561728708630.pdf###', 'application98081728975990.pdf###', NULL, 'audio18141727776193.mp3###audio34231727776203.mp3###', 1, 3, NULL, '2024-09-19 17:48:30', '2024-10-15 10:36:51'),
(57, 'درس چهارم: وجوه اعجاز در قرن چهارم', NULL, 'فهرست مطالب درس چهارم\nنظریه‌پردازان قرن چهارم	55\n1. محمد‎بن ‏يزيد واسطی (م. 306ق.)	55\n2. ابن‌جرير طبری (م. 310ق.)	56\n3. ابوهاشم جبایی (م. 321ق.)	56\n4. ابومسلم اصفهانی (م.322ق.)	58\n5. ابوالحسن اشعری (م. 324 یا 330ق.)	58\n6. ابوالحسن علی‎بن‏عيسی رمّانی (م. 384ق.)	60\n7. ابوسليمان خطّابی بستی (م. 388ق.)	62', '0', NULL, 40, 38421, 'application69781728708680.pdf###', 'application74361728975913.pdf###', NULL, 'audio98491728118464.mp3###audio94161728118476.mp3###', 1, 4, NULL, '2024-09-19 17:49:02', '2024-10-15 10:37:00'),
(58, 'درس پنجم: وجوه اعجاز در قرن پنجم', NULL, 'فهرست مطالب درس پنجم\nنظریه‌پردازان قرن پنجم	69\n1. باقلانی ( م.403ق.)	69\n2. شيخ مفيد (م. 413ق.)	73\n3. قاضی عبدالجبار (م. 415ق.)	74\n4. سيدمرتضی (م. 436ق.)	75\n5. شيخ طوسی (م. 460ق.)	77\n6. ابن‌سنان الخفاجی (م. 466ق.)	78\n7. عبدالقاهر جرجانی (400 _ 471ق.)	79', '0', NULL, 38, 38421, 'application65821728708703.pdf###', 'application51291728901560.pdf###', NULL, 'audio17581728118538.mp3###audio30031728118545.mp3###', 1, 5, NULL, '2024-09-19 17:49:37', '2024-10-15 10:24:28'),
(59, 'درس ششم: وجوه اعجاز در قرن ششم', NULL, 'فهرست مطالب درس ششم\nنظریه‌پردازان قرن ششم	87\n1. راغب اصفهانی (م. 502ق.)	87\n2. غزالی (م. 505ق.)	89\n3. زمخشری (م. 538ق.)	91\n4. قاضی عياض (م. 544ق.)	92\n5. ابن‌عطيۀ اندلسی ( م. 546ق.)	94\n6. شيخ طبرسی (472 _ 552ق.)	95\n7. قطب راوندی (م. 573ق.)	97', '0', NULL, 24, 38421, 'application72441728708814.pdf###', 'application76881728901618.pdf###', NULL, 'audio93391728118597.mp3###audio42301728118605.mp3###', 1, 6, NULL, '2024-09-19 17:50:04', '2024-10-15 10:24:05'),
(60, 'درس هفتم: وجه اعجاز قرآن در قرن هفتم و هشتم (1)', NULL, 'فهرست مطالب درس هفتم\nنظریه پردازان قرن هفتم و هشتم	101\n1. فخرالدين رازی (م. 606ق.)	101\n2. سكّاكی (م. 626ق.)	105\n3. ابن‌جزّی كلبی (م.741ق.)	106\nمراد از اعجاز هدایتی و تشریعی	107', '0', NULL, 26, 38421, 'application9831728708862.pdf###', 'application90761728901672.pdf###', NULL, 'audio93321728118681.mp3###audio69841728118694.mp3###', 1, 7, NULL, '2024-09-19 17:50:40', '2024-10-15 10:22:34'),
(61, 'درس هشتم: وجه اعجاز قرآن در قرن هشتم (2)', NULL, 'فهرست مطالب درس هشتم\nنظریه‌پردازان قرن هشتم	110\n1. علوی يمنی (م. 749ق.)	110\n2. بدرالدين زركشی (م. 794ق.)	116', '0', NULL, 32, 38421, 'application15361728708920.pdf###', 'application13131728901852.pdf###', NULL, 'audio61421728118806.mp3###audio14351728118819.mp3###audio79421728118836.mp3###', 1, 8, NULL, '2024-09-19 17:51:50', '2024-10-15 10:21:43'),
(62, 'درس نهم: وجه اعجاز قرآن در قرن دهم تا سیزدهم', NULL, 'فهرست مطالب درس نهم\nنظریه‌پردازان قرن دهم تا سیزدهم	124\n1. سیوطی (م. 911ق.)	124\n2. سيدعبدالله شبّر (م. 1242ق.)	134', '0', NULL, 30, 38421, 'application20691728709002.pdf###', 'application52681728901898.pdf###', NULL, 'audio46621728118869.mp3###', 1, 9, NULL, '2024-09-19 17:53:05', '2024-10-15 10:20:47'),
(63, 'شناسنامه و فهرست مطالب کتاب  خداشناسی در قرآن', NULL, 'مؤلف: علامه محمدتقی مصباح یزدی&\nقسمت‌نویس: علی‌رضا کرمانی\nویراستار: محمدرضا پهلوانی\nدرس جبرانی مقطع کارشناسی ارشد\nتعداد درس: 12', '0', NULL, 130, 31302, 'application32591728896625.pdf###', NULL, NULL, NULL, 1, 0, NULL, '2024-09-19 17:57:36', '2024-10-16 09:29:18'),
(64, 'درس اول: شناخت خداوند (1)', NULL, 'فهرست مطالب درس اول\nقسمت اول: راه‌های شناخت خدا	10\nانواع شناخت	10\nاسم خاص و اسم عام	12\nقسمت دوم: شناخت خدا با برهان‌های عقلی	14\nدلیل عقلی بر وجود خدا در قرآن	14\nقسمت سوم: شناخت خداوند از راه فطرت	17\nقسمت چهارم: شناخت حضوری خداوند (1)	22\nآیهٔ فطرت	22\nدو تفسیر برای آیهٔ فطرت	23', '0', NULL, 152, 31302, 'application65801728559183.pdf###', 'application48521727950738.pdf###', 'video86291728718916.mp4###video65421728718925.mp4###video65731728718934.mp4###video79211728718940.mp4###', 'audio64981727258000.mp3###audio83661727258004.mp3###audio86681727258007.mp3###audio60261727258010.mp3###', 1, 1, NULL, '2024-09-19 17:58:11', '2024-10-19 15:50:20'),
(65, 'درس دوم: شناخت خداوند (2)، توحید و مراتب آن', NULL, 'فهرست مطالب درس دوم\nقسمت اول: شناخت حضوری خداوند (2)	30\nآیهٔ میثاق	30\nقسمت دوم: ربوبیت و توحید پروردگار با استدلال به آیهٔ میثاق	35\nآیهٔ میثاق و ربوبیت	35\nرابطهٔ میان خدا و انسان	36\nقسمت سوم: مفهوم توحید	41\nمفهوم توحید	41\nمراتب توحید	42', '0', NULL, 60, 31302, 'application57391728554542.pdf###', 'application95151727950752.pdf###', 'video14301728810929.WMV###video22501728810940.WMV###video15781728810948.WMV###', 'audio51761727323955.mp3###audio86061727323963.mp3###audio49921727323967.mp3###', 1, 2, NULL, '2024-09-19 17:59:02', '2024-10-19 16:25:33'),
(66, 'درس سوم: نصاب و معیار توحید', NULL, 'فهرست مطالب درس سوم\nقسمت اول: نصاب توحید	50\nقسمت دوم: مراتب و معیار توحید	53\nمراتب پنج‌گانه توحید	53\nقسمت سوم: توحید و اسناد خلقت به دیگران	57\nوساطت در تدبیر	57\nرابطهٔ توحید با ولایت تكوینی و تشریعی اولیای الهی	59\nرابطهٔ توحید با شفاعت	62', '0', NULL, 68, 31302, 'application59481728554569.pdf###', 'application50701727950691.pdf###', 'video11871728817396.mp4###video10261728817504.mp4###video74921728817520.mp4###', 'audio43991727324116.mp3###audio29391727324120.mp3###audio40571727324125.mp3###', 1, 3, NULL, '2024-09-19 17:59:37', '2024-10-15 11:41:51'),
(67, 'درس چهارم: اثبات توحید', NULL, 'فهرست مطالب درس چهارم\nقسمت اول: ادلهٔ عقلی توحید در قرآن	65\nاستدلال عقلی بر توحید	65\nتقریر ملازمه	67\nاثبات نظام واحد برای عالم	68\nقسمت دوم: استدلال بر توحید در قرآن	69\nجهان چندسیستمی	69', '0', NULL, 34, 31302, 'application8621728554595.pdf###', 'application37491727950765.pdf###', 'video41831728726114.mp4###video84961728726126.mp4###', 'audio87441727324189.mp3###audio2851727324194.mp3###', 1, 4, NULL, '2024-09-19 18:00:12', '2024-10-15 07:30:48'),
(68, 'درس پنجم: اقسام توحید و شناخت اوصاف خداوند', NULL, 'فهرست مطالب درس پنجم\nقسمت اول: اقسام توحید از دیدگاه فیلسوفان و متكلمان	80\nتوحید ذاتی، صفاتی و افعالی	80\nتوحید ذاتی و صفاتی در اصطلاح فلاسفه و متكلمان	81\nتوحید افعالی در اصطلاح فلاسفه و متكلمان	83\nقسمت دوم: اقسام توحید در عرفان	85\nتوحید در اصطلاح عارفان	85\nقسمت سوم: شناخت صفات خدا	90\nخدا را تا چه اندازه می‌توان شناخت	90\nشناخت خدا از دیدگاه قرآن و روایات	90\nقسمت چهارم: شناخت عقلی و قلبی صفات خدا	95\n[توانایی انسان در شناخت اوصاف خدا]	95', '0', NULL, 42, 31302, 'application3981728554624.pdf###', 'application26621727950800.pdf###', 'video22851728726409.mp4###video69141728726424.mp4###video58911728726431.mp4###video63691728726438.mp4###', 'audio54541727324257.mp3###audio20521727324262.mp3###audio73641727324268.mp3###audio60111727324272.mp3###', 1, 5, NULL, '2024-09-19 18:00:40', '2024-10-15 15:07:27'),
(69, 'درس ششم: توحید افعالی، خلق و تدبیر', NULL, 'فهرست مطالب درس ششم\nقسمت اول: شناخت افعال خداوند	105\nافعال الهی (1)	105\nخلق و تدبیر جهان از دیدگاه قرآن	106\nقسمت دوم: خلق و تدبیر خداوند در قرآن	110\nخدا و خلق در قرآن	110\nقسمت سوم: اقسام علیت	115\nافعال الهی (2)	115\nانواع نسبت میان فعل و فاعل	116\nقسمت چهارم: خداوند و عوامل طبیعی در قرآن	119', '0', NULL, 30, 31302, 'application82121728554670.pdf###', 'application26261727950815.pdf###', 'video1991728726643.mp4###video34521728726654.mp4###video48961728726660.mp4###video52181728726665.mp4###', 'audio28221727324339.mp3###audio44051727324344.mp3###audio45381727324351.mp3###audio47361727324355.mp3###', 1, 6, NULL, '2024-09-19 18:01:11', '2024-10-15 07:49:34'),
(70, 'درس هفتم: رابطهٔ اصل علیت با توحید افعالی', NULL, 'فهرست مطالب درس هفتم\nقسمت اول: علیت در قرآن	130\nفرشتگان و رسالت تكوینی و تشریعی	134\nقسمت دوم: رابطهٔ اصل علیت با افعال انسانی	136\nقرآن و فاعلیت انسان	136\nقسمت سوم: اصل علیت و رابطهٔ آن با اعجاز	140\nاعجاز و قانون علیت	140\nقسمت چهارم: معجزه، نقض یا اثبات قانون علیت؟	144', '0', NULL, 28, 31302, 'application52071728554727.pdf###', 'application57191727950828.pdf###', 'video46771728726798.mp4###video67841728726814.mp4###video28161728726823.mp4###video24891728726832.mp4###', 'audio89781727324396.mp3###audio68731727324402.mp3###audio24741727324407.mp3###audio89351727324412.mp3###', 1, 7, NULL, '2024-09-19 18:01:47', '2024-10-15 08:09:13'),
(71, 'درس هشتم: قدرت الهی', NULL, 'فهرست مطالب درس هشتم\nقسمت اول: محدودهٔ قدرت الهی	153\nقلمرو قدرت و مشیت الهی	153\nخدا و انجام دادن فعل محال	156\nقسمت دوم: رابطهٔ قدرت الهی با شرور و كارهای قبیح	158\nخدا و انجام دادن فعل قبیح	158\nرابطهٔ قدرت با حكمت خداوند	159\nقسمت سوم: رابطهٔ قدرت با ارادهٔ خداوند	161\nرابطهٔ قدرت با اراده	161\nقسمت چهارم: افعال خداوند و مصالح نظام هستی	166\nمعنای مصلحت	166', '0', NULL, 22, 31302, 'application82351728554750.pdf###', 'application77491727950841.pdf###', 'video48161728726889.mp4###video64911728726901.mp4###video86921728726911.mp4###video41551728726918.mp4###', 'audio37291727324452.mp3###audio18711727324458.mp3###audio74991727324463.mp3###audio19901727324468.mp3###', 1, 8, NULL, '2024-09-19 18:02:15', '2024-10-15 11:42:26'),
(72, 'درس نهم: هدف‌داری افعال الهی و هدف نهایی خلقت', NULL, 'فهرست مطالب درس نهم\nقسمت اول: مؤاخذه خدا، ممكن یا غیر ممكن؟	173\nخدا مورد بازخواست قرار نمی‌گیرد	173\nقسمت دوم: هدف افعال خداوند از دیدگاه قرآن	179\nغایت افعال الهی از نظر قرآن	184\nقسمت سوم: افعال خداوند و هدف نهایی خلقت	189\nهدف آفرینش جهان و انسان	192\nهدف آفرینش مجردات تام	192\nهدف آفرینش موجودات مادی و مجردات ناقص	193\nقسمت چهارم: هدف آفرینش انسان	195\nآزمایش، هدف آفرینش انسان	195\nهدف خداوند از آزمایش انسان	200', '0', NULL, 28, 31302, 'application11811728554769.pdf###', 'application38641728887221.pdf###', 'video36751728726981.mp4###video75661728726989.mp4###video36431728726997.mp4###video19961728727003.mp4###', 'audio19801727324503.mp3###audio78141727324509.mp3###audio51571727324516.mp3###audio47171727324521.mp3###', 1, 9, NULL, '2024-09-19 18:02:47', '2024-10-15 08:04:02'),
(73, 'درس دهم: علم الهی', NULL, 'فهرست مطالب درس دهم\nقسمت اول: مراتب علم الهی(1)	207\nنظر قرآن دربارهٔ فعل الهی	208\nقسمت دوم: مراتب علم الهی (2)	214\nمفهوم کتاب در قرآن	214\nعلم الهی و اختیار انسان	220', '0', NULL, 26, 31302, 'application41751728554786.pdf###', 'application63091727950858.pdf###', 'video90791728727053.mp4###video94921728727061.mp4###', 'audio71431727324541.mp3###audio61811727324546.mp3###', 1, 10, NULL, '2024-09-19 18:03:21', '2024-10-15 08:04:16'),
(74, 'درس یازدهم: اذن و تقدیر الهی (1)', NULL, 'فهرست مطالب درس یازدهم\nقسمت اول: مفهوم اذن الهی و اقسام آن	225\nقسمت دوم: مفهوم تقدیر الهی	231', '0', NULL, 28, 31302, 'application20191728554805.pdf###', 'application25961727950872.pdf###', 'video61351728727162.mp4###video48141728727168.mp4###', 'audio61501727324570.mp3###audio42421727324575.mp3###', 1, 11, NULL, '2024-09-19 18:03:56', '2024-10-15 08:04:57'),
(75, 'درس دوازدهم: تقدیر الهی (2)، اجل و قضای الهی', NULL, 'فهرست مطالب درس دوازدهم\nقسمت اول: نكاتی دربارهٔ تقدیر	243\nاجل	248\nقسمت دوم: رابطهٔ قضای الهی با اختیار	250\nقضا و اختیار	256\n...', '0', NULL, 48, 31302, 'application3691728801199.pdf###', 'application63711727950883.pdf###', 'video55061728727208.mp4###video57341728727218.mp4###', 'audio97551727324593.mp3###audio14411727324619.mp3###', 1, 12, NULL, '2024-09-19 18:04:28', '2024-10-15 15:07:46'),
(76, 'شناسنامه و فهرست مطالب کتاب  درآمدی بر معرفت شناسی و مبانی معرفت دینی', NULL, 'مؤلف محتوای آموزشی: محمد حسین‌زاده \nقسمت‌نویس: محمدمهدی اکبری‌دهقان \nویراستار: محمدرضا پهلوانی \nدرس جبرانی مقطع کارشناسی ارشد\nتعداد درس: 12', '0', NULL, 58, 31301, 'application91501728896707.pdf###', NULL, NULL, NULL, 1, 1, NULL, '2024-09-19 18:06:52', '2024-10-15 08:09:55'),
(77, 'درس اول: مفاهیم و کلیات', NULL, 'فهرست مطالب درس اول\nقسمت اول: پیشینه معرفت‌شناسی	9\nتعریف معرفت	10\nقسمت دوم:‌ تعریف معرفت‌شناسی	11\nقسمت سوم: رویکرد اندیشمندان مسلمان به معرفت‌شناسی	13\nپاره‌ای از معرفت‌های یقینی و تردیدناپذیر انسان	14\nقسمت چهارم: امکان معرفت	15\nقسمت پنجم: دورنمایی از مباحث معرفت‌شناسی	17\nقسمت ششم: اقسام علم (علم حضوری و علم حصولی)	18\nتعریف علم حضوری و علم حصولی	19\nاقسام علم حضوری انسان	20\nقسمت هفتم: ویژگی‌ها و راز خطاناپذیری علم حضوری	21', '0', NULL, 116, 31301, 'application26751728705246.pdf###', 'application53161727541117.pdf###', 'video40791728887687.mp4###video88551728887709.mp4###video68281728887727.mp4###video84811728887741.mp4###video29451728887750.mp4###video75401728887762.mp4###video45671728887773.mp4###', 'audio73361727324844.mp3###audio92011727324850.mp3###audio10621727324856.mp3###audio63681727324860.mp3###audio34651727324865.mp3###audio93931727324871.mp3###audio34651727324875.mp3###', 1, 2, NULL, '2024-09-19 18:07:24', '2024-10-20 17:02:31'),
(78, 'درس دوم: علم حصولی و حضوری', NULL, 'فهرست مطالب درس دوم\nقسمت اول: رابطه ارزش شناخت و علم حصولی	25\nاقسام علم حصولی	26\nقسمت دوم: اقسام تصور	27\nمفاهیم جزئی	28\nقسمت سوم: مفاهیم کلی (1)	28\nاقسام مفاهیم كلی	29\nمفاهیم ماهوی و ویژگی‌های آنها	30\nقسمت چهارم: مفاهیم کلی (2)	30\nمفاهیم منطقی و فلسفی	30\nتمایز مفاهیم منطقی و فلسفی	31', '0', NULL, 52, 31301, 'application17371728705275.pdf###', 'application95801727943863.pdf###', 'video68331728888016.mp4###video16451728888037.mp4###video94731728888058.mp4###video5981728888080.mp4###', 'audio49981727324924.mp3###audio5751727324928.mp3###audio79971727324932.mp3###audio9111727324937.mp3###', 1, 3, NULL, '2024-09-19 18:08:05', '2024-10-20 14:16:33'),
(79, 'درس سوم: قضایا و صدق', NULL, 'فهرست مطالب درس سوم\nقسمت اول: تقسیم اولیه قضایا (1)	35\nبدیهی و نظری	36\nتحلیلی و تركیبی	36\nقسمت دوم: تقسیم اولیه قضایا (2)	37\nپسین و پیشین	38\nقسمت سوم: حقیقت صدق	39\nپیشینه حقیقت صدق	41\nقسمت چهارم: تعریف صدق و کذب	41\nنظریه مطابقت، تعریف رایج صدق	42', '0', NULL, 26, 31301, 'application49281728705305.pdf###', 'application69041727943897.pdf###', 'video64481728888155.mp4###video55081728888182.mp4###video14261728888202.mp4###video21941728888222.mp4###', 'audio61831727325024.mp3###audio28691727325028.mp3###audio46001727325032.mp3###audio22001727325036.mp3###', 1, 4, NULL, '2024-09-19 18:08:58', '2024-10-20 16:10:17'),
(80, 'درس چهارم: معیار صدق', NULL, 'فهرست مطالب درس  چهارم\nقسمت اول: مبناگروی و چیستی معیار صدق	47\nمعیار صدق	48\nمعیار اندیشمندان مسلمان	48\nقسمت دوم: راه‌حل اول مبناگرایان	50\nراز صدق بدیهیات	50\nقسمت سوم: راه‌حل دوم مبناگرایان (1)	51\n1. وجدانیات	52\n2. بدیهیات منطق	52\nقسمت چهارم: راه‌حل دوم مبناگرایان (2)	53\n3. قضایای تحلیلی	53\nقسمت پنجم: راه‌حل دوم مبناگرایان (3)	54\n4. بدیهیات اولیه	54\nقسمت ششم: پوزیتیویستها و چیستی معیار صدق	58\nمعیار پوزیتیویستهای منطقی	59\nنقد معیار پوزیتیویستها	59\nقسمت هفتم: انسجام‌گرایان و چیستی معیار صدق	60\nمعیار انسجام‌گرایان	61\nقسمت هشتم: نقد معیار انسجام‌گرایان	61', '0', NULL, 34, 31301, 'application48811728705333.pdf###', 'application23871727943910.pdf###', 'video77671728888341.mp4###video59661728888368.mp4###video17371728888387.mp4###video92591728888409.mp4###video68591728888431.mp4###video48691728888454.mp4###video72361728888481.mp4###video93961728888510.mp4###', 'audio22671727325072.mp3###', 1, 5, NULL, '2024-09-19 18:09:37', '2024-10-15 09:24:32'),
(81, 'درس پنجم: تعارض معرفت‌های دینی با معرفت‌های بشری دیگر', NULL, 'فهرست مطالب درس پنجم\nقسمت اول: معرفت دینی	69\nتعریف دین	69\nتعریف معرفت	71\nقسمت دوم: چیستی معیار صدق در معرفت‌های دینی	72\nقسمت سوم: تعارض معرفت‌های دینی و غیر دینی	75\nتعارض معرفت‌های دینی با دیگر معرفت‌های بشری	76\nقسمت چهارم: آموزه‌های عقل‌‌ستیز دینی	78\nقسمت پنجم: انواع تعارض‌های معرفت دینی و غیر دینی	80\nانواع تعارض	80\nقسمت ششم: ‌بررسی نمونه‌ها‌یی از تعارض دلیل عقلی با نقلی	83\nنمونهای از تعارض دلیل عقلی با دلیل نقلی	83\nنمونهای از تعارض دلیل علمی و دلیل نقلی	85', '0', NULL, 32, 31301, 'application53991728705372.pdf###', 'application29971727943925.pdf###', 'video40811728888599.mp4###video35931728888631.mp4###video20951728888657.mp4###video40061728888695.mp4###video5001728888726.mp4###video12651728888758.mp4###', 'audio45071727325125.mp3###audio32761727325129.mp3###audio19221727325133.mp3###audio58781727325139.mp3###audio65841727325144.mp3###audio93851727325148.mp3###', 1, 6, NULL, '2024-09-19 18:10:15', '2024-10-15 09:22:32'),
(82, 'درس ششم: تعدد قرائت‌ها از دین (1)', NULL, 'فهرست مطالب درس ششم\nقسمت اول: نظریه‌های تفسیر متن (هرمنوتیک کلاسیک)	93\nنظریه تعدد قرائت‌ها از دین و مبانی آن	93\nدانش تفسیر متون در مغربزمین	94\nقسمت دوم: نظریه‌های تفسیر متن (هرمنوتیک رمانتیك)	96\nنظریه «تعدد قرائت‌ها از دین» و مبانی آن	96\nقسمت سوم: بررسی هرمنوتیک کلاسیک و رمانتیک	98\nپیامد دیدگاههای هرمنوتیک کلاسیک و رمانتیک	99', '0', NULL, 42, 31301, 'application13851728705414.pdf###', 'application3491727943939.pdf###', 'video82561728889059.mp4###video97091728889078.mp4###video85741728889093.mp4###', 'audio2831727325213.mp3###audio16671727325217.mp3###audio67001727325221.mp3###', 1, 7, NULL, '2024-09-19 18:10:53', '2024-10-15 11:28:05'),
(83, 'درس هفتم: تعدد قرائت‌ها از دین (2)', NULL, 'فهرست مطالب درس هفتم\nقسمت اول: نظریه‌های تفسیر متن (هرمنوتیک فلسفی)	107\nتمایز هرمنوتیک فلسفی با هرمنوتیک رمانتیک و هرمنوتیک كلاسیك	108\nدستاوردهای هرمنوتیک فلسفی درباره فهم متن	108\nقسمت دوم: نقد و بررسی هرمنوتیک فلسفی	109\nقسمت سوم: پیش‌دانسته‌ها و تفسیرهای گوناگون در فهم متن	113\nقسمت چهارم: علل اختلاف‌نظر در فهم متن	115', '0', NULL, 18, 31301, 'application55991728705503.pdf###', 'application93721727943950.pdf###', 'video3691728889234.mp4###video76311728889253.mp4###video99951728889273.mp4###video36221728889291.mp4###video38911728889318.mp4###', 'audio80131727325243.mp3###audio24651727325248.mp3###audio98831727325255.mp3###audio99801727325259.mp3###', 1, 8, NULL, '2024-09-19 18:11:23', '2024-10-15 08:49:36'),
(84, 'درس هشتم: پلورالیسم دینی', NULL, 'فهرست مطالب درس هشتم\nقسمت اول: تعریف و پیشینه پلورالیسم دینی	121\nتعریف آموزه نجات در مسیحیت سنتی	123\nقسمت دوم: آموزه‌های پلورایسم دینی	124\nقسمت سوم: نقد پلورالیسم دینی (1)	127\nبررسی پلورالیسم دینی	127\nقسمت چهارم: نقد پلورالیسم دینی (2)	128\nقسمت پنجم: نقد پلورالیسم دینی (3)	130', '0', NULL, 26, 31301, 'application83731728705532.pdf###', 'application31411727943977.pdf###', 'video77131728889357.mp4###video55281728889375.mp4###video76271728889391.mp4###video32831728889407.mp4###video64801728889431.mp4###', 'audio36031727325312.mp3###audio16991727325317.mp3###audio88101727325320.mp3###audio20401727325324.mp3###audio52701727325328.mp3###', 1, 9, NULL, '2024-09-19 18:11:56', '2024-10-15 08:50:33'),
(85, 'درس نهم: حقانیت و رستگاری در اسلام (1)', NULL, 'فهرست مطالب درس نهم\nقسمت اول: حقانیت ادیان و دیدگاه اسلام	137\nاسلام و مسئله حقانیت همه ادیان	138\nاسلام عام و اسلام خاص	138\nقسمت دوم: ادله دیدگاه اسلامی در مسئله حقانیت	141', '0', NULL, 22, 31301, 'application90851728705567.pdf###', 'application79151727943994.pdf###', 'video60791728889474.mp4###video90081728889491.mp4###', 'audio58471727325354.mp3###audio74381727325360.mp3###', 1, 10, NULL, '2024-09-19 18:12:25', '2024-10-15 08:51:58'),
(86, 'درس دهم: حقانیت و رستگاری در اسلام (2)', NULL, 'فهرست مطالب درس دهم\nقسمت اول: تفاوت حقانیت با مسئله نجات	153\nاسلام و مسئله رستگاری	154\nرستگاران از دیدگاه اسلام	155\nقسمت دوم: ادله و نقدهای درون‌دینی (نقلی) حقانیت همه ادیان	157\nدفاع از نظریه حقانیت همه ادیان	157\nنقد و بررسی ادله حقانیت ادیان	158\nپاسخ‌های مشترك	158\nقسمت سوم: پاسخ‌های اختصاصی به ادله نقلی حقانیت ادیان (1)	159\nپاسخ‌های اختصاصی استدلال اول	160\nقسمت چهارم: پاسخ‌های اختصاصی به ادله نقلی حقانیت ادیان (2)	162\nپاسخ اختصاصی به استدلال دوم	162\nپاسخ اختصاصی به استدلال سوم	163', '0', NULL, 20, 31301, 'application84091728705608.pdf###', 'application21891727944018.pdf###', 'video66681728889533.mp4###video21401728889565.mp4###video71981728889580.mp4###video95181728889608.mp4###', 'audio88941727325390.mp3###audio71251727325395.mp3###audio91711727325400.mp3###audio99591727325404.mp3###', 1, 11, NULL, '2024-09-19 18:12:56', '2024-10-15 11:28:56'),
(87, 'درس یازدهم: تغییر در دین', NULL, 'فهرست مطالب درس یازدهم\nقسمت اول: امکان تغییر در دین	169\nعقاید	171\nارزشهای اخلاقی	172\nقسمت دوم: تغییر در احکام	173\nاحكام	173\nقسمت سوم: انواع تغییر در احکام	174\n1. تبدل موضوع	175\n2. احكام حكومتی	176\n3. تزاحم احكام	178', '0', NULL, 18, 31301, 'application12061728705640.pdf###', 'application8751727944031.pdf###', 'video14971728889708.mp4###video27751728889720.mp4###video82491728889735.mp4###', 'audio34061727325440.mp3###audio60161727325444.mp3###audio59221727325449.mp3###', 1, 12, NULL, '2024-09-19 18:13:29', '2024-10-15 08:55:38'),
(88, 'درس دوازدهم: تغییر در معرفت دینی', NULL, 'فهرست مطالب درس دوازدهم\nقسمت اول: تغییر و تحول در معرفت دینی و معانی آن	181\nقسمت دوم: رد و ابطال و تحول در معرفت دینی	185\nقسمت سوم: معرفت‌های دینی تحول‌پذیر	188\nمعرفت‌های یقینی دینی	188\nمعرفت‌های یقینی غیر دینی	190\nقسمت چهارم: بررسی ارتباط معرفت‌های دینی با معرفت‌های غیر دینی	191\nقسمت پنجم: تبعیت معرفت‌های دینی از معرفت‌های غیر دینی، آری یا خیر	194', '0', NULL, 26, 31301, 'application31581728705671.pdf###', 'application95051727944042.pdf###', 'video15141728889767.mp4###video75151728889782.mp4###video79431728889801.mp4###video73571728889817.mp4###video22031728889834.mp4###', 'audio56131727325499.mp3###audio48141727325504.mp3###audio92211727325509.mp3###audio97121727325516.mp3###audio32301727325524.mp3###', 1, 13, NULL, '2024-09-19 18:13:58', '2024-10-15 08:56:44'),
(89, 'درس پنجم: اعجاز بیانی قرآن (1)', NULL, 'فهرست مطالب درس  پنجم\nاستواری و درستی واژه‌ها	53\nآشنایی واژه‌ها	53', '0', NULL, 26, 38422, 'application55311728883156.pdf###', 'application28991729422342.pdf###', NULL, 'audio33571728973478.mp3###', 1, 6, NULL, '2024-10-14 08:49:22', '2024-10-20 14:35:51'),
(92, 'درس دوازدهم: وجه اعجاز قرآن در قرن پانزدهم', NULL, 'فهرست مطالب درس دوازدهم\n1. تبیین وجوه پیش‎گفتۀ اعجاز قرآن	171\n1 _ 1. سیدابوالقاسم خویی (م. 1413ق.)	171\n2 _ 1. محمدفاضل لنکرانی (م. 1428ق.)	173\n2. تأکید بر اعجاز بیانی	174\n1 _ 2. عايشه عبدالرحمان بنت الشاطی(م. 1419ق.)	174\n3. بیان وجوه جدید اعجاز قرآن	178\n1 _ 3. نظام صوتی یا نظم‎آهنگ قرآن کریم	178\n2 _ 3. اعجاز تأثیری	179\n3 _ 3. اعجاز عددی	181', '0', NULL, 14, 38421, 'application19271728890110.pdf###', 'application87351728902176.pdf###', NULL, NULL, 1, 12, NULL, '2024-10-14 10:45:18', '2024-10-15 10:18:59'),
(90, 'درس دهم: وجه اعجاز قرآن در قرن چهاردهم (1)', NULL, 'فهرست مطالب درس دهم\n1. تأکید بر اعجاز بیانی	139\n1 _ 1. مصطفی‎صادق رافعی (م. 1316ش.)	139\n2 _ 1. محمدعبدالله درّاز (م. 1337ش.)	141\n3 _ 1. محمدعبدالعظيم زرقانی (م. 1367ق.)	144\n2. تطبیق علوم تجربی بر قرآن کریم (اعجاز علمی قرآن)	145\n1 _ 2. سيدعبدالرحمن كواكبى‏ (م. 1320ق.)	147\n2 _ 2. شيخ‎محمد عبده‏ (م. 1323ق.)	148\n3 _ 2. محمدرشید رضا (م. 1354ق.)	148\n4 _ 2. طنطاوی جوهری (م. 1358ق.)	150\nبررسی دیدگاه افراطی در اعجاز علمی	151', '0', NULL, 20, 38421, 'application71591728890145.pdf###', 'application3711728902079.pdf###', NULL, NULL, 1, 10, NULL, '2024-10-14 10:39:21', '2024-10-15 10:20:28'),
(91, 'درس یازدهم: وجه اعجاز قرآن در قرن چهاردهم (2)', NULL, 'فهرست مطالب درس یازدهم\n3. بیان وجوه جدید اعجاز قرآن	158\n1 _ 3. صورتگری هنری	159\n2 _ 3. اعجاز تشریعی	163\n3 _ 3. دیدگاه همه‏جانبه‏نگر علامه طباطبایی&	164', '0', NULL, 22, 38421, 'application71921728890129.pdf###', 'application44031728902122.pdf###', NULL, NULL, 1, 11, NULL, '2024-10-14 10:41:06', '2024-10-15 10:19:26'),
(93, 'Sesstion 1: Imam Ali (a)', '60:30', 'Section 1: Imam Ali (a)\nPart A: Importance of knowing the Life of Imams\nPart B: Methods of Knowing Imam Ali (a)\nPart C: Familial Background of Amir al-Mu\'minin Ali\nPart D: One Question\nPart E: Muhammadan Reality\nPart F: Imam Ali’s Attributes and Virtues', '0', NULL, 26, 2, 'application78551729065107.pdf###', 'application67431729065110.pdf###', 'video76921729065115.mp4###video79191729065117.mp4###video36671729065119.mp4###video25721729065157.mp4###video50501729065158.mp4###video54221729065160.mp4###', 'audio65121729065166.mp3###audio41181729065166.mp3###audio56561729065169.mp3###audio98011729065176.mp3###audio57391729065178.mp3###audio60911729065183.mp3###', 1, 1, NULL, '2024-10-16 08:34:19', '2024-10-20 11:30:44'),
(94, 'Part B: Methods of Knowing Imam Ali (a)', '13:6', 'Introduction: \nWe will explain as much as we can the personality of Imam Ali (a) with three methods. But to know him correctly we must consider some fundamental issues, like the concept of infallibility.\n\nSummary: \nIn this part, we became familiar with the following issues:\n1: God almighty said in the Quran: “And taught him a knowledge from Our own” (18:65) (wa ‘allam­nâhô  melladonnâ’el­mâ ) accordingly the knowledge of Imams is a kind of divine knowledge.\n2:  We have three methods for knowing Imam Ali (a). The first one is the Historical analysis. Second is studying his attributes and virtues. And the 3rd one is studying his familial background, his children, parents and progeny.', '0', NULL, 2, 2, 'application54741729055197.pdf###', 'application62771729055202.pdf###', 'video36061729055205.mp4###', 'audio1481729055207.mp3###', 1, 2, '2024-10-16 11:19:26', '2024-10-16 08:36:49', '2024-10-16 11:19:26'),
(95, 'Part C: Familial Background of Amir al-Mu\'minin Ali', '15:53', 'In this part, we became familiar with the following issues:', '0', NULL, 0, 2, 'application66781729055565.pdf###', 'application85081729055567.pdf###', 'video13531729055696.mp4###', 'audio54821729055701.mp3###', 1, 3, '2024-10-16 11:19:24', '2024-10-16 08:45:28', '2024-10-16 11:19:24'),
(96, 'الدرس الاول', '1:00:00', 'بعد مطالعة هذا الدرس سنتعرف على الامور التالية:\n‌أ.	مكانة علم الكلام في العلوم والمعارف البشرية.\n‌ب.	مجالات البحث الديني.\n‌ج.	تعريف علم الكلام.\n‌د.	السبب في تسميته بعلم الكلام.', '0', NULL, 18, 1, 'application3091729057318.pdf###', 'application27591729057321.pdf###', 'video4711729057344.mp4###video79631729057355.mp4###video97211729057360.mp4###video84901729057369.mp4###video8221729057371.mp4###', 'audio36611729058736.mp3###audio61871729058738.mp3###audio45871729058739.mp3###audio72501729058741.mp3###audio13691729058744.mp3###', 1, 1, NULL, '2024-10-16 09:35:48', '2024-10-20 12:38:44');

-- --------------------------------------------------------

--
-- Table structure for table `learnpaths_files`
--

CREATE TABLE `learnpaths_files` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `learnPath_id` int(11) DEFAULT NULL,
  `file_category_id` int(11) DEFAULT NULL,
  `file_type_id` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `download_count` int(11) DEFAULT 0,
  `size` varchar(255) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `learnpath_view_user`
--

CREATE TABLE `learnpath_view_user` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `learnPath_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `view_count` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `learnpath_view_user`
--

INSERT INTO `learnpath_view_user` (`id`, `learnPath_id`, `user_id`, `view_count`, `created_at`, `updated_at`) VALUES
(1, 40, 63, 0, NULL, NULL),
(2, 40, 63, 0, NULL, NULL),
(3, 51, 63, 0, NULL, NULL),
(4, 51, 63, 0, NULL, NULL),
(5, 75, 132, 0, NULL, NULL),
(6, 75, 132, 0, NULL, NULL),
(7, 40, 89, 2, NULL, NULL),
(8, 40, 89, 2, NULL, NULL),
(9, 63, 30, 0, NULL, NULL),
(10, 63, 30, 0, NULL, NULL),
(11, 53, 132, 0, NULL, NULL),
(12, 53, 132, 0, NULL, NULL),
(13, 63, 112, 0, NULL, NULL),
(14, 63, 112, 0, NULL, NULL),
(15, 66, 111, 0, NULL, NULL),
(16, 66, 111, 0, NULL, NULL),
(17, 60, 132, 0, NULL, NULL),
(18, 60, 132, 0, NULL, NULL),
(19, 59, 132, 0, NULL, NULL),
(20, 59, 132, 0, NULL, NULL),
(21, 62, 132, 0, NULL, NULL),
(22, 62, 132, 0, NULL, NULL),
(23, 54, 132, 0, NULL, NULL),
(24, 54, 132, 0, NULL, NULL),
(25, 63, 135, 0, NULL, NULL),
(26, 63, 135, 0, NULL, NULL),
(27, 15, 66, 0, NULL, NULL),
(28, 15, 66, 0, NULL, NULL),
(29, 63, 120, 0, NULL, NULL),
(30, 63, 120, 0, NULL, NULL),
(31, 64, 131, 0, NULL, NULL),
(32, 64, 131, 0, NULL, NULL),
(33, 63, 82, 4, NULL, NULL),
(34, 63, 82, 4, NULL, NULL),
(35, 63, 82, 4, NULL, NULL),
(36, 63, 82, 4, NULL, NULL),
(37, 64, 30, 2, NULL, NULL),
(38, 64, 30, 2, NULL, NULL),
(39, 63, 122, 0, NULL, NULL),
(40, 63, 122, 0, NULL, NULL),
(41, 65, 122, 0, NULL, NULL),
(42, 65, 122, 0, NULL, NULL),
(43, 63, 122, 0, NULL, NULL),
(44, 63, 122, 0, NULL, NULL),
(45, 63, 122, 0, NULL, NULL),
(46, 63, 122, 0, NULL, NULL),
(47, 17, 122, 0, NULL, NULL),
(48, 17, 122, 0, NULL, NULL),
(49, 40, 63, 0, NULL, NULL),
(50, 40, 63, 0, NULL, NULL),
(51, 41, 63, 0, NULL, NULL),
(52, 41, 63, 0, NULL, NULL),
(53, 64, 63, 0, NULL, NULL),
(54, 64, 63, 0, NULL, NULL),
(55, 64, 63, 0, NULL, NULL),
(56, 64, 63, 0, NULL, NULL),
(57, 65, 63, 0, NULL, NULL),
(58, 65, 63, 0, NULL, NULL),
(59, 66, 63, 0, NULL, NULL),
(60, 66, 63, 0, NULL, NULL),
(61, 64, 63, 0, NULL, NULL),
(62, 64, 63, 0, NULL, NULL),
(63, 64, 63, 0, NULL, NULL),
(64, 64, 63, 0, NULL, NULL),
(65, 64, 114, 0, NULL, NULL),
(66, 64, 114, 0, NULL, NULL),
(67, 76, 132, 0, NULL, NULL),
(68, 76, 132, 0, NULL, NULL),
(69, 64, 114, 0, NULL, NULL),
(70, 64, 114, 0, NULL, NULL),
(71, 63, 66, 0, NULL, NULL),
(72, 63, 66, 0, NULL, NULL),
(73, 53, 82, 0, NULL, NULL),
(74, 53, 82, 0, NULL, NULL),
(75, 63, 113, 2, NULL, NULL),
(76, 63, 113, 2, NULL, NULL),
(77, 66, 30, 0, NULL, NULL),
(78, 66, 30, 0, NULL, NULL),
(79, 64, 30, 2, NULL, NULL),
(80, 64, 30, 2, NULL, NULL),
(81, 88, 121, 0, NULL, NULL),
(82, 88, 121, 0, NULL, NULL),
(83, 76, 121, 4, NULL, NULL),
(84, 76, 121, 4, NULL, NULL),
(85, 77, 121, 4, NULL, NULL),
(86, 77, 121, 4, NULL, NULL),
(87, 76, 128, 0, NULL, NULL),
(88, 76, 128, 0, NULL, NULL),
(89, 77, 66, 0, NULL, NULL),
(90, 77, 66, 0, NULL, NULL),
(91, 76, 66, 0, NULL, NULL),
(92, 76, 66, 0, NULL, NULL),
(93, 79, 128, 2, NULL, NULL),
(94, 79, 128, 2, NULL, NULL),
(95, 77, 95, 0, NULL, NULL),
(96, 77, 95, 0, NULL, NULL),
(97, 78, 95, 0, NULL, NULL),
(98, 78, 95, 0, NULL, NULL),
(99, 77, 103, 0, NULL, NULL),
(100, 77, 103, 0, NULL, NULL),
(101, 77, 104, 0, NULL, NULL),
(102, 77, 104, 0, NULL, NULL),
(103, 76, 112, 0, NULL, NULL),
(104, 76, 112, 0, NULL, NULL),
(105, 76, 112, 0, NULL, NULL),
(106, 76, 112, 0, NULL, NULL),
(107, 78, 114, 0, NULL, NULL),
(108, 78, 114, 0, NULL, NULL),
(109, 84, 114, 0, NULL, NULL),
(110, 84, 114, 0, NULL, NULL),
(111, 63, 93, 0, NULL, NULL),
(112, 63, 93, 0, NULL, NULL),
(113, 64, 93, 0, NULL, NULL),
(114, 64, 93, 0, NULL, NULL),
(115, 64, 82, 4, NULL, NULL),
(116, 64, 82, 4, NULL, NULL),
(117, 64, 82, 4, NULL, NULL),
(118, 64, 82, 4, NULL, NULL),
(119, 64, 82, 4, NULL, NULL),
(120, 64, 82, 4, NULL, NULL),
(121, 64, 82, 4, NULL, NULL),
(122, 64, 82, 4, NULL, NULL),
(123, 28, 108, 0, NULL, NULL),
(124, 28, 108, 0, NULL, NULL),
(125, 41, 114, 0, NULL, NULL),
(126, 41, 114, 0, NULL, NULL),
(127, 41, 116, 0, NULL, NULL),
(128, 41, 116, 0, NULL, NULL),
(129, 41, 114, 0, NULL, NULL),
(130, 41, 114, 0, NULL, NULL),
(131, 40, 93, 0, NULL, NULL),
(132, 40, 93, 0, NULL, NULL),
(133, 15, 93, 0, NULL, NULL),
(134, 15, 93, 0, NULL, NULL),
(135, 16, 116, 0, NULL, NULL),
(136, 16, 116, 0, NULL, NULL),
(137, 17, 112, 0, NULL, NULL),
(138, 17, 112, 0, NULL, NULL),
(139, 15, 116, 0, NULL, NULL),
(140, 15, 116, 0, NULL, NULL),
(141, 23, 68, 0, NULL, NULL),
(142, 23, 68, 0, NULL, NULL),
(143, 77, 82, 0, NULL, NULL),
(144, 77, 82, 0, NULL, NULL),
(145, 64, 111, 0, NULL, NULL),
(146, 64, 111, 0, NULL, NULL),
(147, 29, 86, 0, NULL, NULL),
(148, 29, 86, 0, NULL, NULL),
(149, 64, 125, 0, NULL, NULL),
(150, 64, 125, 0, NULL, NULL),
(151, 28, 116, 0, NULL, NULL),
(152, 28, 116, 0, NULL, NULL),
(153, 53, 99, 0, NULL, NULL),
(154, 53, 99, 0, NULL, NULL),
(155, 54, 99, 0, NULL, NULL),
(156, 54, 99, 0, NULL, NULL),
(157, 54, 90, 0, NULL, NULL),
(158, 54, 90, 0, NULL, NULL),
(159, 74, 90, 0, NULL, NULL),
(160, 74, 90, 0, NULL, NULL),
(161, 73, 90, 0, NULL, NULL),
(162, 73, 90, 0, NULL, NULL),
(163, 74, 90, 0, NULL, NULL),
(164, 74, 90, 0, NULL, NULL),
(165, 75, 90, 0, NULL, NULL),
(166, 75, 90, 0, NULL, NULL),
(167, 77, 82, 0, NULL, NULL),
(168, 77, 82, 0, NULL, NULL),
(169, 61, 90, 0, NULL, NULL),
(170, 61, 90, 0, NULL, NULL),
(171, 77, 131, 0, NULL, NULL),
(172, 77, 131, 0, NULL, NULL),
(173, 76, 131, 0, NULL, NULL),
(174, 76, 131, 0, NULL, NULL),
(175, 77, 131, 0, NULL, NULL),
(176, 77, 131, 0, NULL, NULL),
(177, 16, 131, 0, NULL, NULL),
(178, 16, 131, 0, NULL, NULL),
(179, 54, 119, 0, NULL, NULL),
(180, 54, 119, 0, NULL, NULL),
(181, 63, 108, 0, NULL, NULL),
(182, 63, 108, 0, NULL, NULL),
(183, 64, 112, 2, NULL, NULL),
(184, 64, 112, 2, NULL, NULL),
(185, 65, 112, 0, NULL, NULL),
(186, 65, 112, 0, NULL, NULL),
(187, 64, 128, 2, NULL, NULL),
(188, 64, 128, 2, NULL, NULL),
(189, 54, 104, 0, NULL, NULL),
(190, 54, 104, 0, NULL, NULL),
(191, 54, 104, 0, NULL, NULL),
(192, 54, 104, 0, NULL, NULL),
(193, 64, 131, 0, NULL, NULL),
(194, 64, 131, 0, NULL, NULL),
(195, 63, 95, 0, NULL, NULL),
(196, 63, 95, 0, NULL, NULL),
(197, 64, 95, 0, NULL, NULL),
(198, 64, 95, 0, NULL, NULL),
(199, 63, 82, 4, NULL, NULL),
(200, 63, 82, 4, NULL, NULL),
(201, 64, 82, 4, NULL, NULL),
(202, 64, 82, 4, NULL, NULL),
(203, 64, 116, 0, NULL, NULL),
(204, 64, 116, 0, NULL, NULL),
(205, 63, 64, 0, NULL, NULL),
(206, 63, 64, 0, NULL, NULL),
(207, 40, 64, 0, NULL, NULL),
(208, 40, 64, 0, NULL, NULL),
(209, 41, 64, 2, NULL, NULL),
(210, 41, 64, 2, NULL, NULL),
(211, 77, 128, 4, NULL, NULL),
(212, 77, 128, 4, NULL, NULL),
(213, 77, 128, 4, NULL, NULL),
(214, 77, 128, 4, NULL, NULL),
(215, 78, 128, 0, NULL, NULL),
(216, 78, 128, 0, NULL, NULL),
(217, 79, 128, 2, NULL, NULL),
(218, 79, 128, 2, NULL, NULL),
(219, 54, 125, 0, NULL, NULL),
(220, 54, 125, 0, NULL, NULL),
(221, 64, 113, 6, NULL, NULL),
(222, 64, 113, 6, NULL, NULL),
(223, 63, 1, 14, NULL, NULL),
(224, 63, 132, 6, NULL, NULL),
(225, 32, 132, 2, NULL, NULL),
(226, 41, 24, 2, NULL, NULL),
(227, 77, 98, 6, NULL, NULL),
(228, 88, 98, 2, NULL, NULL),
(229, 77, 85, 4, NULL, NULL),
(230, 76, 108, 2, NULL, NULL),
(231, 88, 85, 2, NULL, NULL),
(232, 53, 93, 2, NULL, NULL),
(233, 15, 128, 2, NULL, NULL),
(234, 63, 140, 4, NULL, NULL),
(235, 64, 71, 32, NULL, NULL),
(236, 65, 71, 4, NULL, NULL),
(237, 64, 140, 10, NULL, NULL),
(238, 54, 128, 8, NULL, NULL),
(239, 16, 128, 6, NULL, NULL),
(240, 15, 89, 2, NULL, NULL),
(241, 41, 66, 2, NULL, NULL),
(242, 42, 66, 2, NULL, NULL),
(243, 41, 121, 6, NULL, NULL),
(244, 42, 121, 2, NULL, NULL),
(245, 41, 113, 2, NULL, NULL),
(246, 42, 64, 2, NULL, NULL),
(247, 17, 64, 2, NULL, NULL),
(248, 16, 64, 2, NULL, NULL),
(249, 76, 30, 2, NULL, NULL),
(250, 77, 30, 2, NULL, NULL),
(251, 64, 19, 56, NULL, NULL),
(252, 65, 19, 40, NULL, NULL),
(253, 66, 19, 30, NULL, NULL),
(254, 71, 19, 18, NULL, NULL),
(255, 75, 19, 36, NULL, NULL),
(256, 77, 19, 52, NULL, NULL),
(257, 63, 19, 60, NULL, NULL),
(258, 54, 71, 6, NULL, NULL),
(259, 16, 71, 6, NULL, NULL),
(260, 64, 1, 10, NULL, NULL),
(261, 64, 132, 4, NULL, NULL),
(262, 66, 132, 4, NULL, NULL),
(263, 28, 128, 4, NULL, NULL),
(264, 29, 128, 6, NULL, NULL),
(265, 30, 128, 8, NULL, NULL),
(266, 29, 121, 10, NULL, NULL),
(267, 63, 106, 4, NULL, NULL),
(268, 65, 82, 2, NULL, NULL),
(269, 66, 82, 2, NULL, NULL),
(270, 67, 82, 2, NULL, NULL),
(271, 78, 30, 2, NULL, NULL),
(272, 66, 71, 2, NULL, NULL),
(273, 69, 71, 2, NULL, NULL),
(274, 73, 71, 2, NULL, NULL),
(275, 41, 71, 6, NULL, NULL),
(276, 55, 71, 4, NULL, NULL),
(277, 59, 71, 2, NULL, NULL),
(278, 57, 71, 2, NULL, NULL),
(279, 25, 71, 4, NULL, NULL),
(280, 54, 121, 4, NULL, NULL),
(281, 54, 112, 2, NULL, NULL),
(282, 55, 121, 2, NULL, NULL),
(283, 53, 106, 4, NULL, NULL),
(284, 55, 106, 4, NULL, NULL),
(285, 54, 106, 4, NULL, NULL),
(286, 53, 89, 2, NULL, NULL),
(287, 77, 1, 2, NULL, NULL),
(288, 76, 19, 42, NULL, NULL),
(289, 79, 19, 20, NULL, NULL),
(290, 82, 19, 24, NULL, NULL),
(291, 16, 19, 26, NULL, NULL),
(292, 19, 19, 26, NULL, NULL),
(293, 18, 19, 24, NULL, NULL),
(294, 29, 71, 4, NULL, NULL),
(295, 63, 71, 2, NULL, NULL),
(296, 67, 19, 24, NULL, NULL),
(297, 68, 19, 32, NULL, NULL),
(298, 70, 19, 22, NULL, NULL),
(299, 69, 19, 18, NULL, NULL),
(300, 72, 19, 26, NULL, NULL),
(301, 73, 19, 20, NULL, NULL),
(302, 74, 19, 20, NULL, NULL),
(303, 65, 1, 2, NULL, NULL),
(304, 73, 132, 2, NULL, NULL),
(305, 64, 146, 22, NULL, NULL),
(306, 63, 146, 32, NULL, NULL),
(307, 76, 146, 8, NULL, NULL),
(308, 78, 19, 38, NULL, NULL),
(309, 80, 19, 20, NULL, NULL),
(310, 81, 19, 20, NULL, NULL),
(311, 83, 19, 14, NULL, NULL),
(312, 84, 19, 20, NULL, NULL),
(313, 85, 19, 18, NULL, NULL),
(314, 86, 19, 16, NULL, NULL),
(315, 87, 19, 14, NULL, NULL),
(316, 88, 19, 16, NULL, NULL),
(317, 40, 19, 28, NULL, NULL),
(318, 41, 19, 22, NULL, NULL),
(319, 42, 19, 16, NULL, NULL),
(320, 43, 19, 14, NULL, NULL),
(321, 44, 19, 16, NULL, NULL),
(322, 45, 19, 16, NULL, NULL),
(323, 46, 19, 18, NULL, NULL),
(324, 47, 19, 18, NULL, NULL),
(325, 48, 19, 16, NULL, NULL),
(326, 49, 19, 28, NULL, NULL),
(327, 50, 19, 16, NULL, NULL),
(328, 51, 19, 14, NULL, NULL),
(329, 52, 19, 14, NULL, NULL),
(330, 28, 19, 34, NULL, NULL),
(331, 29, 19, 18, NULL, NULL),
(332, 30, 19, 18, NULL, NULL),
(333, 31, 19, 12, NULL, NULL),
(334, 32, 19, 14, NULL, NULL),
(335, 33, 19, 18, NULL, NULL),
(336, 77, 71, 4, NULL, NULL),
(337, 34, 19, 22, NULL, NULL),
(338, 35, 19, 14, NULL, NULL),
(339, 36, 19, 20, NULL, NULL),
(340, 37, 19, 14, NULL, NULL),
(341, 38, 19, 22, NULL, NULL),
(342, 39, 19, 20, NULL, NULL),
(343, 53, 19, 58, NULL, NULL),
(344, 54, 19, 38, NULL, NULL),
(345, 55, 19, 26, NULL, NULL),
(346, 56, 19, 40, NULL, NULL),
(347, 57, 19, 38, NULL, NULL),
(348, 58, 19, 32, NULL, NULL),
(349, 59, 19, 22, NULL, NULL),
(350, 60, 19, 26, NULL, NULL),
(351, 61, 19, 28, NULL, NULL),
(352, 62, 19, 30, NULL, NULL),
(353, 15, 19, 34, NULL, NULL),
(354, 17, 19, 22, NULL, NULL),
(355, 20, 19, 22, NULL, NULL),
(356, 21, 19, 20, NULL, NULL),
(357, 22, 19, 24, NULL, NULL),
(358, 23, 19, 20, NULL, NULL),
(359, 24, 19, 16, NULL, NULL),
(360, 25, 19, 16, NULL, NULL),
(361, 26, 19, 16, NULL, NULL),
(362, 27, 19, 22, NULL, NULL),
(363, 77, 146, 36, NULL, NULL),
(364, 65, 146, 10, NULL, NULL),
(365, 66, 146, 26, NULL, NULL),
(366, 67, 146, 8, NULL, NULL),
(367, 74, 146, 8, NULL, NULL),
(368, 68, 146, 6, NULL, NULL),
(369, 69, 146, 10, NULL, NULL),
(370, 70, 146, 4, NULL, NULL),
(371, 71, 146, 4, NULL, NULL),
(372, 72, 146, 2, NULL, NULL),
(373, 73, 146, 2, NULL, NULL),
(374, 75, 146, 8, NULL, NULL),
(375, 63, 89, 2, NULL, NULL),
(376, 64, 123, 2, NULL, NULL),
(377, 78, 146, 8, NULL, NULL),
(378, 80, 146, 8, NULL, NULL),
(379, 81, 146, 10, NULL, NULL),
(380, 82, 146, 18, NULL, NULL),
(381, 68, 71, 2, NULL, NULL),
(382, 75, 71, 2, NULL, NULL),
(383, 70, 71, 2, NULL, NULL),
(384, 84, 71, 2, NULL, NULL),
(385, 88, 71, 2, NULL, NULL),
(386, 52, 71, 4, NULL, NULL),
(387, 38, 71, 2, NULL, NULL),
(388, 34, 71, 6, NULL, NULL),
(389, 32, 71, 2, NULL, NULL),
(390, 61, 71, 4, NULL, NULL),
(391, 58, 71, 6, NULL, NULL),
(392, 27, 71, 6, NULL, NULL),
(393, 29, 136, 2, NULL, NULL),
(394, 80, 128, 2, NULL, NULL),
(395, 78, 116, 2, NULL, NULL),
(396, 89, 19, 22, NULL, NULL),
(397, 66, 78, 2, NULL, NULL),
(398, 66, 1, 2, NULL, NULL),
(399, 89, 1, 4, NULL, NULL),
(400, 29, 1, 6, NULL, NULL),
(401, 28, 1, 2, NULL, NULL),
(402, 31, 1, 2, NULL, NULL),
(403, 32, 1, 2, NULL, NULL),
(404, 79, 146, 4, NULL, NULL),
(405, 83, 146, 4, NULL, NULL),
(406, 84, 146, 4, NULL, NULL),
(407, 85, 146, 4, NULL, NULL),
(408, 86, 146, 4, NULL, NULL),
(409, 87, 146, 4, NULL, NULL),
(410, 88, 146, 4, NULL, NULL),
(411, 91, 19, 22, NULL, NULL),
(412, 90, 19, 20, NULL, NULL),
(413, 92, 19, 14, NULL, NULL),
(414, 39, 71, 2, NULL, NULL),
(415, 24, 71, 2, NULL, NULL),
(416, 36, 71, 2, NULL, NULL),
(417, 49, 71, 2, NULL, NULL),
(418, 80, 71, 2, NULL, NULL),
(419, 26, 71, 2, NULL, NULL),
(420, 50, 71, 2, NULL, NULL),
(421, 56, 71, 2, NULL, NULL),
(422, 20, 71, 6, NULL, NULL),
(423, 43, 121, 2, NULL, NULL),
(424, 43, 106, 6, NULL, NULL),
(425, 42, 106, 2, NULL, NULL),
(426, 44, 106, 2, NULL, NULL),
(427, 43, 128, 2, NULL, NULL),
(428, 16, 121, 6, NULL, NULL),
(429, 16, 106, 8, NULL, NULL),
(430, 15, 121, 4, NULL, NULL),
(431, 17, 121, 2, NULL, NULL),
(432, 17, 128, 4, NULL, NULL),
(433, 16, 54, 2, NULL, NULL),
(434, 81, 82, 2, NULL, NULL),
(435, 78, 82, 2, NULL, NULL),
(436, 80, 82, 2, NULL, NULL),
(437, 48, 82, 2, NULL, NULL),
(438, 30, 121, 8, NULL, NULL),
(439, 68, 113, 2, NULL, NULL),
(440, 75, 113, 2, NULL, NULL),
(441, 93, 71, 18, NULL, NULL),
(442, 94, 71, 2, NULL, NULL),
(443, 96, 71, 10, NULL, NULL),
(444, 55, 128, 2, NULL, NULL),
(445, 93, 1, 2, NULL, NULL),
(446, 96, 148, 8, NULL, NULL),
(447, 93, 148, 6, NULL, NULL),
(448, 40, 124, 4, NULL, NULL),
(449, 41, 124, 8, NULL, NULL),
(450, 17, 119, 2, NULL, NULL),
(451, 23, 119, 2, NULL, NULL),
(452, 29, 96, 2, NULL, NULL),
(453, 65, 128, 2, NULL, NULL),
(454, 42, 124, 2, NULL, NULL),
(455, 43, 124, 2, NULL, NULL),
(456, 77, 132, 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `online_classrooms`
--

CREATE TABLE `online_classrooms` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `creator_id` int(11) DEFAULT NULL COMMENT 'شناسه کاربر ثبت کننده',
  `editor_id` int(11) DEFAULT NULL COMMENT 'شناسه کاربر ویرایش کننده',
  `start_hour` varchar(255) DEFAULT NULL,
  `duration` varchar(255) DEFAULT NULL,
  `group` varchar(255) DEFAULT '0',
  `course_id` int(11) DEFAULT NULL,
  `presence_count` int(11) NOT NULL DEFAULT 0,
  `status_id` int(11) NOT NULL DEFAULT 1,
  `order` int(11) DEFAULT NULL,
  `is_cancel` varchar(2000) DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

--
-- Dumping data for table `online_classrooms`
--

INSERT INTO `online_classrooms` (`id`, `title`, `creator_id`, `editor_id`, `start_hour`, `duration`, `group`, `course_id`, `presence_count`, `status_id`, `order`, `is_cancel`, `date`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'جلسه 1', 1, NULL, '16:00', '60', '1403102', 31302, 32, 1, 1, NULL, '1403/07/07', NULL, '2024-09-25 21:54:27', '2024-09-28 16:56:36'),
(2, 'جلسه 2', 1, NULL, '16:00', '60', '1403102', 31302, 37, 1, 2, NULL, '1403/07/14', NULL, '2024-09-25 21:54:27', '2024-10-05 17:38:36'),
(3, 'جلسه 3', 1, NULL, '16:00', '60', '1403102', 31302, 30, 1, 3, NULL, '1403/07/21', NULL, '2024-09-25 21:54:27', '2024-10-12 16:54:04'),
(4, 'جلسه 4', 1, NULL, '16:00', '60', '1403102', 31302, 25, 1, 4, NULL, '1403/07/28', NULL, '2024-09-25 21:54:27', '2024-10-19 16:58:38'),
(5, 'جلسه 5', 1, NULL, '16:00', '60', '1403102', 31302, 0, 1, 5, NULL, '1403/08/05', NULL, '2024-09-25 21:54:27', NULL),
(6, 'جلسه 6', 1, NULL, '16:00', '60', '1403102', 31302, 0, 1, 6, NULL, '1403/08/12', NULL, '2024-09-25 21:54:27', NULL),
(7, 'جلسه 7', 1, NULL, '16:00', '60', '1403102', 31302, 0, 1, 7, NULL, '1403/08/19', NULL, '2024-09-25 21:54:27', NULL),
(8, 'جلسه 8', 1, NULL, '16:00', '60', '1403102', 31302, 0, 1, 8, NULL, '1403/08/26', NULL, '2024-09-25 21:54:27', NULL),
(9, 'جلسه 9', 1, NULL, '16:00', '60', '1403102', 31302, 0, 1, 9, NULL, '1403/09/03', NULL, '2024-09-25 21:54:27', NULL),
(10, 'جلسه 10', 1, NULL, '16:00', '60', '1403102', 31302, 0, 1, 10, NULL, '1403/09/10', NULL, '2024-09-25 21:54:27', NULL),
(11, 'جلسه 11', 1, NULL, '16:00', '60', '1403102', 31302, 0, 1, 11, NULL, '1403/09/17', NULL, '2024-09-25 21:54:27', NULL),
(12, 'جلسه 12', 1, NULL, '16:00', '60', '1403102', 31302, 0, 1, 12, NULL, '1403/09/24', NULL, '2024-09-25 21:54:27', NULL),
(13, 'جلسه 1', 1, NULL, '16:00', '60', '1403102', 31301, 39, 1, 1, NULL, '1403/07/08', NULL, '2024-09-25 21:54:27', '2024-09-29 17:13:36'),
(14, 'جلسه 2', 1, NULL, '16:00', '60', '1403102', 31301, 39, 1, 2, NULL, '1403/07/15', NULL, '2024-09-25 21:54:27', '2024-10-06 17:13:05'),
(15, 'جلسه 3', 1, NULL, '16:00', '60', '1403102', 31301, 38, 1, 3, NULL, '1403/07/22', NULL, '2024-09-25 21:54:27', '2024-10-13 17:00:26'),
(16, 'جلسه 4', 1, NULL, '16:00', '60', '1403102', 31301, 36, 1, 4, NULL, '1403/07/29', NULL, '2024-09-25 21:54:27', '2024-10-20 16:54:09'),
(17, 'جلسه 5', 1, NULL, '16:00', '60', '1403102', 31301, 0, 1, 5, NULL, '1403/08/06', NULL, '2024-09-25 21:54:27', NULL),
(18, 'جلسه 6', 1, NULL, '16:00', '60', '1403102', 31301, 0, 1, 6, NULL, '1403/08/13', NULL, '2024-09-25 21:54:27', NULL),
(19, 'جلسه 7', 1, NULL, '16:00', '60', '1403102', 31301, 0, 1, 7, NULL, '1403/08/20', NULL, '2024-09-25 21:54:27', NULL),
(20, 'جلسه 8', 1, NULL, '16:00', '60', '1403102', 31301, 0, 1, 8, NULL, '1403/08/27', NULL, '2024-09-25 21:54:27', NULL),
(21, 'جلسه 9', 1, NULL, '16:00', '60', '1403102', 31301, 0, 1, 9, NULL, '1403/09/04', NULL, '2024-09-25 21:54:27', NULL),
(22, 'جلسه 10', 1, NULL, '16:00', '60', '1403102', 31301, 0, 1, 10, NULL, '1403/09/11', NULL, '2024-09-25 21:54:27', NULL),
(23, 'جلسه 11', 1, NULL, '16:00', '60', '1403102', 31301, 0, 1, 11, NULL, '1403/09/18', NULL, '2024-09-25 21:54:27', NULL),
(24, 'جلسه 12', 1, NULL, '16:00', '60', '1403102', 31301, 0, 1, 12, NULL, '1403/09/25', NULL, '2024-09-25 21:54:27', NULL),
(25, 'جلسه 1', 1, NULL, '15:00', '60', '1403101', 38423, 42, 1, 1, NULL, '1403/07/09', NULL, '2024-09-25 21:54:27', '2024-09-30 16:20:17'),
(26, 'جلسه 2', 1, NULL, '15:00', '60', '1403101', 38423, 39, 1, 2, NULL, '1403/07/16', NULL, '2024-09-25 21:54:27', '2024-10-07 15:52:05'),
(27, 'جلسه 3', 1, NULL, '15:00', '60', '1403101', 38423, 43, 1, 3, NULL, '1403/07/23', NULL, '2024-09-25 21:54:27', '2024-10-14 15:59:43'),
(28, 'جلسه 4', 1, NULL, '15:00', '60', '1403101', 38423, 0, 1, 4, NULL, '1403/07/30', NULL, '2024-09-25 21:54:27', NULL),
(29, 'جلسه 5', 1, NULL, '15:00', '60', '1403101', 38423, 0, 1, 5, NULL, '1403/08/07', NULL, '2024-09-25 21:54:27', NULL),
(30, 'جلسه 6', 1, NULL, '15:00', '60', '1403101', 38423, 0, 1, 6, NULL, '1403/08/14', NULL, '2024-09-25 21:54:27', NULL),
(31, 'جلسه 7', 1, NULL, '15:00', '60', '1403101', 38423, 0, 1, 7, NULL, '1403/08/21', NULL, '2024-09-25 21:54:27', NULL),
(32, 'جلسه 8', 1, NULL, '15:00', '60', '1403101', 38423, 0, 1, 8, NULL, '1403/08/28', NULL, '2024-09-25 21:54:27', NULL),
(33, 'جلسه 9', 1, NULL, '15:00', '60', '1403101', 38423, 0, 1, 9, NULL, '1403/09/05', NULL, '2024-09-25 21:54:27', NULL),
(34, 'جلسه 10', 1, NULL, '15:00', '60', '1403101', 38423, 0, 1, 10, NULL, '1403/09/12', NULL, '2024-09-25 21:54:27', NULL),
(35, 'جلسه 11', 1, NULL, '15:00', '60', '1403101', 38423, 0, 1, 11, NULL, '1403/09/19', NULL, '2024-09-25 21:54:27', NULL),
(36, 'جلسه 12', 1, NULL, '15:00', '60', '1403101', 38423, 0, 1, 12, NULL, '1403/09/26', NULL, '2024-09-25 21:54:27', NULL),
(37, 'جلسه 1', 1, NULL, '16:00', '60', '1403101', 38309, 39, 1, 1, NULL, '1403/07/09', NULL, '2024-09-25 21:54:27', '2024-09-30 17:21:30'),
(38, 'جلسه 2', 1, NULL, '16:00', '60', '1403101', 38309, 40, 1, 2, NULL, '1403/07/16', NULL, '2024-09-25 21:54:27', '2024-10-07 16:57:28'),
(39, 'جلسه 3', 1, NULL, '16:00', '60', '1403101', 38309, 43, 1, 3, NULL, '1403/07/23', NULL, '2024-09-25 21:54:27', '2024-10-14 16:58:45'),
(40, 'جلسه 4', 1, NULL, '16:00', '60', '1403101', 38309, 0, 1, 4, NULL, '1403/07/30', NULL, '2024-09-25 21:54:27', NULL),
(41, 'جلسه 5', 1, NULL, '16:00', '60', '1403101', 38309, 0, 1, 5, NULL, '1403/08/07', NULL, '2024-09-25 21:54:27', NULL),
(42, 'جلسه 6', 1, NULL, '16:00', '60', '1403101', 38309, 0, 1, 6, NULL, '1403/08/14', NULL, '2024-09-25 21:54:27', NULL),
(43, 'جلسه 7', 1, NULL, '16:00', '60', '1403101', 38309, 0, 1, 7, NULL, '1403/08/21', NULL, '2024-09-25 21:54:27', NULL),
(44, 'جلسه 8', 1, NULL, '16:00', '60', '1403101', 38309, 0, 1, 8, NULL, '1403/08/28', NULL, '2024-09-25 21:54:27', NULL),
(45, 'جلسه 9', 1, NULL, '16:00', '60', '1403101', 38309, 0, 1, 9, NULL, '1403/09/05', NULL, '2024-09-25 21:54:27', NULL),
(46, 'جلسه 10', 1, NULL, '16:00', '60', '1403101', 38309, 0, 1, 10, NULL, '1403/09/12', NULL, '2024-09-25 21:54:27', NULL),
(47, 'جلسه 11', 1, NULL, '16:00', '60', '1403101', 38309, 0, 1, 11, NULL, '1403/09/19', NULL, '2024-09-25 21:54:27', NULL),
(48, 'جلسه 12', 1, NULL, '16:00', '60', '1403101', 38309, 0, 1, 12, NULL, '1403/09/26', NULL, '2024-09-25 21:54:27', NULL),
(49, 'جلسه 1', 1, NULL, '14:00', '60', '1403101', 38422, 37, 1, 1, NULL, '1403/07/10', NULL, '2024-09-25 21:54:27', '2024-10-01 15:02:07'),
(50, 'جلسه 2', 1, NULL, '14:00', '60', '1403101', 38422, 38, 1, 2, NULL, '1403/07/17', NULL, '2024-09-25 21:54:27', '2024-10-08 15:00:01'),
(51, 'جلسه 3', 1, NULL, '14:00', '60', '1403101', 38422, 41, 1, 3, NULL, '1403/07/24', NULL, '2024-09-25 21:54:27', '2024-10-15 15:13:35'),
(52, 'جلسه 4', 1, NULL, '14:00', '60', '1403101', 38422, 0, 1, 4, NULL, '1403/08/01', NULL, '2024-09-25 21:54:27', NULL),
(53, 'جلسه 5', 1, NULL, '14:00', '60', '1403101', 38422, 0, 1, 5, NULL, '1403/08/08', NULL, '2024-09-25 21:54:27', NULL),
(54, 'جلسه 6', 1, NULL, '14:00', '60', '1403101', 38422, 0, 1, 6, NULL, '1403/08/15', NULL, '2024-09-25 21:54:27', NULL),
(55, 'جلسه 7', 1, NULL, '14:00', '60', '1403101', 38422, 0, 1, 7, NULL, '1403/08/22', NULL, '2024-09-25 21:54:27', NULL),
(56, 'جلسه 8', 1, NULL, '14:00', '60', '1403101', 38422, 0, 1, 8, NULL, '1403/08/29', NULL, '2024-09-25 21:54:27', NULL),
(57, 'جلسه 9', 1, NULL, '14:00', '60', '1403101', 38422, 0, 1, 9, NULL, '1403/09/06', NULL, '2024-09-25 21:54:27', NULL),
(58, 'جلسه 10', 1, NULL, '14:00', '60', '1403101', 38422, 0, 1, 10, NULL, '1403/09/13', NULL, '2024-09-25 21:54:27', NULL),
(59, 'جلسه 11', 1, NULL, '14:00', '60', '1403101', 38422, 0, 1, 11, NULL, '1403/09/20', NULL, '2024-09-25 21:54:27', NULL),
(60, 'جلسه 12', 1, NULL, '14:00', '60', '1403101', 38422, 0, 1, 12, NULL, '1403/09/27', NULL, '2024-09-25 21:54:27', NULL),
(61, 'جلسه 1', 1, NULL, '15:00', '60', '1403101', 38421, 21, 1, 1, NULL, '1403/07/11', NULL, '2024-09-25 21:54:27', '2024-10-02 16:44:50'),
(62, 'جلسه 2', 1, NULL, '15:00', '60', '1403101', 38421, 44, 1, 2, NULL, '1403/07/18', NULL, '2024-09-25 21:54:27', '2024-10-09 16:14:45'),
(63, 'جلسه 3', 1, NULL, '15:00', '60', '1403101', 38421, 42, 1, 3, NULL, '1403/07/25', NULL, '2024-09-25 21:54:27', '2024-10-16 15:55:42'),
(64, 'جلسه 4', 1, NULL, '15:00', '60', '1403101', 38421, 0, 1, 4, NULL, '1403/08/02', NULL, '2024-09-25 21:54:27', NULL),
(65, 'جلسه 5', 1, NULL, '15:00', '60', '1403101', 38421, 0, 1, 5, NULL, '1403/08/09', NULL, '2024-09-25 21:54:27', NULL),
(66, 'جلسه 6', 1, NULL, '15:00', '60', '1403101', 38421, 0, 1, 6, NULL, '1403/08/16', NULL, '2024-09-25 21:54:27', NULL),
(67, 'جلسه 7', 1, NULL, '15:00', '60', '1403101', 38421, 0, 1, 7, NULL, '1403/08/23', NULL, '2024-09-25 21:54:27', NULL),
(68, 'جلسه 8', 1, NULL, '15:00', '60', '1403101', 38421, 0, 1, 8, NULL, '1403/08/30', NULL, '2024-09-25 21:54:27', NULL),
(69, 'جلسه 9', 1, NULL, '15:00', '60', '1403101', 38421, 0, 1, 9, NULL, '1403/09/07', NULL, '2024-09-25 21:54:27', NULL),
(70, 'جلسه 10', 1, NULL, '15:00', '60', '1403101', 38421, 0, 1, 10, NULL, '1403/09/14', NULL, '2024-09-25 21:54:27', NULL),
(71, 'جلسه 11', 1, NULL, '15:00', '60', '1403101', 38421, 0, 1, 11, NULL, '1403/09/21', NULL, '2024-09-25 21:54:27', NULL),
(72, 'جلسه 12', 1, NULL, '15:00', '60', '1403101', 38421, 0, 1, 12, NULL, '1403/09/28', NULL, '2024-09-25 21:54:27', NULL),
(73, 'جلسه تست همکاران', 1, NULL, '14:00', '60', '1403101', 11111, 0, 1, 1, NULL, '1403/07/08', NULL, '2024-09-29 14:29:42', '2024-09-29 14:29:42'),
(74, 'test', 1, NULL, '07:00', '60', '0', 11111, 1, 1, NULL, NULL, '1403/07/12', NULL, '2024-10-03 07:42:27', '2024-10-03 07:42:33'),
(75, 'جلسه تست 15 مهر', 18, NULL, '16:00', '45', '1403101', 11111, 1, 1, 3, NULL, '1403/07/16', NULL, '2024-10-07 16:23:54', '2024-10-07 16:48:54'),
(76, 'جلسه دوم مهرماه', 18, NULL, '16:30', '45:00', '1403101', 11111, 1, 1, 4, NULL, '1403/07/16', NULL, '2024-10-07 16:49:59', '2024-10-07 16:53:35'),
(77, 'Session 1', 71, NULL, '10:10', '50', '0', 2, 0, 1, 1, NULL, '1403/07/24', NULL, '2024-10-16 09:51:21', '2024-10-16 09:51:21'),
(78, 'Session 2', 71, NULL, '10:10', '50', '0', 2, 0, 1, 2, NULL, '1403/07/26', NULL, '2024-10-16 09:51:51', '2024-10-16 09:51:51'),
(79, 'الجلسة الاولی', 71, NULL, '13:00', '90', '0', 1, 0, 1, 1, NULL, '1403/07/18', NULL, '2024-10-16 09:52:51', '2024-10-16 09:52:51'),
(80, 'الجلسة الثانیة', 71, NULL, '15:00', '90', '0', 1, 0, 1, 2, NULL, '1403/07/27', NULL, '2024-10-16 09:53:19', '2024-10-16 09:53:19');

-- --------------------------------------------------------

--
-- Table structure for table `online_classroom_archive_files`
--

CREATE TABLE `online_classroom_archive_files` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `onlineClassroom_id` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `download_count` int(11) DEFAULT NULL,
  `size` varchar(255) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `online_classroom_user`
--

CREATE TABLE `online_classroom_user` (
  `user_id` int(11) NOT NULL,
  `onlineClassroom_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `presence_date` varchar(10) DEFAULT NULL,
  `presence_time` varchar(6) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

--
-- Dumping data for table `online_classroom_user`
--

INSERT INTO `online_classroom_user` (`user_id`, `onlineClassroom_id`, `created_at`, `presence_date`, `presence_time`, `updated_at`) VALUES
(1, 1, '2024-09-28 16:50:02', '1403/07/07', '16:00', '2024-09-28 16:50:02'),
(121, 1, '2024-09-28 16:50:28', '1403/07/07', '16:00', '2024-09-28 16:50:28'),
(128, 1, '2024-09-28 16:55:18', '1403/07/07', '16:00', '2024-09-28 16:55:18'),
(78, 1, '2024-09-28 16:55:42', '1403/07/07', '16:00', '2024-09-28 16:55:42'),
(100, 1, '2024-09-28 17:00:15', '1403/07/07', '16:00', '2024-09-28 17:00:15'),
(30, 1, '2024-09-28 17:00:22', '1403/07/07', '16:00', '2024-09-28 17:00:22'),
(108, 1, '2024-09-28 17:00:36', '1403/07/07', '16:00', '2024-09-28 17:00:36'),
(122, 1, '2024-09-28 17:01:55', '1403/07/07', '16:00', '2024-09-28 17:01:55'),
(113, 1, '2024-09-28 17:04:02', '1403/07/07', '16:00', '2024-09-28 17:04:02'),
(107, 1, '2024-09-28 17:06:12', '1403/07/07', '16:00', '2024-09-28 17:06:12'),
(96, 1, '2024-09-28 17:06:30', '1403/07/07', '16:00', '2024-09-28 17:06:30'),
(28, 1, '2024-09-28 17:06:52', '1403/07/07', '16:00', '2024-09-28 17:06:52'),
(132, 1, '2024-09-28 17:11:39', '1403/07/07', '16:00', '2024-09-28 17:11:39'),
(66, 1, '2024-09-28 17:13:03', '1403/07/07', '16:00', '2024-09-28 17:13:03'),
(95, 1, '2024-09-28 17:13:27', '1403/07/07', '16:00', '2024-09-28 17:13:27'),
(90, 1, '2024-09-28 17:13:46', '1403/07/07', '16:00', '2024-09-28 17:13:46'),
(103, 1, '2024-09-28 17:14:12', '1403/07/07', '16:00', '2024-09-28 17:14:12'),
(112, 1, '2024-09-28 17:14:13', '1403/07/07', '16:00', '2024-09-28 17:14:13'),
(114, 1, '2024-09-28 17:14:32', '1403/07/07', '16:00', '2024-09-28 17:14:32'),
(116, 1, '2024-09-28 17:14:34', '1403/07/07', '16:00', '2024-09-28 17:14:34'),
(93, 1, '2024-09-28 17:14:43', '1403/07/07', '16:00', '2024-09-28 17:14:43'),
(97, 1, '2024-09-28 17:16:54', '1403/07/07', '16:00', '2024-09-28 17:16:54'),
(85, 1, '2024-09-28 17:19:01', '1403/07/07', '16:00', '2024-09-28 17:19:01'),
(106, 1, '2024-09-28 17:21:34', '1403/07/07', '16:00', '2024-09-28 17:21:34'),
(123, 1, '2024-09-28 17:21:55', '1403/07/07', '16:00', '2024-09-28 17:21:55'),
(84, 1, '2024-09-28 17:24:09', '1403/07/07', '16:00', '2024-09-28 17:24:09'),
(102, 1, '2024-09-28 17:28:29', '1403/07/07', '16:00', '2024-09-28 17:28:29'),
(67, 1, '2024-09-28 17:38:29', '1403/07/07', '16:00', '2024-09-28 17:38:29'),
(61, 1, '2024-09-28 17:38:48', '1403/07/07', '16:00', '2024-09-28 17:38:48'),
(82, 1, '2024-09-28 17:39:24', '1403/07/07', '16:00', '2024-09-28 17:39:24'),
(109, 1, '2024-09-28 17:55:14', '1403/07/07', '16:00', '2024-09-28 17:55:14'),
(131, 1, '2024-09-28 17:55:26', '1403/07/07', '16:00', '2024-09-28 17:55:26'),
(78, 13, '2024-09-29 16:47:38', '1403/07/08', '16:00', '2024-09-29 16:47:38'),
(97, 13, '2024-09-29 16:48:11', '1403/07/08', '16:00', '2024-09-29 16:48:11'),
(109, 13, '2024-09-29 16:51:00', '1403/07/08', '16:00', '2024-09-29 16:51:00'),
(100, 13, '2024-09-29 16:51:46', '1403/07/08', '16:00', '2024-09-29 16:51:46'),
(114, 13, '2024-09-29 16:53:27', '1403/07/08', '16:00', '2024-09-29 16:53:27'),
(67, 13, '2024-09-29 16:53:56', '1403/07/08', '16:00', '2024-09-29 16:53:56'),
(119, 13, '2024-09-29 16:55:18', '1403/07/08', '16:00', '2024-09-29 16:55:18'),
(103, 13, '2024-09-29 16:55:45', '1403/07/08', '16:00', '2024-09-29 16:55:45'),
(1, 13, '2024-09-29 16:56:15', '1403/07/08', '16:00', '2024-09-29 16:56:15'),
(90, 13, '2024-09-29 16:56:16', '1403/07/08', '16:00', '2024-09-29 16:56:16'),
(61, 13, '2024-09-29 16:56:53', '1403/07/08', '16:00', '2024-09-29 16:56:53'),
(122, 13, '2024-09-29 16:57:32', '1403/07/08', '16:00', '2024-09-29 16:57:32'),
(99, 13, '2024-09-29 16:57:34', '1403/07/08', '16:00', '2024-09-29 16:57:34'),
(132, 13, '2024-09-29 16:57:43', '1403/07/08', '16:00', '2024-09-29 16:57:43'),
(84, 13, '2024-09-29 16:59:40', '1403/07/08', '16:00', '2024-09-29 16:59:40'),
(121, 13, '2024-09-29 16:59:44', '1403/07/08', '16:00', '2024-09-29 16:59:44'),
(128, 13, '2024-09-29 17:00:50', '1403/07/08', '16:00', '2024-09-29 17:00:50'),
(95, 13, '2024-09-29 17:01:25', '1403/07/08', '16:00', '2024-09-29 17:01:25'),
(123, 13, '2024-09-29 17:01:25', '1403/07/08', '16:00', '2024-09-29 17:01:25'),
(106, 13, '2024-09-29 17:01:49', '1403/07/08', '16:00', '2024-09-29 17:01:49'),
(111, 13, '2024-09-29 17:02:14', '1403/07/08', '16:00', '2024-09-29 17:02:14'),
(82, 13, '2024-09-29 17:02:52', '1403/07/08', '16:00', '2024-09-29 17:02:52'),
(104, 13, '2024-09-29 17:03:56', '1403/07/08', '16:00', '2024-09-29 17:03:56'),
(98, 13, '2024-09-29 17:03:58', '1403/07/08', '16:00', '2024-09-29 17:03:58'),
(64, 13, '2024-09-29 17:04:03', '1403/07/08', '16:00', '2024-09-29 17:04:03'),
(112, 13, '2024-09-29 17:05:24', '1403/07/08', '16:00', '2024-09-29 17:05:24'),
(117, 13, '2024-09-29 17:05:26', '1403/07/08', '16:00', '2024-09-29 17:05:26'),
(136, 13, '2024-09-29 17:05:31', '1403/07/08', '16:00', '2024-09-29 17:05:31'),
(62, 13, '2024-09-29 17:05:42', '1403/07/08', '16:00', '2024-09-29 17:05:42'),
(110, 13, '2024-09-29 17:10:14', '1403/07/08', '16:00', '2024-09-29 17:10:14'),
(27, 13, '2024-09-29 17:11:21', '1403/07/08', '16:00', '2024-09-29 17:11:21'),
(66, 13, '2024-09-29 17:11:31', '1403/07/08', '16:00', '2024-09-29 17:11:31'),
(108, 13, '2024-09-29 17:11:47', '1403/07/08', '16:00', '2024-09-29 17:11:47'),
(116, 13, '2024-09-29 17:12:49', '1403/07/08', '16:00', '2024-09-29 17:12:49'),
(30, 13, '2024-09-29 17:19:00', '1403/07/08', '16:00', '2024-09-29 17:19:00'),
(85, 13, '2024-09-29 17:20:28', '1403/07/08', '16:00', '2024-09-29 17:20:28'),
(118, 13, '2024-09-29 17:21:38', '1403/07/08', '16:00', '2024-09-29 17:21:38'),
(113, 13, '2024-09-29 17:25:58', '1403/07/08', '16:00', '2024-09-29 17:25:58'),
(96, 13, '2024-09-29 17:32:15', '1403/07/08', '16:00', '2024-09-29 17:32:15'),
(108, 25, '2024-09-30 15:45:46', '1403/07/09', '15:00', '2024-09-30 15:45:46'),
(100, 25, '2024-09-30 15:47:33', '1403/07/09', '15:00', '2024-09-30 15:47:33'),
(103, 25, '2024-09-30 15:51:55', '1403/07/09', '15:00', '2024-09-30 15:51:55'),
(112, 25, '2024-09-30 15:54:23', '1403/07/09', '15:00', '2024-09-30 15:54:23'),
(109, 25, '2024-09-30 15:54:23', '1403/07/09', '15:00', '2024-09-30 15:54:23'),
(98, 25, '2024-09-30 15:54:30', '1403/07/09', '15:00', '2024-09-30 15:54:30'),
(119, 25, '2024-09-30 15:54:49', '1403/07/09', '15:00', '2024-09-30 15:54:49'),
(95, 25, '2024-09-30 15:56:40', '1403/07/09', '15:00', '2024-09-30 15:56:40'),
(90, 25, '2024-09-30 15:57:06', '1403/07/09', '15:00', '2024-09-30 15:57:06'),
(113, 25, '2024-09-30 15:57:12', '1403/07/09', '15:00', '2024-09-30 15:57:12'),
(61, 25, '2024-09-30 15:57:16', '1403/07/09', '15:00', '2024-09-30 15:57:16'),
(122, 25, '2024-09-30 15:57:21', '1403/07/09', '15:00', '2024-09-30 15:57:21'),
(132, 25, '2024-09-30 15:58:10', '1403/07/09', '15:00', '2024-09-30 15:58:10'),
(62, 25, '2024-09-30 15:59:23', '1403/07/09', '15:00', '2024-09-30 15:59:23'),
(89, 25, '2024-09-30 16:00:22', '1403/07/09', '15:00', '2024-09-30 16:00:22'),
(64, 25, '2024-09-30 16:01:10', '1403/07/09', '15:00', '2024-09-30 16:01:10'),
(123, 25, '2024-09-30 16:01:22', '1403/07/09', '15:00', '2024-09-30 16:01:22'),
(111, 25, '2024-09-30 16:01:30', '1403/07/09', '15:00', '2024-09-30 16:01:30'),
(84, 25, '2024-09-30 16:01:39', '1403/07/09', '15:00', '2024-09-30 16:01:39'),
(67, 25, '2024-09-30 16:02:15', '1403/07/09', '15:00', '2024-09-30 16:02:15'),
(107, 25, '2024-09-30 16:02:32', '1403/07/09', '15:00', '2024-09-30 16:02:32'),
(116, 25, '2024-09-30 16:02:39', '1403/07/09', '15:00', '2024-09-30 16:02:39'),
(85, 25, '2024-09-30 16:03:08', '1403/07/09', '15:00', '2024-09-30 16:03:08'),
(96, 25, '2024-09-30 16:03:23', '1403/07/09', '15:00', '2024-09-30 16:03:23'),
(114, 25, '2024-09-30 16:04:02', '1403/07/09', '15:00', '2024-09-30 16:04:02'),
(99, 25, '2024-09-30 16:04:11', '1403/07/09', '15:00', '2024-09-30 16:04:11'),
(66, 25, '2024-09-30 16:04:57', '1403/07/09', '15:00', '2024-09-30 16:04:57'),
(97, 25, '2024-09-30 16:05:14', '1403/07/09', '15:00', '2024-09-30 16:05:14'),
(106, 25, '2024-09-30 16:05:39', '1403/07/09', '15:00', '2024-09-30 16:05:39'),
(131, 25, '2024-09-30 16:10:51', '1403/07/09', '15:00', '2024-09-30 16:10:51'),
(82, 25, '2024-09-30 16:12:20', '1403/07/09', '15:00', '2024-09-30 16:12:20'),
(117, 25, '2024-09-30 16:14:58', '1403/07/09', '15:00', '2024-09-30 16:14:58'),
(86, 25, '2024-09-30 16:15:23', '1403/07/09', '15:00', '2024-09-30 16:15:23'),
(78, 25, '2024-09-30 16:17:26', '1403/07/09', '15:00', '2024-09-30 16:17:26'),
(102, 25, '2024-09-30 16:21:46', '1403/07/09', '15:00', '2024-09-30 16:21:46'),
(24, 25, '2024-09-30 16:27:04', '1403/07/09', '15:00', '2024-09-30 16:27:04'),
(68, 25, '2024-09-30 16:28:33', '1403/07/09', '15:00', '2024-09-30 16:28:33'),
(118, 25, '2024-09-30 16:32:24', '1403/07/09', '15:00', '2024-09-30 16:32:24'),
(110, 25, '2024-09-30 16:34:36', '1403/07/09', '15:00', '2024-09-30 16:34:36'),
(128, 25, '2024-09-30 16:37:18', '1403/07/09', '15:00', '2024-09-30 16:37:18'),
(91, 25, '2024-09-30 16:38:29', '1403/07/09', '15:00', '2024-09-30 16:38:29'),
(98, 37, '2024-09-30 16:51:53', '1403/07/09', '16:00', '2024-09-30 16:51:53'),
(64, 37, '2024-09-30 16:54:40', '1403/07/09', '16:00', '2024-09-30 16:54:40'),
(96, 37, '2024-09-30 16:54:43', '1403/07/09', '16:00', '2024-09-30 16:54:43'),
(121, 25, '2024-09-30 16:56:54', '1403/07/09', '15:00', '2024-09-30 16:56:54'),
(90, 37, '2024-09-30 16:57:49', '1403/07/09', '16:00', '2024-09-30 16:57:49'),
(122, 37, '2024-09-30 16:58:04', '1403/07/09', '16:00', '2024-09-30 16:58:04'),
(100, 37, '2024-09-30 16:58:19', '1403/07/09', '16:00', '2024-09-30 16:58:19'),
(109, 37, '2024-09-30 16:58:33', '1403/07/09', '16:00', '2024-09-30 16:58:33'),
(107, 37, '2024-09-30 16:59:08', '1403/07/09', '16:00', '2024-09-30 16:59:08'),
(89, 37, '2024-09-30 16:59:11', '1403/07/09', '16:00', '2024-09-30 16:59:11'),
(103, 37, '2024-09-30 16:59:13', '1403/07/09', '16:00', '2024-09-30 16:59:13'),
(119, 37, '2024-09-30 16:59:18', '1403/07/09', '16:00', '2024-09-30 16:59:18'),
(66, 37, '2024-09-30 16:59:21', '1403/07/09', '16:00', '2024-09-30 16:59:21'),
(111, 37, '2024-09-30 16:59:21', '1403/07/09', '16:00', '2024-09-30 16:59:21'),
(67, 37, '2024-09-30 16:59:22', '1403/07/09', '16:00', '2024-09-30 16:59:22'),
(121, 37, '2024-09-30 16:59:30', '1403/07/09', '16:00', '2024-09-30 16:59:30'),
(82, 37, '2024-09-30 16:59:34', '1403/07/09', '16:00', '2024-09-30 16:59:34'),
(61, 37, '2024-09-30 16:59:40', '1403/07/09', '16:00', '2024-09-30 16:59:40'),
(108, 37, '2024-09-30 16:59:50', '1403/07/09', '16:00', '2024-09-30 16:59:50'),
(117, 37, '2024-09-30 16:59:56', '1403/07/09', '16:00', '2024-09-30 16:59:56'),
(99, 37, '2024-09-30 17:00:05', '1403/07/09', '16:00', '2024-09-30 17:00:05'),
(84, 37, '2024-09-30 17:00:16', '1403/07/09', '16:00', '2024-09-30 17:00:16'),
(112, 37, '2024-09-30 17:00:57', '1403/07/09', '16:00', '2024-09-30 17:00:57'),
(95, 37, '2024-09-30 17:01:32', '1403/07/09', '16:00', '2024-09-30 17:01:32'),
(113, 37, '2024-09-30 17:01:45', '1403/07/09', '16:00', '2024-09-30 17:01:45'),
(91, 37, '2024-09-30 17:02:25', '1403/07/09', '16:00', '2024-09-30 17:02:25'),
(128, 37, '2024-09-30 17:02:32', '1403/07/09', '16:00', '2024-09-30 17:02:32'),
(114, 37, '2024-09-30 17:04:06', '1403/07/09', '16:00', '2024-09-30 17:04:06'),
(123, 37, '2024-09-30 17:04:15', '1403/07/09', '16:00', '2024-09-30 17:04:15'),
(106, 37, '2024-09-30 17:06:10', '1403/07/09', '16:00', '2024-09-30 17:06:10'),
(116, 37, '2024-09-30 17:06:35', '1403/07/09', '16:00', '2024-09-30 17:06:35'),
(86, 37, '2024-09-30 17:06:55', '1403/07/09', '16:00', '2024-09-30 17:06:55'),
(131, 37, '2024-09-30 17:07:39', '1403/07/09', '16:00', '2024-09-30 17:07:39'),
(93, 37, '2024-09-30 17:15:56', '1403/07/09', '16:00', '2024-09-30 17:15:56'),
(68, 37, '2024-09-30 17:17:01', '1403/07/09', '16:00', '2024-09-30 17:17:01'),
(85, 37, '2024-09-30 17:18:58', '1403/07/09', '16:00', '2024-09-30 17:18:58'),
(78, 37, '2024-09-30 17:22:55', '1403/07/09', '16:00', '2024-09-30 17:22:55'),
(110, 37, '2024-09-30 17:44:21', '1403/07/09', '16:00', '2024-09-30 17:44:21'),
(21, 37, '2024-09-30 17:46:00', '1403/07/09', '16:00', '2024-09-30 17:46:00'),
(118, 37, '2024-09-30 17:57:07', '1403/07/09', '16:00', '2024-09-30 17:57:07'),
(112, 49, '2024-10-01 14:52:32', '1403/07/10', '14:00', '2024-10-01 14:52:32'),
(109, 49, '2024-10-01 14:53:21', '1403/07/10', '14:00', '2024-10-01 14:53:21'),
(119, 49, '2024-10-01 14:54:03', '1403/07/10', '14:00', '2024-10-01 14:54:03'),
(52, 49, '2024-10-01 14:55:56', '1403/07/10', '14:00', '2024-10-01 14:55:56'),
(23, 49, '2024-10-01 14:56:12', '1403/07/10', '14:00', '2024-10-01 14:56:12'),
(97, 49, '2024-10-01 14:56:23', '1403/07/10', '14:00', '2024-10-01 14:56:23'),
(113, 49, '2024-10-01 14:58:20', '1403/07/10', '14:00', '2024-10-01 14:58:20'),
(90, 49, '2024-10-01 14:58:22', '1403/07/10', '14:00', '2024-10-01 14:58:22'),
(122, 49, '2024-10-01 14:59:48', '1403/07/10', '14:00', '2024-10-01 14:59:48'),
(128, 49, '2024-10-01 14:59:56', '1403/07/10', '14:00', '2024-10-01 14:59:56'),
(82, 49, '2024-10-01 15:00:07', '1403/07/10', '14:00', '2024-10-01 15:00:07'),
(89, 49, '2024-10-01 15:00:17', '1403/07/10', '14:00', '2024-10-01 15:00:17'),
(121, 49, '2024-10-01 15:00:22', '1403/07/10', '14:00', '2024-10-01 15:00:22'),
(123, 49, '2024-10-01 15:00:31', '1403/07/10', '14:00', '2024-10-01 15:00:31'),
(103, 49, '2024-10-01 15:01:02', '1403/07/10', '14:00', '2024-10-01 15:01:02'),
(132, 49, '2024-10-01 15:01:13', '1403/07/10', '14:00', '2024-10-01 15:01:13'),
(61, 49, '2024-10-01 15:01:33', '1403/07/10', '14:00', '2024-10-01 15:01:33'),
(78, 49, '2024-10-01 15:01:37', '1403/07/10', '14:00', '2024-10-01 15:01:37'),
(117, 49, '2024-10-01 15:02:11', '1403/07/10', '14:00', '2024-10-01 15:02:11'),
(100, 49, '2024-10-01 15:02:15', '1403/07/10', '14:00', '2024-10-01 15:02:15'),
(86, 49, '2024-10-01 15:02:39', '1403/07/10', '14:00', '2024-10-01 15:02:39'),
(91, 49, '2024-10-01 15:02:58', '1403/07/10', '14:00', '2024-10-01 15:02:58'),
(85, 49, '2024-10-01 15:03:19', '1403/07/10', '14:00', '2024-10-01 15:03:19'),
(67, 49, '2024-10-01 15:04:22', '1403/07/10', '14:00', '2024-10-01 15:04:22'),
(96, 49, '2024-10-01 15:04:36', '1403/07/10', '14:00', '2024-10-01 15:04:36'),
(107, 49, '2024-10-01 15:04:45', '1403/07/10', '14:00', '2024-10-01 15:04:45'),
(84, 49, '2024-10-01 15:04:48', '1403/07/10', '14:00', '2024-10-01 15:04:48'),
(95, 49, '2024-10-01 15:04:58', '1403/07/10', '14:00', '2024-10-01 15:04:58'),
(116, 49, '2024-10-01 15:05:37', '1403/07/10', '14:00', '2024-10-01 15:05:37'),
(111, 49, '2024-10-01 15:05:49', '1403/07/10', '14:00', '2024-10-01 15:05:49'),
(66, 49, '2024-10-01 15:08:35', '1403/07/10', '14:00', '2024-10-01 15:08:35'),
(114, 49, '2024-10-01 15:09:00', '1403/07/10', '14:00', '2024-10-01 15:09:00'),
(68, 49, '2024-10-01 15:17:18', '1403/07/10', '14:00', '2024-10-01 15:17:18'),
(62, 49, '2024-10-01 15:21:30', '1403/07/10', '14:00', '2024-10-01 15:21:30'),
(106, 49, '2024-10-01 15:24:08', '1403/07/10', '14:00', '2024-10-01 15:24:08'),
(98, 49, '2024-10-01 15:24:21', '1403/07/10', '14:00', '2024-10-01 15:24:21'),
(99, 49, '2024-10-01 15:24:33', '1403/07/10', '14:00', '2024-10-01 15:24:33'),
(112, 61, '2024-10-02 15:51:16', '1403/07/11', '15:00', '2024-10-02 15:51:16'),
(98, 61, '2024-10-02 15:52:56', '1403/07/11', '15:00', '2024-10-02 15:52:56'),
(90, 61, '2024-10-02 15:55:22', '1403/07/11', '15:00', '2024-10-02 15:55:22'),
(64, 61, '2024-10-02 15:56:31', '1403/07/11', '15:00', '2024-10-02 15:56:31'),
(78, 61, '2024-10-02 15:59:20', '1403/07/11', '15:00', '2024-10-02 15:59:20'),
(103, 61, '2024-10-02 16:01:28', '1403/07/11', '15:00', '2024-10-02 16:01:28'),
(89, 61, '2024-10-02 16:02:11', '1403/07/11', '15:00', '2024-10-02 16:02:11'),
(99, 61, '2024-10-02 16:03:14', '1403/07/11', '15:00', '2024-10-02 16:03:14'),
(68, 61, '2024-10-02 16:04:32', '1403/07/11', '15:00', '2024-10-02 16:04:32'),
(119, 61, '2024-10-02 16:07:09', '1403/07/11', '15:00', '2024-10-02 16:07:09'),
(114, 61, '2024-10-02 16:07:33', '1403/07/11', '15:00', '2024-10-02 16:07:33'),
(91, 61, '2024-10-02 16:07:45', '1403/07/11', '15:00', '2024-10-02 16:07:45'),
(116, 61, '2024-10-02 16:08:34', '1403/07/11', '15:00', '2024-10-02 16:08:34'),
(128, 61, '2024-10-02 16:09:52', '1403/07/11', '15:00', '2024-10-02 16:09:52'),
(62, 61, '2024-10-02 16:09:52', '1403/07/11', '15:00', '2024-10-02 16:09:52'),
(117, 61, '2024-10-02 16:11:50', '1403/07/11', '15:00', '2024-10-02 16:11:50'),
(85, 61, '2024-10-02 16:14:25', '1403/07/11', '15:00', '2024-10-02 16:14:25'),
(100, 61, '2024-10-02 16:23:24', '1403/07/11', '15:00', '2024-10-02 16:23:24'),
(86, 61, '2024-10-02 16:24:06', '1403/07/11', '15:00', '2024-10-02 16:24:06'),
(84, 61, '2024-10-02 16:24:06', '1403/07/11', '15:00', '2024-10-02 16:24:06'),
(1, 61, '2024-10-02 16:47:04', '1403/07/11', '15:00', '2024-10-02 16:47:04'),
(1, 74, '2024-10-03 08:42:33', NULL, NULL, '2024-10-03 08:42:33'),
(98, 2, '2024-10-05 16:45:10', '1403/07/14', '15:45', '2024-10-05 16:45:11'),
(115, 2, '2024-10-05 16:47:30', '1403/07/14', '15:47', '2024-10-05 16:47:30'),
(95, 2, '2024-10-05 16:48:31', '1403/07/14', '15:48', '2024-10-05 16:48:31'),
(97, 2, '2024-10-05 16:50:40', '1403/07/14', '15:50', '2024-10-05 16:50:40'),
(110, 2, '2024-10-05 16:50:41', '1403/07/14', '15:50', '2024-10-05 16:50:41'),
(102, 2, '2024-10-05 16:53:43', '1403/07/14', '15:53', '2024-10-05 16:53:43'),
(123, 2, '2024-10-05 16:53:48', '1403/07/14', '15:53', '2024-10-05 16:53:48'),
(90, 2, '2024-10-05 16:54:14', '1403/07/14', '15:54', '2024-10-05 16:54:14'),
(128, 2, '2024-10-05 16:54:41', '1403/07/14', '15:54', '2024-10-05 16:54:41'),
(112, 2, '2024-10-05 16:54:48', '1403/07/14', '15:54', '2024-10-05 16:54:48'),
(113, 2, '2024-10-05 16:55:57', '1403/07/14', '15:55', '2024-10-05 16:55:57'),
(1, 2, '2024-10-05 16:56:39', '1403/07/14', '15:56', '2024-10-05 16:56:39'),
(85, 2, '2024-10-05 16:59:09', '1403/07/14', '15:59', '2024-10-05 16:59:09'),
(78, 2, '2024-10-05 16:59:51', '1403/07/14', '15:59', '2024-10-05 16:59:51'),
(89, 2, '2024-10-05 16:59:52', '1403/07/14', '15:59', '2024-10-05 16:59:52'),
(122, 2, '2024-10-05 17:00:54', '1403/07/14', '16:00', '2024-10-05 17:00:54'),
(62, 2, '2024-10-05 17:00:57', '1403/07/14', '16:00', '2024-10-05 17:00:57'),
(132, 2, '2024-10-05 17:00:58', '1403/07/14', '16:00', '2024-10-05 17:00:58'),
(100, 2, '2024-10-05 17:01:27', '1403/07/14', '16:01', '2024-10-05 17:01:27'),
(67, 2, '2024-10-05 17:01:36', '1403/07/14', '16:01', '2024-10-05 17:01:36'),
(66, 2, '2024-10-05 17:01:41', '1403/07/14', '16:01', '2024-10-05 17:01:41'),
(103, 2, '2024-10-05 17:02:06', '1403/07/14', '16:02', '2024-10-05 17:02:06'),
(63, 2, '2024-10-05 17:02:07', '1403/07/14', '16:02', '2024-10-05 17:02:07'),
(82, 2, '2024-10-05 17:02:16', '1403/07/14', '16:02', '2024-10-05 17:02:16'),
(91, 2, '2024-10-05 17:02:16', '1403/07/14', '16:02', '2024-10-05 17:02:16'),
(116, 2, '2024-10-05 17:03:02', '1403/07/14', '16:03', '2024-10-05 17:03:02'),
(28, 2, '2024-10-05 17:03:23', '1403/07/14', '16:03', '2024-10-05 17:03:23'),
(109, 2, '2024-10-05 17:04:33', '1403/07/14', '16:04', '2024-10-05 17:04:33'),
(84, 2, '2024-10-05 17:05:04', '1403/07/14', '16:05', '2024-10-05 17:05:04'),
(114, 2, '2024-10-05 17:06:28', '1403/07/14', '16:06', '2024-10-05 17:06:28'),
(118, 2, '2024-10-05 17:06:53', '1403/07/14', '16:06', '2024-10-05 17:06:53'),
(125, 2, '2024-10-05 17:10:52', '1403/07/14', '16:10', '2024-10-05 17:10:52'),
(121, 2, '2024-10-05 17:10:57', '1403/07/14', '16:10', '2024-10-05 17:10:57'),
(64, 2, '2024-10-05 15:52:15', '1403/07/14', '15:52', '2024-10-05 15:52:15'),
(131, 2, '2024-10-05 17:31:17', '1403/07/14', '16:31', '2024-10-05 17:31:17'),
(106, 2, '2024-10-05 17:31:53', '1403/07/14', '16:31', '2024-10-05 17:31:53'),
(61, 2, '2024-10-05 17:46:09', '1403/07/14', '16:46', '2024-10-05 17:46:09'),
(121, 26, '2024-10-07 14:47:18', '1403/07/16', '14:47', '2024-10-07 14:47:18'),
(121, 26, '2024-10-07 14:49:27', '1403/07/16', '14:49', '2024-10-07 14:49:27'),
(109, 26, '2024-10-07 14:51:14', '1403/07/16', '14:51', '2024-10-07 14:51:14'),
(109, 26, '2024-10-07 14:51:19', '1403/07/16', '14:51', '2024-10-07 14:51:19'),
(114, 26, '2024-10-07 14:51:45', '1403/07/16', '14:51', '2024-10-07 14:51:45'),
(98, 26, '2024-10-07 14:51:47', '1403/07/16', '14:51', '2024-10-07 14:51:47'),
(107, 26, '2024-10-07 14:52:36', '1403/07/16', '14:52', '2024-10-07 14:52:36'),
(119, 26, '2024-10-07 14:53:55', '1403/07/16', '14:53', '2024-10-07 14:53:55'),
(100, 26, '2024-10-07 14:54:35', '1403/07/16', '14:54', '2024-10-07 14:54:35'),
(112, 26, '2024-10-07 14:54:44', '1403/07/16', '14:54', '2024-10-07 14:54:44'),
(62, 26, '2024-10-07 14:57:34', '1403/07/16', '14:57', '2024-10-07 14:57:34'),
(103, 26, '2024-10-07 14:57:59', '1403/07/16', '14:57', '2024-10-07 14:57:59'),
(122, 26, '2024-10-07 14:58:08', '1403/07/16', '14:58', '2024-10-07 14:58:08'),
(113, 26, '2024-10-07 14:58:36', '1403/07/16', '14:58', '2024-10-07 14:58:36'),
(64, 26, '2024-10-07 14:59:04', '1403/07/16', '14:59', '2024-10-07 14:59:04'),
(122, 26, '2024-10-07 14:59:06', '1403/07/16', '14:59', '2024-10-07 14:59:06'),
(24, 26, '2024-10-07 14:59:06', '1403/07/16', '14:59', '2024-10-07 14:59:06'),
(64, 26, '2024-10-07 14:59:44', '1403/07/16', '14:59', '2024-10-07 14:59:44'),
(111, 26, '2024-10-07 15:00:33', '1403/07/16', '15:00', '2024-10-07 15:00:33'),
(99, 26, '2024-10-07 15:00:34', '1403/07/16', '15:00', '2024-10-07 15:00:34'),
(78, 26, '2024-10-07 15:00:53', '1403/07/16', '15:00', '2024-10-07 15:00:53'),
(89, 26, '2024-10-07 15:01:08', '1403/07/16', '15:01', '2024-10-07 15:01:08'),
(108, 26, '2024-10-07 15:01:16', '1403/07/16', '15:01', '2024-10-07 15:01:16'),
(97, 26, '2024-10-07 15:01:20', '1403/07/16', '15:01', '2024-10-07 15:01:20'),
(122, 26, '2024-10-07 15:01:22', '1403/07/16', '15:01', '2024-10-07 15:01:22'),
(116, 26, '2024-10-07 15:01:34', '1403/07/16', '15:01', '2024-10-07 15:01:34'),
(67, 26, '2024-10-07 15:01:45', '1403/07/16', '15:01', '2024-10-07 15:01:45'),
(84, 26, '2024-10-07 15:01:52', '1403/07/16', '15:01', '2024-10-07 15:01:52'),
(110, 26, '2024-10-07 15:02:26', '1403/07/16', '15:02', '2024-10-07 15:02:26'),
(91, 26, '2024-10-07 15:02:29', '1403/07/16', '15:02', '2024-10-07 15:02:29'),
(114, 26, '2024-10-07 15:02:48', '1403/07/16', '15:02', '2024-10-07 15:02:48'),
(108, 26, '2024-10-07 15:02:50', '1403/07/16', '15:02', '2024-10-07 15:02:50'),
(85, 26, '2024-10-07 15:03:13', '1403/07/16', '15:03', '2024-10-07 15:03:13'),
(115, 26, '2024-10-07 15:03:13', '1403/07/16', '15:03', '2024-10-07 15:03:13'),
(112, 26, '2024-10-07 15:03:22', '1403/07/16', '15:03', '2024-10-07 15:03:22'),
(90, 26, '2024-10-07 15:03:38', '1403/07/16', '15:03', '2024-10-07 15:03:38'),
(93, 26, '2024-10-07 15:05:12', '1403/07/16', '15:05', '2024-10-07 15:05:12'),
(99, 26, '2024-10-07 15:06:08', '1403/07/16', '15:06', '2024-10-07 15:06:08'),
(115, 26, '2024-10-07 15:06:14', '1403/07/16', '15:06', '2024-10-07 15:06:14'),
(66, 26, '2024-10-07 15:06:30', '1403/07/16', '15:06', '2024-10-07 15:06:30'),
(115, 26, '2024-10-07 15:07:45', '1403/07/16', '15:07', '2024-10-07 15:07:45'),
(106, 26, '2024-10-07 15:07:54', '1403/07/16', '15:07', '2024-10-07 15:07:54'),
(115, 26, '2024-10-07 15:07:57', '1403/07/16', '15:07', '2024-10-07 15:07:57'),
(61, 26, '2024-10-07 15:08:07', '1403/07/16', '15:08', '2024-10-07 15:08:07'),
(106, 26, '2024-10-07 15:08:38', '1403/07/16', '15:08', '2024-10-07 15:08:38'),
(106, 26, '2024-10-07 15:09:00', '1403/07/16', '15:09', '2024-10-07 15:09:00'),
(95, 26, '2024-10-07 15:09:05', '1403/07/16', '15:09', '2024-10-07 15:09:05'),
(95, 26, '2024-10-07 15:10:59', '1403/07/16', '15:10', '2024-10-07 15:10:59'),
(123, 26, '2024-10-07 15:11:55', '1403/07/16', '15:11', '2024-10-07 15:11:55'),
(97, 26, '2024-10-07 15:11:58', '1403/07/16', '15:11', '2024-10-07 15:11:58'),
(103, 26, '2024-10-07 15:11:59', '1403/07/16', '15:11', '2024-10-07 15:11:59'),
(118, 26, '2024-10-07 15:12:30', '1403/07/16', '15:12', '2024-10-07 15:12:30'),
(123, 26, '2024-10-07 15:12:32', '1403/07/16', '15:12', '2024-10-07 15:12:32'),
(97, 26, '2024-10-07 15:15:03', '1403/07/16', '15:15', '2024-10-07 15:15:03'),
(118, 26, '2024-10-07 15:15:36', '1403/07/16', '15:15', '2024-10-07 15:15:36'),
(117, 26, '2024-10-07 15:16:23', '1403/07/16', '15:16', '2024-10-07 15:16:23'),
(118, 26, '2024-10-07 15:16:34', '1403/07/16', '15:16', '2024-10-07 15:16:34'),
(132, 26, '2024-10-07 15:17:27', '1403/07/16', '15:17', '2024-10-07 15:17:27'),
(118, 26, '2024-10-07 15:18:00', '1403/07/16', '15:18', '2024-10-07 15:18:00'),
(82, 26, '2024-10-07 15:18:26', '1403/07/16', '15:18', '2024-10-07 15:18:26'),
(86, 26, '2024-10-07 15:19:36', '1403/07/16', '15:19', '2024-10-07 15:19:36'),
(115, 26, '2024-10-07 15:19:56', '1403/07/16', '15:19', '2024-10-07 15:19:56'),
(108, 26, '2024-10-07 15:23:28', '1403/07/16', '15:23', '2024-10-07 15:23:28'),
(82, 26, '2024-10-07 15:25:21', '1403/07/16', '15:25', '2024-10-07 15:25:21'),
(82, 26, '2024-10-07 15:25:27', '1403/07/16', '15:25', '2024-10-07 15:25:27'),
(82, 26, '2024-10-07 15:28:19', '1403/07/16', '15:28', '2024-10-07 15:28:19'),
(82, 26, '2024-10-07 15:28:24', '1403/07/16', '15:28', '2024-10-07 15:28:24'),
(116, 26, '2024-10-07 15:34:41', '1403/07/16', '15:34', '2024-10-07 15:34:41'),
(99, 26, '2024-10-07 15:35:57', '1403/07/16', '15:35', '2024-10-07 15:35:57'),
(116, 26, '2024-10-07 15:36:44', '1403/07/16', '15:36', '2024-10-07 15:36:44'),
(61, 26, '2024-10-07 15:37:18', '1403/07/16', '15:37', '2024-10-07 15:37:18'),
(95, 26, '2024-10-07 15:38:57', '1403/07/16', '15:38', '2024-10-07 15:38:57'),
(121, 26, '2024-10-07 15:40:48', '1403/07/16', '15:40', '2024-10-07 15:40:48'),
(99, 26, '2024-10-07 15:43:54', '1403/07/16', '15:43', '2024-10-07 15:43:54'),
(121, 26, '2024-10-07 15:45:42', '1403/07/16', '15:45', '2024-10-07 15:45:42'),
(98, 38, '2024-10-07 15:49:01', '1403/07/16', '15:49', '2024-10-07 15:49:01'),
(123, 26, '2024-10-07 15:49:27', '1403/07/16', '15:49', '2024-10-07 15:49:27'),
(114, 38, '2024-10-07 15:49:47', '1403/07/16', '15:49', '2024-10-07 15:49:47'),
(132, 26, '2024-10-07 15:49:49', '1403/07/16', '15:49', '2024-10-07 15:49:49'),
(118, 26, '2024-10-07 15:49:50', '1403/07/16', '15:49', '2024-10-07 15:49:50'),
(90, 26, '2024-10-07 15:49:50', '1403/07/16', '15:49', '2024-10-07 15:49:50'),
(117, 26, '2024-10-07 15:49:54', '1403/07/16', '15:49', '2024-10-07 15:49:54'),
(119, 38, '2024-10-07 15:49:57', '1403/07/16', '15:49', '2024-10-07 15:49:57'),
(108, 38, '2024-10-07 15:49:59', '1403/07/16', '15:49', '2024-10-07 15:49:59'),
(114, 38, '2024-10-07 15:50:10', '1403/07/16', '15:50', '2024-10-07 15:50:10'),
(108, 38, '2024-10-07 15:50:13', '1403/07/16', '15:50', '2024-10-07 15:50:13'),
(103, 38, '2024-10-07 15:50:17', '1403/07/16', '15:50', '2024-10-07 15:50:17'),
(84, 38, '2024-10-07 15:50:19', '1403/07/16', '15:50', '2024-10-07 15:50:19'),
(112, 38, '2024-10-07 15:50:21', '1403/07/16', '15:50', '2024-10-07 15:50:21'),
(93, 38, '2024-10-07 15:50:26', '1403/07/16', '15:50', '2024-10-07 15:50:26'),
(109, 38, '2024-10-07 15:50:32', '1403/07/16', '15:50', '2024-10-07 15:50:32'),
(108, 38, '2024-10-07 15:50:36', '1403/07/16', '15:50', '2024-10-07 15:50:36'),
(100, 38, '2024-10-07 15:51:09', '1403/07/16', '15:51', '2024-10-07 15:51:09'),
(61, 38, '2024-10-07 15:51:11', '1403/07/16', '15:51', '2024-10-07 15:51:11'),
(132, 26, '2024-10-07 15:51:20', '1403/07/16', '15:51', '2024-10-07 15:51:20'),
(67, 38, '2024-10-07 15:52:00', '1403/07/16', '15:52', '2024-10-07 15:52:00'),
(106, 26, '2024-10-07 15:52:05', '1403/07/16', '15:52', '2024-10-07 15:52:05'),
(117, 38, '2024-10-07 15:52:13', '1403/07/16', '15:52', '2024-10-07 15:52:13'),
(107, 38, '2024-10-07 15:52:14', '1403/07/16', '15:52', '2024-10-07 15:52:14'),
(66, 38, '2024-10-07 15:52:54', '1403/07/16', '15:52', '2024-10-07 15:52:54'),
(113, 38, '2024-10-07 15:53:23', '1403/07/16', '15:53', '2024-10-07 15:53:23'),
(122, 38, '2024-10-07 15:53:38', '1403/07/16', '15:53', '2024-10-07 15:53:38'),
(123, 38, '2024-10-07 15:54:08', '1403/07/16', '15:54', '2024-10-07 15:54:08'),
(128, 38, '2024-10-07 15:54:27', '1403/07/16', '15:54', '2024-10-07 15:54:27'),
(90, 38, '2024-10-07 15:54:31', '1403/07/16', '15:54', '2024-10-07 15:54:31'),
(82, 38, '2024-10-07 15:54:53', '1403/07/16', '15:54', '2024-10-07 15:54:53'),
(78, 38, '2024-10-07 15:55:31', '1403/07/16', '15:55', '2024-10-07 15:55:31'),
(62, 38, '2024-10-07 15:58:01', '1403/07/16', '15:58', '2024-10-07 15:58:01'),
(85, 38, '2024-10-07 15:59:30', '1403/07/16', '15:59', '2024-10-07 15:59:30'),
(103, 38, '2024-10-07 15:59:44', '1403/07/16', '15:59', '2024-10-07 15:59:44'),
(89, 38, '2024-10-07 16:00:07', '1403/07/16', '16:00', '2024-10-07 16:00:07'),
(111, 38, '2024-10-07 16:00:28', '1403/07/16', '16:00', '2024-10-07 16:00:28'),
(110, 38, '2024-10-07 16:00:39', '1403/07/16', '16:00', '2024-10-07 16:00:39'),
(91, 38, '2024-10-07 16:00:41', '1403/07/16', '16:00', '2024-10-07 16:00:41'),
(114, 38, '2024-10-07 16:00:50', '1403/07/16', '16:00', '2024-10-07 16:00:50'),
(84, 38, '2024-10-07 16:01:33', '1403/07/16', '16:01', '2024-10-07 16:01:33'),
(97, 38, '2024-10-07 16:01:36', '1403/07/16', '16:01', '2024-10-07 16:01:36'),
(86, 38, '2024-10-07 16:01:50', '1403/07/16', '16:01', '2024-10-07 16:01:50'),
(115, 38, '2024-10-07 16:02:15', '1403/07/16', '16:02', '2024-10-07 16:02:15'),
(64, 38, '2024-10-07 16:02:56', '1403/07/16', '16:02', '2024-10-07 16:02:56'),
(103, 38, '2024-10-07 16:04:15', '1403/07/16', '16:04', '2024-10-07 16:04:15'),
(21, 38, '2024-10-07 16:04:50', '1403/07/16', '16:04', '2024-10-07 16:04:50'),
(91, 38, '2024-10-07 16:05:42', '1403/07/16', '16:05', '2024-10-07 16:05:42'),
(99, 38, '2024-10-07 16:06:07', '1403/07/16', '16:06', '2024-10-07 16:06:07'),
(106, 38, '2024-10-07 16:06:08', '1403/07/16', '16:06', '2024-10-07 16:06:08'),
(67, 38, '2024-10-07 16:06:39', '1403/07/16', '16:06', '2024-10-07 16:06:39'),
(117, 38, '2024-10-07 16:07:19', '1403/07/16', '16:07', '2024-10-07 16:07:19'),
(86, 38, '2024-10-07 16:07:20', '1403/07/16', '16:07', '2024-10-07 16:07:20'),
(116, 38, '2024-10-07 16:07:28', '1403/07/16', '16:07', '2024-10-07 16:07:28'),
(99, 38, '2024-10-07 16:08:34', '1403/07/16', '16:08', '2024-10-07 16:08:34'),
(128, 38, '2024-10-07 16:11:16', '1403/07/16', '16:11', '2024-10-07 16:11:16'),
(68, 38, '2024-10-07 16:11:37', '1403/07/16', '16:11', '2024-10-07 16:11:37'),
(99, 38, '2024-10-07 16:13:18', '1403/07/16', '16:13', '2024-10-07 16:13:18'),
(82, 38, '2024-10-07 16:14:06', '1403/07/16', '16:14', '2024-10-07 16:14:06'),
(82, 38, '2024-10-07 16:14:08', '1403/07/16', '16:14', '2024-10-07 16:14:08'),
(97, 38, '2024-10-07 16:14:33', '1403/07/16', '16:14', '2024-10-07 16:14:33'),
(67, 38, '2024-10-07 16:14:36', '1403/07/16', '16:14', '2024-10-07 16:14:36'),
(67, 38, '2024-10-07 16:15:12', '1403/07/16', '16:15', '2024-10-07 16:15:12'),
(121, 38, '2024-10-07 16:16:08', '1403/07/16', '16:16', '2024-10-07 16:16:08'),
(82, 38, '2024-10-07 16:17:33', '1403/07/16', '16:17', '2024-10-07 16:17:33'),
(106, 38, '2024-10-07 16:17:41', '1403/07/16', '16:17', '2024-10-07 16:17:41'),
(97, 38, '2024-10-07 16:18:12', '1403/07/16', '16:18', '2024-10-07 16:18:12'),
(91, 38, '2024-10-07 16:19:21', '1403/07/16', '16:19', '2024-10-07 16:19:21'),
(128, 38, '2024-10-07 16:20:36', '1403/07/16', '16:20', '2024-10-07 16:20:36'),
(103, 38, '2024-10-07 16:21:51', '1403/07/16', '16:21', '2024-10-07 16:21:51'),
(97, 38, '2024-10-07 16:23:05', '1403/07/16', '16:23', '2024-10-07 16:23:05'),
(18, 75, '2024-10-07 16:23:59', '1403/07/16', '16:23', '2024-10-07 16:23:59'),
(128, 38, '2024-10-07 16:27:11', '1403/07/16', '16:27', '2024-10-07 16:27:11'),
(97, 38, '2024-10-07 16:29:20', '1403/07/16', '16:29', '2024-10-07 16:29:20'),
(103, 38, '2024-10-07 16:30:07', '1403/07/16', '16:30', '2024-10-07 16:30:07'),
(99, 38, '2024-10-07 16:30:27', '1403/07/16', '16:30', '2024-10-07 16:30:27'),
(106, 38, '2024-10-07 16:30:36', '1403/07/16', '16:30', '2024-10-07 16:30:36'),
(128, 38, '2024-10-07 16:30:36', '1403/07/16', '16:30', '2024-10-07 16:30:36'),
(97, 38, '2024-10-07 16:31:21', '1403/07/16', '16:31', '2024-10-07 16:31:21'),
(99, 38, '2024-10-07 16:31:53', '1403/07/16', '16:31', '2024-10-07 16:31:53'),
(18, 75, '2024-10-07 16:31:57', '1403/07/16', '16:31', '2024-10-07 16:31:57'),
(18, 75, '2024-10-07 16:32:39', '1403/07/16', '16:32', '2024-10-07 16:32:39'),
(21, 38, '2024-10-07 16:33:09', '1403/07/16', '16:33', '2024-10-07 16:33:09'),
(95, 38, '2024-10-07 16:33:28', '1403/07/16', '16:33', '2024-10-07 16:33:28'),
(95, 38, '2024-10-07 16:33:57', '1403/07/16', '16:33', '2024-10-07 16:33:57'),
(95, 38, '2024-10-07 16:34:36', '1403/07/16', '16:34', '2024-10-07 16:34:36'),
(18, 76, '2024-10-07 16:50:04', '1403/07/16', '16:50', '2024-10-07 16:50:04'),
(1, 38, '2024-10-07 16:53:45', '1403/07/16', '16:53', '2024-10-07 16:53:45'),
(123, 50, '2024-10-08 13:45:36', '1403/07/17', '13:45', '2024-10-08 13:45:36'),
(128, 50, '2024-10-08 13:45:48', '1403/07/17', '13:45', '2024-10-08 13:45:48'),
(107, 50, '2024-10-08 13:46:06', '1403/07/17', '13:46', '2024-10-08 13:46:06'),
(114, 50, '2024-10-08 13:50:23', '1403/07/17', '13:50', '2024-10-08 13:50:23'),
(109, 50, '2024-10-08 13:50:57', '1403/07/17', '13:50', '2024-10-08 13:50:57'),
(121, 50, '2024-10-08 13:51:05', '1403/07/17', '13:51', '2024-10-08 13:51:05'),
(68, 50, '2024-10-08 13:52:40', '1403/07/17', '13:52', '2024-10-08 13:52:40'),
(78, 50, '2024-10-08 13:54:34', '1403/07/17', '13:54', '2024-10-08 13:54:34'),
(90, 50, '2024-10-08 13:55:05', '1403/07/17', '13:55', '2024-10-08 13:55:05'),
(103, 50, '2024-10-08 13:55:30', '1403/07/17', '13:55', '2024-10-08 13:55:30'),
(113, 50, '2024-10-08 13:55:39', '1403/07/17', '13:55', '2024-10-08 13:55:39'),
(1, 50, '2024-10-08 13:56:09', '1403/07/17', '13:56', '2024-10-08 13:56:09'),
(97, 50, '2024-10-08 13:56:10', '1403/07/17', '13:56', '2024-10-08 13:56:10'),
(119, 50, '2024-10-08 13:56:57', '1403/07/17', '13:56', '2024-10-08 13:56:57'),
(98, 50, '2024-10-08 13:57:07', '1403/07/17', '13:57', '2024-10-08 13:57:07'),
(85, 50, '2024-10-08 13:57:49', '1403/07/17', '13:57', '2024-10-08 13:57:49'),
(52, 50, '2024-10-08 13:59:08', '1403/07/17', '13:59', '2024-10-08 13:59:08'),
(67, 50, '2024-10-08 13:59:57', '1403/07/17', '13:59', '2024-10-08 13:59:57'),
(64, 50, '2024-10-08 14:00:01', '1403/07/17', '14:00', '2024-10-08 14:00:01'),
(132, 50, '2024-10-08 14:00:03', '1403/07/17', '14:00', '2024-10-08 14:00:03'),
(122, 50, '2024-10-08 14:00:20', '1403/07/17', '14:00', '2024-10-08 14:00:20'),
(100, 50, '2024-10-08 14:00:32', '1403/07/17', '14:00', '2024-10-08 14:00:32'),
(89, 50, '2024-10-08 14:00:49', '1403/07/17', '14:00', '2024-10-08 14:00:49'),
(116, 50, '2024-10-08 14:00:54', '1403/07/17', '14:00', '2024-10-08 14:00:54'),
(110, 50, '2024-10-08 14:01:14', '1403/07/17', '14:01', '2024-10-08 14:01:14'),
(23, 50, '2024-10-08 14:03:38', '1403/07/17', '14:03', '2024-10-08 14:03:38'),
(99, 50, '2024-10-08 14:03:54', '1403/07/17', '14:03', '2024-10-08 14:03:54'),
(111, 50, '2024-10-08 14:04:23', '1403/07/17', '14:04', '2024-10-08 14:04:23'),
(66, 50, '2024-10-08 14:05:11', '1403/07/17', '14:05', '2024-10-08 14:05:11'),
(91, 50, '2024-10-08 14:05:55', '1403/07/17', '14:05', '2024-10-08 14:05:55'),
(108, 50, '2024-10-08 14:06:43', '1403/07/17', '14:06', '2024-10-08 14:06:43'),
(93, 50, '2024-10-08 14:09:44', '1403/07/17', '14:09', '2024-10-08 14:09:44'),
(117, 50, '2024-10-08 14:10:24', '1403/07/17', '14:10', '2024-10-08 14:10:24'),
(61, 50, '2024-10-08 14:10:39', '1403/07/17', '14:10', '2024-10-08 14:10:39'),
(96, 50, '2024-10-08 14:11:07', '1403/07/17', '14:11', '2024-10-08 14:11:07'),
(112, 50, '2024-10-08 14:12:38', '1403/07/17', '14:12', '2024-10-08 14:12:38'),
(86, 50, '2024-10-08 14:13:34', '1403/07/17', '14:13', '2024-10-08 14:13:34'),
(84, 50, '2024-10-08 14:13:53', '1403/07/17', '14:13', '2024-10-08 14:13:53'),
(131, 1, '2024-09-28 14:25:26', '1403/07/07', '16:00', '2024-09-28 14:25:26'),
(78, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(97, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(109, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(100, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(114, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(67, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(119, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(103, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(1, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(90, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(61, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(122, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(99, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(132, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(84, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(121, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(128, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(95, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(123, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(106, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(111, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(82, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(104, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(98, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(64, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(112, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(117, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(136, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(62, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(110, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(27, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(66, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(108, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(116, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(30, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(85, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(118, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(113, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(96, 14, '2024-10-06 12:30:00', '1403/07/15', '16:00', '2024-10-06 12:30:00'),
(121, 62, '2024-10-09 14:45:20', '1403/07/18', '14:45', '2024-10-09 14:45:20'),
(114, 62, '2024-10-09 14:50:34', '1403/07/18', '14:50', '2024-10-09 14:50:34'),
(64, 62, '2024-10-09 14:52:06', '1403/07/18', '14:52', '2024-10-09 14:52:06'),
(90, 62, '2024-10-09 14:55:55', '1403/07/18', '14:55', '2024-10-09 14:55:55'),
(78, 62, '2024-10-09 14:56:15', '1403/07/18', '14:56', '2024-10-09 14:56:15'),
(109, 62, '2024-10-09 14:56:38', '1403/07/18', '14:56', '2024-10-09 14:56:38'),
(68, 62, '2024-10-09 14:56:45', '1403/07/18', '14:56', '2024-10-09 14:56:45'),
(98, 62, '2024-10-09 14:57:02', '1403/07/18', '14:57', '2024-10-09 14:57:02'),
(107, 62, '2024-10-09 14:57:06', '1403/07/18', '14:57', '2024-10-09 14:57:06'),
(100, 62, '2024-10-09 14:57:08', '1403/07/18', '14:57', '2024-10-09 14:57:08'),
(103, 62, '2024-10-09 14:57:20', '1403/07/18', '14:57', '2024-10-09 14:57:20'),
(122, 62, '2024-10-09 14:58:00', '1403/07/18', '14:58', '2024-10-09 14:58:00'),
(112, 62, '2024-10-09 14:58:45', '1403/07/18', '14:58', '2024-10-09 14:58:45'),
(118, 62, '2024-10-09 14:58:48', '1403/07/18', '14:58', '2024-10-09 14:58:48'),
(66, 62, '2024-10-09 14:59:06', '1403/07/18', '14:59', '2024-10-09 14:59:06'),
(97, 62, '2024-10-09 14:59:19', '1403/07/18', '14:59', '2024-10-09 14:59:19'),
(111, 62, '2024-10-09 14:59:52', '1403/07/18', '14:59', '2024-10-09 14:59:52'),
(55, 62, '2024-10-09 15:00:37', '1403/07/18', '15:00', '2024-10-09 15:00:37'),
(110, 62, '2024-10-09 15:00:54', '1403/07/18', '15:00', '2024-10-09 15:00:54'),
(89, 62, '2024-10-09 15:01:18', '1403/07/18', '15:01', '2024-10-09 15:01:18'),
(85, 62, '2024-10-09 15:01:29', '1403/07/18', '15:01', '2024-10-09 15:01:29'),
(108, 62, '2024-10-09 15:01:40', '1403/07/18', '15:01', '2024-10-09 15:01:40'),
(91, 62, '2024-10-09 15:01:41', '1403/07/18', '15:01', '2024-10-09 15:01:41'),
(119, 62, '2024-10-09 15:01:59', '1403/07/18', '15:01', '2024-10-09 15:01:59'),
(67, 62, '2024-10-09 15:02:10', '1403/07/18', '15:02', '2024-10-09 15:02:10'),
(116, 62, '2024-10-09 15:02:53', '1403/07/18', '15:02', '2024-10-09 15:02:53'),
(96, 62, '2024-10-09 15:03:11', '1403/07/18', '15:03', '2024-10-09 15:03:11'),
(61, 62, '2024-10-09 15:03:11', '1403/07/18', '15:03', '2024-10-09 15:03:11'),
(124, 62, '2024-10-09 15:03:58', '1403/07/18', '15:03', '2024-10-09 15:03:58'),
(128, 62, '2024-10-09 15:04:10', '1403/07/18', '15:04', '2024-10-09 15:04:10'),
(84, 62, '2024-10-09 15:04:14', '1403/07/18', '15:04', '2024-10-09 15:04:14'),
(106, 62, '2024-10-09 15:05:32', '1403/07/18', '15:05', '2024-10-09 15:05:32'),
(102, 62, '2024-10-09 15:05:42', '1403/07/18', '15:05', '2024-10-09 15:05:42'),
(93, 62, '2024-10-09 15:06:36', '1403/07/18', '15:06', '2024-10-09 15:06:36'),
(113, 62, '2024-10-09 15:07:37', '1403/07/18', '15:07', '2024-10-09 15:07:37'),
(95, 62, '2024-10-09 15:07:44', '1403/07/18', '15:07', '2024-10-09 15:07:44'),
(117, 62, '2024-10-09 15:07:54', '1403/07/18', '15:07', '2024-10-09 15:07:54'),
(115, 62, '2024-10-09 15:09:47', '1403/07/18', '15:09', '2024-10-09 15:09:47'),
(22, 62, '2024-10-09 15:14:04', '1403/07/18', '15:14', '2024-10-09 15:14:04'),
(86, 62, '2024-10-09 15:18:57', '1403/07/18', '15:18', '2024-10-09 15:18:57'),
(99, 62, '2024-10-09 15:26:26', '1403/07/18', '15:26', '2024-10-09 15:26:26'),
(62, 62, '2024-10-09 15:28:10', '1403/07/18', '15:28', '2024-10-09 15:28:10'),
(131, 62, '2024-10-09 15:29:04', '1403/07/18', '15:29', '2024-10-09 15:29:04'),
(132, 62, '2024-10-09 15:50:10', '1403/07/18', '15:50', '2024-10-09 15:50:10'),
(108, 3, '2024-10-12 15:46:54', '1403/07/21', '15:46', '2024-10-12 15:46:54'),
(90, 3, '2024-10-12 15:54:44', '1403/07/21', '15:54', '2024-10-12 15:54:44'),
(61, 3, '2024-10-12 15:55:39', '1403/07/21', '15:55', '2024-10-12 15:55:39'),
(121, 3, '2024-10-12 15:56:04', '1403/07/21', '15:56', '2024-10-12 15:56:04'),
(103, 3, '2024-10-12 15:56:11', '1403/07/21', '15:56', '2024-10-12 15:56:11'),
(122, 3, '2024-10-12 15:56:15', '1403/07/21', '15:56', '2024-10-12 15:56:15'),
(84, 3, '2024-10-12 15:57:02', '1403/07/21', '15:57', '2024-10-12 15:57:02'),
(98, 3, '2024-10-12 15:57:46', '1403/07/21', '15:57', '2024-10-12 15:57:46'),
(95, 3, '2024-10-12 15:57:53', '1403/07/21', '15:57', '2024-10-12 15:57:53'),
(116, 3, '2024-10-12 15:58:32', '1403/07/21', '15:58', '2024-10-12 15:58:32'),
(28, 3, '2024-10-12 15:59:00', '1403/07/21', '15:59', '2024-10-12 15:59:00'),
(115, 3, '2024-10-12 15:59:11', '1403/07/21', '15:59', '2024-10-12 15:59:11'),
(89, 3, '2024-10-12 15:59:18', '1403/07/21', '15:59', '2024-10-12 15:59:18'),
(106, 3, '2024-10-12 15:59:20', '1403/07/21', '15:59', '2024-10-12 15:59:20'),
(85, 3, '2024-10-12 15:59:24', '1403/07/21', '15:59', '2024-10-12 15:59:24'),
(67, 3, '2024-10-12 15:59:29', '1403/07/21', '15:59', '2024-10-12 15:59:29'),
(112, 3, '2024-10-12 15:59:46', '1403/07/21', '15:59', '2024-10-12 15:59:46'),
(132, 3, '2024-10-12 16:00:11', '1403/07/21', '16:00', '2024-10-12 16:00:11'),
(78, 3, '2024-10-12 16:00:27', '1403/07/21', '16:00', '2024-10-12 16:00:27'),
(91, 3, '2024-10-12 16:01:02', '1403/07/21', '16:01', '2024-10-12 16:01:02'),
(96, 3, '2024-10-12 16:01:20', '1403/07/21', '16:01', '2024-10-12 16:01:20'),
(118, 3, '2024-10-12 16:01:39', '1403/07/21', '16:01', '2024-10-12 16:01:39'),
(128, 3, '2024-10-12 16:01:43', '1403/07/21', '16:01', '2024-10-12 16:01:43'),
(123, 3, '2024-10-12 16:01:55', '1403/07/21', '16:01', '2024-10-12 16:01:55'),
(18, 3, '2024-10-12 16:02:06', '1403/07/21', '16:02', '2024-10-12 16:02:06'),
(114, 3, '2024-10-12 16:02:19', '1403/07/21', '16:02', '2024-10-12 16:02:19'),
(82, 3, '2024-10-12 16:03:04', '1403/07/21', '16:03', '2024-10-12 16:03:04'),
(64, 3, '2024-10-12 16:04:28', '1403/07/21', '16:04', '2024-10-12 16:04:28'),
(97, 3, '2024-10-12 16:05:04', '1403/07/21', '16:05', '2024-10-12 16:05:04'),
(102, 3, '2024-10-12 16:15:33', '1403/07/21', '16:15', '2024-10-12 16:15:33'),
(97, 15, '2024-10-13 15:53:43', '1403/07/22', '15:53', '2024-10-13 15:53:43'),
(90, 15, '2024-10-13 15:54:37', '1403/07/22', '15:54', '2024-10-13 15:54:37'),
(122, 15, '2024-10-13 15:55:02', '1403/07/22', '15:55', '2024-10-13 15:55:02'),
(98, 15, '2024-10-13 15:55:14', '1403/07/22', '15:55', '2024-10-13 15:55:14'),
(67, 15, '2024-10-13 15:55:25', '1403/07/22', '15:55', '2024-10-13 15:55:25'),
(85, 15, '2024-10-13 15:55:41', '1403/07/22', '15:55', '2024-10-13 15:55:41'),
(95, 15, '2024-10-13 15:55:50', '1403/07/22', '15:55', '2024-10-13 15:55:50'),
(100, 15, '2024-10-13 15:56:06', '1403/07/22', '15:56', '2024-10-13 15:56:06'),
(113, 15, '2024-10-13 15:56:12', '1403/07/22', '15:56', '2024-10-13 15:56:12'),
(103, 15, '2024-10-13 15:56:24', '1403/07/22', '15:56', '2024-10-13 15:56:24'),
(91, 15, '2024-10-13 15:57:01', '1403/07/22', '15:57', '2024-10-13 15:57:01'),
(123, 15, '2024-10-13 15:57:17', '1403/07/22', '15:57', '2024-10-13 15:57:17'),
(112, 15, '2024-10-13 15:57:52', '1403/07/22', '15:57', '2024-10-13 15:57:52'),
(61, 15, '2024-10-13 15:58:01', '1403/07/22', '15:58', '2024-10-13 15:58:01'),
(108, 15, '2024-10-13 15:59:02', '1403/07/22', '15:59', '2024-10-13 15:59:02'),
(111, 15, '2024-10-13 15:59:18', '1403/07/22', '15:59', '2024-10-13 15:59:18'),
(128, 15, '2024-10-13 16:00:07', '1403/07/22', '16:00', '2024-10-13 16:00:07'),
(89, 15, '2024-10-13 16:00:43', '1403/07/22', '16:00', '2024-10-13 16:00:43'),
(115, 15, '2024-10-13 16:00:58', '1403/07/22', '16:00', '2024-10-13 16:00:58'),
(119, 15, '2024-10-13 16:00:59', '1403/07/22', '16:00', '2024-10-13 16:00:59'),
(62, 15, '2024-10-13 16:01:19', '1403/07/22', '16:01', '2024-10-13 16:01:19'),
(106, 15, '2024-10-13 16:01:22', '1403/07/22', '16:01', '2024-10-13 16:01:22'),
(84, 15, '2024-10-13 16:01:28', '1403/07/22', '16:01', '2024-10-13 16:01:28'),
(132, 15, '2024-10-13 16:02:01', '1403/07/22', '16:02', '2024-10-13 16:02:01'),
(82, 15, '2024-10-13 16:03:57', '1403/07/22', '16:03', '2024-10-13 16:03:57'),
(66, 15, '2024-10-13 16:04:34', '1403/07/22', '16:04', '2024-10-13 16:04:34'),
(114, 15, '2024-10-13 16:04:57', '1403/07/22', '16:04', '2024-10-13 16:04:57'),
(116, 15, '2024-10-13 16:06:55', '1403/07/22', '16:06', '2024-10-13 16:06:55'),
(118, 15, '2024-10-13 16:08:03', '1403/07/22', '16:08', '2024-10-13 16:08:03'),
(117, 15, '2024-10-13 16:10:26', '1403/07/22', '16:10', '2024-10-13 16:10:26'),
(27, 15, '2024-10-13 16:11:07', '1403/07/22', '16:11', '2024-10-13 16:11:07'),
(109, 15, '2024-10-13 16:14:49', '1403/07/22', '16:14', '2024-10-13 16:14:49'),
(96, 15, '2024-10-13 16:15:07', '1403/07/22', '16:15', '2024-10-13 16:15:07'),
(78, 15, '2024-10-13 16:15:52', '1403/07/22', '16:15', '2024-10-13 16:15:52'),
(102, 15, '2024-10-13 16:16:58', '1403/07/22', '16:16', '2024-10-13 16:16:58'),
(93, 15, '2024-10-13 16:18:15', '1403/07/22', '16:18', '2024-10-13 16:18:15'),
(64, 15, '2024-10-13 16:23:15', '1403/07/22', '16:23', '2024-10-13 16:23:15'),
(121, 15, '2024-10-13 16:34:08', '1403/07/22', '16:34', '2024-10-13 16:34:08'),
(121, 27, '2024-10-14 14:53:10', '1403/07/23', '14:53', '2024-10-14 14:53:10'),
(90, 27, '2024-10-14 14:55:01', '1403/07/23', '14:55', '2024-10-14 14:55:01'),
(98, 27, '2024-10-14 14:55:09', '1403/07/23', '14:55', '2024-10-14 14:55:09'),
(107, 27, '2024-10-14 14:55:10', '1403/07/23', '14:55', '2024-10-14 14:55:10'),
(103, 27, '2024-10-14 14:55:21', '1403/07/23', '14:55', '2024-10-14 14:55:21'),
(128, 27, '2024-10-14 14:55:26', '1403/07/23', '14:55', '2024-10-14 14:55:26'),
(61, 27, '2024-10-14 14:55:31', '1403/07/23', '14:55', '2024-10-14 14:55:31'),
(114, 27, '2024-10-14 14:56:18', '1403/07/23', '14:56', '2024-10-14 14:56:18'),
(109, 27, '2024-10-14 14:56:38', '1403/07/23', '14:56', '2024-10-14 14:56:38'),
(119, 27, '2024-10-14 14:57:07', '1403/07/23', '14:57', '2024-10-14 14:57:07'),
(112, 27, '2024-10-14 14:57:50', '1403/07/23', '14:57', '2024-10-14 14:57:50'),
(84, 27, '2024-10-14 14:59:05', '1403/07/23', '14:59', '2024-10-14 14:59:05'),
(82, 27, '2024-10-14 14:59:26', '1403/07/23', '14:59', '2024-10-14 14:59:26'),
(100, 27, '2024-10-14 14:59:49', '1403/07/23', '14:59', '2024-10-14 14:59:49'),
(122, 27, '2024-10-14 15:00:10', '1403/07/23', '15:00', '2024-10-14 15:00:10'),
(64, 27, '2024-10-14 15:00:23', '1403/07/23', '15:00', '2024-10-14 15:00:23'),
(67, 27, '2024-10-14 15:00:32', '1403/07/23', '15:00', '2024-10-14 15:00:32'),
(96, 27, '2024-10-14 15:01:36', '1403/07/23', '15:01', '2024-10-14 15:01:36'),
(116, 27, '2024-10-14 15:01:37', '1403/07/23', '15:01', '2024-10-14 15:01:37'),
(97, 27, '2024-10-14 15:01:52', '1403/07/23', '15:01', '2024-10-14 15:01:52'),
(99, 27, '2024-10-14 15:02:27', '1403/07/23', '15:02', '2024-10-14 15:02:27'),
(89, 27, '2024-10-14 15:02:47', '1403/07/23', '15:02', '2024-10-14 15:02:47'),
(118, 27, '2024-10-14 15:03:13', '1403/07/23', '15:03', '2024-10-14 15:03:13'),
(66, 27, '2024-10-14 15:03:19', '1403/07/23', '15:03', '2024-10-14 15:03:19'),
(110, 27, '2024-10-14 15:03:38', '1403/07/23', '15:03', '2024-10-14 15:03:38'),
(132, 27, '2024-10-14 15:03:39', '1403/07/23', '15:03', '2024-10-14 15:03:39'),
(24, 27, '2024-10-14 15:03:41', '1403/07/23', '15:03', '2024-10-14 15:03:41'),
(113, 27, '2024-10-14 15:03:57', '1403/07/23', '15:03', '2024-10-14 15:03:57'),
(102, 27, '2024-10-14 15:04:10', '1403/07/23', '15:04', '2024-10-14 15:04:10'),
(106, 27, '2024-10-14 15:04:34', '1403/07/23', '15:04', '2024-10-14 15:04:34'),
(91, 27, '2024-10-14 15:04:48', '1403/07/23', '15:04', '2024-10-14 15:04:48'),
(93, 27, '2024-10-14 15:05:09', '1403/07/23', '15:05', '2024-10-14 15:05:09'),
(78, 27, '2024-10-14 15:05:17', '1403/07/23', '15:05', '2024-10-14 15:05:17'),
(85, 27, '2024-10-14 15:05:33', '1403/07/23', '15:05', '2024-10-14 15:05:33'),
(111, 27, '2024-10-14 15:08:04', '1403/07/23', '15:08', '2024-10-14 15:08:04'),
(124, 27, '2024-10-14 15:10:45', '1403/07/23', '15:10', '2024-10-14 15:10:45'),
(62, 27, '2024-10-14 15:12:25', '1403/07/23', '15:12', '2024-10-14 15:12:25'),
(86, 27, '2024-10-14 15:13:50', '1403/07/23', '15:13', '2024-10-14 15:13:50'),
(117, 27, '2024-10-14 15:14:47', '1403/07/23', '15:14', '2024-10-14 15:14:47'),
(108, 27, '2024-10-14 15:15:17', '1403/07/23', '15:15', '2024-10-14 15:15:17'),
(95, 27, '2024-10-14 15:23:50', '1403/07/23', '15:23', '2024-10-14 15:23:50'),
(123, 27, '2024-10-14 15:24:52', '1403/07/23', '15:24', '2024-10-14 15:24:52'),
(98, 39, '2024-10-14 15:55:06', '1403/07/23', '15:55', '2024-10-14 15:55:06');
INSERT INTO `online_classroom_user` (`user_id`, `onlineClassroom_id`, `created_at`, `presence_date`, `presence_time`, `updated_at`) VALUES
(107, 39, '2024-10-14 15:55:10', '1403/07/23', '15:55', '2024-10-14 15:55:10'),
(121, 39, '2024-10-14 15:55:23', '1403/07/23', '15:55', '2024-10-14 15:55:23'),
(119, 39, '2024-10-14 15:55:30', '1403/07/23', '15:55', '2024-10-14 15:55:30'),
(90, 39, '2024-10-14 15:55:30', '1403/07/23', '15:55', '2024-10-14 15:55:30'),
(78, 39, '2024-10-14 15:55:30', '1403/07/23', '15:55', '2024-10-14 15:55:30'),
(111, 39, '2024-10-14 15:55:36', '1403/07/23', '15:55', '2024-10-14 15:55:36'),
(109, 39, '2024-10-14 15:55:40', '1403/07/23', '15:55', '2024-10-14 15:55:40'),
(112, 39, '2024-10-14 15:55:54', '1403/07/23', '15:55', '2024-10-14 15:55:54'),
(103, 39, '2024-10-14 15:56:00', '1403/07/23', '15:56', '2024-10-14 15:56:00'),
(128, 39, '2024-10-14 15:56:10', '1403/07/23', '15:56', '2024-10-14 15:56:10'),
(84, 39, '2024-10-14 15:56:41', '1403/07/23', '15:56', '2024-10-14 15:56:41'),
(99, 39, '2024-10-14 15:56:52', '1403/07/23', '15:56', '2024-10-14 15:56:52'),
(100, 39, '2024-10-14 15:56:57', '1403/07/23', '15:56', '2024-10-14 15:56:57'),
(122, 39, '2024-10-14 15:57:09', '1403/07/23', '15:57', '2024-10-14 15:57:09'),
(123, 39, '2024-10-14 15:57:13', '1403/07/23', '15:57', '2024-10-14 15:57:13'),
(106, 39, '2024-10-14 15:57:17', '1403/07/23', '15:57', '2024-10-14 15:57:17'),
(132, 39, '2024-10-14 15:57:34', '1403/07/23', '15:57', '2024-10-14 15:57:34'),
(97, 39, '2024-10-14 15:57:51', '1403/07/23', '15:57', '2024-10-14 15:57:51'),
(68, 27, '2024-10-14 15:58:16', '1403/07/23', '15:58', '2024-10-14 15:58:16'),
(89, 39, '2024-10-14 15:58:26', '1403/07/23', '15:58', '2024-10-14 15:58:26'),
(66, 39, '2024-10-14 15:59:06', '1403/07/23', '15:59', '2024-10-14 15:59:06'),
(113, 39, '2024-10-14 15:59:21', '1403/07/23', '15:59', '2024-10-14 15:59:21'),
(55, 39, '2024-10-14 15:59:41', '1403/07/23', '15:59', '2024-10-14 15:59:41'),
(54, 39, '2024-10-14 15:59:44', '1403/07/23', '15:59', '2024-10-14 15:59:44'),
(91, 39, '2024-10-14 16:00:13', '1403/07/23', '16:00', '2024-10-14 16:00:13'),
(67, 39, '2024-10-14 16:00:14', '1403/07/23', '16:00', '2024-10-14 16:00:14'),
(68, 39, '2024-10-14 16:00:19', '1403/07/23', '16:00', '2024-10-14 16:00:19'),
(93, 39, '2024-10-14 16:00:22', '1403/07/23', '16:00', '2024-10-14 16:00:22'),
(64, 39, '2024-10-14 16:00:27', '1403/07/23', '16:00', '2024-10-14 16:00:27'),
(86, 39, '2024-10-14 16:01:32', '1403/07/23', '16:01', '2024-10-14 16:01:32'),
(110, 39, '2024-10-14 16:01:34', '1403/07/23', '16:01', '2024-10-14 16:01:34'),
(61, 39, '2024-10-14 16:02:41', '1403/07/23', '16:02', '2024-10-14 16:02:41'),
(108, 39, '2024-10-14 16:02:43', '1403/07/23', '16:02', '2024-10-14 16:02:43'),
(82, 39, '2024-10-14 16:02:55', '1403/07/23', '16:02', '2024-10-14 16:02:55'),
(124, 39, '2024-10-14 16:03:04', '1403/07/23', '16:03', '2024-10-14 16:03:04'),
(116, 39, '2024-10-14 16:03:49', '1403/07/23', '16:03', '2024-10-14 16:03:49'),
(21, 39, '2024-10-14 16:04:36', '1403/07/23', '16:04', '2024-10-14 16:04:36'),
(114, 39, '2024-10-14 16:04:58', '1403/07/23', '16:04', '2024-10-14 16:04:58'),
(62, 39, '2024-10-14 16:07:25', '1403/07/23', '16:07', '2024-10-14 16:07:25'),
(96, 39, '2024-10-14 16:09:49', '1403/07/23', '16:09', '2024-10-14 16:09:49'),
(117, 39, '2024-10-14 16:12:23', '1403/07/23', '16:12', '2024-10-14 16:12:23'),
(69, 39, '2024-10-14 16:19:42', '1403/07/23', '16:19', '2024-10-14 16:19:42'),
(115, 39, '2024-10-14 16:21:38', '1403/07/23', '16:21', '2024-10-14 16:21:38'),
(90, 51, '2024-10-15 13:54:16', '1403/07/24', '13:54', '2024-10-15 13:54:16'),
(121, 51, '2024-10-15 13:55:06', '1403/07/24', '13:55', '2024-10-15 13:55:06'),
(122, 51, '2024-10-15 13:55:10', '1403/07/24', '13:55', '2024-10-15 13:55:10'),
(123, 51, '2024-10-15 13:55:16', '1403/07/24', '13:55', '2024-10-15 13:55:16'),
(78, 51, '2024-10-15 13:55:53', '1403/07/24', '13:55', '2024-10-15 13:55:53'),
(109, 51, '2024-10-15 13:55:57', '1403/07/24', '13:55', '2024-10-15 13:55:57'),
(60, 51, '2024-10-15 13:56:01', '1403/07/24', '13:56', '2024-10-15 13:56:01'),
(107, 51, '2024-10-15 13:56:27', '1403/07/24', '13:56', '2024-10-15 13:56:27'),
(82, 51, '2024-10-15 13:56:50', '1403/07/24', '13:56', '2024-10-15 13:56:50'),
(118, 51, '2024-10-15 13:56:57', '1403/07/24', '13:56', '2024-10-15 13:56:57'),
(98, 51, '2024-10-15 13:57:14', '1403/07/24', '13:57', '2024-10-15 13:57:14'),
(97, 51, '2024-10-15 13:57:21', '1403/07/24', '13:57', '2024-10-15 13:57:21'),
(128, 51, '2024-10-15 13:57:27', '1403/07/24', '13:57', '2024-10-15 13:57:27'),
(100, 51, '2024-10-15 13:57:42', '1403/07/24', '13:57', '2024-10-15 13:57:42'),
(112, 51, '2024-10-15 13:57:57', '1403/07/24', '13:57', '2024-10-15 13:57:57'),
(113, 51, '2024-10-15 13:58:16', '1403/07/24', '13:58', '2024-10-15 13:58:16'),
(64, 51, '2024-10-15 13:58:20', '1403/07/24', '13:58', '2024-10-15 13:58:20'),
(103, 51, '2024-10-15 13:58:51', '1403/07/24', '13:58', '2024-10-15 13:58:51'),
(89, 51, '2024-10-15 13:59:55', '1403/07/24', '13:59', '2024-10-15 13:59:55'),
(62, 51, '2024-10-15 14:00:24', '1403/07/24', '14:00', '2024-10-15 14:00:24'),
(23, 51, '2024-10-15 14:00:32', '1403/07/24', '14:00', '2024-10-15 14:00:32'),
(111, 51, '2024-10-15 14:00:48', '1403/07/24', '14:00', '2024-10-15 14:00:48'),
(91, 51, '2024-10-15 14:00:53', '1403/07/24', '14:00', '2024-10-15 14:00:53'),
(110, 51, '2024-10-15 14:00:56', '1403/07/24', '14:00', '2024-10-15 14:00:56'),
(119, 51, '2024-10-15 14:01:28', '1403/07/24', '14:01', '2024-10-15 14:01:28'),
(61, 51, '2024-10-15 14:01:38', '1403/07/24', '14:01', '2024-10-15 14:01:38'),
(66, 51, '2024-10-15 14:02:37', '1403/07/24', '14:02', '2024-10-15 14:02:37'),
(114, 51, '2024-10-15 14:03:49', '1403/07/24', '14:03', '2024-10-15 14:03:49'),
(67, 51, '2024-10-15 14:04:34', '1403/07/24', '14:04', '2024-10-15 14:04:34'),
(132, 51, '2024-10-15 14:09:05', '1403/07/24', '14:09', '2024-10-15 14:09:05'),
(93, 51, '2024-10-15 14:09:37', '1403/07/24', '14:09', '2024-10-15 14:09:37'),
(108, 51, '2024-10-15 14:09:38', '1403/07/24', '14:09', '2024-10-15 14:09:38'),
(102, 51, '2024-10-15 14:10:12', '1403/07/24', '14:10', '2024-10-15 14:10:12'),
(84, 51, '2024-10-15 14:14:33', '1403/07/24', '14:14', '2024-10-15 14:14:33'),
(99, 51, '2024-10-15 14:15:42', '1403/07/24', '14:15', '2024-10-15 14:15:42'),
(86, 51, '2024-10-15 14:16:16', '1403/07/24', '14:16', '2024-10-15 14:16:16'),
(117, 51, '2024-10-15 14:19:25', '1403/07/24', '14:19', '2024-10-15 14:19:25'),
(52, 51, '2024-10-15 14:32:57', '1403/07/24', '14:32', '2024-10-15 14:32:57'),
(95, 51, '2024-10-15 14:33:20', '1403/07/24', '14:33', '2024-10-15 14:33:20'),
(116, 51, '2024-10-15 14:35:21', '1403/07/24', '14:35', '2024-10-15 14:35:21'),
(106, 51, '2024-10-15 14:38:23', '1403/07/24', '14:38', '2024-10-15 14:38:23'),
(106, 63, '2024-10-16 14:54:40', '1403/07/25', '14:54', '2024-10-16 14:54:40'),
(103, 63, '2024-10-16 14:55:32', '1403/07/25', '14:55', '2024-10-16 14:55:32'),
(109, 63, '2024-10-16 14:56:18', '1403/07/25', '14:56', '2024-10-16 14:56:18'),
(112, 63, '2024-10-16 14:56:20', '1403/07/25', '14:56', '2024-10-16 14:56:20'),
(100, 63, '2024-10-16 14:56:28', '1403/07/25', '14:56', '2024-10-16 14:56:28'),
(97, 63, '2024-10-16 14:57:24', '1403/07/25', '14:57', '2024-10-16 14:57:24'),
(66, 63, '2024-10-16 14:57:40', '1403/07/25', '14:57', '2024-10-16 14:57:40'),
(96, 63, '2024-10-16 14:58:06', '1403/07/25', '14:58', '2024-10-16 14:58:06'),
(98, 63, '2024-10-16 14:58:11', '1403/07/25', '14:58', '2024-10-16 14:58:11'),
(68, 63, '2024-10-16 14:58:23', '1403/07/25', '14:58', '2024-10-16 14:58:23'),
(85, 63, '2024-10-16 14:58:45', '1403/07/25', '14:58', '2024-10-16 14:58:45'),
(82, 63, '2024-10-16 14:59:30', '1403/07/25', '14:59', '2024-10-16 14:59:30'),
(61, 63, '2024-10-16 15:00:00', '1403/07/25', '15:00', '2024-10-16 15:00:00'),
(55, 63, '2024-10-16 15:01:09', '1403/07/25', '15:01', '2024-10-16 15:01:09'),
(67, 63, '2024-10-16 15:01:21', '1403/07/25', '15:01', '2024-10-16 15:01:21'),
(110, 63, '2024-10-16 15:01:28', '1403/07/25', '15:01', '2024-10-16 15:01:28'),
(89, 63, '2024-10-16 15:01:32', '1403/07/25', '15:01', '2024-10-16 15:01:32'),
(128, 63, '2024-10-16 15:01:37', '1403/07/25', '15:01', '2024-10-16 15:01:37'),
(84, 63, '2024-10-16 15:01:39', '1403/07/25', '15:01', '2024-10-16 15:01:39'),
(90, 63, '2024-10-16 15:01:59', '1403/07/25', '15:01', '2024-10-16 15:01:59'),
(107, 63, '2024-10-16 15:02:01', '1403/07/25', '15:02', '2024-10-16 15:02:01'),
(115, 63, '2024-10-16 15:02:03', '1403/07/25', '15:02', '2024-10-16 15:02:03'),
(116, 63, '2024-10-16 15:02:11', '1403/07/25', '15:02', '2024-10-16 15:02:11'),
(60, 63, '2024-10-16 15:02:13', '1403/07/25', '15:02', '2024-10-16 15:02:13'),
(111, 63, '2024-10-16 15:02:31', '1403/07/25', '15:02', '2024-10-16 15:02:31'),
(124, 63, '2024-10-16 15:02:35', '1403/07/25', '15:02', '2024-10-16 15:02:35'),
(118, 63, '2024-10-16 15:02:36', '1403/07/25', '15:02', '2024-10-16 15:02:36'),
(102, 63, '2024-10-16 15:03:02', '1403/07/25', '15:03', '2024-10-16 15:03:02'),
(114, 63, '2024-10-16 15:03:07', '1403/07/25', '15:03', '2024-10-16 15:03:07'),
(22, 63, '2024-10-16 15:03:31', '1403/07/25', '15:03', '2024-10-16 15:03:31'),
(108, 63, '2024-10-16 15:04:58', '1403/07/25', '15:04', '2024-10-16 15:04:58'),
(91, 63, '2024-10-16 15:05:24', '1403/07/25', '15:05', '2024-10-16 15:05:24'),
(113, 63, '2024-10-16 15:06:06', '1403/07/25', '15:06', '2024-10-16 15:06:06'),
(86, 63, '2024-10-16 15:06:08', '1403/07/25', '15:06', '2024-10-16 15:06:08'),
(93, 63, '2024-10-16 15:07:28', '1403/07/25', '15:07', '2024-10-16 15:07:28'),
(95, 63, '2024-10-16 15:08:33', '1403/07/25', '15:08', '2024-10-16 15:08:33'),
(132, 63, '2024-10-16 15:08:50', '1403/07/25', '15:08', '2024-10-16 15:08:50'),
(117, 63, '2024-10-16 15:10:17', '1403/07/25', '15:10', '2024-10-16 15:10:17'),
(62, 63, '2024-10-16 15:18:52', '1403/07/25', '15:18', '2024-10-16 15:18:52'),
(64, 63, '2024-10-16 15:33:37', '1403/07/25', '15:33', '2024-10-16 15:33:37'),
(78, 63, '2024-10-16 15:52:54', '1403/07/25', '15:52', '2024-10-16 15:52:54'),
(121, 63, '2024-10-16 15:55:42', '1403/07/25', '15:55', '2024-10-16 15:55:42'),
(112, 4, '2024-10-19 15:55:48', '1403/07/28', '15:55', '2024-10-19 15:55:48'),
(103, 4, '2024-10-19 15:56:12', '1403/07/28', '15:56', '2024-10-19 15:56:12'),
(61, 4, '2024-10-19 15:58:06', '1403/07/28', '15:58', '2024-10-19 15:58:06'),
(90, 4, '2024-10-19 16:00:38', '1403/07/28', '16:00', '2024-10-19 16:00:38'),
(85, 4, '2024-10-19 16:00:49', '1403/07/28', '16:00', '2024-10-19 16:00:49'),
(89, 4, '2024-10-19 16:01:09', '1403/07/28', '16:01', '2024-10-19 16:01:09'),
(64, 4, '2024-10-19 16:01:31', '1403/07/28', '16:01', '2024-10-19 16:01:31'),
(66, 4, '2024-10-19 16:01:34', '1403/07/28', '16:01', '2024-10-19 16:01:34'),
(114, 4, '2024-10-19 16:01:43', '1403/07/28', '16:01', '2024-10-19 16:01:43'),
(122, 4, '2024-10-19 16:02:31', '1403/07/28', '16:02', '2024-10-19 16:02:31'),
(102, 4, '2024-10-19 16:02:33', '1403/07/28', '16:02', '2024-10-19 16:02:33'),
(128, 4, '2024-10-19 16:03:12', '1403/07/28', '16:03', '2024-10-19 16:03:12'),
(132, 4, '2024-10-19 16:03:20', '1403/07/28', '16:03', '2024-10-19 16:03:20'),
(78, 4, '2024-10-19 16:03:44', '1403/07/28', '16:03', '2024-10-19 16:03:44'),
(95, 4, '2024-10-19 16:04:18', '1403/07/28', '16:04', '2024-10-19 16:04:18'),
(82, 4, '2024-10-19 16:04:19', '1403/07/28', '16:04', '2024-10-19 16:04:19'),
(123, 4, '2024-10-19 16:04:34', '1403/07/28', '16:04', '2024-10-19 16:04:34'),
(91, 4, '2024-10-19 16:04:43', '1403/07/28', '16:04', '2024-10-19 16:04:43'),
(115, 4, '2024-10-19 16:08:28', '1403/07/28', '16:08', '2024-10-19 16:08:28'),
(116, 4, '2024-10-19 16:08:45', '1403/07/28', '16:08', '2024-10-19 16:08:45'),
(67, 4, '2024-10-19 16:08:59', '1403/07/28', '16:08', '2024-10-19 16:08:59'),
(106, 4, '2024-10-19 16:11:23', '1403/07/28', '16:11', '2024-10-19 16:11:23'),
(28, 4, '2024-10-19 16:19:14', '1403/07/28', '16:19', '2024-10-19 16:19:14'),
(97, 4, '2024-10-19 16:21:52', '1403/07/28', '16:21', '2024-10-19 16:21:52'),
(121, 4, '2024-10-19 16:31:40', '1403/07/28', '16:31', '2024-10-19 16:31:40'),
(108, 16, '2024-10-20 15:52:36', '1403/07/29', '15:52', '2024-10-20 15:52:36'),
(60, 16, '2024-10-20 15:53:16', '1403/07/29', '15:53', '2024-10-20 15:53:16'),
(118, 16, '2024-10-20 15:55:23', '1403/07/29', '15:55', '2024-10-20 15:55:23'),
(98, 16, '2024-10-20 15:55:26', '1403/07/29', '15:55', '2024-10-20 15:55:26'),
(85, 16, '2024-10-20 15:55:32', '1403/07/29', '15:55', '2024-10-20 15:55:32'),
(90, 16, '2024-10-20 15:56:05', '1403/07/29', '15:56', '2024-10-20 15:56:05'),
(67, 16, '2024-10-20 15:56:17', '1403/07/29', '15:56', '2024-10-20 15:56:17'),
(109, 16, '2024-10-20 15:56:17', '1403/07/29', '15:56', '2024-10-20 15:56:17'),
(112, 16, '2024-10-20 15:56:38', '1403/07/29', '15:56', '2024-10-20 15:56:38'),
(128, 16, '2024-10-20 15:57:06', '1403/07/29', '15:57', '2024-10-20 15:57:06'),
(119, 16, '2024-10-20 15:57:09', '1403/07/29', '15:57', '2024-10-20 15:57:09'),
(121, 16, '2024-10-20 15:57:58', '1403/07/29', '15:57', '2024-10-20 15:57:58'),
(115, 16, '2024-10-20 15:58:22', '1403/07/29', '15:58', '2024-10-20 15:58:22'),
(97, 16, '2024-10-20 15:58:33', '1403/07/29', '15:58', '2024-10-20 15:58:33'),
(122, 16, '2024-10-20 15:58:45', '1403/07/29', '15:58', '2024-10-20 15:58:45'),
(100, 16, '2024-10-20 15:58:47', '1403/07/29', '15:58', '2024-10-20 15:58:47'),
(61, 16, '2024-10-20 15:58:52', '1403/07/29', '15:58', '2024-10-20 15:58:52'),
(102, 16, '2024-10-20 15:59:57', '1403/07/29', '15:59', '2024-10-20 15:59:57'),
(111, 16, '2024-10-20 16:00:24', '1403/07/29', '16:00', '2024-10-20 16:00:24'),
(91, 16, '2024-10-20 16:00:51', '1403/07/29', '16:00', '2024-10-20 16:00:51'),
(66, 16, '2024-10-20 16:01:23', '1403/07/29', '16:01', '2024-10-20 16:01:23'),
(132, 16, '2024-10-20 16:01:41', '1403/07/29', '16:01', '2024-10-20 16:01:41'),
(89, 16, '2024-10-20 16:01:56', '1403/07/29', '16:01', '2024-10-20 16:01:56'),
(103, 16, '2024-10-20 16:02:41', '1403/07/29', '16:02', '2024-10-20 16:02:41'),
(62, 16, '2024-10-20 16:03:23', '1403/07/29', '16:03', '2024-10-20 16:03:23'),
(64, 16, '2024-10-20 16:03:37', '1403/07/29', '16:03', '2024-10-20 16:03:37'),
(123, 16, '2024-10-20 16:05:02', '1403/07/29', '16:05', '2024-10-20 16:05:02'),
(114, 16, '2024-10-20 16:05:05', '1403/07/29', '16:05', '2024-10-20 16:05:05'),
(82, 16, '2024-10-20 16:05:55', '1403/07/29', '16:05', '2024-10-20 16:05:55'),
(27, 16, '2024-10-20 16:05:55', '1403/07/29', '16:05', '2024-10-20 16:05:55'),
(117, 16, '2024-10-20 16:07:33', '1403/07/29', '16:07', '2024-10-20 16:07:33'),
(116, 16, '2024-10-20 16:07:40', '1403/07/29', '16:07', '2024-10-20 16:07:40'),
(113, 16, '2024-10-20 16:08:39', '1403/07/29', '16:08', '2024-10-20 16:08:39'),
(84, 16, '2024-10-20 16:11:39', '1403/07/29', '16:11', '2024-10-20 16:11:39'),
(78, 16, '2024-10-20 16:34:47', '1403/07/29', '16:34', '2024-10-20 16:34:47'),
(106, 16, '2024-10-20 16:38:15', '1403/07/29', '16:38', '2024-10-20 16:38:15');

-- --------------------------------------------------------

--
-- Table structure for table `quizs`
--

CREATE TABLE `quizs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `course_id` int(11) DEFAULT NULL COMMENT 'شناسه درس',
  `title` varchar(250) DEFAULT NULL COMMENT 'عنوان',
  `description` text DEFAULT NULL COMMENT 'توضیح',
  `group` varchar(255) DEFAULT '0',
  `end_time` varchar(20) DEFAULT NULL,
  `end_date` varchar(20) DEFAULT NULL,
  `start_date` varchar(20) DEFAULT NULL COMMENT 'تاریخ شروع آزمون',
  `start_time` varchar(20) DEFAULT NULL COMMENT 'تاریخ پایان آزمون',
  `limit_time` varchar(5) DEFAULT '0' COMMENT 'مدت زمان آزمون (دقیقه)',
  `one_page` varchar(1) NOT NULL DEFAULT '1' COMMENT 'تعداد صفحات آزمون(مقدار یک یعنی تمام سئوالات در یک صفحه|مقدار صفر هر سئوال در یک صفحه)',
  `total_score` varchar(5) NOT NULL DEFAULT '0' COMMENT 'جمع نمرات آزمون',
  `corrected_count` int(11) NOT NULL DEFAULT 0 COMMENT 'تعداد ازمون های تصحیح شده',
  `question_count` int(11) NOT NULL DEFAULT 0 COMMENT 'تعداد سئوالات آزمون',
  `answer_count` int(11) NOT NULL DEFAULT 0 COMMENT 'تعداد پاسخ های آزمون',
  `randomize` varchar(1) NOT NULL DEFAULT '1' COMMENT 'تعداد صفحات آزمون(مقدار یک یعنی تمام سئوالات در یک صفحه|مقدار صفر هر سئوال در یک صفحه)',
  `min` varchar(5) DEFAULT NULL,
  `max` varchar(5) DEFAULT NULL,
  `avg` varchar(5) DEFAULT NULL,
  `use_editor` varchar(1) NOT NULL DEFAULT '1' COMMENT 'تعداد صفحات آزمون(مقدار یک یعنی تمام سئوالات در یک صفحه|مقدار صفر هر سئوال در یک صفحه)',
  `creator_id` int(11) DEFAULT NULL COMMENT 'ثبت کننده آزمون',
  `editor_id` int(11) DEFAULT NULL COMMENT 'ویرایش کننده آزمون',
  `status_id` int(11) NOT NULL DEFAULT 1 COMMENT 'شناسه وضعیت فعال/غیر فعال',
  `lang` varchar(2) NOT NULL DEFAULT 'en' COMMENT 'زبان',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

--
-- Dumping data for table `quizs`
--

INSERT INTO `quizs` (`id`, `course_id`, `title`, `description`, `group`, `end_time`, `end_date`, `start_date`, `start_time`, `limit_time`, `one_page`, `total_score`, `corrected_count`, `question_count`, `answer_count`, `randomize`, `min`, `max`, `avg`, `use_editor`, `creator_id`, `editor_id`, `status_id`, `lang`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 31302, 'تست', '<p>تست</p>', '1403101', '11:11', '1403/07/06', '1403/07/05', '10:00', NULL, '1', '40', 0, 2, 0, '1', NULL, NULL, NULL, '1', 1, NULL, 1, 'en', '2024-09-26 17:54:19', '2024-09-26 10:09:42', '2024-09-26 10:09:42');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_answer`
--

CREATE TABLE `quiz_answer` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL COMMENT 'شناسه کاربر پاسخ دهنده',
  `question_id` int(11) DEFAULT NULL COMMENT 'شناسه سئوال',
  `quiz_attemp_id` int(11) DEFAULT NULL COMMENT 'شناسه رکورد شرکت رد آزمون',
  `question_type_id` int(11) NOT NULL DEFAULT 1 COMMENT 'شناسه نوع سئوال',
  `answer` text DEFAULT NULL COMMENT 'پاسخ تشریحی',
  `answer_option_id` int(11) DEFAULT NULL COMMENT 'شناسه نوع سئوال',
  `score` varchar(5) NOT NULL DEFAULT '0' COMMENT 'نمره',
  `view_time` varchar(5) NOT NULL DEFAULT '0' COMMENT 'درج زمان مشاهده سئوال',
  `course_id` int(11) DEFAULT NULL COMMENT 'شناسه درس',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

--
-- Dumping data for table `quiz_answer`
--

INSERT INTO `quiz_answer` (`id`, `user_id`, `question_id`, `quiz_attemp_id`, `question_type_id`, `answer`, `answer_option_id`, `score`, `view_time`, `course_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 1, NULL, NULL, '0', '0', 31302, NULL, '2024-09-26 10:09:53', '2024-09-26 10:09:53'),
(2, 1, 2, 1, 2, NULL, NULL, '0', '0', 31302, NULL, '2024-09-26 10:09:53', '2024-09-26 10:09:53'),
(3, 111, 1, 2, 1, NULL, NULL, '0', '0', 31302, NULL, '2024-09-26 17:42:04', '2024-09-26 17:42:04'),
(4, 111, 2, 2, 2, NULL, NULL, '0', '0', 31302, NULL, '2024-09-26 17:42:04', '2024-09-26 17:42:04');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_attemp`
--

CREATE TABLE `quiz_attemp` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL COMMENT 'شناسه کاربر آزمون دهنده',
  `course_id` int(11) DEFAULT NULL COMMENT 'شناسه درس',
  `quiz_id` int(11) DEFAULT NULL COMMENT 'شناسه آزمون',
  `start_at` varchar(20) DEFAULT NULL COMMENT 'شروع آزمون کاربر',
  `end_at` varchar(20) DEFAULT NULL COMMENT 'پایان آزمون کاربر',
  `deadline` varchar(20) DEFAULT NULL COMMENT 'مهلت پاسخگویی',
  `total_score` varchar(5) NOT NULL DEFAULT '0' COMMENT 'جمع نمره دانشجو',
  `quiz_score` varchar(5) NOT NULL DEFAULT '0' COMMENT 'جمع نمره آزمون',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

--
-- Dumping data for table `quiz_attemp`
--

INSERT INTO `quiz_attemp` (`id`, `user_id`, `course_id`, `quiz_id`, `start_at`, `end_at`, `deadline`, `total_score`, `quiz_score`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 31302, 1, '2024-09-26 10:09:53', NULL, '1403/07/06 11:11', '0', '40', NULL, '2024-09-26 10:09:53', '2024-09-26 10:09:53'),
(2, 111, 31302, 1, '2024-09-26 17:42:04', NULL, '1403/07/06 11:11', '0', '40', NULL, '2024-09-26 17:42:04', '2024-09-26 17:42:04');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_options`
--

CREATE TABLE `quiz_options` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(250) DEFAULT NULL COMMENT 'عنوان',
  `question_id` int(11) DEFAULT NULL COMMENT 'شناسه سئوال',
  `order` int(11) DEFAULT NULL COMMENT 'ترتیب',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

--
-- Dumping data for table `quiz_options`
--

INSERT INTO `quiz_options` (`id`, `title`, `question_id`, `order`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'تست', 2, 1, NULL, '2024-09-26 10:09:42', '2024-09-26 10:09:42'),
(2, '2', 2, 2, NULL, '2024-09-26 10:09:42', '2024-09-26 10:09:42'),
(3, '3', 2, 3, NULL, '2024-09-26 10:09:42', '2024-09-26 10:09:42'),
(4, 'چار', 2, 4, NULL, '2024-09-26 10:09:42', '2024-09-26 10:09:42');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_questions`
--

CREATE TABLE `quiz_questions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` text DEFAULT NULL COMMENT 'سئوال',
  `quiz_id` int(11) DEFAULT NULL COMMENT 'شناسه آزمون',
  `question_type_id` int(11) NOT NULL DEFAULT 1 COMMENT 'شناسه نوع سئوال',
  `correct_option_id` int(11) NOT NULL DEFAULT 1 COMMENT 'شناسه پاسخ صحیح',
  `order` int(11) DEFAULT NULL COMMENT 'ترتیب',
  `score` varchar(5) NOT NULL DEFAULT '0' COMMENT 'نمره',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

--
-- Dumping data for table `quiz_questions`
--

INSERT INTO `quiz_questions` (`id`, `title`, `quiz_id`, `question_type_id`, `correct_option_id`, `order`, `score`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'سوال یک', 1, 1, 1, 1, '20', NULL, '2024-09-26 10:09:42', '2024-09-26 10:09:42'),
(2, 'سوال دو', 1, 2, 2, 2, '20', NULL, '2024-09-26 10:09:42', '2024-09-26 10:09:42');

-- --------------------------------------------------------

--
-- Table structure for table `surveys`
--

CREATE TABLE `surveys` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL COMMENT 'عنوان',
  `course_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'شناسه درس',
  `creator_id` int(11) DEFAULT NULL COMMENT 'شناسه کاربر ثبت کننده',
  `editor_id` int(11) DEFAULT NULL COMMENT 'شناسه کاربر ویرایش کننده',
  `group` varchar(255) DEFAULT '0' COMMENT 'گروه(سال و ترم و گروه)',
  `start_date` varchar(255) DEFAULT NULL COMMENT 'تاریخ شروع نظر سنجی',
  `expire_date` varchar(255) DEFAULT NULL COMMENT 'تاریخ پایان نظر سنجی',
  `description` text DEFAULT NULL COMMENT 'توضیح',
  `count_question` int(11) NOT NULL DEFAULT 0 COMMENT 'تعداد سئوالات',
  `count_response` int(11) NOT NULL DEFAULT 0 COMMENT 'تعداد پاسخ ها به نظر سنجی',
  `lang` varchar(255) NOT NULL DEFAULT 'fa' COMMENT 'زبان',
  `status_id` int(11) NOT NULL DEFAULT 1 COMMENT 'شناسه وضعیت فعال/غیر فعال',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `survey_answer`
--

CREATE TABLE `survey_answer` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `attemp_id` int(11) DEFAULT NULL COMMENT 'شناسه جدول میانی کاربر و نظرسنجی',
  `survey_id` int(11) DEFAULT NULL COMMENT 'شناسه نظرسنجی',
  `user_id` int(11) DEFAULT NULL COMMENT 'شناسه کاربر',
  `question_id` int(11) DEFAULT NULL COMMENT 'شناسه سئوال',
  `question_option_id` int(11) DEFAULT NULL COMMENT 'شناسه گزینه انتخابی',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `survey_attemp`
--

CREATE TABLE `survey_attemp` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `survey_id` int(11) DEFAULT NULL COMMENT 'شناسه نظر سنجی',
  `user_id` int(11) DEFAULT NULL COMMENT 'ناسه کاربر',
  `course_id` int(11) DEFAULT NULL COMMENT 'شناسه درس',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `survey_questions`
--

CREATE TABLE `survey_questions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL COMMENT 'عنوان',
  `survey_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'شناسه نظر سنجی',
  `question_type_id` int(11) NOT NULL DEFAULT 2 COMMENT 'شناسه نوع سئوال(فقط چند گزینه ای)',
  `order` int(11) DEFAULT NULL COMMENT 'ترتیب',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `survey_question_options`
--

CREATE TABLE `survey_question_options` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL COMMENT 'عنوان',
  `question_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'شناسه سئوال',
  `order` int(11) DEFAULT NULL COMMENT 'ترتیب',
  `count_selected` int(11) NOT NULL DEFAULT 0 COMMENT 'تعداد انتخاب ها',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tools`
--

CREATE TABLE `tools` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title_fa` varchar(255) NOT NULL,
  `title_en` varchar(255) NOT NULL,
  `href` varchar(255) NOT NULL,
  `img` varchar(255) NOT NULL,
  `order` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT 1,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

--
-- Dumping data for table `tools`
--

INSERT INTO `tools` (`id`, `title_fa`, `title_en`, `href`, `img`, `order`, `status_id`, `description`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'خط سیر آموزشی', 'learnpath', 'learnpath', 'learnpath.png', 1, 1, 'ابزارهای دوره‌های آموزشی ما از جمله خط سیر آموزشی، کلاس آنلاین، آرشیو کلاس آنلاین، آزمون، تکلیف، پیامگاه، ارسال و دریافت تحقیقات، و نظرسنجی، به شما امکان می‌دهند تا به راحتی به منابع آموزشی دسترسی پیدا کنید، در کلاس‌های زنده شرکت کنید، و تکالیف خود را ارسال و ارزیابی کنید. این ابزارها با هدف ارتقای تجربه آموزشی شما طراحی شده‌اند و امکانات مختلفی را برای بهبود یادگیری و ارتباط بین دانش‌آموزان و مدرسان فراهم می‌سازند.', NULL, NULL, NULL),
(2, 'کلاس آنلاین', 'online_classroom', 'onlineClassroom', 'onlineclassroom.jpg', 2, 1, 'ابزارهای دوره‌های آموزشی ما از جمله خط سیر آموزشی، کلاس آنلاین، آرشیو کلاس آنلاین، آزمون، تکلیف، پیامگاه، ارسال و دریافت تحقیقات، و نظرسنجی، به شما امکان می‌دهند تا به راحتی به منابع آموزشی دسترسی پیدا کنید، در کلاس‌های زنده شرکت کنید، و تکالیف خود را ارسال و ارزیابی کنید. این ابزارها با هدف ارتقای تجربه آموزشی شما طراحی شده‌اند و امکانات مختلفی را برای بهبود یادگیری و ارتباط بین دانش‌آموزان و مدرسان فراهم می‌سازند.', NULL, NULL, NULL),
(3, 'آرشیو کلاس آنلاین', 'online_archives', 'onlineClassroomArchives', 'online_archives.jpg', 3, 1, 'ابزارهای دوره‌های آموزشی ما از جمله خط سیر آموزشی، کلاس آنلاین، آرشیو کلاس آنلاین، آزمون، تکلیف، پیامگاه، ارسال و دریافت تحقیقات، و نظرسنجی، به شما امکان می‌دهند تا به راحتی به منابع آموزشی دسترسی پیدا کنید، در کلاس‌های زنده شرکت کنید، و تکالیف خود را ارسال و ارزیابی کنید. این ابزارها با هدف ارتقای تجربه آموزشی شما طراحی شده‌اند و امکانات مختلفی را برای بهبود یادگیری و ارتباط بین دانش‌آموزان و مدرسان فراهم می‌سازند.', NULL, NULL, NULL),
(4, 'آرشیو کلاس آنلاین سنوات قبل', 'online_past_archives', 'onlineClassroomPastArchives', 'online_past_archives.jpg', 4, 1, 'ابزارهای دوره‌های آموزشی ما از جمله خط سیر آموزشی، کلاس آنلاین، آرشیو کلاس آنلاین، آزمون، تکلیف، پیامگاه، ارسال و دریافت تحقیقات، و نظرسنجی، به شما امکان می‌دهند تا به راحتی به منابع آموزشی دسترسی پیدا کنید، در کلاس‌های زنده شرکت کنید، و تکالیف خود را ارسال و ارزیابی کنید. این ابزارها با هدف ارتقای تجربه آموزشی شما طراحی شده‌اند و امکانات مختلفی را برای بهبود یادگیری و ارتباط بین دانش‌آموزان و مدرسان فراهم می‌سازند.', NULL, NULL, NULL),
(5, 'آزمون', 'quiz', 'quiz', 'quiz.jpg', 5, 1, 'ابزارهای دوره‌های آموزشی ما از جمله خط سیر آموزشی، کلاس آنلاین، آرشیو کلاس آنلاین، آزمون، تکلیف، پیامگاه، ارسال و دریافت تحقیقات، و نظرسنجی، به شما امکان می‌دهند تا به راحتی به منابع آموزشی دسترسی پیدا کنید، در کلاس‌های زنده شرکت کنید، و تکالیف خود را ارسال و ارزیابی کنید. این ابزارها با هدف ارتقای تجربه آموزشی شما طراحی شده‌اند و امکانات مختلفی را برای بهبود یادگیری و ارتباط بین دانش‌آموزان و مدرسان فراهم می‌سازند.', NULL, NULL, NULL),
(6, 'تکلیف', 'assignments', 'assignment', 'assignment.jpg', 6, 1, 'ابزارهای دوره‌های آموزشی ما از جمله خط سیر آموزشی، کلاس آنلاین، آرشیو کلاس آنلاین، آزمون، تکلیف، پیامگاه، ارسال و دریافت تحقیقات، و نظرسنجی، به شما امکان می‌دهند تا به راحتی به منابع آموزشی دسترسی پیدا کنید، در کلاس‌های زنده شرکت کنید، و تکالیف خود را ارسال و ارزیابی کنید. این ابزارها با هدف ارتقای تجربه آموزشی شما طراحی شده‌اند و امکانات مختلفی را برای بهبود یادگیری و ارتباط بین دانش‌آموزان و مدرسان فراهم می‌سازند.', NULL, NULL, NULL),
(7, 'پیامگاه', 'forum', 'forum', 'forum.jpg', 7, 1, 'ابزارهای دوره‌های آموزشی ما از جمله خط سیر آموزشی، کلاس آنلاین، آرشیو کلاس آنلاین، آزمون، تکلیف، پیامگاه، ارسال و دریافت تحقیقات، و نظرسنجی، به شما امکان می‌دهند تا به راحتی به منابع آموزشی دسترسی پیدا کنید، در کلاس‌های زنده شرکت کنید، و تکالیف خود را ارسال و ارزیابی کنید. این ابزارها با هدف ارتقای تجربه آموزشی شما طراحی شده‌اند و امکانات مختلفی را برای بهبود یادگیری و ارتباط بین دانش‌آموزان و مدرسان فراهم می‌سازند.', NULL, NULL, NULL),
(8, 'ارسال و دریافت تحقیقات', 'inbox', 'inbox', 'message_box.jpg', 8, 0, 'ابزارهای دوره‌های آموزشی ما از جمله خط سیر آموزشی، کلاس آنلاین، آرشیو کلاس آنلاین، آزمون، تکلیف، پیامگاه، ارسال و دریافت تحقیقات، و نظرسنجی، به شما امکان می‌دهند تا به راحتی به منابع آموزشی دسترسی پیدا کنید، در کلاس‌های زنده شرکت کنید، و تکالیف خود را ارسال و ارزیابی کنید. این ابزارها با هدف ارتقای تجربه آموزشی شما طراحی شده‌اند و امکانات مختلفی را برای بهبود یادگیری و ارتباط بین دانش‌آموزان و مدرسان فراهم می‌سازند.', NULL, NULL, '2024-09-09 06:02:59'),
(9, 'نظرسنجی', 'survey', 'survey', 'survey.jpg', 9, 1, 'ابزارهای دوره‌های آموزشی ما از جمله خط سیر آموزشی، کلاس آنلاین، آرشیو کلاس آنلاین، آزمون، تکلیف، پیامگاه، ارسال و دریافت تحقیقات، و نظرسنجی، به شما امکان می‌دهند تا به راحتی به منابع آموزشی دسترسی پیدا کنید، در کلاس‌های زنده شرکت کنید، و تکالیف خود را ارسال و ارزیابی کنید. این ابزارها با هدف ارتقای تجربه آموزشی شما طراحی شده‌اند و امکانات مختلفی را برای بهبود یادگیری و ارتباط بین دانش‌آموزان و مدرسان فراهم می‌سازند.', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `firstname` varchar(255) DEFAULT NULL COMMENT 'نام',
  `lastname` varchar(255) DEFAULT NULL COMMENT 'نام خانوادگی',
  `photo` varchar(255) DEFAULT NULL COMMENT 'تصویر',
  `mobile` varchar(255) DEFAULT NULL COMMENT 'شماره همراه',
  `username` varchar(255) DEFAULT NULL COMMENT 'نام کاربری',
  `role_id` int(11) DEFAULT NULL COMMENT 'نقش',
  `codemeli` varchar(20) DEFAULT NULL COMMENT 'کدملی',
  `email` varchar(50) DEFAULT NULL COMMENT 'ایمیل',
  `count_presented` int(11) NOT NULL DEFAULT 0 COMMENT 'تعداد دروس ارائه شده استاد',
  `count_register` int(11) NOT NULL DEFAULT 0 COMMENT 'تعداد دروس ثبت نام شده',
  `password` varchar(255) DEFAULT NULL COMMENT 'رمز عبور',
  `creator_id` int(11) DEFAULT NULL COMMENT 'شناسه کاربر ثبت کننده',
  `editor_id` int(11) DEFAULT NULL COMMENT 'شناسه کاربر ویرایش کننده',
  `studentID` varchar(12) DEFAULT NULL COMMENT 'کد دانشجویی',
  `person_id` int(11) DEFAULT NULL COMMENT 'کد پرسنلی',
  `gender_id` int(11) DEFAULT NULL COMMENT 'جنسیت',
  `resume` text DEFAULT NULL COMMENT 'رزومه استاد',
  `status_id` int(11) NOT NULL DEFAULT 1 COMMENT 'شناسه وضعیت فعال/غیر فعال',
  `lang` varchar(2) NOT NULL DEFAULT 'fa' COMMENT 'زبان',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `photo`, `mobile`, `username`, `role_id`, `codemeli`, `email`, `count_presented`, `count_register`, `password`, `creator_id`, `editor_id`, `studentID`, `person_id`, `gender_id`, `resume`, `status_id`, `lang`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'مهدی', 'وثوقی', 'image71601727502574.jpg', '09191964745', '09191964745', 4, NULL, 'sanegar.info@gmail.com', 0, 0, '$2y$12$onogYslcq05.1lR6PICdH.0V526DqEd11807W0KzgMZBSDPVhqD.a', 1, 1, NULL, NULL, 1, '', 1, 'fa', NULL, '2024-07-06 15:52:35', '2024-09-28 13:57:20'),
(9, 'مالک', 'اکرمی', '9.jpg', '09129999999', NULL, 3, NULL, 'Akrami@gmail.com', 0, 0, '$2y$12$RQV5eAHvfxPglCa0x7kaXuacRTWMlLGjCj4HeBV1hLzzfdHzUltxq', NULL, NULL, '4444', 99999, 1, '', 1, 'fa', NULL, '2024-07-06 15:52:35', '2024-07-06 15:52:35'),
(10, 'مصطفی', 'ذاکر رضوی', 'image26541727669632.jpg', '09194524024', '09194524024', 4, '0947171207', 'razavi@gmail.com', 0, 0, '$2y$12$Fu9RYSlmzNqYHwu0ElAu7OHFEHlV1xEwJwq6S4bdiHaOLQB9DESL.', 1, 1, '888', 121212, 1, '', 1, 'fa', NULL, '2024-08-19 07:41:18', '2024-09-30 07:43:54'),
(18, 'حمید', 'شاه محمدی', 'image25581726385151.jpg', '09131990750', '2992927058', 5, NULL, 'hamid2432@ymail.com', 0, 0, '$2y$12$V56x3nXW07/WPUAmXImFXOsyDkEmb24LrusX.tB3ObXNKHeI2voKe', 1, 18, '1111111111', NULL, 1, '', 1, 'fa', NULL, '2024-09-15 10:55:54', '2024-09-30 09:15:20'),
(19, 'حجت الاسلام دکتر جعفر', 'احمدی', 'image60451726466691.jpg', '09191475669', '09191475669', 4, NULL, 'ahmadi@jmail.com', 0, 0, '$2y$12$By7UFyzHargbLe45aWN4qedufQjkb/FIjunzwI6dfNCBfXak.APDW', 1, NULL, NULL, NULL, 1, '', 1, 'fa', NULL, '2024-09-16 09:34:56', '2024-09-18 10:59:18'),
(140, 'شمس الله', 'معلم کلایی', 'image41841728285531.jpg', '09106129822', '5010468182', 9, '5010468182', NULL, 0, 0, '$2y$12$MCdjVcByGwGUR8Y7ERYD9uvYFNGK48qlIuP6ie2bq1WoxloQNwqsu', 1, NULL, NULL, NULL, 1, NULL, 1, 'fa', NULL, '2024-10-07 10:51:37', '2024-10-07 10:51:37'),
(21, 'مرادعلی', 'شورگشتی', 'image94601726469763.jpg', '09196665146', '6449283351', 1, '6449283351', NULL, 2, 0, '$2y$12$7ERjmJLpgsL8YsaL8eA5O.hJ5pCRJb42hWwe.tz0Pdp5cGjZz9QNm', NULL, 18, NULL, NULL, 1, NULL, 1, 'fa', NULL, '2024-09-16 10:26:05', '2024-10-01 13:11:40'),
(22, 'علی', 'رهید', 'image91441726469831.jpg', '09124489718', '2122719680', 1, '2122719680', NULL, 2, 0, '$2y$12$qKPV0nj5SWS/kIcIXn/w9uayHY2MyUa4HnqV0JQoGD0SSmOkpniNO', NULL, 18, NULL, NULL, 1, NULL, 1, 'fa', NULL, '2024-09-16 10:27:13', '2024-10-01 09:29:37'),
(23, 'ابوذر', 'تشکری صالح', 'image25891726469923.jpg', '09192946469', '5739729335', 1, '5739729335', NULL, 1, 0, '$2y$12$dM.nL2qQlhzEvyNFA6EW5eMYgdeX3MypbzUUvnETgOFb3Qz9VKgla', NULL, 18, NULL, NULL, 1, NULL, 1, 'fa', NULL, '2024-09-16 10:28:52', '2024-10-01 09:28:39'),
(24, 'حسن', 'صادقی', 'image53021726470003.jpg', '09127527506', '4280934630', 1, '4280934630', NULL, 1, 0, '$2y$12$Wda4urX3NDPMN.wvNrx1vuNVcH0B8ojUhOb4SJunD7m4cG1T46SBm', NULL, 18, NULL, NULL, 1, NULL, 1, 'fa', NULL, '2024-09-16 10:30:12', '2024-10-01 09:28:20'),
(25, 'سیدحامد', 'طاهری', 'image78401726470074.jpg', '09123518449', '4070712925', 1, '4070712925', NULL, 1, 0, '$2y$12$jGf70astw0oe/giE1R5VB.5/eV.7CIGeySUsKp4FYp79D89eIR97S', NULL, 18, NULL, NULL, 1, NULL, 1, 'fa', NULL, '2024-09-16 10:31:17', '2024-10-01 09:27:54'),
(26, 'حسین', 'احمدی حسین آبادی', 'image86821726470375.jpg', '09336734903', NULL, 9, NULL, 'ahmadi1@gmail.com', 0, 0, '$2y$12$KcFLyKDusyiPjF99jxpz0.4lISVJ39OkhfmkjUHmeZ5gkTPOdOTye', 1, 1, NULL, NULL, 1, '', 1, 'fa', '2024-09-30 09:13:00', '2024-09-16 10:36:16', '2024-09-30 09:13:00'),
(27, 'محمدرضا', 'محمدعلیزاده', 'image90011726472862.jpg', '09124528107', '2001636891', 1, '2001636891', NULL, 1, 0, '$2y$12$Vz0ELBJ8F7wJjzoPV/3.uunrimWtLFo5vXWYnCb8DNv9k/AIpCrmG', NULL, 18, NULL, NULL, 1, NULL, 1, 'fa', NULL, '2024-09-16 11:17:46', '2024-10-01 09:27:26'),
(28, 'حسین', 'ناگهی', 'image76201726472965.jpg', '09161682044', '4133203038', 1, '4133203038', NULL, 1, 0, '$2y$12$Ft67Xhngc5nBAbTZzDskSe.6XdJOuuQW02mqE5VPlGCtjwt6tgcOa', NULL, 1, NULL, NULL, 1, 'رزومه استاد', 1, 'fa', NULL, '2024-09-16 11:19:30', '2024-10-01 09:23:17'),
(29, 'مهدی', 'شاه محمدی', 'image40461726473951.jpg', '09131961347', '2993510665', 5, '2993510665', 'mehdi@gmail.com', 0, 0, '$2y$12$W27teZvUy7N/wL/ZbkTzN.Y8Rh2E9zBNyzu5fqDJvHuwY5k6dTe3a', 1, 18, NULL, NULL, 1, '', 1, 'fa', NULL, '2024-09-16 11:35:56', '2024-09-30 09:14:52'),
(30, 'سميه', 'عامري اختيارآبادي', 'image16561726474802.jpg', '09352374413', '2990649433', 2, '2990649433', '03114837001@gmail.com', 0, 0, '$2y$12$iLjE2SNog7kMPxVCaBCel.TIjh2EDrdk2sBFtbYBkQe4NkcptJEr6', 29, 29, '03114837001', NULL, 2, '', 1, 'fa', NULL, '2024-09-16 11:56:26', '2024-09-26 13:21:28'),
(31, 'طاهره', 'گل دوزها', 'image38651726476903.jpg', '09120875169', NULL, 2, NULL, '00114837009@gmail.com', 0, 0, '$2y$12$KLK6Wivd1wEs8Jgq2H.Lh.0ZBiJ9VaW7.zfdWdxQ5Tmx.TChX1tm6', 29, NULL, '00114837009', NULL, 1, '', 1, 'fa', '2024-09-19 09:37:32', '2024-09-16 12:25:14', '2024-09-19 09:37:32'),
(32, 'فاطمه', 'براتي آشتياني', 'image34141726477035.jpg', '09107230406', NULL, 2, NULL, '00114837018@gmail.com', 0, 0, '$2y$12$q/KLXa46EVmrd6Bik6xvIO9MH48NS/OpYHqU.YojDuh8XkF8C4I2m', 29, NULL, '00114837018', NULL, 2, '', 1, 'fa', '2024-09-19 09:38:00', '2024-09-16 12:27:17', '2024-09-19 09:38:00'),
(33, 'مجتبي', 'نيازمند', 'image34561726477228.jpg', '09153825687', NULL, 2, NULL, '00124837031@gmail.com', 0, 0, '$2y$12$bllITxCqBSl59pv45Dpx9OZPRxcNLf/lyPBt9lm/mzKso4iw3C4h2', 29, NULL, '00124837031', NULL, 1, '', 1, 'fa', '2024-09-19 09:38:22', '2024-09-16 12:30:31', '2024-09-19 09:38:22'),
(34, 'زهرا', 'كشاورزبهرغاني', 'image38701726477429.jpg', '09179811614', '2540004326', 2, '2540004326', '01114837006@gmail.com', 0, 0, '$2y$12$98W0E3Eo557jLfEhn9L.buA0HWyoe2WjD2Jk1IF9xCfoK3gH7FpVa', 29, 29, '01114837006', NULL, 2, '', 1, 'fa', NULL, '2024-09-16 12:34:00', '2024-09-26 13:21:28'),
(35, 'حبيبه', 'قاضي زاده احسائي', 'image88501726477551.jpg', '09132989184', '6079800802', 2, '6079800802', '01114837009@gmail.com', 0, 0, '$2y$12$XOVjVPddehhkVEatAydo.uIgoaGAeekpWQfMxBL6hqa3otnqcXBM6', 29, 29, '01114837009', NULL, 2, '', 1, 'fa', NULL, '2024-09-16 12:35:54', '2024-09-26 13:21:29'),
(36, 'پروين', 'نعمت اللهي', 'image97751726477670.jpg', '09166719730', '1861174357', 2, '1861174357', '01114837014@gmail.com', 0, 0, '$2y$12$zfJ/ahl8XytYREMPKLkP5urn4Ox/6Ymuv7FjGu1j7L6z5X3ubOj0C', 29, 29, '01114837014', NULL, 2, '', 1, 'fa', NULL, '2024-09-16 12:37:55', '2024-09-26 13:21:29'),
(37, 'سيده زهرا', 'حسيني', 'image33921726477872.jpg', '09115304196', NULL, 2, NULL, '01114837016@gmail.com', 0, 0, '$2y$12$ogtR5NIuFHIvuKzPQVNWguqgAh2glAItl0r7snjk82B1cHQgldRAC', 29, NULL, '01114837016', NULL, 2, '', 1, 'fa', '2024-09-19 09:40:12', '2024-09-16 12:41:19', '2024-09-19 09:40:12'),
(38, 'محبوبه', 'حسيني', 'image5121726477979.jpg', '09153725848', NULL, 2, NULL, '01114837019@gmail.com', 0, 0, '$2y$12$1AmAF0DPA5Foh9SBoVrZYOPcCzydFOKm46JNfnEdcNL/fBx0fngiO', 29, NULL, '01114837019', NULL, 2, '', 1, 'fa', '2024-09-19 09:40:43', '2024-09-16 12:43:00', '2024-09-19 09:40:43'),
(39, 'طيبه', 'رباني فر', 'image48451726478101.jpg', '09158212132', '0749417285', 2, '0749417285', '01114837021@gmail.com', 0, 0, '$2y$12$NE4SZmRtUNv0L93.54RAeekgpxyW7a5ytjIThErrz.9L.goDYPRse', 29, 29, '01114837021', NULL, 2, '', 1, 'fa', NULL, '2024-09-16 12:45:03', '2024-09-26 13:21:29'),
(40, 'فاطمه', 'جعفري هفشجاني', 'image85041726478196.jpg', '09139817310', '4622665530', 2, '4622665530', '01114837022@gmail.com', 0, 0, '$2y$12$MzesiEq51yXjK7hzY7gsdOnoWT5fPsk2AjAWBskGwOsui7sQwM2uu', 29, 29, '01114837022', NULL, 2, '', 1, 'fa', NULL, '2024-09-16 12:46:38', '2024-09-26 13:21:29'),
(41, 'ريحانه', 'دهقاني', 'image27201726478419.jpg', '09151631251', NULL, 2, NULL, '01114837025@gmail.com', 0, 0, '$2y$12$FIkodQxhkU1x5x1adffSNu5pMUqqoMdzfA4gkeTOqWYzF7U1GOc5a', 29, NULL, '01114837025', NULL, 2, NULL, 1, 'fa', '2024-09-19 09:41:40', '2024-09-16 12:51:37', '2024-09-19 09:41:40'),
(42, 'منيره', 'حيدريان', 'image76171726478604.jpg', '09124493868', NULL, 2, NULL, '01114837027@gmail.com', 0, 0, '$2y$12$IGKybbOh22nf0O9nfkZx3OJhl5ntGIkiBR8nG1aATeJkiJXrc8.Xq', 29, NULL, '01114837027', NULL, 2, NULL, 1, 'fa', '2024-09-19 09:41:58', '2024-09-16 12:53:26', '2024-09-19 09:41:58'),
(43, 'زهرا', 'اميني', 'image66011726479904.jpg', '09107553029', '3240813114', 2, '3240813114', '01114837032@gmail.com', 0, 0, '$2y$12$AOG0yFtXuMaZBxat9Le4Q.WTmoNLPJg1b3jmHO5UIw0EOpIj7U.we', 29, 29, '01114837032', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-16 13:15:08', '2024-09-26 13:21:30'),
(44, 'فاطمه', 'احمدي', 'image16921726480024.jpg', '09117010451', NULL, 2, NULL, '01114837035@gmail.com', 0, 0, '$2y$12$oqaV4hB9a6sRI6U63rsTseqaebOkTkDUyRHYJI37.pKyQJpQRz5ta', 29, NULL, '01114837035', NULL, 2, NULL, 1, 'fa', '2024-09-19 09:42:30', '2024-09-16 13:17:05', '2024-09-19 09:42:30'),
(45, 'وحيده', 'فتاحي طغرالجردي', 'image53521726480284.jpg', '09162778924', '3091279391', 2, '3091279391', '01114837037@gmail.com', 0, 0, '$2y$12$G5DH61Wt5Q34rBVhfw5FR.MBJx7/UEB498SfetVK4uXtYzD3z5Bue', 29, 29, '01114837037', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-16 13:21:28', '2024-10-01 09:17:52'),
(46, 'حسنيه', 'مهقاني', 'image65431726480351.jpg', '09117703639', '2110185481', 2, '2110185481', '01114837039@gmail.com', 0, 0, '$2y$12$UI2EUYEG13fZqr6EnUIV5.eHvdZR0h6FtefAczWnTCGMtnanslhNa', 29, 29, '01114837039', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-16 13:23:09', '2024-10-01 09:18:09'),
(47, 'فاطمه', 'منتظري', 'image3361726481198.jpg', '09112800382', NULL, 2, NULL, '01114837040@gmail.com', 0, 0, '$2y$12$dS6QdenrzfGWOm9p03Tco.DcyQF8UtqmZvo7c5KfayJqDzbXC0822', 29, NULL, '01114837040', NULL, 2, NULL, 1, 'fa', '2024-09-19 09:43:15', '2024-09-16 13:36:40', '2024-09-19 09:43:15'),
(48, 'سيده زهرا', 'طاهري', 'image59791726481281.jpg', '09171743220', '3490401281', 2, '3490401281', '01114837041@gmail.com', 0, 0, '$2y$12$5wFUxZleIyCw709q3GXkS.7cHQomogBO6IjXPEtNclG9av9Zorr6.', 29, 29, '01114837041', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-16 13:38:09', '2024-09-26 13:21:30'),
(49, 'مائده', 'اسفندياري', 'image56071726481393.jpg', '09127515957', NULL, 2, NULL, '01114837042@gmail.com', 0, 0, '$2y$12$ecUK9fs0lXXipF3pTEjtUOMlvimcgedcdKVQ2aB3WaQRPrpXKlwf.', 29, NULL, '01114837042', NULL, 2, NULL, 1, 'fa', '2024-09-19 09:43:50', '2024-09-16 13:39:56', '2024-09-19 09:43:50'),
(50, 'ناهيد', 'صادقيان', 'image15271726481515.jpg', '09133500733', '4431787501', 2, '4431787501', '01114837048@gmail.com', 0, 0, '$2y$12$E9NrjEaFW8oR9ZAw1tjNQOIvl0EAGVQwZYRqavFHtvDhQuRbzcrMm', 29, 29, '01114837048', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-16 13:42:01', '2024-09-26 13:21:30'),
(51, 'علي', 'مظاهري بوداني', 'image21661726481637.jpg', '09103983802', NULL, 2, NULL, '01124837001@gmail.com', 0, 0, '$2y$12$sg3mlv9qMlCT2VAP5EnU1uUu4i420XewPr/jpD3b0lRgK2SPQ2.AO', 29, NULL, '01124837001', NULL, 1, NULL, 1, 'fa', '2024-09-19 09:44:22', '2024-09-16 13:43:58', '2024-09-19 09:44:22'),
(52, 'سيديحيي', 'كاظمي مازندراني', 'image3781726481722.jpg', '09102044104', '4839729719', 2, '4839729719', '01124837002@gmail.com', 0, 0, '$2y$12$NlAYmt.FxTa2VIxYj9Ce0.QMAUEeCSa8t1KJM/IFr.Jdxs2TEWmWK', 29, 29, '01124837002', NULL, 1, NULL, 1, 'fa', NULL, '2024-09-16 13:45:24', '2024-09-26 13:21:31'),
(53, 'ابوالفضل', 'خانجاني', 'image5891726481762.jpg', '09189651355', '0559176181', 2, '0559176181', '01124837005@gmail.com', 0, 0, '$2y$12$M3gwiTRvEsTQGBvERBaHzOGQBYxAV9AkQL1NmPbi88w1w6hSGLksC', 29, 29, '01124837005', NULL, 1, NULL, 1, 'fa', NULL, '2024-09-16 13:46:35', '2024-09-26 13:21:31'),
(54, 'سيدروح اله', 'رضويان', 'image90301726481835.jpg', '09124449534', '0080108131', 2, '0080108131', '01124837008@gmail.com', 0, 0, '$2y$12$YvWRb4TuDG1Swzlod/.Uqem/49/Y5bzO4AOlNznDRz2/0g.36abZ.', 29, 29, '01124837008', NULL, 1, NULL, 1, 'fa', NULL, '2024-09-16 13:47:45', '2024-09-26 13:21:31'),
(55, 'سيدمهدي', 'راست بود', 'image63901726481919.jpg', '09367112929', '1261816102', 2, '1261816102', '01124837023@gmail.com', 0, 0, '$2y$12$oehSKyNGzAnCe0tVPizEmuh/FPTSWVpcJoJImQV/dhPmAmUkS0Oom', 29, 29, '01124837023', NULL, 1, NULL, 1, 'fa', NULL, '2024-09-16 13:49:12', '2024-09-26 13:21:31'),
(56, 'حسن', 'دانافر', 'image14651726482003.jpg', '09151702326', NULL, 2, NULL, '01124837030@gmail.com', 0, 0, '$2y$12$6tr4p7h1pgXeM0bD/mhUR.Pf7VeX6lHzRPz5IAbrCd8XcTbzxAo4.', 29, NULL, '01124837030', NULL, 1, NULL, 1, 'fa', '2024-09-19 09:45:21', '2024-09-16 13:50:39', '2024-09-19 09:45:21'),
(57, 'مهدي', 'خالق پناه چناري', 'image28391726482085.jpg', '09357808537', '0690132131', 2, '0690132131', '01124837031@gmail.com', 0, 0, '$2y$12$y.08oTozZxVYJqx/hb1oYeXd47miP8JG8ib1w4PzLy6KHTxM1LBe6', 29, 29, '01124837031', NULL, 1, NULL, 1, 'fa', NULL, '2024-09-16 13:51:54', '2024-09-26 13:21:32'),
(58, 'سيدابراهيم', 'رضوي', 'image7121726482159.jpg', '09170860431', '5500030612', 2, '5500030612', '01124837036@gmail.com', 0, 0, '$2y$12$eHvsikKwXdDH/Pht3w.0t.Q.Kg9m7I1aH4Ll6jOS/ozOigtQWiUHO', 29, 29, '01124837036', NULL, 1, NULL, 1, 'fa', NULL, '2024-09-16 13:53:09', '2024-09-26 13:21:32'),
(59, 'رسول', 'اسمعيليان صدراباد', 'image81771726482233.jpg', '09138608404', NULL, 2, NULL, '01124837046@gmail.com', 0, 0, '$2y$12$e2hs6kowp44DJSMYwsl7uOISZD.jUTl2CopqmQ0HpcrhifoFDbKSy', 29, NULL, '01124837046', NULL, 1, NULL, 1, 'fa', '2024-09-19 09:46:07', '2024-09-16 13:54:24', '2024-09-19 09:46:07'),
(60, 'فاطمه', 'سيفي اصفهاني', 'image1251726482333.jpg', '09131127866', '1273430786', 2, '1273430786', '02114837003@gmail.com', 0, 0, '$2y$12$8kBQw7yPMcnoP2BZ5Sycs.YERvqrzGfJI0Mjf0gAwmP6VTXBWTXIC', 29, 29, '02114837003', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-16 13:56:11', '2024-10-16 15:01:26'),
(61, 'نرگس', 'ملائي', 'image97171726482453.jpg', '09191531585', '0384651577', 2, '0384651577', '02114837006@gmail.com', 0, 0, '$2y$12$OFTZGZQFkeXTQdJw.rlvX.hmcLqSpKEwaGws.QOtcTRMZZVD9NpIm', 29, 29, '02114837006', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-16 13:57:42', '2024-09-26 13:21:32'),
(62, 'نسرين', 'محمدي خشت مسجدي', 'image84601726482561.jpg', '09386011381', '0081325827', 2, '0081325827', '02114837008@gmail.com', 0, 0, '$2y$12$RnBZEjT0XY2N49Aad4X.gO5pPcYyC4RMVYp3mB9.Z/1zk/YfjYECS', 29, 29, '02114837008', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-16 13:59:31', '2024-10-01 09:17:14'),
(63, 'سحر', 'صفري باغي', 'image44591726482706.jpg', '09118399243', '0081507674', 2, '0081507674', '02114837010@gmail.com', 0, 0, '$2y$12$i.tdF0GNWRdpiDOSsM2w3.HZZ7sGmYIPuhDBTR./m5ZDoBK8/WoLe', 29, 29, '02114837010', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-16 14:02:01', '2024-09-26 13:21:33'),
(64, 'ليلا', 'صفارپور', 'image55921726482793.jpg', '09357903717', '2003225838', 2, '2003225838', '02114837011@gmail.com', 0, 0, '$2y$12$X8AWySYgzhXjxk4Etv5mS.lTdlobLd7XdFaQpVK6w0TNJC4u/V9na', 29, 29, '02114837011', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-16 14:03:57', '2024-09-26 13:21:33'),
(65, 'مهري', 'بابائي', 'image72021726482918.jpg', '09206603206', '3873953617', 2, '3873953617', '02114837012@gmail.com', 0, 0, '$2y$12$kmO58JdU.k/ivM5BIAfY0eH3vusdTTmv1OhVz5Oy6XLyE8aQk9/Ie', 29, 29, '02114837012', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-16 14:05:20', '2024-09-26 13:21:33'),
(66, 'سميه', 'بابائي نژادمراددهنده', 'image37481726482981.jpg', '09199046602', '0440312345', 2, '0440312345', '02114837013@gmail.com', 0, 0, '$2y$12$ke98VZ3Oke8RUF7jJkUbXee/ohBxON33UiIiwXCB0pdXoDckneHES', 29, 29, '02114837013', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-16 14:06:53', '2024-09-26 13:21:33'),
(67, 'فاطمه', 'منتظري نجف آبادي', 'image72671726483147.jpg', '09912059244', '1091597741', 2, '1091597741', '02114837014@gmail.com', 0, 0, '$2y$12$KAzKNKppq7sEzrtlY44lUugM54nNinNiHGUKt3AzwkSYIEQQq9D0a', 29, 29, '02114837014', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-16 14:09:09', '2024-09-26 13:21:34'),
(68, 'بهاره', 'گنجي', 'image14411726483232.jpg', '09304369125', '4270423633', 2, '4270423633', '02114837015@gmail.com', 0, 0, '$2y$12$MdcuGNEtpzpouUN0vS.U2eOpgFNUXLtV/3tG898eMTfx3OK68y/r.', 29, 29, '02114837015', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-16 14:10:34', '2024-09-26 13:21:34'),
(69, 'طيبه', 'بيات', 'image5241726483316.jpg', '09381142755', '0610152602', 2, '0610152602', '02114837016@gmail.com', 0, 0, '$2y$12$83qS0PPfS1sNlc8nnQ0pbOyvQblxh1gEa9.j6Pqk/K.C6VOnith7.', 29, 29, '02114837016', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-16 14:11:58', '2024-09-26 13:21:34'),
(70, 'سعيده', 'خوشحالي', 'image24391726483402.jpg', '09136112064', '2992185061', 2, '2992185061', '02114837018@gmail.com', 0, 0, '$2y$12$79prTYjuvzMxmqrbho1oKuAA9G3CcKfJhUduQV5ai8IDO/oCn.XtO', 29, 29, '02114837018', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-16 14:13:38', '2024-09-26 13:21:34'),
(71, 'محمد', 'مفتاح', 'image85791726541712.jpg', '09192950833', '1249824346', 4, '1249824346', NULL, 0, 0, '$2y$12$QED09ui2uwhKjo/Q0UXlDOaljRqrgQTdMwdP05Le5QZ6Lc3jyF55u', 1, 18, NULL, NULL, 1, NULL, 1, 'fa', NULL, '2024-09-17 06:25:45', '2024-09-28 09:46:16'),
(72, 'سیدمحمد', 'طباطبایی اشکذری', 'image74141726541936.jpg', '09156001638', NULL, 4, NULL, NULL, 0, 0, '$2y$12$ZkjllqBrehKimzD9Xvzjr.WQGU7usl/JUzkFTru88w8ywLvN6otB.', 1, 1, NULL, NULL, 1, NULL, 1, 'fa', '2024-09-30 09:13:30', '2024-09-17 06:29:01', '2024-09-30 09:13:30'),
(145, 'محمد حسین', 'عیسوی', 'image46641728296095.jpg', '09128541300', '1753827681', 4, '1753827681', NULL, 0, 0, '$2y$12$RaCcCwdnFe2rRttp7mNzGuZhv4Hq3yP5PxXHrP2C691HJRkR3jn.u', 18, 18, NULL, NULL, 1, NULL, 1, 'fa', NULL, '2024-10-07 13:41:58', '2024-10-07 13:44:57'),
(74, 'ابوالفضل', 'رنجبر', 'image58331726542671.jpeg', '09127511506', NULL, 4, NULL, NULL, 0, 0, '$2y$12$R2hJtOoIrMLCDUKB4nIDt.MP6HfLsvxq0GkxQ1WigpfxvDvvYzWf6', 1, 1, NULL, NULL, 1, NULL, 1, 'fa', '2024-09-30 09:12:48', '2024-09-17 06:41:13', '2024-09-30 09:12:48'),
(75, 'علی', 'واحدی', 'image85901726542821.jpg', '09366103382', '0320608697', 4, '0320608697', NULL, 0, 0, '$2y$12$pISmm1BQxQ0kMBBWTjUOn.PnOQjBG7fZhU9ac1DGQUcSy3ePRkdHm', 1, 18, NULL, NULL, 1, NULL, 1, 'fa', NULL, '2024-09-17 06:43:43', '2024-09-30 09:14:34'),
(76, 'اکبر', 'محمدباقری', 'image18031726542899.jpg', '09125514315', '3050709111', 4, '3050709111', NULL, 0, 0, '$2y$12$E6a1H.m/wBBog/gDqptFmOaeyDoVcKibrChxh4P7PNyX.oC..HJtq', 1, 18, NULL, NULL, 1, NULL, 1, 'fa', NULL, '2024-09-17 06:45:01', '2024-09-30 09:14:13'),
(142, 'محمد حسین', 'سواعدی', 'image25751728295274.jpg', '09193533742', '1757596755', 8, '1757596755', NULL, 0, 0, '$2y$12$tA6gJ/h48xNFg80xaXyHfuXnYh1uO2HLwI7MA2EQYbEejy17f.vGG', 18, NULL, NULL, NULL, 1, NULL, 1, 'fa', NULL, '2024-10-07 13:31:53', '2024-10-07 13:31:53'),
(78, '.', 'محی آبادی(مسئول کلاس ها)', 'image42001727519111.jpg', '09133874940', '2992818097', 4, '2992818097', NULL, 0, 0, '$2y$12$oAdhHA1LRp8ctINduYtJXefim7fV4YGwm.P9eZnmUW.C/qQ1.KN6S', 1, 18, NULL, NULL, 1, NULL, 1, 'fa', NULL, '2024-09-17 07:00:11', '2024-10-02 07:58:06'),
(141, 'سید صادق', 'میرستاری', 'image69941728295142.jpg', '09138804399', '4231041180', 8, '4231041180', NULL, 0, 0, '$2y$12$9dUK6X70cNvVjwMTWrdSQ.ZTEOnJ4RmuT8E3jPV4xEk9Y.VDjENCu', 18, NULL, NULL, NULL, 1, NULL, 1, 'fa', NULL, '2024-10-07 13:29:51', '2024-10-07 13:29:51'),
(144, 'نوید', 'صمدی', 'image71401728295801.png', '09211059935', '0310316383', 8, '0310316383', NULL, 0, 0, '$2y$12$hQc2r6NGRkRd6lMmgZDZYeq8.PhSBqTRDY95T3u40u0GZsS7lxyWG', 18, NULL, NULL, NULL, 1, NULL, 1, 'fa', NULL, '2024-10-07 13:40:54', '2024-10-07 13:40:55'),
(81, 'مريم', 'ارجمند', 'image7911726545951.jpg', '09931556491', '0740040006', 2, '0740040006', '02114837019@gmail.com', 0, 0, '$2y$12$JyHOqdJ.B0zU7z7QMbWt7.sSX.5J1AIhYNImBeKDjzFu0bCcHz6Mq', 29, 29, '02114837019', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 07:36:29', '2024-09-26 13:21:35'),
(82, 'سيده زهرا', 'حسيني طالمي', 'image13451726546048.jpg', '09117396102', '6530041087', 2, '6530041087', '02114837020@gmail.com', 0, 0, '$2y$12$iaif0Ol2K9H4pqcM.xV4t.SdlEG9YcE7OKd.BaxYWDAhQtYjM67Lu', 29, 29, '02114837020', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 07:38:13', '2024-10-01 09:16:48'),
(83, 'مهين', 'عليپورعباسقلي خان', 'image95991726546154.jpg', '09156120780', '0947178880', 2, '0947178880', '02114837021@gmail.com', 0, 0, '$2y$12$.bmshnJPo2kaZMMhPTngyODrK5UbgRBBarZHS9JMfZ/g0ZrwsytaS', 29, 29, '02114837021', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 07:39:52', '2024-09-26 13:21:35'),
(84, 'فاطمه', 'سموات', 'image55631726546244.jpg', '09182065107', '3875520335', 2, '3875520335', '02114837022@gmail.com', 0, 0, '$2y$12$4VGIsUJo3G0RUwfsp1lX2ui2Y39pPtwfMBnM//JdJXmpezfzd77Nm', 29, 29, '02114837022', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 07:41:19', '2024-09-26 13:21:35'),
(85, 'مولود', 'قاسمي', 'image50891726546329.jpg', '09914459677', '3490311736', 2, '3490311736', '02114837023@gmail.com', 0, 0, '$2y$12$nuOoLben4WSji4g2KOLVvOMzrV8gp/hVfmNiLNmOJKYL4lCGjqUKK', 29, 29, '02114837023', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 07:42:43', '2024-10-01 09:16:28'),
(86, 'كبري', 'نوري فرد', 'image60091726546514.png', '09169098131', '1880315629', 2, '1880315629', '02114837025@gmail.com', 0, 0, '$2y$12$qyN1yWFiim5R36wKJFhcu..oc8qcmblOgu7NOK14F9XETJINOUQ3G', 29, 29, '02114837025', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 07:45:49', '2024-09-26 13:21:36'),
(87, 'مهدیه', 'فاضلی', 'image23751726546616.jpg', '09932957601', '4420748095', 2, '4420748095', '02114837026@gmail.com', 0, 0, '$2y$12$e5Ntk8cMde.t7wkBG9fco.s5D5wiBXc8sIaB9n7ctP3cWQuRJfZI.', 29, 29, '02114837026', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 07:47:39', '2024-09-26 13:21:36'),
(88, 'مهدي', 'عدل وند', 'image64941726546717.jpg', '09122995139', '1552493768', 2, '1552493768', '02124837001@gmail.com', 0, 0, '$2y$12$jf7TMKmPnNfETeB6oVpA0uB2xquG9t1nCFkWX5jNT0KKpKrqSIOza', 29, 29, '02124837001', NULL, 1, NULL, 1, 'fa', NULL, '2024-09-17 07:49:11', '2024-09-26 13:21:36'),
(89, 'حميد', 'پردل', 'image38491726546813.jpg', '09156034634', '0880141735', 2, '0880141735', '02124837002@gmail.com', 0, 0, '$2y$12$d4dDKh.iWnogncXQiXM9jeRvBOfO8P/XoeqPqPs5DtDsSNPofVAy2', 29, 29, '02124837002', NULL, 1, NULL, 1, 'fa', NULL, '2024-09-17 07:50:52', '2024-09-26 13:21:36'),
(90, 'علي اصغر', 'تاجيك جعفرآبادي', 'image58691726546928.jpg', '09335016556', '0410603201', 2, '0410603201', '02124837004@gmail.com', 0, 0, '$2y$12$r1H7LCUNNvSTrnm8/GZO0.Pgzao48WKqlF9oGzhwLA/waTgeVpAfy', 29, 29, '02124837004', NULL, 1, NULL, 1, 'fa', NULL, '2024-09-17 07:52:18', '2024-09-26 13:21:37'),
(91, 'براتعلي', 'حيدري', 'image30661726546986.jpg', '09927893284', '6449976128', 2, '6449976128', '02124837005@gmail.com', 0, 0, '$2y$12$.x2XHJ.pi4XfQOVuCuKTJ.zFrvvWIhMLPEHCRGg/Xrlu.5j2Ls42i', 29, 29, '02124837005', NULL, 1, NULL, 1, 'fa', NULL, '2024-09-17 07:53:44', '2024-09-26 13:21:37'),
(92, 'محمدجواد', 'آتشي گلستان', 'image81571726547063.jpg', '09152266185', '0924034157', 2, '0924034157', '02124837007@gmail.com', 0, 0, '$2y$12$rvdUFNbd79lmNvUbaWuWUegV2Gg6kXjx6QNCCCyLv2Gs9AdJxomsi', 29, 29, '02124837007', NULL, 1, NULL, 1, 'fa', NULL, '2024-09-17 07:54:55', '2024-09-26 13:21:37'),
(93, 'مصطفي', 'نيازي سررود', 'image14991726547131.jpg', '09154817450', '0920116469', 2, '0920116469', '02124837009@gmail.com', 0, 0, '$2y$12$Z8rNT2JdnZIzsJA.X5zY3.cepfCl28WzFvGAfCQ47/wE6F/G52lKm', 29, 29, '02124837009', NULL, 1, NULL, 1, 'fa', NULL, '2024-09-17 07:56:44', '2024-09-26 13:21:37'),
(94, 'مهدي', 'احمدي محمدزينلي', 'image43751726547363.jpg', '09139915047', '5429929018', 2, '5429929018', '02124837024@gmail.com', 0, 0, '$2y$12$LDVDHXP6g4qxikR6KFL3cu/1lEquCwsJm9AxAv/bz0F6BL7tsWq6S', 29, 29, '02124837024', NULL, 1, NULL, 1, 'fa', NULL, '2024-09-17 07:59:25', '2024-09-26 13:21:37'),
(95, 'آمنه', 'نوبخت', 'image35461726547854.jpg', '09196689648', '5309923802', 2, '5309923802', '03114837005@gmail.com', 0, 0, '$2y$12$4Vl279iaz.Mu7wuvnqxU3.r.JEhaZZ8mMiMtRI3PdmPi7OwtTgqm2', 29, 29, '03114837005', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 08:07:36', '2024-09-26 13:21:38'),
(96, 'فاطمه', 'زارع كارمقدم', 'image73391726547881.jpg', '09199541854', '0015031251', 2, '0015031251', '03114837006@gmail.com', 0, 0, '$2y$12$u0wUam9FR86QbZec5k4RouuWr44SfQe84jFkRFpn78wKoyWtVHWpm', 29, 29, '03114837006', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 08:08:40', '2024-09-26 13:21:38'),
(97, 'سپيده', 'كوزه گري', 'image91671726547941.jpg', '09114093450', '2240091797', 2, '2240091797', '03114837008@gmail.com', 0, 0, '$2y$12$WRDJAgiQhoyuR4YvwH4GpOGw6UjNbJCEF2eRtlLi0aGEmAKU2ZkhG', 29, 29, '03114837008', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 08:09:32', '2024-09-26 13:21:38'),
(98, 'فهيمه', 'محمدي', 'image80201726547994.jpg', '09194626641', '0011380871', 2, '0011380871', '03114837009@gmail.com', 0, 0, '$2y$12$7MoxynouISMO0TZWFdjDmOSOBWjpS8jTDf.11YciQ0hbnEL8O/nFS', 29, 98, '03114837009', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 08:10:28', '2024-09-28 09:45:26'),
(99, 'بهاره', 'اسماعيلي', 'image78831726548081.jpg', '09172241229', '2550195442', 2, '2550195442', '03114837012@gmail.com', 0, 0, '$2y$12$GvsxRBCftdgLhA7nb3YSeu7sY.B3R6LXV1aNO07yd8M2rH0Zjeywa', 29, 29, '03114837012', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 08:11:25', '2024-10-01 09:15:57'),
(100, 'منيره', 'بهرامي', 'image6981726548105.jpg', '09191956066', '0384618642', 2, '0384618642', '03114837013@gmail.com', 0, 0, '$2y$12$FvoI5wcYcBD0DB8RtqKXl.ew.Hlc0CmQckStA9IqKtBYUbOb3RZ.S', 29, 29, '03114837013', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 08:12:27', '2024-10-01 09:15:38'),
(101, 'نفيسه', 'ميرخالقي', 'image95291726548274.jpg', '09156531345', '0703758055', 2, '0703758055', '03114837014@gmail.com', 0, 0, '$2y$12$qDkyJ8mz9zPP/S.Eg0EhVu5KswxTlRN07HJJ4dMpnkXAe2Xi.qbru', 29, 29, '03114837014', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 08:15:02', '2024-10-03 07:40:41'),
(102, 'سارا', 'بيات وركشي', 'image84531726548332.jpg', '09362972025', '0311090273', 2, '0311090273', '03114837015@gmail.com', 0, 0, '$2y$12$78we3Wsl1SrYYAcvLzDd8OUbSsTANsnAJTwlUx4cLGvlNAonkbUBq', 29, 29, '03114837015', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 08:16:14', '2024-10-01 09:15:18'),
(103, 'حليمه', 'اباده', 'image61111726548399.jpg', '09133771530', '3071808577', 2, '3071808577', '03114837016@gmail.com', 0, 0, '$2y$12$8FCIzs8d5JEPHpWugDOp8OJQeL.NFpA2cAykChv8L./WknJo8iaQ.', 29, 29, '03114837016', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 08:17:06', '2024-10-01 09:14:57'),
(104, 'فاطمه', 'حمدي حميدي', 'image50311726548528.jpg', '09338222086', '2960385470', 2, '2960385470', '03114837017@gmail.com', 0, 0, '$2y$12$N7ObWwPjivBeXMP7Plzssuk.5kkaLdXobzC4Eo/cR5JdoAqXDd1/y', 29, 29, '03114837017', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 08:19:16', '2024-09-26 13:21:40'),
(105, 'سمانه', 'شكوفگي', 'image89501726548590.jpg', '09123324224', '4579358511', 2, '4579358511', '03114837018@gmail.com', 0, 0, '$2y$12$BSws8u9uSLEdZKNkeULZoeOUZv2d6r4q64MB5tlH6Obj/3Lrj9Nga', 29, 29, '03114837018', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 08:20:17', '2024-09-26 13:21:40'),
(106, 'مليحه', 'نوروزي جاهد', 'image13921727364533.jpeg', '09103815405', '4433304123', 2, '4433304123', '03114837019@gmail.com', 0, 0, '$2y$12$mf8JsHBKUA1r0EB3vfOGIelm8yFr2LIEPO/bWA6xnYBN2uroqe8Ry', 29, 106, '03114837019', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 08:22:13', '2024-09-26 18:58:55'),
(107, 'مرضيه', 'پورسعيدي', 'image97991726548879.jpg', '09909854757', '1080259848', 2, '1080259848', '03114837022@gmail.com', 0, 0, '$2y$12$ZeQpliysUThvJquWfcWIKOWBPWgCsvsJFXgFGgoFjIZMl0J.5x3Si', 29, 107, '03114837022', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 08:25:08', '2024-09-26 22:08:16'),
(108, 'زهرا', 'ابوئي مهريزي', 'image92371726548931.jpg', '09137708394', '4460121387', 2, '4460121387', '03114837023@gmail.com', 0, 0, '$2y$12$jFX0IiR9auw4AIBjY0XiK.a5LlOk8hcOB20vDQNM5L28zsA79IMh2', 29, 29, '03114837023', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 08:25:56', '2024-09-26 13:21:41'),
(109, 'زهرا', 'ذاقلي جان‌آبادي', 'image26081726548974.jpg', '09357030977', '0385188196', 2, '0385188196', '03114837024@gmail.com', 0, 0, '$2y$12$k82dhfay04wImjyN.lYdg.M4JwVW6RXJ963prx9iL2Nr1G/DFMCKe', 29, 29, '03114837024', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 08:26:53', '2024-09-29 11:53:00'),
(110, 'زهره سادات', 'حسيني بوداني', 'image58511726549032.jpg', '09927909210', '5490124180', 2, '5490124180', '03114837026@gmail.com', 0, 0, '$2y$12$lhzyK1FkdMawwO2voj0ShuTmPqEb85JACGWJxuhFeBP4xw92tyFbK', 29, 29, '03114837026', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 08:27:44', '2024-09-26 13:21:41'),
(111, 'مريم', 'فرخي', 'image94831726549122.jpg', '09109610754', '3501387891', 2, '3501387891', '03114837027@gmail.com', 0, 0, '$2y$12$4550.JCknMgJIJlWUlzF3u7oLE7.xozkLV4IQQiklPu5IURIGLypq', 29, 29, '03114837027', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 08:29:33', '2024-09-26 13:21:41'),
(112, 'زهرا', 'صالحي نجاركلائي', 'image60881726549192.jpg', '09021286151', '2160855286', 2, '2160855286', '03114837028@gmail.com', 0, 0, '$2y$12$aDx3yaz7V2POHVzB5qNj3uUM5AqOi14zzV3/JfcEgavXDBXqAmxLa', 29, 29, '03114837028', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 08:30:27', '2024-09-26 13:21:42'),
(113, 'زينب', 'قاسمي', 'image47731726549251.jpg', '09222593797', '0017875005', 2, '0017875005', '03114837029@gmail.com', 0, 0, '$2y$12$.v7YCZgVQAbtxr7L.MOz/ODBotBtHByFEBqHNg.SXS42bGAr9rKm6', 29, 29, '03114837029', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 08:31:19', '2024-10-01 09:14:30'),
(114, 'شيما', 'صبوحي نژاد', 'image70631726549307.jpg', '09365768937', '3240756684', 2, '3240756684', '03114837030@gmail.com', 0, 0, '$2y$12$6xY6DNC.cT4rgMe2zL7sHe4lJZhX3NADcd2NhuRfWDVxlXIoYpxVu', 29, 29, '03114837030', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 08:32:12', '2024-09-26 13:21:42'),
(115, 'زهرا', 'زادسر', 'image81451726549351.jpg', '09373367017', '1271102234', 2, '1271102234', '03114837031@gmail.com', 0, 0, '$2y$12$EzEmfOJ.tpCpvakw3y2JBODQyMq.g4kIoMYnabF1M/ZHOJ/cxSFPm', 29, 29, '03114837031', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 08:33:14', '2024-09-26 13:21:42'),
(116, 'فوزيه', 'محمدزاده', 'image69051726549416.jpg', '09173739532', '3500984533', 2, '3500984533', '03114837032@gmail.com', 0, 0, '$2y$12$mQZCPWCJXoyD6RFPwEr1auifFZA7k2pIFu/fcdJ9c/Es1B64CgbI2', 29, 29, '03114837032', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 08:34:03', '2024-10-01 09:14:09'),
(117, 'حديقه', 'فتحي', 'image63211726549763.jpg', '09138051350', '4270020156', 2, '4270020156', '03114837033@gmail.com', 0, 0, '$2y$12$3Hx2RepIxom7E23IOfoC/.ZYKHrROGRwqpizNEnB945VsKvpIYn5e', 29, 29, '03114837033', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 08:39:59', '2024-09-26 13:21:43'),
(118, 'معصومه', 'جزيني زاده', 'image35211726549839.jpg', '09136338205', '4829941421', 2, '4829941421', '03114837034@gmail.com', 0, 0, '$2y$12$5sE3HBBX2wcDHTKQmXIAEuilogTqfpBvCVP9IEfxgHIraSlv6Un4m', 29, 29, '03114837034', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 08:41:31', '2024-10-01 09:13:52'),
(119, 'فاطمه', 'نصرآباد', 'image56131726549927.jpg', '09125515935', '0491306075', 2, '0491306075', '03114837035@gmail.com', 0, 0, '$2y$12$vJhW5wNxraG45YM1VGPc6.uUe9E4mVrrEP1Ts1KNIAXyMGzveCokC', 29, 29, '03114837035', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-17 08:42:47', '2024-09-26 13:21:43'),
(120, 'سعدي', 'سواعدي', 'image95371726549985.jpgimage28641726550187.jpgimage99621726550224.jpg', '09127499252', '1989529917', 2, '1989529917', '03124837002@gmail.com', 0, 0, '$2y$12$1KvvyhUsC4bvUtjPSu11T.AV/RQj94SF1SX1YNvljeMs8n4jl5Vie', 29, 29, '03124837002', NULL, 1, NULL, 1, 'fa', NULL, '2024-09-17 08:44:22', '2024-09-26 13:21:43'),
(121, 'مهدي', 'سليمي', 'image30371726550091.jpgimage47771726550159.jpgimage15481726550210.jpg', '09176398664', '3410484280', 2, '3410484280', '03124837003@gmail.com', 0, 0, '$2y$12$g1Zs4LGnT7sMQoe/7pDmt.I4rclzcz3DpcXb9ZWGH1F0vuD25hHUO', 29, 29, '03124837003', NULL, 1, NULL, 1, 'fa', NULL, '2024-09-17 08:45:32', '2024-09-26 13:21:44'),
(122, 'ماجد', 'سالمي', 'image54191726550268.jpg', '09396073188', '5850027671', 2, '5850027671', '03124837004@gmail.com', 0, 0, '$2y$12$bXai1.HwyfQIWranqaNN8ep6cSI26yB4GI7RMbP03ExnASoORBj8C', 29, 29, '03124837004', NULL, 1, NULL, 1, 'fa', NULL, '2024-09-17 08:48:22', '2024-09-26 13:21:44'),
(123, 'سيداحمد', 'هاشمي جمعه', 'image39121726550339.jpg', '09338590489', '4609948011', 2, '4609948011', '03124837007@gmail.com', 0, 0, '$2y$12$XcFCw26j6Yb8NZABMNRgN.tQyhHQu3lY0GiTRi4wwnsUsLjpWlfNy', 29, 29, '03124837007', NULL, 1, NULL, 1, 'fa', NULL, '2024-09-17 08:49:49', '2024-09-26 13:21:44'),
(124, 'داود', 'احمدي', 'image88311726550451.jpg', '09197522045', '0072109157', 2, '0072109157', '03124837010@gmail.com', 0, 0, '$2y$12$rpWxg6HzG0WGPrVEdrUd3.uPHwHmW3JZ5SI4sOyqjdwAPFKfBGvM2', 29, 29, '03124837010', NULL, 1, NULL, 1, 'fa', NULL, '2024-09-17 08:51:52', '2024-09-26 13:21:44'),
(125, 'احمد', 'ادياني', 'image80641726550545.jpg', '09128512012', '3501295065', 2, '3501295065', '03124837011@gmail.com', 0, 0, '$2y$12$uuugJISoC09oxWSb3xWU8uH8W1sLJ0onzWn0Ee5FF39sLbn9iwt7S', 29, 29, '03124837011', NULL, 1, NULL, 1, 'fa', NULL, '2024-09-17 08:53:07', '2024-09-26 13:21:44'),
(126, 'حميدرضا', 'محمديان', 'image27211726550610.jpg', '09139735592', '1219428833', 2, '1219428833', '03124837020@gmail.com', 0, 0, '$2y$12$yJ7./lYjOgRsWIIZl/Af6e2nPEdusLQb9nKNfM/dN1XZvyZ9Pt9Cu', 29, 29, '03124837020', NULL, 1, NULL, 1, 'fa', NULL, '2024-09-17 08:54:16', '2024-09-26 13:21:45'),
(127, 'رحيم', 'اماميان قلعه زو', 'image40961726550721.jpg', '09154209741', '5530068464', 2, '5530068464', '03124837021@gmail.com', 0, 0, '$2y$12$.vJXhyS0AWhZ0Epmv93ZfuTaZeI9F.Ef5tTvHYMt2/KxZ0kWkgEo.', 29, 29, '03124837021', NULL, 1, NULL, 1, 'fa', NULL, '2024-09-17 08:55:23', '2024-09-26 13:21:45'),
(128, 'اكبر', 'خشت زر', 'image27641726550806.jpg', '09171844965', '5159556133', 2, '5159556133', '03124837025@gmail.com', 0, 0, '$2y$12$r8GadSNtF8wB/bKyWdrOvu.vZREAe8WXOU2qYSQONJk0B06I7CKje', 29, 29, '03124837025', NULL, 1, NULL, 1, 'fa', NULL, '2024-09-17 08:57:18', '2024-09-26 13:21:45'),
(129, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 'fa', NULL, NULL, NULL),
(130, 'زهره', 'افتخاری پور', 'image9871726643715.pngimage30301726643745.png', '09193542067', NULL, 9, NULL, 'eftekhari@gmail.com', 0, 0, '$2y$12$dnS.G0NUC1SlSKnsz9KD2eZhOeB5TC.VKelkIopP.AYBqiEoVe.sC', 1, 1, NULL, NULL, 2, NULL, 1, 'fa', '2024-09-30 09:12:30', '2024-09-18 10:45:17', '2024-09-30 09:12:30'),
(131, 'زهره', 'خدیجه', 'image78611726726812.jpg', '09117162419', '2722647192', 2, '2722647192', '03114837036@gmail.com', 0, 0, '$2y$12$WF5/tRPyFQHPz9s2x7/UQeKzPSaBgfxYHtkAhdnsdSGgFrUZiCCXu', 29, 29, '03114837036', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-19 09:50:14', '2024-09-26 13:21:45'),
(132, 'مينا', 'شريفي آلوچه', 'image16861726978964.jpg', '09147467995', '1467216542', 2, '1467216542', '03114837037@gmail.com', 0, 0, '$2y$12$nGfZq2ONlqnovadRkaCEEekwaSDsetcoyJhKZXEf9a4bRofL9Qr8S', 29, 29, '03114837037', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-22 07:53:08', '2024-10-01 09:13:23'),
(133, 'سیداسماعیل', 'متکلم', 'image61201726997295.jpg', '09128511538', NULL, 9, NULL, 'motekalem@gmail.com', 0, 0, '$2y$12$QF26GVzWNIOqSTKutuBBA.6eBREmWpVJeVQbti3AvTlG5QAj.bK/q', 18, NULL, NULL, NULL, 1, NULL, 1, 'fa', '2024-09-30 09:12:23', '2024-09-22 12:58:17', '2024-09-30 09:12:23'),
(135, 'زهرا', 'محمدی - تیم فنی', 'image13481727370193.avif', '09191519138', 'point313', 2, '1519138', 'zmohamadi44@yahoo.com', 0, 0, '$2y$12$qoHvhiEQN5gzSvIYA5wIC.u2KQ4lXnRDNtIjEPioecRk.dcZqTLeW', 1, 135, '09191519138', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-26 20:02:44', '2024-09-26 20:33:15'),
(134, 'جعفر', 'احمدی', 'image13921727357647.jpg', '09374617051', '09374617051', 2, '5010468441', NULL, 0, 0, '$2y$12$JqS7WaKduYeMHm9IQlYCyO1AuOzWsg9tvrOktHo6QluL2z4d5OFk6', 19, NULL, '9374617051', NULL, 1, NULL, 1, 'fa', '2024-09-26 17:14:19', '2024-09-26 17:04:20', '2024-09-26 17:14:19'),
(136, 'مهدی', 'ناصری', 'image86621727605726.jpg', '09191472667', '5209345688', 5, '5209345688', NULL, 0, 0, '$2y$12$9fvZ3192uMdcAQqHnsbWkOZk2Q7SUYqnmqiVqs.EP3e32XA25NFJy', 71, 71, NULL, NULL, 1, NULL, 1, 'fa', NULL, '2024-09-29 13:58:48', '2024-09-29 13:59:05'),
(137, '...', '...', 'image71261727674618.jpg', '09191492315', '4449625315', 5, '4449625315', NULL, 0, 0, '$2y$12$M9yBHqwntCwnBfX7l5QprOKu1hDkQkaFq/VjgFeFaN5i83B0yUDle', 18, NULL, '09191492315', NULL, 2, NULL, 1, 'fa', NULL, '2024-09-30 09:08:49', '2024-09-30 09:08:49'),
(138, 'حمید', 'شاه محمدی', 'image8181728122426.jpg', '09927798803', '0202420019', 1, '0202420019', NULL, 1, 0, '$2y$12$kmTiFiYPNHLqZFvoyzNnaum6NFY2Qi1G6kVzzZU6YiQw9l3N6XPp6', 1, NULL, NULL, NULL, 1, 'حمید آقای شاه محمدی هستم', 1, 'fa', NULL, '2024-10-05 13:30:58', '2024-10-16 09:49:24'),
(139, 'محمدعلی', 'سواعدی', 'image6461728192062.jpg', '09191989648', '1753834899', 10, '1753834899', 'savaedi@iki.ac.ir', 0, 0, '$2y$12$ULmCDtwV1Z6YTF3mhPTF6uDBRtk9y6y7xUU67v3RU3rGYum7xc4ze', 71, 18, NULL, NULL, 1, NULL, 1, 'fa', NULL, '2024-10-06 08:51:05', '2024-10-12 13:30:20'),
(143, 'علیرضا', 'خوشحال', 'image86191728295751.png', '09158671559', '5230062517', 8, '5230062517', NULL, 0, 0, '$2y$12$zUHsw/3Yk1hQ2VwU1SsHLOi2midJTov5ca1Gj8ae1zzIuFs8NZ5Ia', 18, NULL, NULL, NULL, 1, NULL, 1, 'fa', NULL, '2024-10-07 13:39:22', '2024-10-07 13:39:22'),
(146, 'حسین', 'حجتی', 'image73581728554309.jpg', '09124519395', '0384136672', 9, '0384136672', NULL, 0, 0, '$2y$12$SOJU0YUYzddFt9dHGpZ2lOqdR3gujnaFzeGFU1cR5cm8kP5uta/fS', 18, NULL, NULL, NULL, 1, NULL, 1, 'fa', NULL, '2024-10-10 13:28:31', '2024-10-10 13:28:31'),
(147, 'علی', 'رشیدپور', 'image16761728704728.jpg', '09338863567', '0385941050', 2, '0385941050', NULL, 0, 0, '$2y$12$gueQ2584qPBwoezi8wA/ZuqZ5KI71ck4t9hd3GjWO1Y4CP455T41a', 18, 71, '09338863567', NULL, 1, NULL, 1, 'fa', NULL, '2024-10-12 07:15:37', '2024-10-19 09:23:59'),
(148, 'دانشجو', 'تستی', 'image99051729147085.jpg', '123456', '123456', 2, '123456', NULL, 0, 0, '$2y$12$rE/W0wHUVfLojpXi2/lAM.yw9n1vdLQYHVM7u8VeFDvSYb.m6B74a', 71, 71, '123456', NULL, 1, NULL, 1, 'fa', NULL, '2024-10-17 10:08:07', '2024-10-19 09:09:36');

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title_fa` varchar(255) DEFAULT NULL,
  `title_en` varchar(255) DEFAULT NULL,
  `status_id` int(11) NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`id`, `title_fa`, `title_en`, `status_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'استاد', 'teacher', 1, NULL, '2024-07-06 15:52:33', '2024-07-06 15:52:33'),
(2, 'دانشجو', 'student', 1, NULL, '2024-07-06 15:52:33', '2024-07-06 15:52:33'),
(3, 'دستیار استاد', 'Assistant', 1, NULL, '2024-07-06 15:52:33', '2024-07-06 15:52:33'),
(4, 'پرسنل', 'personel', 1, NULL, '2024-07-06 15:52:33', '2024-07-06 15:52:33'),
(5, 'کارشناس آموزش', 'education expert', 1, NULL, '2024-07-06 15:52:33', '2024-07-06 15:52:33'),
(6, 'کارشناس برگزاری کلاس آنلاین', 'Online class expert', 1, NULL, '2024-07-06 15:52:33', '2024-07-06 15:52:33'),
(7, 'کارشناس انفورماتیک', 'Informatics expert', 1, NULL, '2024-07-06 15:52:33', '2024-07-06 15:52:33'),
(8, 'کارشناس امتحانات', 'exam', 1, NULL, NULL, NULL),
(9, 'کارشناس پژوهش', 'Research expert', 1, NULL, '2024-09-16 09:08:39', '2024-09-16 09:08:39'),
(10, 'کارشناس آموزش های آزاد', NULL, 1, NULL, '2024-10-07 15:25:34', '2024-10-07 15:25:34');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assignments`
--
ALTER TABLE `assignments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `assignment_answers`
--
ALTER TABLE `assignment_answers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `assignment_answers_detail`
--
ALTER TABLE `assignment_answers_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `assignment_options`
--
ALTER TABLE `assignment_options`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `base_counts`
--
ALTER TABLE `base_counts`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `base_file_categories`
--
ALTER TABLE `base_file_categories`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `base_file_types`
--
ALTER TABLE `base_file_types`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `base_genders`
--
ALTER TABLE `base_genders`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `base_keywords`
--
ALTER TABLE `base_keywords`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `base_languages`
--
ALTER TABLE `base_languages`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `base_question_types`
--
ALTER TABLE `base_question_types`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `base_statuses`
--
ALTER TABLE `base_statuses`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `base_systems`
--
ALTER TABLE `base_systems`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `base_year_semesters`
--
ALTER TABLE `base_year_semesters`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`) USING BTREE;

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`) USING BTREE;

--
-- Indexes for table `config`
--
ALTER TABLE `config`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `config_key_unique` (`key`) USING BTREE,
  ADD KEY `config_config_group_id_foreign` (`config_group_id`) USING BTREE;

--
-- Indexes for table `configs`
--
ALTER TABLE `configs`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `config_group`
--
ALTER TABLE `config_group`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `config_group_name_unique` (`name`) USING BTREE;

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`code`) USING BTREE,
  ADD KEY `id` (`id`) USING BTREE;

--
-- Indexes for table `course_categories`
--
ALTER TABLE `course_categories`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `course_presented`
--
ALTER TABLE `course_presented`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `course_users`
--
ALTER TABLE `course_users`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `forums`
--
ALTER TABLE `forums`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `forum_attachments`
--
ALTER TABLE `forum_attachments`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `forum_likes`
--
ALTER TABLE `forum_likes`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `forum_posts`
--
ALTER TABLE `forum_posts`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `inbox`
--
ALTER TABLE `inbox`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `inbox_files`
--
ALTER TABLE `inbox_files`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `learnpaths`
--
ALTER TABLE `learnpaths`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `learnpaths_files`
--
ALTER TABLE `learnpaths_files`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `learnpath_view_user`
--
ALTER TABLE `learnpath_view_user`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `online_classrooms`
--
ALTER TABLE `online_classrooms`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `online_classroom_archive_files`
--
ALTER TABLE `online_classroom_archive_files`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `quizs`
--
ALTER TABLE `quizs`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `quiz_answer`
--
ALTER TABLE `quiz_answer`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `quiz_attemp`
--
ALTER TABLE `quiz_attemp`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `quiz_options`
--
ALTER TABLE `quiz_options`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `quiz_questions`
--
ALTER TABLE `quiz_questions`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `surveys`
--
ALTER TABLE `surveys`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `survey_answer`
--
ALTER TABLE `survey_answer`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `survey_attemp`
--
ALTER TABLE `survey_attemp`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `survey_questions`
--
ALTER TABLE `survey_questions`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `survey_question_options`
--
ALTER TABLE `survey_question_options`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `tools`
--
ALTER TABLE `tools`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `tools_title_fa_unique` (`title_fa`) USING BTREE,
  ADD UNIQUE KEY `tools_title_en_unique` (`title_en`) USING BTREE;

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `users_mobile_unique` (`mobile`) USING BTREE,
  ADD UNIQUE KEY `users_email_unique` (`email`) USING BTREE;

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assignments`
--
ALTER TABLE `assignments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `assignment_answers`
--
ALTER TABLE `assignment_answers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `assignment_answers_detail`
--
ALTER TABLE `assignment_answers_detail`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `assignment_options`
--
ALTER TABLE `assignment_options`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `base_counts`
--
ALTER TABLE `base_counts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `base_file_categories`
--
ALTER TABLE `base_file_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `base_file_types`
--
ALTER TABLE `base_file_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `base_genders`
--
ALTER TABLE `base_genders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `base_keywords`
--
ALTER TABLE `base_keywords`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `base_languages`
--
ALTER TABLE `base_languages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `base_question_types`
--
ALTER TABLE `base_question_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `base_statuses`
--
ALTER TABLE `base_statuses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `base_systems`
--
ALTER TABLE `base_systems`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `base_year_semesters`
--
ALTER TABLE `base_year_semesters`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `config`
--
ALTER TABLE `config`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `configs`
--
ALTER TABLE `configs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `config_group`
--
ALTER TABLE `config_group`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `course_categories`
--
ALTER TABLE `course_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `course_presented`
--
ALTER TABLE `course_presented`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `course_users`
--
ALTER TABLE `course_users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=467;

--
-- AUTO_INCREMENT for table `forums`
--
ALTER TABLE `forums`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `forum_attachments`
--
ALTER TABLE `forum_attachments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `forum_likes`
--
ALTER TABLE `forum_likes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `forum_posts`
--
ALTER TABLE `forum_posts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `inbox`
--
ALTER TABLE `inbox`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inbox_files`
--
ALTER TABLE `inbox_files`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `learnpaths`
--
ALTER TABLE `learnpaths`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;

--
-- AUTO_INCREMENT for table `learnpaths_files`
--
ALTER TABLE `learnpaths_files`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `learnpath_view_user`
--
ALTER TABLE `learnpath_view_user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=457;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `online_classrooms`
--
ALTER TABLE `online_classrooms`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `online_classroom_archive_files`
--
ALTER TABLE `online_classroom_archive_files`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quizs`
--
ALTER TABLE `quizs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `quiz_answer`
--
ALTER TABLE `quiz_answer`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `quiz_attemp`
--
ALTER TABLE `quiz_attemp`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `quiz_options`
--
ALTER TABLE `quiz_options`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `quiz_questions`
--
ALTER TABLE `quiz_questions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `surveys`
--
ALTER TABLE `surveys`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `survey_answer`
--
ALTER TABLE `survey_answer`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `survey_attemp`
--
ALTER TABLE `survey_attemp`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `survey_questions`
--
ALTER TABLE `survey_questions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `survey_question_options`
--
ALTER TABLE `survey_question_options`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tools`
--
ALTER TABLE `tools`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=149;

--
-- AUTO_INCREMENT for table `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
