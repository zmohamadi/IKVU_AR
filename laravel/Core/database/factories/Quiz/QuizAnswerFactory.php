<?php

namespace Database\Factories\Quiz;

use Illuminate\Database\Eloquent\Factories\Factory;
use Models\Edu\Quiz\QuizAnswer;

class QuizAnswerFactory extends Factory
{
    protected $model = QuizAnswer::class;
 
    public function definition(): array
    {
        return [
            "user_id" => fake()->numberBetween(10,50),
            "mark" => fake()->numberBetween(1,10),
            "answer" => fake()->word(5,10),
            "quiz_id" => fake()->numberBetween(1,10)
        ];
    }
}
