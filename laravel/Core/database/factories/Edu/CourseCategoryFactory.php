<?php

namespace Database\Factories\Edu;

use Illuminate\Database\Eloquent\Factories\Factory;
use Models\Edu\CourseCategory;

class CourseCategoryFactory extends Factory
{
    protected $model = CourseCategory::class;
 
    public function definition(): array
    {
        return [
            'title_en' => fake()->word
        ];
    }
}
