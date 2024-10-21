<?php

namespace Database\Factories\Edu;

use Illuminate\Database\Eloquent\Factories\Factory;
use Models\Edu\Course;

class CourseFactory extends Factory
{
    protected $model = Course::class;
 
    public function definition(): array
    {
        return [
            'title' => fake()->word(),
            // "thumbnail" => fake()->randomElement(['1.jpg', '2.jpg','3.jpg']),
            // "description" => fake()->text,
            'code' => fake()->unique()->randomNumber(4),
            'less_id' => fake()->unique()->randomNumber(4),
            // "objectives" => fake()->paragraph,
            // "start_date" => fake()->date,
            // "end_date" => fake()->date,
            // "registration_end_date" => fake()->date,
            // "top_score" => fake()->numberBetween(1,100),
            // "average_score" => fake()->numberBetween(1,100),
            "category_id" => fake()->numberBetween(1,5),
            // "status_id" => fake()->numberBetween(0,1),
            // 'system_id' => 1,
            // 'lang' => "fa"
        ];
    }
}
