<?php
namespace Admin\Controllers\Edu;

use Admin\Controllers\Public\BaseAbstract;
use Illuminate\Http\Request;

class OnlineArchiveController extends BaseAbstract{

    public function getList($course, $group){
        $ServerType = "b5";
        $room = $course."-".$group;
        ini_set('allow_url_fopen', "On");
        $url = "http://vu.iki.ac.ir/bbb/meeting_api.php?ID=$room&Type=$ServerType";
        $response = self::callAPIContent4($url);
        $response = json_decode($response, true);
        $response = self::sort($response);
        return response()->json($response);
    }

    public function getPastList($course, $group){
        $ServerType = "bbb";
        $room = $course."-".$group;
        ini_set('allow_url_fopen', "On");
        $url = "http://vu.iki.ac.ir/bbb/meeting_api.php?ID=$room&Type=$ServerType";
        $response = self::callAPIContent4($url);
        $response = json_decode($response, true);
        $response = self::sort($response);
        return response()->json($response);
    }

    public function getList0(){
        $response = '[{"url":["https:\/\/b5.iki.ac.ir\/playback\/presentation\/2.3\/efdd536867e60fc329f23f077266afed794772e9-1708928625518"],"recordID":["efdd536867e60fc329f23f077266afed794772e9-1708928625518"],"date":"1402\/12\/07"},{"url":["https:\/\/b5.iki.ac.ir\/playback\/presentation\/2.3\/efdd536867e60fc329f23f077266afed794772e9-1709533398529"],"recordID":["efdd536867e60fc329f23f077266afed794772e9-1709533398529"],"date":"1402\/12\/14"},{"url":["https:\/\/b5.iki.ac.ir\/playback\/presentation\/2.3\/efdd536867e60fc329f23f077266afed794772e9-1710138358039"],"recordID":["efdd536867e60fc329f23f077266afed794772e9-1710138358039"],"date":"1402\/12\/21"},{"url":["https:\/\/b5.iki.ac.ir\/playback\/presentation\/2.3\/efdd536867e60fc329f23f077266afed794772e9-1713162230329"],"recordID":["efdd536867e60fc329f23f077266afed794772e9-1713162230329"],"date":"1403\/01\/27"},{"url":["https:\/\/b5.iki.ac.ir\/playback\/presentation\/2.3\/efdd536867e60fc329f23f077266afed794772e9-1713778202013"],"recordID":["efdd536867e60fc329f23f077266afed794772e9-1713778202013"],"date":"1403\/02\/03"},{"url":["https:\/\/b5.iki.ac.ir\/playback\/presentation\/2.3\/efdd536867e60fc329f23f077266afed794772e9-1713767038180"],"recordID":["efdd536867e60fc329f23f077266afed794772e9-1713767038180"],"date":"1403\/02\/03"},{"url":["https:\/\/b5.iki.ac.ir\/playback\/presentation\/2.3\/efdd536867e60fc329f23f077266afed794772e9-1714371818816"],"recordID":["efdd536867e60fc329f23f077266afed794772e9-1714371818816"],"date":"1403\/02\/10"},{"url":["https:\/\/b5.iki.ac.ir\/playback\/presentation\/2.3\/efdd536867e60fc329f23f077266afed794772e9-1714382653401"],"recordID":["efdd536867e60fc329f23f077266afed794772e9-1714382653401"],"date":"1403\/02\/10"},{"url":["https:\/\/b5.iki.ac.ir\/playback\/presentation\/2.3\/efdd536867e60fc329f23f077266afed794772e9-1714976832007"],"recordID":["efdd536867e60fc329f23f077266afed794772e9-1714976832007"],"date":"1403\/02\/17"},{"url":["https:\/\/b5.iki.ac.ir\/playback\/presentation\/2.3\/efdd536867e60fc329f23f077266afed794772e9-1715090323229"],"recordID":["efdd536867e60fc329f23f077266afed794772e9-1715090323229"],"date":"1403\/02\/18"},{"url":["https:\/\/b5.iki.ac.ir\/playback\/presentation\/2.3\/efdd536867e60fc329f23f077266afed794772e9-1715088355738"],"recordID":["efdd536867e60fc329f23f077266afed794772e9-1715088355738"],"date":"1403\/02\/18"},{"url":["https:\/\/b5.iki.ac.ir\/playback\/presentation\/2.3\/efdd536867e60fc329f23f077266afed794772e9-1715581448630"],"recordID":["efdd536867e60fc329f23f077266afed794772e9-1715581448630"],"date":"1403\/02\/24"},{"url":["https:\/\/b5.iki.ac.ir\/playback\/presentation\/2.3\/efdd536867e60fc329f23f077266afed794772e9-1715693035487"],"recordID":["efdd536867e60fc329f23f077266afed794772e9-1715693035487"],"date":"1403\/02\/25"},{"url":["https:\/\/b5.iki.ac.ir\/playback\/presentation\/2.3\/efdd536867e60fc329f23f077266afed794772e9-1716297994812"],"recordID":["efdd536867e60fc329f23f077266afed794772e9-1716297994812"],"date":"1403\/03\/01"},{"url":["https:\/\/b5.iki.ac.ir\/playback\/presentation\/2.3\/efdd536867e60fc329f23f077266afed794772e9-1716791001635"],"recordID":["efdd536867e60fc329f23f077266afed794772e9-1716791001635"],"date":"1403\/03\/07"},{"url":["https:\/\/b5.iki.ac.ir\/playback\/presentation\/2.3\/efdd536867e60fc329f23f077266afed794772e9-1716902566456"],"recordID":["efdd536867e60fc329f23f077266afed794772e9-1716902566456"],"date":"1403\/03\/08"},{"url":["https:\/\/b5.iki.ac.ir\/playback\/presentation\/2.3\/efdd536867e60fc329f23f077266afed794772e9-1716906439852"],"recordID":["efdd536867e60fc329f23f077266afed794772e9-1716906439852"],"date":"1403\/03\/08"}]';
        $response = json_decode($response, true);
        $response = self::sort($response);
        return response()->json($response);
    }

    static function callAPIContent4($url){
        $options = array(
            'http' => array(
                'method'=>"GET",
                'header'=>"Accept-language: en\r\n" .
                "Cookie: foo=bar\r\n"
            )
        );
        $context = stream_context_create($options);
        return $file = file_get_contents($url, false, $context);
    }

    static function sort($items){
        for($k=0; $k<count($items); $k++){
            $items[$k]['date'] = self::correctDate($items[$k]['date']);
        }
        for($i = 0; $i < count($items); $i++){
            for($j = $i + 1; $j < count($items); $j++){
                if($items[$i]['date'] > $items[$j]['date']){
                    $temp = $items[$i];
                    $items[$i] = $items[$j];
                    $items[$j] = $temp;
                }
            }
        }
        return $items;
    }

    static function correctDate($date)
    {
        if(strlen($date) == 0 || strlen($date) == 10) return $date;

        $temp = explode("/",$date);
        if(strlen($temp[1]) < 2) $temp[1] = "0".$temp[1];
        if(strlen($temp[2]) < 2) $temp[2] = "0".$temp[2];
        $date = implode("/",$temp);
        return $date;
    }

    public function getUserGroup($course) {
       
    
        // Fetch the group for the specified course and user
        $group = \Models\Edu\Register::where('code', $course)
                    ->where('user_id', $this->user_id)
                    ->pluck('group'); // Use value to get a single value
        
        // dd($group.'-'.$course.'-'.$this->user_id);
        // dd($this->user);
        // dd($group);
        // Check if a group was found
        if ($group !== null) {
            return response()->json($group[0]);
        } else {
            return response()->json(['error' => 'Group not found'], 422);
        }
    }
    
}
