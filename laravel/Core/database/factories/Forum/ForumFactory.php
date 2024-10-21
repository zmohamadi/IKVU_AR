<?php

namespace Database\Factories\Forum;

use Illuminate\Database\Eloquent\Factories\Factory;
use Models\Edu\Forum\Forum;

class ForumFactory extends Factory
{
    protected $model = Forum::class;
 
    public function definition(): array
    {
        return [
            'title' => fake()->word,
            "description" => fake()->text,
            "course_id" => fake()->randomElement(['15356796','12536796','123526796','993456796']),
            "group" => fake()->randomElement(['1401200','1402102','1402205','1403203','0']),
            "manager_id" => fake()->randomElement(['1','9']),
            "lock" => fake()->randomElement(['0','1']),
            "need_to_apply" => fake()->randomElement(['0','1']),
        ];
    }
}
