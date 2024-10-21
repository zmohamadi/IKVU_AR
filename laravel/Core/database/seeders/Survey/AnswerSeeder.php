<?php

namespace Database\Seeders\Survey;

use Illuminate\Database\Seeder;
use Models\Edu\Survey\Answer;

class AnswerSeeder extends Seeder
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
                "survey_id" => 1,
                "user_id" => 3,
                "question_id" => 1,
                "question_option_id" => 2,
            ],

        ];
        foreach ($items as $item) {
            Answer::create($item);
        }
    }
}
