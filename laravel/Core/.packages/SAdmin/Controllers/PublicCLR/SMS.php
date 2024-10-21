<?php

namespace SAdmin\Controllers\PublicCLR;

use App\User;
use SoapClient;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class SMS extends Controller
{
    // protected static $user   = "vsms3855";
    // protected static $pass   = "ali2576";
    // protected static $from   = "50002211251";
    // protected static $domain = "0098";
    protected static $user   = "akbari97";
    protected static $pass   = "0384";
    protected static $from   = "10006152735000";

    public static function sendSMS($mobile, $text = ""){        
        // $text = str_replace(" ", '%20', $text);
        // $text = str_replace("\n", '%0a', $text);

        $soap = new SoapClient("http://my.hiro-sms.com/webservice/send.php?wsdl");
        //SendSMS
        $soap->Username= self::$user;
        $soap->Password= self::$pass;
        $soap->fromNum = self::$from;
        // $soap->toNum=array("+989191964745","+989109664085");
        $soap->toNum=array($mobile);
        $soap->Content = $text;
        $soap->Type = '0';


        $array = $soap->SendSMS($soap->fromNum,$soap->toNum,$soap->Content,$soap->Type,$soap->Username,$soap->Password);
        // dd($array);
    }

    public static function sendSMS2($mobile, $text = ""){        
        $text = str_replace(" ", '%20', $text);
        $text = str_replace("\n", '%0a', $text);
        $ch = curl_init();
        $urlSMSpanel = "http://www.0098sms.com/sendsmslink.aspx?FROM=".self::$from."&TO={$mobile}&TEXT={$text}&USERNAME=".self::$user."&PASSWORD=".self::$pass."&DOMAIN=".self::$domain;
        // $urlSMSpanel = "http://www.0098sms.com/sendsmslink.aspx?FROM=50002211251&TO=09109664085&TEXT=".$TEXT."&USERNAME=vsms3855&PASSWORD=ali2576&DOMAIN=0098";
        // set URL and other appropriate options
        curl_setopt($ch, CURLOPT_URL, $urlSMSpanel);
        curl_setopt($ch, CURLOPT_HEADER, 0);
    
        // grab URL and pass it to the browser
        curl_exec($ch);
    
        // close cURL resource, and free up system resources
        curl_close($ch);
    }

    function sendSMS1($mobile, $random_code){
        $user_smsPandel = 'vsms3855';
        $pass_smsPanel = 'ali2576';
        $FROM = '50002211251';
        $DOMAIN = '0098';

        $TEXT = 'کد%20تأیید%20شما:%20'.$random_code.'%0ahttp://ikvu.ac.ir'; //  %20 = space  %0a = enter 
    
        // create a new cURL resource
        $ch = curl_init();
        $urlSMSpanel = "http://www.0098sms.com/sendsmslink.aspx?FROM={$FROM}&TO={$mobile}&TEXT={$TEXT}&USERNAME={$user_smsPandel}&PASSWORD={$pass_smsPanel}&DOMAIN={$DOMAIN}";
        // $urlSMSpanel = "http://www.0098sms.com/sendsmslink.aspx?FROM=50002211251&TO=09109664085&TEXT=".$TEXT."&USERNAME=vsms3855&PASSWORD=ali2576&DOMAIN=0098";
        // set URL and other appropriate options
        curl_setopt($ch, CURLOPT_URL, $urlSMSpanel);
        curl_setopt($ch, CURLOPT_HEADER, 0);
    
        // grab URL and pass it to the browser
        curl_exec($ch);
    
        // close cURL resource, and free up system resources
        curl_close($ch);
    }
}
