<?php

namespace Database\Seeders\Assignment;

use Illuminate\Database\Seeder;
use Models\Edu\Assignment\Answer;

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
