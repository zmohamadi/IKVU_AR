<?php

namespace Database\Factories\Assignment;

use Illuminate\Database\Eloquent\Factories\Factory;
use Models\Edu\Assignment\AssignmentAnswer;

class AssignmentAnswerFactory extends Factory
{
    protected $model = AssignmentAnswer::class;
 
    public function definition(): array
    {
        return [
            "user_id" => fake()->numberBetween(10,50),
            "score" => fake()->numberBetween(1,10),
            "answer" => fake()->word(5,10),
            "assignment_id" => fake()->numberBetween(1,10)
        ];
    }
}
