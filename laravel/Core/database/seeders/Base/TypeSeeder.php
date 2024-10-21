<?php

namespace Database\Seeders\Base;

use Illuminate\Database\Seeder;
use Models\Base\Type;

class TypeSeeder extends Seeder
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
                "title"=>"img",
                "title_en"=>"img",
                "title_ar"=>"صورة",
                "description"=>"png,jpg,tif,gif,jpeg,WebP,AVIF",
                "status_id" => "1"
            ],
            [
                "title"=>"audio",
                "title_en"=>"audio",
                "title_ar"=>"سمعي",
                "description"=>"wave,mp3",
                "status_id" => "1"
            ],
            [
                "title"=>"video",
                "title_en"=>"video",
                "title_ar"=>"فيديو",
                "description"=>"mov,mp4,flv,avi,wmv",
                "status_id" => "1"
            ],
            [
                "title"=>"document",
                "title_en"=>"document",
                "title_ar"=>"وثيقة",
                "description"=>"pdf,doc,docx,ppt",
                "status_id" => "1"
            ],
        ];
        foreach($items as $item)
        {
            Type::create($item);
        }
    }
}
