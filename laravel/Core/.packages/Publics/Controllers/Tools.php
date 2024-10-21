<?php

namespace Publics\Controllers;
use \Carbon\Carbon;
use Morilog\Jalali\Jalalian;

class Tools{
  
    public static function checkDateTime($field = [])
    {
        // Replace slashes with dashes in the date strings
        foreach ($field as $key => $value) {
            $field[$key] = str_replace('/', '-', $value);
        }
    
        try {
            // Ensure start_time_date is in the correct format
            if (isset($field['start_time_date'])) {
                // Convert Jalali to Carbon
                $start_time_date_jalali = $field['start_time_date'];
                $start_time_date_carbon = Jalalian::fromFormat('Y-m-d H:i', $start_time_date_jalali)->toCarbon();
                $field['start_time_date'] = $start_time_date_carbon->format('Y-m-d H:i');
            }
            if (isset($field['end_time_date'])) {
                // Convert Jalali to Carbon
                $end_time_date_jalali = $field['end_time_date'];
                $end_time_date_carbon = Jalalian::fromFormat('Y-m-d H:i', $end_time_date_jalali)->toCarbon();
                $field['end_time_date'] = $end_time_date_carbon->format('Y-m-d H:i');
            }
    
            // Get the current time in Carbon
            $now = Jalalian::now();
            $time = $now->toCarbon();
            $before_time = $time;
    
            if (isset($field['before_time'])) {
                $before_time = $now->addMinutes((int)$field['before_time'])->toCarbon();
            }
    
            if (isset($field['duration'])) {
                // Ensure start_time_date is in Carbon format
                $start_time_date_carbon = Carbon::createFromFormat('Y-m-d H:i', $field['start_time_date']);
                $end_time_date_carbon = $start_time_date_carbon->addMinutes((int)$field['duration']);
                $field['end_time_date'] = $end_time_date_carbon->format('Y-m-d H:i');
                $end_time_date_jalali = Jalalian::fromCarbon($end_time_date_carbon)->format('Y-m-d H:i');
            }
    
            $status = "loading_date";
            $title = "loading_date";
            $message = "loading_date";
            $flag = true;
    
            if (isset($field["start_time_date"])) {
                if ($before_time < $field["start_time_date"]) {
                    $start_time_date_jalali = Jalalian::fromCarbon($start_time_date_carbon)->format('Y-m-d H:i');
                    $status = "before_time";
                    $message = "The time has not yet arrived, thank you for your patience.<br/> Start at: {$start_time_date_jalali}";
                    $flag = false;
                }
            }
    
            if (isset($field['end_time_date']) && $flag) {
                if ($time > $field['end_time_date']) {
                    $end_time_date_jalali = Jalalian::fromCarbon($end_time_date_carbon)->format('Y-m-d H:i');
                    $status = "after_time";
                    $message = "The time to login has ended at: {$end_time_date_jalali}";
                    $flag = false;
                }
            }
    
            if ($flag) {
                $status = "on_time";
                $message = "";
                $title = "start";
            }
    
            return ["status" => $status, "message" => $message, "title" => $title, "flag" => $flag];
        } catch (\Exception $e) {
            return ["status" => "error", "message" => "Error: " . $e->getMessage(), "title" => "error", "flag" => false];
        }
    }
    public static function checkDateTime000($field=[])
    {
        foreach($field as $key=>$value){
            $field[$key] = str_replace('T', ' ', $value);
        }
        $before_time = $time = Carbon::now()->format('Y-m-d H:i');
        if(isset($field['before_time'])){
            $before_time = Carbon::now()->addMinute($field['before_time'])->format('Y-m-d H:i');
        }
        if(isset($field['duration'])){
            $field['end_time_date'] = Carbon::createFromFormat('Y-m-d H:i',  $field["start_time_date"])->addMinute($field['duration']); 
        }
        $status = "loading_date";
        $title = "loading_date";
        $message = "loading_date";
        $flag = true;
        if(isset($field["start_time_date"])){
            if($before_time < $field["start_time_date"])
            {
                $status = "before_time";
                $message = "The time has not yet arrived, thank you for your patience.<br/> Start at: {$field["start_time_date"]}";
                $flag = false;
            }
        }
        if(isset($field['end_time_date']) && $flag){
            if($time > $field["end_time_date"])
            {
                $status = "after_time";
                $message = "The time to login has ended at: {$field['end_time_date']}";
                $flag = false;
            }
        }
        if($flag){
            $status = "on_time";
            $message = "";
            $title = "start";            
        }
        return ["status"=>$status,"message"=>$message,"title"=>$title,"flag"=>$flag];
    }
    public static function compareDateWithToday($date){
        $today = Carbon::now()->format('Y-m-d');
        // dd("today : " .$today . "  - date : ". $date);
        $res = true;
        if($date< $today) $res =  false;
        return $res;
    }

    public static function getUserCourseInfo($course){
        if(is_array(session('course-'.$course))){
            return session('course-'.$course);
        }
    }
    // semester, group
    public static function setGroup($field=[])
    {
        $group = $field['semester'] ? $field['semester'] . $field['group'] : 0;
        return $group;
    }
    // کاربر در چه گروهی ثبت نام کرده است ؟ 
    public static function userGroup($course, $user_id)
    {
        // گرفتن تاریخ امروز بدون فرمت اضافه
        $today = Jalalian::now();

        // جستجوی ثبت‌نام کاربر بر اساس شناسه کاربر و کد دوره
        $userRegister = \Models\Edu\Register::where([
            'user_id' => $user_id,
            'code' => $course
        ])
        ->where('end_date', '>=', $today) // شرط: تاریخ پایان باید بزرگتر یا برابر امروز باشد
        ->select('group')
        ->get();

        // اگر دقیقا یک رکورد یافت شد، گروه کاربر برگردانده شود
        if ($userRegister->count() == 1) {
            return $userRegister->first()->group;
        }

        // در غیر اینصورت، تمام رکوردها برگردانده شوند
        return $userRegister;
    }


    
    public static function getGroupNum($course, $user_id)
    {
        $groups = self::userGroup($course, $user_id);
        
        // اگر فقط یک مقدار باشد
        if (is_string($groups)) {
            return [substr($groups, -2)];
        }
    
        $newArray = [];
        
        // اگر مجموعه‌ای از گروه‌ها باشد
        foreach ($groups as $value) {
            $newArray[] = substr($value->group, -2);
        }
        
        return $newArray;
    }
    


    // get semester, group & Checked For a Course Of user Logined
    public static function conditionGroup($field=[])
    {
        $semesterYear = substr($field['group'], 0, 5);
        $collection = $field['collection']->whereIn('group', [$field['group'], 0, $semesterYear."00"]);
        return $collection;
    }
    // کاربر مورد نظر در درس و گروه مشخص شده چه نقشی دارد؟ 
    public static function roleOfUser($user, $course, $group) //استفاده در گزارش پیامگاه
    {
        return \Models\Edu\Register::where(["user_id" => $user, "code" => $course, "group" => $group])->pluck('role_id')->first();
    }
    /**
     * تابعی برای تبدیل اعداد فارسی به انگلیسی
     */
    public static function numbersFaToEn($num){
        $numbers = ['۰' => '0', '۱'=>'1', '۲'=>'2', '۳'=>'3', '٤'=>'4','۴'=>'4',
                    '۵'=>'5', '۶'=>'6', '۷'=>'7', '۸'=>'8', '۹'=>'9'];
        $num = \str_ireplace(',','',$num);
        foreach($numbers as $key=>$val)
        {
            $num = \str_replace($key, $val, $num);
        }
        return $num;
    }
    /**
     * تابعی برای تبدیل اعداد انگلیسی به فارسی
     */
    public static function numbersEnToFa($num){
        $numbers = ['0'=>'۰', '1'=>'۱', '2'=>'۲', '3'=>'۳', '4'=>'٤',
                    '5'=>'۵', '6'=>'۶', '7'=>'۷', '8'=>'۸', '9'=>'۹'];
        $num = \str_ireplace(',','',$num);
        foreach($numbers as $key=>$val)
        {
            $num = \str_replace($key, $val, $num);
        }
        return $num;
    }
    /**
     * تابعی برای تبدیل اعداد انگلیسی به فارسی
     */
    public static function toPersianNumber($str){
        $persianNumbers = ["۰", "۱", "۲", "۳", "۴", "۵", "۶", "۷", "۸", "۹"];

        for($i=0; $i<count($persianNumbers); $i++){
            $str = str_replace($i, $persianNumbers[$i], $str);
        }
        return $str;
    }

    /**
     * تابعی برای تبدیل
     * \n
     *  به
     * <br>
     */
    public static function displayEnter($str = "")
    {
        // return nl2br($str);
        return str_replace(PHP_EOL,"<br>",$str);
    }

    public static function makePath($url)
    {

        $default = ['category', 'city'];
        $path=[];

        foreach($default as $var){
            if(isset($url[$var])){
                $path[] = $var.'='.$url[$var];
            }
            else if(request()->input($var) != "")
            {
                $path[] = $var.'='.request()->input($var);
            }
        }

        $queryString = implode('&', $path);

        return $queryString;
    }

    public static function getCharArray($str){
        $chars = [];
        for($i=0; $i< strlen($str); $i++){
            $chars[] = substr($str, $i, 1);
        }

        return $chars;
    }
    /**
     * $obj : an object made of the desired model (sample : $adv = Adv::find($id);)
     *
     * $field : field of date whose format is to be changed (sample : $adv->created_at = \Morilog\Jalali\Jalalian::forge($adv->created_at))
     *
     * $field_output : field name for data output which is the default date_time
     *                  this name is used in the react component (sample : {item.date_time})
     *                  the output field name should not be the same as the database field name.
     *
     * $relation : if field of date is in the table itself -> this parameter is empty
     *             if the relationship is one to several (1:n) -> this parameter is hasMany
     *             if the relationship is several to several (n:m) -> this parameter is belongsToMany
     *
     * $relation_name : if parameter $relation was not empty, relationship name is sent
     *      (sample : public function log_users()
     *              {
     *                  return $this->belongsToMany(\Models\User::class, 'shop_advs_logs', 'adv_id', 'user_id')
     *                       ->withPivot('id','reason_text','created_at');
     *               })
     *
     *   sample how to use the function : use \Publics\Tools\Tools;
     *                                    Tools::convertDateTime($adv, 'created_at', 'created', 'belongsToMany', 'log_users');
     *
     *   sample how to use the react component : the field name must be named date_time ({item.created})
     */
    public static function convertDateTime($obj, $field, $field_output="date_time", $relation="", $relation_name="")
    {
        if($relation == '')
        {
            $obj->$field = \Morilog\Jalali\Jalalian::forge($obj->$field);
            $array_date_time = explode(" ", $obj->$field);
            $date = explode("-", $array_date_time[0]);
            $date = implode("/", $date);
            $time = explode(":", $array_date_time[1], -1);
            $time = implode(":", $time);
            $obj->$field_output = $date.' - '. $time;
        }

        if($relation == 'hasMany')
        {
            $obj->$relation_name[$i]->$field = \Morilog\Jalali\Jalalian::forge($obj->$relation_name[$i]->$field);
            $array_date_time = explode(" ", $obj->$relation_name[$i]->$field);
            $date = explode("-", $array_date_time[0]);
            $date = implode("/", $date);
            $time = explode(":", $array_date_time[1], -1);
            $time = implode(":", $time);
            $obj->$relation_name[$i]->$field_output = $date.' - '. $time;
        }

        if($relation == 'belongsToMany')
        {
            for ($i = 0; $i < count($obj->$relation_name); $i++)
            {
                $obj->$relation_name[$i]->pivot->$field = \Morilog\Jalali\Jalalian::forge($obj->$relation_name[$i]->pivot->$field);
                $array_date_time = explode(" ", $obj->$relation_name[$i]->pivot->$field);
                $date = explode("-", $array_date_time[0]);
                $date = implode("/", $date);
                $time = explode(":", $array_date_time[1], -1);
                $time = implode(":", $time);
                $obj->$relation_name[$i]->pivot->$field_output = $date.' - '. $time;
            }
        }
        return $obj->$field_output;
    }
    function singularize($word)
    {
        $singular = array (
        '/(quiz)zes$/i' => '\1',
        '/(matr)ices$/i' => '\1ix',
        '/(vert|ind)ices$/i' => '\1ex',
        '/^(ox)en/i' => '\1',
        '/(alias|status)es$/i' => '\1',
        '/([octop|vir])i$/i' => '\1us',
        '/(cris|ax|test)es$/i' => '\1is',
        '/(shoe)s$/i' => '\1',
        '/(o)es$/i' => '\1',
        '/(bus)es$/i' => '\1',
        '/([m|l])ice$/i' => '\1ouse',
        '/(x|ch|ss|sh)es$/i' => '\1',
        '/(m)ovies$/i' => '\1ovie',
        '/(s)eries$/i' => '\1eries',
        '/([^aeiouy]|qu)ies$/i' => '\1y',
        '/([lr])ves$/i' => '\1f',
        '/(tive)s$/i' => '\1',
        '/(hive)s$/i' => '\1',
        '/([^f])ves$/i' => '\1fe',
        '/(^analy)ses$/i' => '\1sis',
        '/((a)naly|(b)a|(d)iagno|(p)arenthe|(p)rogno|(s)ynop|(t)he)ses$/i' => '\1\2sis',
        '/([ti])a$/i' => '\1um',
        '/(n)ews$/i' => '\1ews',
        '/s$/i' => '',
        );

        $uncountable = array('equipment', 'information', 'rice', 'money', 'species', 'series', 'fish', 'sheep');

        $irregular = array(
        'person' => 'people',
        'man' => 'men',
        'child' => 'children',
        'sex' => 'sexes',
        'move' => 'moves');

        $lowercased_word = strtolower($word);
        foreach ($uncountable as $_uncountable){
            if(substr($lowercased_word,(-1*strlen($_uncountable))) == $_uncountable){
                return $word;
            }
        }

        foreach ($irregular as $_plural=> $_singular){
            if (preg_match('/('.$_singular.')$/i', $word, $arr)) {
                return preg_replace('/('.$_singular.')$/i', substr($arr[0],0,1).substr($_plural,1), $word);
            }
        }

        foreach ($singular as $rule => $replacement) {
            if (preg_match($rule, $word)) {
                return preg_replace($rule, $replacement, $word);
            }
        }

        return $word;
    }
    public static function getRepeatRequest($inputs, &$other=[], &$attributes=[]){
        $rules = [];

        foreach(request()->all() as $key=>$value)
        {
            $first = array_key_first($inputs);
            if(\substr($key, 0, strlen($first)) == $first)
            {
                $i = substr($key, strlen($first));
                foreach($inputs as $input=>$rule){
                    $var2 = $input.$i;
                    $rules[$var2] = $rule;
                    $attributes[$var2] = trans('validation.attributes.'.$input);
                }
            }
        }

        return $other = array_merge($rules, $other);
    }
    public static function getRepeatValues($values){
        $data = [];

        foreach(request()->all() as $key=>$value)
        {
            $first = $values[0];
            if(\substr($key, 0, strlen($first)) == $first)
            {
                $i = substr($key, strlen($first));
                $n = str_replace("_", '', $i);
                foreach($values as $var){
                    $var2 = $var.$i;
                    $data[$n][$var] = request()->$var2;
                }
            }
        }

        return $data;
    }
    public static function encode_str($str = 0)
    {
        $key = $str."1a2s3d4f5g6h";
        $data = base64_encode($str);
        $data = str_replace(array('+','/', '='),array('-','_', ','),$data);
        return $data;
    } 
    public static function decode_str($str = 'MA==')
    {
        $data = str_replace(array('-','_', ','),array('+','/', '='),$str);
        $mod4 = strlen($data) % 4;
        if ($mod4) {
            $data .= substr('====', $mod4);
        }
            $data = str_replace('1a2s3d4f5g6h', '', base64_decode($data));
        return  $data;
    }
}
