<?php

namespace Database\Seeders\Base;

use Illuminate\Database\Seeder;
use Models\Base\Language;

class LanguageSeeder extends Seeder
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
                "title"=>"فارسی",
                "symbol"  => "fa",
                "dir"  => "rtl",
                "icon"  => "fa.png",
                "status_id" => "1"
            ],
            [
                "title"=>"English",
                "symbol"  => "en",
                "dir"  => "ltr",
                "icon"  => "en.png",
                "status_id" => "0"
            ],
            [
                "title"=>"عربی",
                "symbol"  => "ar",
                "dir"  => "rtl",
                "icon"  => "ar.png",
                "status_id" => "0"
            ],
        ];
        foreach($items as $item)
        {
            Language::create($item);
        }
    }
}
