<?php

namespace Database\Seeders\Forum;

use Illuminate\Database\Seeder;
use Models\Edu\Forum\Subject;

class SubjectSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Subject::factory()->count(5)->create();
    }
}
