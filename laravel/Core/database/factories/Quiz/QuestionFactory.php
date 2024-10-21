<?php

namespace Database\Factories\Quiz;

use Illuminate\Database\Eloquent\Factories\Factory;
use Models\Edu\Quiz\Question;

class QuestionFactory extends Factory
{
    protected $model = Question::class;
 
    public function definition(): array
    {
        return [
            "title" => fake()->paragraph,
            "quiz_id" => fake()->numberBetween(1,10),
            "question_type_id" => fake()->numberBetween(1,2),
            "score" => fake()->numberBetween(1,10),
        ];
    }
}
