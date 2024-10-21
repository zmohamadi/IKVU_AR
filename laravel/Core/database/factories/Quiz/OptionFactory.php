<?php

namespace Database\Factories\Quiz;

use Illuminate\Database\Eloquent\Factories\Factory;
use Models\Edu\Quiz\Option;

class OptionFactory extends Factory
{
    protected $model = Option::class;
 
    public function definition(): array
    {
        return [
            "title" => fake()->word,
            "question_id" => fake()->numberBetween(1,10)
        ];
    }
}
