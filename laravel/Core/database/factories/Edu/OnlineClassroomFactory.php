<?php

namespace Database\Factories\Edu;

use Illuminate\Database\Eloquent\Factories\Factory;
use Models\Edu\OnlineClassroom\OnlineClassroom;

class OnlineClassroomFactory extends Factory
{
    protected $model = OnlineClassroom::class;
 
    public function definition(): array
    {
        return [
            'title' => fake()->sentence(4),
            "start_hour" => fake()->time,
            "duration" => fake()->time,
            "meet_link" => fake()->url,
            "date" => fake()->date,
            "course_id" => fake()->numberBetween(1,10),
            "status_id" => fake()->numberBetween(0,1),
        ];
    }
}
