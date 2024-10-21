<?php

namespace Database\Seeders\Base;

use Illuminate\Database\Seeder;
use Models\Base\FileCategory;

class FileCategorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $items = [
            [
                "title" => "اسکن مدارک",
                "name" => "degrees",
                "description" => "مدارک تحصیلی (دانشگاهی و حوزوی)",
                "status_id" => "1"
            ],
            [
                "title" => "مدارک شناسایی",
                "name" => "melicart",
                "description" => "اسکن کارت ملی یا پاسپورت",
                "status_id" => "1"
            ],
            [
                "title" => "گواهینامه",
                "name" => "melicart",
                "description" => "اسکن گواهینامه",
                "status_id" => "1"
            ],
            [
                "title" => "مدارک شغلی",
                "name" => "melicart",
                "description" => "مدارک معتبر از سابقه کار",
                "status_id" => "1"
            ],
            [
                "title" => "نمونه کار",
                "name" => "cv",
                "description" => "فایل رزومه کاجو و یا نمونه مرتبط  شغل کارفرما",
                "status_id" => "1"
            ],
            [
                "title" => "مجوزها",
                "name" => "licenses",
                "description" => "مجوزهای کاری برای شرکت یا ...",
                "status_id" => "1"
            ],
            [
                "title" => "معرفی نامه",
                "name" => "introduction",
                "description" => "معرفی نامه رسمی (رابط)",
                "status_id" => "1"
            ],
        ];

        foreach ($items as $item)
        {
            FileCategory::create($item);
        }
    }
}
