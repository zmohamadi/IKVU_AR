<?php

namespace Database\Seeders\Assignment;

use Illuminate\Database\Seeder;
use Models\Edu\Assignment\Assignment;

class AssignmentSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Assignment::factory()->count(10)->create();
    }
}
