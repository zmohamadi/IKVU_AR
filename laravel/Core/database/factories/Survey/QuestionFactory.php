<?php

namespace Database\Factories\Survey;

use Illuminate\Database\Eloquent\Factories\Factory;
use Models\Edu\Survey\Question;

class QuestionFactory extends Factory
{
    protected $model = Question::class;
 
    public function definition(): array
    {
        return [
            "title" => fake()->word,
            "survey_id" => fake()->numberBetween(1,5),
            "question_type_id" =>1,
        ];
    }
}
