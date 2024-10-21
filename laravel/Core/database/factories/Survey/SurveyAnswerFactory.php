<?php

namespace Database\Factories\Survey;

use Illuminate\Database\Eloquent\Factories\Factory;
use Models\Edu\Survey\SurveyAnswer;

class SurveyAnswerFactory extends Factory
{
    protected $model = SurveyAnswer::class;
 
    public function definition(): array
    {
        return [
            "user_id" => fake()->numberBetween(10,50),
            "mark" => fake()->numberBetween(1,10),
            "answer" => fake()->word(5,10),
            "survey_id" => fake()->numberBetween(1,10)
        ];
    }
}
