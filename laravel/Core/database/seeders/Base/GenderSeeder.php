<?php

namespace Database\Seeders\Base;

use Illuminate\Database\Seeder;
use Models\Base\Gender;

class GenderSeeder extends Seeder
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
                "title_fa" => "آقا",
                "title_en" => "male",
            ],
            [
                "title_fa" => "خانم",
                "title_en" => "femail",
            ],
        ];
        foreach($items as $item)
        {
            Gender::create($item);
        }
    }
}
