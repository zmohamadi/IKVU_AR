<?php

namespace Database\Seeders\Person;

use Illuminate\Database\Seeder;
use Models\Person\Teacher;

class TeacherSeeder extends Seeder
{
    
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Teacher::factory()->count(5)->create();
    }
}
