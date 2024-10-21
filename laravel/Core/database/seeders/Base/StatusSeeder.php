<?php

namespace Database\Seeders\Base;

use Illuminate\Database\Seeder;
use Models\Base\Status;

class StatusSeeder extends Seeder
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
                "title_fa"=>"وضعیت فعالی",
                "title_en"=>"active status",
                "status_id" => 1
            ],
            [
                "title_fa"=>"فعال",
                "title_en"=>"active",
                "group_id" => 1,
                "code"  => 1,
                "color" => "theme-10",
                "status_id" => 1
            ],
            [
                "title_fa"=>"غیر فعال",
                "title_en"=>"inactive",
                "group_id" => 1,
                "code"  => 0,
                "color" => "theme-24",
                "status_id" => 1
            ],
            [
                "title_fa"=>"وضعیت پست پیامگاه",
                "title_en"=>"Message post status",
                "status_id" => 1
            ],
            [
                "title_fa"=>"نیاز به بررسی",
                "title_en"=>"Need to check",
                "group_id" => 4,
                "code"  => 0,
                "color" => "theme-23",
                "status_id" => 1
            ],
            [
                "title_fa"=>"عمومی",
                "title_en"=>"General",
                "group_id" => 4,
                "code"  => 1,
                "color" => "theme-17",
                "status_id" => 1
            ],
            [
                "title_fa"=>"خصوصی",
                "title_en"=>"private",
                "group_id" => 4,
                "code"  => 2,
                "color" => "theme-10",
                "status_id" => 1
            ],
            [
                "title_fa"=>"رد",
                "title_en"=>"rejection",
                "group_id" => 4,
                "code"  => 3,
                "color" => "theme-24",
                "status_id" => 1
            ], 
            [
                "title_fa"=>"نوع عملکرد پست",
                "title_en"=>"Post function type",
                "status_id" => 1
            ],
            [
                "title_fa"=>"لایک",
                "title_en"=>"like",
                "group_id" => 9,
                "code"  => 1,
                "color" => "theme-24",
                "status_id" => 1
            ],
            [
                "title_fa"=>"لایک نکردن",
                "title_en"=>"Dislike",
                "group_id" => 9,
                "code"  => 0,
                "color" => "theme-10",
                "status_id" => 1
            ],
        ];
        foreach($items as $item)
        {
            Status::create($item);
        }
    }
}
