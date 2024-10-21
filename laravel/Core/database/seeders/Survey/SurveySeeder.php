<?php

namespace Database\Seeders\Survey;

use Illuminate\Database\Seeder;
use Models\Edu\Survey\Survey;
use Models\Edu\Survey\Question;
use Models\Edu\Survey\QuestionOption;

class SurveySeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Survey::factory()
        ->has(
            Question::factory()
                ->has(QuestionOption::factory()
                ->count(4), 'questionOptions')
            ->count(3), 'questions'
        )
        ->count(5)->create();

       
    }
}
