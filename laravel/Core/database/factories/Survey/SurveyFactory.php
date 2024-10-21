<?php

namespace Database\Factories\Survey;

use Illuminate\Database\Eloquent\Factories\Factory;
use Models\Edu\Survey\Survey;

class SurveyFactory extends Factory
{
    protected $model = Survey::class;
 
    public function definition(): array
    {
        return [
            "title" => fake()->word,
            "course_id" => fake()->numberBetween(1,10),
            "status_id" => fake()->numberBetween(0,1),
            "start_date" => fake()->date,
            "expire_date" => fake()->date,
            "description" => fake()->paragraph,
        ];
    }
}
