<?php

namespace Database\Factories\Edu;

use Illuminate\Database\Eloquent\Factories\Factory;
use Models\Edu\Resource\Resource;

class ResourceFactory extends Factory
{
    protected $model = Resource::class;
 
    public function definition(): array
    {
        return [
            "title"=>fake()->sentence,
            "course_id"  => fake()->numberBetween(1,10),
            "duration"  =>fake()->time,
            "link"  =>fake()->url,
            "lang"  => "en",
            "display_status_id"  => 1,
            "status_id" => fake()->numberBetween(0,1)
        ];
    }
}
