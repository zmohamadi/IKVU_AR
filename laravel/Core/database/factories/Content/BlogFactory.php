<?php

namespace Database\Factories\Content;

use Illuminate\Database\Eloquent\Factories\Factory;
use Models\Content\Blog;

class BlogFactory extends Factory
{
    protected $model = Blog::class;
 
    public function definition(): array
    {
        return [
            'title' => fake()->sentence(4),
                "summary" => fake()->paragraph,
                "text" => fake()->text,
                "subject_id" => fake()->numberBetween(1,5),
                "image" => fake()->randomElement(['1.jpg', '2.jpg','3.jpg']),
                "thumb" => fake()->randomElement(['1.jpg', '2.jpg','3.jpg']),
                "lang" => "en",
                "creator_id" => 1,
        ];
    }
}
