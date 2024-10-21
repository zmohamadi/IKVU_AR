<?php

namespace Publics\Controllers;

// use Src\Publics\Controller;
use App\Http\Controllers\Controller;
use Publics\Traits\Calendar\JDateTime;
use Publics\Traits\Calendar\Calendar;
use Publics\Controllers\Numbers;
use Hekmatinasser\Verta\Verta;

class ConvertDate extends Controller
{
    public static function toJalali($date)
    {
        /**
         * get date jalali with numbers En
        */
        $dateGregorian = $date;
        /**
         * date want be sorat array
        */
        $dateGregorianArray = explode('/', $dateGregorian);
        /**
         * array date gregorian convert to array date jalali
        */
        $dateJalaliArray = Verta::getJalali($dateGregorianArray[0], $dateGregorianArray[1], $dateGregorianArray[2]);
        /**
         *  read array date jalali b sorat format date
        */
        $dateJalali = implode('/',$dateJalaliArray);
        /**
         *  date numbers En convert to numbers Fa
        */
        $dateJalaliFa = Numbers::numbersEnToFa($dateJalali);

        return $dateJalaliFa;
    }
    public static function toGregorian($date)
    {
        /**
         * get date jalali with numbers Fa and convert to numbers En
        */
        $dateJalali = Numbers::numbersFaToEn($date);
        $pdateArray = explode("/", $dateJalali);
        $date = Verta::getGregorian($pdateArray[0], $pdateArray[1], $pdateArray[2]);
        if(strlen($date[1]) < 2) $date[1] = "0".$date[1];
        if(strlen($date[2]) < 2) $date[2] = "0".$date[2];
        $greDate = implode("/", $date);
        // dd($greDate);
        return $greDate;


        // /**
        //  * get date jalali with numbers Fa and convert to numbers En
        // */
        // $dateJalali = Numbers::numbersFaToEn($date);
        // /**
        //  * date want be sorat array
        // */
        // $dateJalaliArray = explode('/', $dateJalali);
        // /**
        //  * array date jalali convert to array date gregorian
        // */
        // $dateGregorianArray = Verta::getGregorian($dateJalaliArray[0], $dateJalaliArray[1], $dateJalaliArray[2]);
        // // $dateGregorianArray = Calendar::jalali2En($dateJalaliArray);
        // /**
        //  *  read array date gregorian b sorat format date
        // */
        // if(strlen($dateGregorianArray[1])==1) $dateGregorianArray[1] = "0".$dateGregorianArray[1];
        // if(strlen($dateGregorianArray[2])==1) $dateGregorianArray[1] = "0".$dateGregorianArray[2];
        // $dateGregorian = implode('/', $dateGregorianArray);
        // return $dateGregorian;
    }
    public static function birthDate($year_sh, $month_sh, $day_sh): array
    {
        if ($year_sh && $month_sh && $day_sh) {
            $birth_date_items = [$year_sh ,$month_sh, $day_sh ];
            $birth_date_sh = implode('/', $birth_date_items);
            $birth_date_items_m = Verta::getGregorian($year_sh, $month_sh, $day_sh);
            $birth_date_m = implode('-', $birth_date_items_m);

            return array($birth_date_sh, $birth_date_m);
        }
        return ['',''];
    }
}
