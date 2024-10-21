<?php
namespace Admin\Controllers\Edu;

use Illuminate\Http\Request;
use Admin\Controllers\Public\BaseAbstract;
use Models\Edu\OnlineClassroom\OnlineClassroom;
use Models\Edu\OnlineClassroom\OnlineClassroomUser;
use \Carbon\Carbon;
use \Bigbluebutton;
use Morilog\Jalali\Jalalian;

class BBBController extends BaseAbstract{    

    public function join($sid)
    {
        $role_id = $this->role_id;
        $class = OnlineClassroom::with('course')->find($sid);

        $urls = explode(",", env('FRONTEND_URLS'));
        Bigbluebutton::create([
            'meetingID' => $class->course->code."-".$class->group,
            'meetingName' => $class->course->title,
            'attendeePW'  => '654321',
            'moderatorPW' => '123456',
            'endCallbackUrl' => $urls[0].'/panel/courses/' . $class->course->code .'/tools',
            'logoutUrl' => $urls[0].'/panel/courses/' . $class->course->code . '/tools',
            'duration'=>$class->duration,
            // 'muteOnStart'=>$role_id==2 ? true : false,
        ]);
    
        $url = Bigbluebutton::join([
            'meetingID' => $class->course->code."-".$class->group,
            'userName' => $this->user->firstname." ".$this->user->lastname,
            'password' => $role_id == 2 ? "654321" : "123456",
            'muteOnStart'=>$role_id==2 ? true : false,
            'lockSettingsDisableMic'=>$role_id==2 ? true : false,
            'lockSettingsDisableCam'=>$role_id==2 ? true : false,
            'customParameters' => [  
                'muteOnStart'=>$role_id==2 ? true : false,
                'lockSettingsDisableMic'=>$role_id==2 ? true : false,
                'lockSettingsDisableCam'=>$role_id==2 ? true : false,
            ]
        ]);

        // plus presence_count
        $createPresence = $this->createPresence($sid);
       

        // create presence
        $presenceCount = $this->presenceCount($sid);

        // return redirect()->to($url);
        return response()->json(['url' => $url]);
    }

    public function getArchive(){
        $meetingID = $_GET['room'];
        $ServerType = $_GET['Type']; // b1
        $url = "http://vu.iki.ac.ir/bbb/meeting_api.php?ID=$meetingID&Type=$ServerType";
        echo $this->callAPIContent($url);
    }

    public function callAPIContent($url){
        $content = file_get_contents($url);
        return $content;
    }

    public function presenceCount($id)
    {
        $count = OnlineClassroomUser::where('onlineClassroom_id',$id)->distinct()->count('user_id');
        $presence_count = OnlineClassroom::where('id', $id)->update(["presence_count"=>$count]);
        return $presence_count;
    }

    public function createPresence($id)
    {
        // dd(Jalalian::fromCarbon(Carbon::now())->format('Y/m/d'));
        // ثبت حضور
        $createPresence = OnlineClassroomUser::firstOrCreate(
            [
                'user_id' => $this->user_id,
                'onlineClassroom_id' => $id
            ],
            [
                'presence_date' => Jalalian::fromCarbon(Carbon::now())->format('Y/m/d'),
                'presence_time' => Jalalian::fromCarbon(Carbon::now())->format('H:i'),
                // 'created_at' => now(),
            ]
        );
        
        
        return $createPresence;
    }
   

}
