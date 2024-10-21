<?php

namespace Database\Seeders\Survey;

use Illuminate\Database\Seeder;
use Models\Edu\Survey\QuestionOption;

class QuestionOptionSeeder extends Seeder
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
                "question_id" => 1,
                "title" => "خوب",
                "order" => 2,
                
            ],
            [
                "question_id" => 1,
                "title" => "عالی",
                "order" => 1,
               
            ],
            [
                "question_id" => 1,
                "title" => "بد",
                "order" => 3,
              
            ],
            [
                "question_id" => 1,
                "title" => "خیلی بد",
                "order" => 4,
               
            ],

        ];
        foreach ($items as $item) {
            QuestionOption::create($item);
        }
    }
}
