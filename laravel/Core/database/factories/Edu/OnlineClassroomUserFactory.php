<?php

namespace Database\Factories\Edu;

use Illuminate\Database\Eloquent\Factories\Factory;
use Models\Edu\OnlineClassroom\OnlineClassroomUser;

class OnlineClassroomUserFactory extends Factory
{
    protected $model = OnlineClassroomUser::class;
 
    public function definition(): array
    {
        return [
            "student_id" => fake()->numberBetween(5,10),
            "onlineClassroom_id" => fake()->numberBetween(1,10),
        ];
    }
}
