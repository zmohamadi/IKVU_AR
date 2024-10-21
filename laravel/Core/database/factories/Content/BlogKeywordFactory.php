<?php

namespace Database\Factories\Content;

use Illuminate\Database\Eloquent\Factories\Factory;
use Models\Content\BlogKeyword;

class BlogKeywordFactory extends Factory
{
    protected $model = BlogKeyword::class;
 
    public function definition(): array
    {
        return [
            "keyword_id" => fake()->numberBetween(1,10),
            "blog_id" => fake()->numberBetween(1,10),
        ];
    }
}
