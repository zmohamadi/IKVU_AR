-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 24, 2024 at 10:22 AM
-- Server version: 10.6.19-MariaDB
-- PHP Version: 8.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ictvucom_lms`
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
(1, 'courses', 0, NULL, NULL, NULL, NULL),
(2, 'categories', 0, NULL, NULL, NULL, NULL),
(3, 'teachers', 0, NULL, NULL, NULL, NULL),
(4, 'students', 0, NULL, NULL, NULL, NULL),
(5, 'quizs', 0, NULL, NULL, NULL, NULL),
(6, 'online_classrooms', 0, NULL, NULL, NULL, NULL),
(7, 'surveys', 0, NULL, NULL, NULL, NULL),
(8, 'learnpaths', 0, NULL, NULL, NULL, NULL),
(9, 'assignments', 0, NULL, NULL, NULL, NULL),
(10, 'assistants', 0, NULL, NULL, NULL, NULL),
(11, 'perssonel', 0, NULL, NULL, NULL, NULL);

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
(1, 'img', 'img', 'صورة', 'png,jpg,tif,gif,jpeg,WebP,AVIF', 1, NULL, '2024-04-14 03:37:06', '2024-04-14 03:37:06'),
(2, 'audio', 'audio', 'سمعي', 'wave,mp3', 1, NULL, '2024-04-14 03:37:06', '2024-04-14 03:37:06'),
(3, 'video', 'video', 'فيديو', 'mov,mp4,flv,avi,wmv', 1, NULL, '2024-04-14 03:37:06', '2024-04-14 03:37:06'),
(4, 'document', 'document', 'وثيقة', 'pdf,doc,docx,ppt', 1, NULL, '2024-04-14 03:37:06', '2024-04-14 03:37:06');

-- --------------------------------------------------------

--
-- Table structure for table `base_genders`
--

CREATE TABLE `base_genders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title_ar` varchar(100) DEFAULT NULL,
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

INSERT INTO `base_genders` (`id`, `title_ar`, `title_fa`, `title_en`, `status_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'آقا', 'آقا', 'male', 1, '2024-07-06 16:52:35', '2024-07-06 16:52:35', NULL),
(2, 'خانم', 'خانم', 'femail', 1, '2024-07-06 16:52:35', '2024-07-06 16:52:35', NULL);

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
(1, 'فارسی', 'fa', 'rtl', 'fa.png', 0, NULL, '2024-07-06 16:52:35', '2024-07-06 16:52:35'),
(2, 'English', 'en', 'ltr', 'en.png', 0, NULL, '2024-07-06 16:52:35', '2024-07-06 16:52:35'),
(3, 'عربی', 'ar', 'rtl', 'ar.png', 1, NULL, '2024-07-06 16:52:35', '2024-07-06 16:52:35');

-- --------------------------------------------------------

--
-- Table structure for table `base_question_types`
--

CREATE TABLE `base_question_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title_fa` varchar(100) DEFAULT NULL,
  `title_ar` varchar(100) DEFAULT NULL,
  `title_en` varchar(100) DEFAULT NULL,
  `status_id` int(11) NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

--
-- Dumping data for table `base_question_types`
--

INSERT INTO `base_question_types` (`id`, `title_fa`, `title_ar`, `title_en`, `status_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'تشریحی', 'وصفي', 'Descriptive', 1, NULL, '2024-07-06 16:52:35', '2024-07-06 16:52:35'),
(2, 'چند گزینه ای', 'الاختيار من متعدد', 'Multiple choice', 1, NULL, '2024-07-06 16:52:35', '2024-07-06 16:52:35');

-- --------------------------------------------------------

--
-- Table structure for table `base_statuses`
--

CREATE TABLE `base_statuses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title_fa` varchar(200) DEFAULT NULL COMMENT 'عنوان به زبان فارسی',
  `title_ar` varchar(200) DEFAULT NULL COMMENT 'عنوان به زبان عربی',
  `title_en` varchar(200) DEFAULT NULL COMMENT 'عنوان به زبان انگلیسی',
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

INSERT INTO `base_statuses` (`id`, `title_fa`, `title_ar`, `title_en`, `group_id`, `code`, `color`, `status_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'وضعیت فعالی', 'الحالة النشطة', 'active status', NULL, NULL, NULL, 1, NULL, '2024-07-06 16:52:35', '2024-07-06 16:52:35'),
(2, 'فعال', 'نشيط', 'active', 1, '1', 'theme-10', 1, NULL, '2024-07-06 16:52:35', '2024-07-06 16:52:35'),
(3, 'غیر فعال', 'غير نشط', 'inactive', 1, '0', 'theme-24', 1, NULL, '2024-07-06 16:52:35', '2024-07-06 16:52:35'),
(4, 'وضعیت پست پیامگاه', 'حالة نشر الرسالة', 'Message post status', NULL, NULL, NULL, 1, NULL, '2024-07-18 09:25:10', '2024-07-18 09:25:10'),
(5, 'نیاز به بررسی', 'بحاجة للتحقق', 'Need to check', 4, '0', 'theme-23', 1, NULL, '2024-07-18 09:25:10', '2024-07-18 09:25:10'),
(6, 'عمومی', 'عام', 'General', 4, '1', 'theme-17', 1, NULL, '2024-07-18 09:25:10', '2024-07-18 09:25:10'),
(7, 'خصوصی', 'خاص', 'private', 4, '2', 'theme-10', 1, NULL, '2024-07-18 09:25:10', '2024-07-18 09:25:10'),
(8, 'رد', 'الرفض', 'rejection', 4, '3', 'theme-24', 1, NULL, '2024-07-18 09:25:10', '2024-07-18 09:25:10'),
(9, 'نوع عملکرد پست', 'نوع وظيفة ما بعد', 'Post function type', NULL, NULL, NULL, 1, NULL, '2024-07-18 09:25:10', '2024-07-18 09:25:10'),
(10, 'لایک', 'يحب', 'like', 9, '1', 'theme-24', 1, NULL, '2024-07-18 09:25:10', '2024-07-18 09:25:10'),
(11, 'لایک نکردن', 'لا يعجبني', 'Dislike', 9, '0', 'theme-10', 1, NULL, '2024-07-18 09:25:10', '2024-07-18 09:25:10');

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
(1, 'گلستان', '123456', '1235', 'گلستان رابط', 'image21631729606583.webp', 1, NULL, '<p>توضیح</p>', 1, NULL, '2024-10-22 17:46:27', '2024-10-22 17:46:27');

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
(1, '1403', '1', '1403/07/01', '1403/07/29', NULL, NULL, NULL, 1, 1, NULL, NULL, '2024-10-21 13:01:26');

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

-- --------------------------------------------------------

--
-- Table structure for table `course_categories`
--

CREATE TABLE `course_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title_fa` varchar(255) DEFAULT NULL,
  `title_ar` varchar(255) DEFAULT NULL,
  `title_en` varchar(255) DEFAULT NULL,
  `pic` varchar(255) DEFAULT NULL,
  `creator_id` int(11) DEFAULT NULL COMMENT 'شناسه کاربر ثبت کننده',
  `editor_id` int(11) DEFAULT NULL COMMENT 'شناسه کاربر ویرایش کننده',
  `status_id` int(11) NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

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
  `title_ar` varchar(255) DEFAULT NULL,
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

INSERT INTO `tools` (`id`, `title_fa`, `title_ar`, `title_en`, `href`, `img`, `order`, `status_id`, `description`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'خط سیر آموزشی', 'تعلم المسار', 'learnpath', 'learnpath', 'learnpath.png', 1, 1, 'ابزارهای دوره‌های آموزشی ما از جمله خط سیر آموزشی، کلاس آنلاین، آرشیو کلاس آنلاین، آزمون، تکلیف، پیامگاه، ارسال و دریافت تحقیقات، و نظرسنجی، به شما امکان می‌دهند تا به راحتی به منابع آموزشی دسترسی پیدا کنید، در کلاس‌های زنده شرکت کنید، و تکالیف خود را ارسال و ارزیابی کنید. این ابزارها با هدف ارتقای تجربه آموزشی شما طراحی شده‌اند و امکانات مختلفی را برای بهبود یادگیری و ارتباط بین دانش‌آموزان و مدرسان فراهم می‌سازند.', NULL, NULL, NULL),
(2, 'کلاس آنلاین', 'الفصول الدراسية عبر الإنترنت', 'online_classroom', 'onlineClassroom', 'onlineclassroom.jpg', 2, 1, 'ابزارهای دوره‌های آموزشی ما از جمله خط سیر آموزشی، کلاس آنلاین، آرشیو کلاس آنلاین، آزمون، تکلیف، پیامگاه، ارسال و دریافت تحقیقات، و نظرسنجی، به شما امکان می‌دهند تا به راحتی به منابع آموزشی دسترسی پیدا کنید، در کلاس‌های زنده شرکت کنید، و تکالیف خود را ارسال و ارزیابی کنید. این ابزارها با هدف ارتقای تجربه آموزشی شما طراحی شده‌اند و امکانات مختلفی را برای بهبود یادگیری و ارتباط بین دانش‌آموزان و مدرسان فراهم می‌سازند.', NULL, NULL, NULL),
(3, 'آرشیو کلاس آنلاین', 'المحفوظات على الانترنت', 'online_archives', 'onlineClassroomArchives', 'online_archives.jpg', 3, 1, 'ابزارهای دوره‌های آموزشی ما از جمله خط سیر آموزشی، کلاس آنلاین، آرشیو کلاس آنلاین، آزمون، تکلیف، پیامگاه، ارسال و دریافت تحقیقات، و نظرسنجی، به شما امکان می‌دهند تا به راحتی به منابع آموزشی دسترسی پیدا کنید، در کلاس‌های زنده شرکت کنید، و تکالیف خود را ارسال و ارزیابی کنید. این ابزارها با هدف ارتقای تجربه آموزشی شما طراحی شده‌اند و امکانات مختلفی را برای بهبود یادگیری و ارتباط بین دانش‌آموزان و مدرسان فراهم می‌سازند.', NULL, NULL, NULL),
(4, 'آرشیو کلاس آنلاین سنوات قبل', 'المحفوظات الماضية على الانترنت', 'online_past_archives', 'onlineClassroomPastArchives', 'online_past_archives.jpg', 4, 1, 'ابزارهای دوره‌های آموزشی ما از جمله خط سیر آموزشی، کلاس آنلاین، آرشیو کلاس آنلاین، آزمون، تکلیف، پیامگاه، ارسال و دریافت تحقیقات، و نظرسنجی، به شما امکان می‌دهند تا به راحتی به منابع آموزشی دسترسی پیدا کنید، در کلاس‌های زنده شرکت کنید، و تکالیف خود را ارسال و ارزیابی کنید. این ابزارها با هدف ارتقای تجربه آموزشی شما طراحی شده‌اند و امکانات مختلفی را برای بهبود یادگیری و ارتباط بین دانش‌آموزان و مدرسان فراهم می‌سازند.', NULL, NULL, NULL),
(5, 'آزمون', 'لغز', 'quiz', 'quiz', 'quiz.jpg', 5, 1, 'ابزارهای دوره‌های آموزشی ما از جمله خط سیر آموزشی، کلاس آنلاین، آرشیو کلاس آنلاین، آزمون، تکلیف، پیامگاه، ارسال و دریافت تحقیقات، و نظرسنجی، به شما امکان می‌دهند تا به راحتی به منابع آموزشی دسترسی پیدا کنید، در کلاس‌های زنده شرکت کنید، و تکالیف خود را ارسال و ارزیابی کنید. این ابزارها با هدف ارتقای تجربه آموزشی شما طراحی شده‌اند و امکانات مختلفی را برای بهبود یادگیری و ارتباط بین دانش‌آموزان و مدرسان فراهم می‌سازند.', NULL, NULL, NULL),
(6, 'تکلیف', 'المهام', 'assignments', 'assignment', 'assignment.jpg', 6, 1, 'ابزارهای دوره‌های آموزشی ما از جمله خط سیر آموزشی، کلاس آنلاین، آرشیو کلاس آنلاین، آزمون، تکلیف، پیامگاه، ارسال و دریافت تحقیقات، و نظرسنجی، به شما امکان می‌دهند تا به راحتی به منابع آموزشی دسترسی پیدا کنید، در کلاس‌های زنده شرکت کنید، و تکالیف خود را ارسال و ارزیابی کنید. این ابزارها با هدف ارتقای تجربه آموزشی شما طراحی شده‌اند و امکانات مختلفی را برای بهبود یادگیری و ارتباط بین دانش‌آموزان و مدرسان فراهم می‌سازند.', NULL, NULL, NULL),
(7, 'پیامگاه', 'المنتدى', 'forum', 'forum', 'forum.jpg', 7, 1, 'ابزارهای دوره‌های آموزشی ما از جمله خط سیر آموزشی، کلاس آنلاین، آرشیو کلاس آنلاین، آزمون، تکلیف، پیامگاه، ارسال و دریافت تحقیقات، و نظرسنجی، به شما امکان می‌دهند تا به راحتی به منابع آموزشی دسترسی پیدا کنید، در کلاس‌های زنده شرکت کنید، و تکالیف خود را ارسال و ارزیابی کنید. این ابزارها با هدف ارتقای تجربه آموزشی شما طراحی شده‌اند و امکانات مختلفی را برای بهبود یادگیری و ارتباط بین دانش‌آموزان و مدرسان فراهم می‌سازند.', NULL, NULL, NULL),
(8, 'ارسال و دریافت تحقیقات', 'البريد الوارد', 'inbox', 'inbox', 'message_box.jpg', 8, 0, 'ابزارهای دوره‌های آموزشی ما از جمله خط سیر آموزشی، کلاس آنلاین، آرشیو کلاس آنلاین، آزمون، تکلیف، پیامگاه، ارسال و دریافت تحقیقات، و نظرسنجی، به شما امکان می‌دهند تا به راحتی به منابع آموزشی دسترسی پیدا کنید، در کلاس‌های زنده شرکت کنید، و تکالیف خود را ارسال و ارزیابی کنید. این ابزارها با هدف ارتقای تجربه آموزشی شما طراحی شده‌اند و امکانات مختلفی را برای بهبود یادگیری و ارتباط بین دانش‌آموزان و مدرسان فراهم می‌سازند.', NULL, NULL, '2024-09-09 07:02:59'),
(9, 'نظرسنجی', 'استطلاع', 'survey', 'survey', 'survey.jpg', 9, 1, 'ابزارهای دوره‌های آموزشی ما از جمله خط سیر آموزشی، کلاس آنلاین، آرشیو کلاس آنلاین، آزمون، تکلیف، پیامگاه، ارسال و دریافت تحقیقات، و نظرسنجی، به شما امکان می‌دهند تا به راحتی به منابع آموزشی دسترسی پیدا کنید، در کلاس‌های زنده شرکت کنید، و تکالیف خود را ارسال و ارزیابی کنید. این ابزارها با هدف ارتقای تجربه آموزشی شما طراحی شده‌اند و امکانات مختلفی را برای بهبود یادگیری و ارتباط بین دانش‌آموزان و مدرسان فراهم می‌سازند.', NULL, NULL, NULL);

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
(1, 'مهدی', 'وثوقی', 'image71601727502574.jpgimage51581729607462.png', '09191964745', '09191964745', 4, '09191964745', 'sanegar.info@gmail.com', 0, 0, '$2y$12$onogYslcq05.1lR6PICdH.0V526DqEd11807W0KzgMZBSDPVhqD.a', NULL, 1, NULL, NULL, 1, NULL, 1, 'fa', NULL, NULL, '2024-10-22 18:01:12'),
(2, 'محمد', 'مفتاح', 'image19091729751483.webp', '09192950833', '1249824346', 4, '1249824346', NULL, 0, 0, '$2y$12$NaodMNOE3gRkTe/VSYYMmeZ8e/Y0cUnt2KzRCy16xDXD46bHx9HrS', 1, 1, NULL, NULL, 1, NULL, 1, 'fa', NULL, '2024-10-24 09:59:58', '2024-10-24 10:01:26');

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title_fa` varchar(255) DEFAULT NULL,
  `title_ar` varchar(255) DEFAULT NULL,
  `title_en` varchar(255) DEFAULT NULL,
  `status_id` int(11) NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_persian_ci;

--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`id`, `title_fa`, `title_ar`, `title_en`, `status_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'استاد', 'مدرس', 'Teacher', 1, NULL, '2024-07-06 16:52:33', '2024-07-06 16:52:33'),
(2, 'دانشجو', 'طالب', 'Student', 1, NULL, '2024-07-06 16:52:33', '2024-07-06 16:52:33'),
(3, 'دستیار استاد', 'مساعد', 'Assistant', 1, NULL, '2024-07-06 16:52:33', '2024-07-06 16:52:33'),
(4, 'پرسنل', 'الموظفين', 'Personnel', 1, NULL, '2024-07-06 16:52:33', '2024-07-06 16:52:33'),
(5, 'کارشناس آموزش', 'خبير التعليم', 'Education expert', 1, NULL, '2024-07-06 16:52:33', '2024-07-06 16:52:33'),
(6, 'کارشناس برگزاری کلاس آنلاین', 'خبير الصف عبر الإنترنت', 'Online class expert', 1, NULL, '2024-07-06 16:52:33', '2024-07-06 16:52:33'),
(7, 'کارشناس انفورماتیک', 'خبير المعلوماتية', 'Informatics expert', 1, NULL, '2024-07-06 16:52:33', '2024-07-06 16:52:33'),
(8, 'کارشناس امتحانات', 'خبير الامتحان', 'Exam expert', 1, NULL, NULL, NULL),
(9, 'کارشناس پژوهش', 'خبير أبحاث', 'Research expert', 1, NULL, '2024-09-16 10:08:39', '2024-09-16 10:08:39'),
(10, 'کارشناس آموزش های آزاد', 'خبير التعليم المجاني', 'Free education expert', 1, NULL, '2024-10-07 16:25:34', '2024-10-07 16:25:34');

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
  ADD PRIMARY KEY (`id`) USING BTREE;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `assignment_answers`
--
ALTER TABLE `assignment_answers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `assignment_answers_detail`
--
ALTER TABLE `assignment_answers_detail`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `base_statuses`
--
ALTER TABLE `base_statuses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `base_systems`
--
ALTER TABLE `base_systems`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `base_year_semesters`
--
ALTER TABLE `base_year_semesters`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course_categories`
--
ALTER TABLE `course_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course_presented`
--
ALTER TABLE `course_presented`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course_users`
--
ALTER TABLE `course_users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `forums`
--
ALTER TABLE `forums`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `forum_attachments`
--
ALTER TABLE `forum_attachments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `forum_likes`
--
ALTER TABLE `forum_likes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `forum_posts`
--
ALTER TABLE `forum_posts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `learnpaths_files`
--
ALTER TABLE `learnpaths_files`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `learnpath_view_user`
--
ALTER TABLE `learnpath_view_user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `online_classrooms`
--
ALTER TABLE `online_classrooms`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `online_classroom_archive_files`
--
ALTER TABLE `online_classroom_archive_files`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quizs`
--
ALTER TABLE `quizs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quiz_answer`
--
ALTER TABLE `quiz_answer`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quiz_attemp`
--
ALTER TABLE `quiz_attemp`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quiz_options`
--
ALTER TABLE `quiz_options`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quiz_questions`
--
ALTER TABLE `quiz_questions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
