<?php

namespace Database\Factories\Assignment;

use Illuminate\Database\Eloquent\Factories\Factory;
use Models\Edu\Assignment\Answer;

class AnswerFactory extends Factory
{
    protected $model = Answer::class;
 
    public function definition(): array
    {
        return [
            "answer" => fake()->paragraph,
            "user_id" => fake()->numberBetween(5,10),
            "assignment_id" => fake()->numberBetween(1,10),
            "course_id" => fake()->numberBetween(1,10),
            "score" => fake()->numberBetween(1,10),
        ];
    }
}
