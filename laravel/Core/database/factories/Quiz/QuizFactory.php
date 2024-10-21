<?php

namespace Database\Factories\Quiz;

use Illuminate\Database\Eloquent\Factories\Factory;
use Models\Edu\Quiz\Quiz;

class QuizFactory extends Factory
{
    protected $model = Quiz::class;
 
    public function definition(): array
    {
        // $faker = \Faker\Factory::create('fa_IR'); // تنظیم زبان به فارسی

        return [
            "title" => fake()->word,
            "description" => fake()->word,
            "course_id" => fake()->numberBetween(1,10),
            "status_id" => fake()->numberBetween(0,1),
            "start_time_date" => fake()->date,
            "end_time_date" => fake()->date,
        ];
    }
}
