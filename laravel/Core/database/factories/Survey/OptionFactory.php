<?php

namespace Database\Factories\Survey;

use Illuminate\Database\Eloquent\Factories\Factory;
use Models\Edu\Survey\QuestionOption;

class OptionFactory extends Factory
{
    protected $model = QuestionOption::class;
 
    public function definition(): array
    {
        return [
            "title" => fake()->word,
            "question_id" => fake()->numberBetween(1,10)
        ];
    }
}
