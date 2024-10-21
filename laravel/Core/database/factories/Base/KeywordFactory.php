<?php

namespace Database\Factories\Base;

use Illuminate\Database\Eloquent\Factories\Factory;
use Models\Base\Keyword;

class KeywordFactory extends Factory
{
    protected $model = Keyword::class;
 
    public function definition(): array
    {
        return [
            'title' => fake()->word,
            'order' => fake()->numberBetween(1,10)
        ];
    }
}
