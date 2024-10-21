<?php

namespace Publics\Controllers;

// use Src\Publics\Controller;
use App\Http\Controllers\Controller;

class Numbers extends Controller
{
    public static function numbersFaToEn($num){
        $numbers = ['۰' => '0', '۱'=>'1', '۲'=>'2', '۳'=>'3', '٤'=>'4','۴'=>'4',
                    '۵'=>'5', '۶'=>'6', '۷'=>'7', '۸'=>'8', '۹'=>'9'];

        $num = \str_ireplace(',','',$num);

        foreach($numbers as $key=>$val){
        $num = \str_replace($key, $val, $num);
        }

        return $num;
    }

    public static function numbersEnToFa($num){
        $numbers = ['0'=>'۰', '1'=>'۱', '2'=>'۲', '3'=>'۳', '4'=>'٤',
                    '5'=>'۵', '6'=>'۶', '7'=>'۷', '8'=>'۸', '9'=>'۹'];

        $num = \str_ireplace(',','',$num);

        foreach($numbers as $key=>$val){
            $num = \str_replace($key, $val, $num);
        }

        return $num;
    }
}
