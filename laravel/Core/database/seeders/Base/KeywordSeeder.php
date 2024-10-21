<?php

namespace Database\Seeders\Base;

use Illuminate\Database\Seeder;
use Models\Base\Keyword;

class KeywordSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Keyword::factory()->count(10)->create();
    }
}
