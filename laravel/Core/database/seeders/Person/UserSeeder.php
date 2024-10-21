<?php

namespace Database\Seeders\Person;

use Illuminate\Database\Seeder;
use Models\Person\User;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $items = [
            ["firstname"=>"مهدی","lastname"=>"وثوقی","role_id"=>"3","gender_id"=>"1","email"=>"sanegar.info@gmail.com", "mobile"=>"09191964745", "password"=>bcrypt("09191964745"), "status_id"=>"1", "lang"=>"fa","photo"=>"1.jpg",],
            ["firstname"=>"احمد","lastname"=>"احمدی نیا","role_id"=>"1","person_id"=>"111111","gender_id"=>"1","email"=>"Ahmadi@gmail.com", "mobile"=>"09122222222", "password"=>bcrypt("09122222222"), "status_id"=>"1", "lang"=>"fa","photo"=>"2.jpg",],
            ["firstname"=>"علی","lastname"=>"مولوی","role_id"=>"1","person_id"=>"22222","gender_id"=>"1","email"=>"AliMolavi@gmail.com", "mobile"=>"09123333333", "password"=>bcrypt("09123333333"), "status_id"=>"1", "lang"=>"fa","photo"=>"3.jpg",],
            ["firstname"=>"ناصر","lastname"=>"تقوایی","role_id"=>"1","person_id"=>"33333","gender_id"=>"1","email"=>"Taghvaey@gmail.com", "mobile"=>"09124444444", "password"=>bcrypt("09124444444"), "status_id"=>"1", "lang"=>"fa","photo"=>"4.jpg",],
            ["firstname"=>"رضا","lastname"=>"رضوانی","role_id"=>"1","person_id"=>"44444","gender_id"=>"1","email"=>"Reza@gmail.com", "mobile"=>"09125555555", "password"=>bcrypt("09125555555"), "status_id"=>"1", "lang"=>"fa","photo"=>"5.jpg",],
            ["firstname"=>"امیر","lastname"=>"رضایی نیا","role_id"=>"2","person_id"=>"555555","studentID"=>"001111","gender_id"=>"1","email"=>"Amir@gmail.com", "mobile"=>"09126666666", "password"=>bcrypt("09126666666"), "status_id"=>"1", "lang"=>"fa","photo"=>"6.jpg",],
            ["firstname"=>"امین","lastname"=>"امیری","role_id"=>"2","person_id"=>"66666","studentID"=>"00222","gender_id"=>"1","email"=>"Amin@gmail.com", "mobile"=>"09127777777", "password"=>bcrypt("09127777777"), "status_id"=>"1", "lang"=>"fa","photo"=>"7.jpg",],
            ["firstname"=>"وحید","lastname"=>"وحیدی","role_id"=>"2","person_id"=>"8888","studentID"=>"003333","gender_id"=>"1","email"=>"Vahidi@gmail.com", "mobile"=>"09128888888", "password"=>bcrypt("09128888888"), "status_id"=>"1", "lang"=>"fa","photo"=>"8.jpg",],
            ["firstname"=>"مالک","lastname"=>"اکرمی","role_id"=>"2","person_id"=>"99999","studentID"=>"00444","gender_id"=>"1","email"=>"Akrami@gmail.com", "mobile"=>"09129999999", "password"=>bcrypt("09129999999"), "status_id"=>"1", "lang"=>"fa","photo"=>"9.jpg",],
            ["firstname"=>"مصطفی","lastname"=>"ذاکر رضوی","role_id"=>"4","person_id"=>"121212","studentID"=>"00888","gender_id"=>"1","email"=>"razavi@gmail.com", "mobile"=>"09194524024", "password"=>bcrypt("09194524024"), "status_id"=>"1", "lang"=>"fa","photo"=>"10.jpg",],
        ];
        foreach($items as $item)
        {
            User::create($item);
        }
    }
}
