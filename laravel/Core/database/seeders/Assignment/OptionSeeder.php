<?php

namespace Database\Seeders\Assignment;

use Illuminate\Database\Seeder;
use Models\Edu\Assignment\Option;

class OptionSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Option::factory()->count(10)->create();   
    }
}
