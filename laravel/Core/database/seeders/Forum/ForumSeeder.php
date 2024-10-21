<?php

namespace Database\Seeders\Forum;

use Illuminate\Database\Seeder;
use Models\Edu\Forum\Forum;

class ForumSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Forum::factory()->count(10)->create();
    }
}
