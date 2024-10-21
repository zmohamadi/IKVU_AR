<?php

namespace Database\Seeders\Person;

use Illuminate\Database\Seeder;
use Models\Person\Role;

class RoleSeeder extends Seeder
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
                "title_en"=>"teacher",
                "title_fa"=>"استاد",
            ],
            [
                "title_en"=>"student",
                "title_fa"=>"دانشجو",
            ],
            [
                "title_en"=>"Assistant",
                "title_fa"=>"دستیار استاد",
            ], 
            [
                "title_en"=>"personnel",
                "title_fa"=>"پرسنل",
            ], 
            [
                "title_en"=>"education expert",
                "title_fa"=>"کارشناس آموزش",
            ], 
            [
                "title_en"=>"Online class expert",
                "title_fa"=>"کارشناس برگزاری کلاس آنلاین",
            ], 
            [
                "title_en"=>"Informatics expert",
                "title_fa"=>"کارشناس انفورماتیک",
            ], 
            [
                "title_en"=>"Examination expert",
                "title_fa"=>"کارشناس امتحانات",
            ],
            [
                "title_en"=>"Research expert",
                "title_fa"=>"کارشناس پژوهش",
            ],
        ];
        foreach($items as $item)
        {
            Role::create($item);
        }
    }
}
