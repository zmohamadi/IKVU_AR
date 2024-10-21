<?php

namespace Database\Seeders\Quiz;

use Illuminate\Database\Seeder;
use Models\Edu\Quiz\Quiz;

class QuizSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Quiz::factory()->count(10)->create();
    }
}
