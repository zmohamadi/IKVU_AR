<?php

namespace Database\Factories\Content;

use Illuminate\Database\Eloquent\Factories\Factory;
use Models\Content\ContactUs;

class ContactUsFactory extends Factory
{
    protected $model = ContactUs::class;
 
    public function definition(): array
    {
        return [
            'sender_name' => fake()->name,
            "sender_email" => fake()->email,
            "subject" => fake()->word,
            "comment" => fake()->text,
        ];
    }
}
