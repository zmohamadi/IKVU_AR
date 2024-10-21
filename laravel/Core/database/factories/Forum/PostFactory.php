<?php

namespace Database\Factories\Forum;

use Illuminate\Database\Eloquent\Factories\Factory;
use Models\Edu\Forum\Post;

class PostFactory extends Factory
{
    protected $model = Post::class;
 
    public function definition(): array
    {
        return [
            'title' => fake()->word,
            'message' => fake()->text,
            "forum_id" => fake()->numberBetween(1,5),
            "sender_id" => fake()->numberBetween(2,8),
            "parent_id" => fake()->numberBetween(5,10),
            "type_id" => fake()->numberBetween(0,3),
        ];
    }
}
