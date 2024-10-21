<?php

namespace Publics\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class CourseFactory extends Factory{
    public function definition()
    {
        return [
            // 'code' => Str::random(10),
            'code' => fake()->unique()->randomNumber(7),
            'title' => fake()->title(),
            'description' => fake()->paragraph(),
            'thumbnail' => Str::random(10).".png",
            'category_id' => 1,
            'system_id' => 1,
            'status_id' => 1,
            'lang' => "fa"
        ];
    }
}