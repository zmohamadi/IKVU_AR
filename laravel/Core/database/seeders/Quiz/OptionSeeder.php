<?php

namespace Database\Seeders\Quiz;

use Illuminate\Database\Seeder;
use Models\Edu\Quiz\Option;

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
