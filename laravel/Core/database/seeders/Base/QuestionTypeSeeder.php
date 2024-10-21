<?php

namespace Database\Seeders\Base;

use Illuminate\Database\Seeder;
use Models\Base\QuestionType;

class QuestionTypeSeeder extends Seeder
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
                "title_en" => "Descriptive",
                "title_fa" => "تشریحی",
                
            ],
            [
                "title_en" => "Multiple choice",
                "title_fa" => "چند گزینه ای",
                
            ]
            
            
        ];
        foreach($items as $item)
        {
            QuestionType::create($item);
        }
    }
}
