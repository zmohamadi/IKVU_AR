<?php

namespace Database\Seeders\Quiz;

use Illuminate\Database\Seeder;
use Models\Edu\Quiz\Question;

class QuestionSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Question::factory()->count(10)->create();
    }
}
