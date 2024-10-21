<?php

namespace Database\Factories\Forum;

use Illuminate\Database\Eloquent\Factories\Factory;
use Models\Edu\Forum\Attachment;

class AttachmentFactory extends Factory
{
    protected $model = Attachment::class;
 
    public function definition(): array
    {
        return [
            "post_id" => fake()->numberBetween(1,5),
            "file_type_id" => 1,
            "file_category_id" => 1,
            "name" => fake()->randomElement(['1.jpg', '2.jpg','3.jpg']),
        ];
    }
}
