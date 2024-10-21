<?php

namespace Database\Seeders\Edu;

use Illuminate\Database\Seeder;
use Models\Edu\OnlineClassroom\OnlineClassroom;

class OnlineClassroomSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        OnlineClassroom::factory()->count(10)->create();
    }
}
