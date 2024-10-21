<?php

namespace Database\Factories\Content;

use Illuminate\Database\Eloquent\Factories\Factory;
use Models\Content\BlogComment;

class BlogCommentFactory extends Factory
{
    protected $model = BlogComment::class;
 
    public function definition(): array
    {
        return [
            'sender_name' => fake()->name,
            "sender_email" => fake()->email,
            "comment" => fake()->text,
            "blog_id" => fake()->numberBetween(1,10),
            "confirm_id" => fake()->numberBetween(0,1),
        ];
    }
}
