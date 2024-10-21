<?php

namespace Database\Factories\Survey;

use Illuminate\Database\Eloquent\Factories\Factory;
use Models\Edu\Survey\Question;

class Question2Factory extends Factory
{
    protected $model = Question::class;
 
    public function definition(): array
    {
        return [
            "title" => fake()->word,
            "survey_id" => fake()->numberBetween(5,10),
            "question_type_id" =>2,
        ];
    }
}
