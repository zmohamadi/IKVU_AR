<?php

namespace Database\Seeders\Quiz;

use Illuminate\Database\Seeder;
use Models\Edu\Quiz\Type;

class TypeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $items = [
            [
                "title_en" => "Descriptive",
                "title_fa" => "تشریحی",
                
            ],
            [
                "title_en" => "Multiple choice",
                "title_fa" => "چند گزینه ای",
                
            ]
            
            
        ];
        foreach($items as $item)
        {
            Type::create($item);
        }
    }
}
