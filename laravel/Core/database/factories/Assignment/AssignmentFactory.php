<?php

namespace Database\Factories\Assignment;

use Illuminate\Database\Eloquent\Factories\Factory;
use Models\Edu\Assignment\Assignment;

class AssignmentFactory extends Factory
{
    protected $model = Assignment::class;
 
    public function definition(): array
    {
        return [
            "description" => fake()->paragraph,
            "course_id" => fake()->numberBetween(1,10),
            "status_id" => fake()->numberBetween(0,1),
            "question_type_id" => fake()->numberBetween(1,2),
            "start_date" => fake()->date,
            "expire_date" => fake()->date,
            "score" => fake()->numberBetween(1,10)
        ];
    }
}
