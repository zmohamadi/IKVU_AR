<?php

namespace Database\Factories\Forum;

use Illuminate\Database\Eloquent\Factories\Factory;
use Models\Edu\Forum\Like;

class LikeFactory extends Factory
{
    protected $model = Like::class;
 
    public function definition(): array
    {
        return [
            "user_id" => fake()->numberBetween(2,8),
            "post_id" => fake()->numberBetween(1,5),
            "like_type_id" => fake()->randomElement(['0','1']),
        ];
    }
}
