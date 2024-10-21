<?php

namespace Database\Seeders\Person;

use Illuminate\Database\Seeder;
use Models\Person\Student;

class StudentSeeder extends Seeder
{
    
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Student::factory()->count(10)->create();
    }
}
