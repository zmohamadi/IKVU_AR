<?php

namespace Database\Factories\Assignment;

use Illuminate\Database\Eloquent\Factories\Factory;
use Models\Edu\Assignment\AnswerDetail;

class AnswerDetailFactory extends Factory
{
    protected $model = AnswerDetail::class;
 
    public function definition(): array
    {
        return [
            "answer_id" => fake()->numberBetween(5,10),
            "user_id" => fake()->numberBetween(5,10),
            "answer" => fake()->paragraph,
            "answer_option_id" => fake()->numberBetween(1,10),
            // "assignment_id" => fake()->numberBetween(1,10),
            // "course_id" => fake()->numberBetween(1,10),
        ];
    }
}
