<?php

namespace Database\Factories\Assignment;

use Illuminate\Database\Eloquent\Factories\Factory;
use Models\Edu\Assignment\Option;

class OptionFactory extends Factory
{
    protected $model = Option::class;
 
    public function definition(): array
    {
        return [
            "title" => fake()->word,
            "assignment_id" => fake()->numberBetween(1,10)
        ];
    }
}
