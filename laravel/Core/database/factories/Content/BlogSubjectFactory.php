<?php

namespace Database\Factories\Content;

use Illuminate\Database\Eloquent\Factories\Factory;
use Models\Content\BlogSubject;

class BlogSubjectFactory extends Factory
{
    protected $model = BlogSubject::class;
 
    public function definition(): array
    {
        return [
            'title_en' => fake()->word
        ];
    }
}
