<?php

namespace Database\Seeders\Quiz;

use Illuminate\Database\Seeder;
use Models\Edu\Quiz\Answer;

class AnswerSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Answer::factory()->count(10)->create();
    }
}
