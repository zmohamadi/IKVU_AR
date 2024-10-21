<?php

namespace Database\Factories\Quiz;

use Illuminate\Database\Eloquent\Factories\Factory;
use Models\Edu\Quiz\Answer;

class AnswerFactory extends Factory
{
    protected $model = Answer::class;
 
    public function definition(): array
    {
        return [
            "answer" => fake()->paragraph,
            "user_id" => fake()->numberBetween(5,10),
            "course_id" => fake()->numberBetween(1,10),
            "status_id" => fake()->numberBetween(0,1),
            "score" => fake()->numberBetween(1,10),
        ];
    }
}
