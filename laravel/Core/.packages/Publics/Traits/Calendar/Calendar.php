<?php
namespace Publics\Traits\Calendar;

use Publics\Traits\Calendar\JDateTime;
// error_reporting(E_ERROR);

class Calendar {

    private $year;
    private $year_month = array();
    private $week = array("شنبه"=>0, "یکشنبه"=>1, "دوشنبه"=>2, "سه شنبه"=>3, "چهارشنبه"=>4, "پنجشنبه"=>5, "جمعه"=>6);
    private $month = array("","فروردین","اردیبهشت","خرداد","تیر","مرداد","شهریور","مهر","آبان","آذر","دی","بهمن","اسفند");
    private $monasebats = array();
    private $courses = array();
    private $courses_merge = array();
    private $courses_all = array();
    private $username;
    private $monthName = "";
    private $today = "";
    private $term_year;
    private $term_semester;
    private $term_end_date;

    function __construct($year = "")
    {
        // dd($_GET['y']);
        // if($_GET['y']!= "")
        //     $year = $_GET['y'];

        if($year == "")
        {
            $jdate = new JDateTime(true, true, 'Asia/Tehran');
            $year = $jdate->date("Y", false, false);;
        }


        $this->year_month = array (0, 31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 29);
        if ((($year+1) % 400 == 0) or (($year+1) % 4 == 0 and ($year+1) % 100 <> 0))
        	$this->year_month[12] = 30;

        $this->year  = $year;

        // mysql_select_db("ikvu_main");
        // mysql_select_db("educ_ikvu");
    }

    /**
     *   نمایش تقویم
     */
    function displayCalendar()
    {
        $jdate = new JDateTime(true, true, 'Asia/Tehran');

        if($_GET["p"] != "")
            $mounth = $_GET["p"];
        else
            $mounth = (int)$jdate->date("m", false, false);

        $start = $jdate->mktime(0,0,0,$mounth,1,$this->year);
        $end   = $jdate->mktime(0,0,0,$mounth,$this->year_month[$mounth],$this->year);
        $this->today = $jdate->date("Y/m/d", false, false);
        # echo $this->today.$start;
        $next = $mounth+1;
        $perv = $mounth-1;

        $follow1 = $follow2 = "";
        if($_GET['y']!="")
            $follow1 = $follow2 = "&y=".$_GET['y'];
        if($perv == 0)
        {
            $perv = 12;
            $follow1 = "&y=".($this->year-1);
        }
        if($next == 13)
        {
            $next = 1;
            $follow2 = "&y=".($this->year+1);
        }

        $d1 = $jdate->date("l", $start);
        $d2 = $jdate->date("l", $end);
        $day1 = $this->week[$d1];
        $day2 = $this->week[$d2];
        # echo "$day1 $d1";

        $dayRecords = "";
        for($i=0; $i<$day1; $i++)
        {
            $dayRecords .= "<div class='element'>&nbsp;</div>";
        }

        // $this->getTermInfo($this->year, $mounth, 1);
        // $this->getSelectedCourses();

        for($k=1; $k <= $this->year_month[$mounth]; $k++)
        {
            $dayRecords .= $this->getDayMonasebat($this->year, $mounth, $k);
        }

        $this->monthName = $this->month[$mounth];

        return ("
        <div id='calendar'>
            <div id='monthView'>
                <a href='?p=$next".$follow2."' title='ماه بعد'><img id='leftArrow' src='/Behsima/img/calendar/right.png' align='absmiddle' style='float:right'/></a>
                ".$this->monthName." ".$this->fa_numbers($this->year)."
                <a href='?p=$perv".$follow1."' title='ماه قبل'><img id='leftArrow' src='/Behsima/img/calendar/left.png' align='absmiddle'  style='float:left'/></a>
                <div class='clear'></div>
            </div>
            <div id='weekDays'>
            <div class='clear'></div>
                <div class='element'>ش</div>
                <div class='element'>ی</div>
                <div class='element'>د</div>
                <div class='element'>س</div>
                <div class='element'>چ</div>
                <div class='element'>پ</div>
                <div class='element'>ج</div>
                <div class='clear'></div>
            </div>
            <div id='days'>
                $dayRecords
                <div class='clear'></div>
            </div>
        </div>
        ");

    }

    /**
     *   نمایش وقایع ماه
     */
    public function displayEventsDetails()
    {
        $events = "";
        foreach($this->monasebats as $date=>$monasebat)
        {
            $class = "";
            if ($date == $this->today) $class = " today";
            $str = "<div class='mDate'> ".$this->fa_numbers($date)." </div>";
            $str .= "<div class='dayEvent'>";
            for($i=0; $i<count($monasebat);$i++)
            {
                if($monasebat[$i]['text'] != "")
                {
                    $title = "<a href='javascript:showText(\"".$date.$i."\",\"".$monasebat[$i]['title']."\")' > ".$monasebat[$i]['title']." </a>";
                    $str .= "<div id='".$date.$i."' class='hidden'> ".$monasebat[$i]['text']." </div>";
                }
                else
                {
                    $title = $monasebat[$i]['title'];
                }

                $str .= "<div class = 'mEvent'> ".$title." </div>";
                $str .= "<div class = 'mGroup'>".$monasebat[$i]['catTitle']."</div>";
                $str .= "<div class = 'clear'></div>";
            }
            $str .= "</div>";
            $str .= "<div class = 'clear'></div>";
            $events .= "<div id='day$date' class='mDay$class'>$str</div>";
        }

        $name = $this->monthName;
        if(in_array ($name, array("فروردین","اردیبهشت","آبان","دی","بهمن")))
            $name = $name." ماه";
        else
            $name = $name."ماه";
        return("
        <div id='calendarEvents'>
            <div id='monthEvent' class='right'>
                رویدادهای ".$name."
            </div>
            <div id='days1'>
                $events
                <div class='clear'></div>
            </div>
        </div>
        ");
    }

    /**
     *   گرفتن مناسب های روز
     */
    public function getDayMonasebat($y, $m, $d)
    {
        $d2 = $d;
        if(strlen($m)==1) $m = "0".$m;
        if(strlen($d)==1) $d = "0".$d;
        $date = $y."/".$m."/".$d;
        # Check being an Event in the Day
        $check = false;

        // /* GET Spetial Events */
        // if ($this->getEventSpecial($date))
        //     $check = true;

        // /* GET Educational Calendar */
        // if ($this->getEventEduCalendar($y, $m, $d, $date))
        //     $check = true;

        // /* GET Online Class Events */
        // if($this->getEventOnline($y, $m, $d, $date))
        //     $check = true;

        // /* GET Exam Programs */
        if($this->getEventEducation($y, $m, $d, $date))
            $check = true;

        if($check)
        {
            if($date == $this->today)
                return "<div class='element today' onclick='goTo(\"$date\")'>".$this->fa_numbers($d2)."</div>";
            else
                return "<div class='element event' onmouseenter = 'hilightDay(\"$date\")' onclick='goTo(\"$date\")' onmouseout = 'back(\"$date\")'>".$this->fa_numbers($d2)."</div>";
        }
        else
        {
            if($date == $this->today)
                return "<div class='element today' onclick='goTo(\"$date\")'>".$this->fa_numbers($d2)."</div>";
            else
                return "<div class='element'>".$this->fa_numbers($d2)."</div>";
        }
    }

    /**
     *   تبدیل تاریخ میلادی به شمسی
     */
    private function en2Jalali($date, $seperator = "-")
    {
        $jdate = new JDateTime(true, true, 'Asia/Tehran');
        list($y,$m,$d) = explode($seperator, $date);
        $time = $jdate->mktime(0,0,0,$m,$d,$y,false);
        $faDate = $jdate->date("Y/m/d", $time, false);
        return $this->fa_numbers($faDate);
    }

    /**
     *   تبدیل تاریخ شمسی به میلادی
     */
    private function jalali2En($date, $seperator = "/")
    {
        $jdate = new JDateTime(true, true, 'Asia/Tehran');
        list($y,$m,$d) = explode($seperator, $date);
        $time = $jdate->mktime(0,0,0,$m,$d,$y);
        $enDate = $jdate->date("Y/m/d", $time,null,false);
        return($enDate);
    }

    /**
     *   تبدیل اعداد انگلیسی به فارسی
     */
    private function fa_numbers($digit)
    {
        $en_numbers = array("\n" , "&#039;" , 0 , 1 , 2 , 3 , 4 , 5 , 6 , 7 , 8 , 9 );
        $fa_numbers = array("<br/>" , "'" , '۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸' , '۹');
        $fa_digit = "";

		$fa_digit = str_replace($en_numbers , $fa_numbers , $digit);

        return $fa_digit;
    }

    /**
     *   گرفتن اطلاعات ترم
     */
    private function getTermInfo($y, $m, $d)
    {
        $date = $y."/".$m."/".$d;
        $sql = "
            SELECT
                `EduYear`, `semester`, `EndSemDate`
            FROM `educationalcalendar`
            WHERE `EndSemDate` > '$date' AND `StartSemDate` < '$date'
        ";
        # echo $sql;
        $result = api_sql_query($sql, __FILE__, __LINE__);
        $data = Database::fetch_array($result);

        if($data)
        {
            $this->term_year     = $data['EduYear'];
            $this->term_semester = $data['semester'];
            $this->term_end_date = $data['EndSemDate'];

        }
        else
        {
            # echo "Empty!!!";
            if($m >= 1 && $m < 5)
            {
                $this->term_year     = intval($y)-1;
                $this->term_semester = 2;
                $this->term_end_date = $y."/04/31";
            }
            elseif($m >= 6 && $m < 11)
            {
                $this->term_year     = $y;
                $this->term_semester = 1;
                $this->term_end_date = $y."/10/30";
            }
            elseif($m == 11 || $m == 12)
            {
                $this->term_year     = $y;
                $this->term_semester = 2;
                $this->term_end_date = (intval($y)+ 1)."/04/31";
            }
        }
        //echo $this->term_year." ".$this->term_semester;
    }

    private function nextTerm()
    {
        if($this->term_semester == 1)
        {
           $this->term_semester = 2;
        }
    }

    /**
     *   درس های انتخاب واحد شده
     */
    private function getSelectedCourses()
    {
        $user_id = $_SESSION['_user']['user_id'];
        $sql = "
            SELECT
                `username`
            FROM  `dokeos_main`.`user`
            WHERE `user_id` = '$user_id'
        ";
        $result = api_sql_query($sql, __FILE__, __LINE__);
        $data = Database::fetch_array($result);
        $this->username = $data['username'];

        $sql = "
            SELECT
                `courses`.`LesCode`, `courses`.`PLesName`, `pl`.`GrpCode`
            FROM
                `selectedcourses` as sc JOIN `presentedcourses` as pl ON sc.LesID = pl.LesID AND StNo = '$this->username'
                JOIN `courses` ON pl.LesCode = courses.LesCode
            WHERE
                EduYear = '$this->term_year'
                AND semester = '$this->term_semester'
                AND CourseStatus != 'DROP'
        ";
        $result = api_sql_query($sql, __FILE__, __LINE__);
        while($data = Database::fetch_array($result))
        {
            if(substr($data['LesCode'], 0, 2) == "88")
            {
                $data['LesCode'] = substr($data['LesCode'], 2);
            }
            $this->courses[$data['LesCode']] = array("code"=>$data['LesCode'], "name"=>$data['PLesName'], "group"=>$data['GrpCode']) ;
            $this->courses_all[$data['LesCode']] = array("code"=>$data['LesCode'], "name"=>$data['PLesName'], "group"=>$data['GrpCode']) ;
        }

        //echo $sql;
        //echo $this->username;
        //print_r($this->courses);

        foreach($this->courses as $course)
        {
            $sql = "
                SELECT
                    parent_code
                FROM
                    `dokeos_main`.`chat_course_merge`
                WHERE
                    child_code = '$course[code]'
                    AND year = '$this->term_year'
                    AND semester = '$this->term_semester'
            ";
            //echo $sql."<br/>";
            $result = api_sql_query($sql, __FILE__, __LINE__);
            while($data = Database::fetch_array($result))
            {
                $this->courses_merge[$data['parent_code']] = array("code"=>$data['parent_code'], "name"=>$course['name'], 'group'=>$course['group']) ;
                $this->courses_all[$data['parent_code']] = array("code"=>$data['parent_code'], "name"=>$course['name'], 'group'=>$course['group']) ;
            }

        }
    }

    /**
     *  رویدادهای ثبت شده توسط واحدها
     */
    private function getEventSpecial($date)
    {
        $check = false;
        $sql = "
            SELECT *
            FROM `events` LEFT JOIN `event_category` ON `event_category`.id = `events`.catId
            WHERE `start_date` <= '$date' and `end_date` >= '$date' and `status` = '1'";
        $result = api_sql_query($sql, __FILE__, __LINE__);
        while($data = Database::fetch_array($result))
        {
            $monasebat = array('title'=>$data['title'],'text'=>$data['text'],'catTitle'=>$data['catTitle']);
            $this->monasebats[$date][] = $monasebat;
            $check = true;
        }
        return $check;
    }

    /**
     *  رویدادهای تقویم آموزشی
     */
    private function getEventEduCalendar($y, $m, $d, $date)
    {
        $check = false;
        $jdate = new JDateTime(true, true, 'Asia/Tehran');
        $time = $jdate->mktime(0,0,0,$m,$d,$y);
        $enDate = $jdate->date("Y-m-d", $time, false, false);
        $sql = "
            SELECT
                *
            FROM `educationalcalendar`
            WHERE `EduYear` = '$y' or `EduYear` = '".($y - 1)."'
        ";

        $result = api_sql_query($sql, __FILE__, __LINE__);
        while($data = Database::fetch_array($result))
        {
            $title = "";
            $text = "";
            if($data['semester'] == 1)
                $semester = "اول";
            else if($data['semester'] == 2)
                $semester = "دوم";
            else if($data['semester'] == 3)
                $semester = "تابستانی";
            $year = $this->fa_numbers(substr($data['EduYear']+1, 2, 2)."-".($data['EduYear']));

            switch(true)
            {
                case substr($data['WWWDCSFromTS'],0,10) == $enDate:
                    $title = "آغاز انتخاب واحد ترم ".$semester." سال تحصیلی ".$year." درس آموزش مجازی";
                    $text = "آغاز انتخاب واحد: ".$this->en2Jalali(substr($data['WWWDCSFromTS'],0,10))."<br/> پایان انتخاب واحد: ".$this->en2Jalali(substr($data['WWWDCSToTS'],0,10));
                    break;

                case substr($data['WWWDCSToTS'],0,10)   == $enDate:
                    $title = "پایان انتخاب واحد ترم ".$semester." سال تحصیلی ".$year." درس آموزش مجازی";
                    $text = "آغاز انتخاب واحد: ".$this->en2Jalali(substr($data['WWWDCSFromTS'],0,10))."<br/> پایان انتخاب واحد: ".$this->en2Jalali(substr($data['WWWDCSToTS'],0,10));
                    break;

                case substr($data['WWWNCSFromTS'],0,10) == $enDate:
                    $title = "آغاز انتخاب واحد ترم ".$semester." سال تحصیلی ".$year." درس آموزش نیمه حضوری";
                    $text = "آغاز انتخاب واحد: ".$this->en2Jalali(substr($data['WWWNCSFromTS'],0,10))."<br/> پایان انتخاب واحد: ".$this->en2Jalali(substr($data['WWWNCSToTS'],0,10));
                    break;

                case substr($data['WWWNCSToTS'],0,10)   == $enDate:
                    $title = "پایان انتخاب واحد ترم ".$semester." سال تحصیلی ".$year."درس آموزش نیمه حضوری ";
                    $text = "آغاز انتخاب واحد: ".$this->en2Jalali(substr($data['WWWNCSFromTS'],0,10))."<br/> پایان انتخاب واحد: ".$this->en2Jalali(substr($data['WWWNCSToTS'],0,10));
                    break;

                ###
                case substr($data['WWWDDNAFromTS'],0,10) == $enDate:
                    $title = "آغاز حذف و اضافه ترم ".$semester." سال تحصیلی ".$year." درس آموزش مجازی";
                    $text = "آغاز حذف و اضافه: ".$this->en2Jalali(substr($data['WWWDDNAFromTS'],0,10))."<br/> پایان حذف واضافه: ".$this->en2Jalali(substr($data['WWWDDNAToTS'],0,10));
                    break;

                case substr($data['WWWDDNAToTS'],0,10) == $enDate:
                    $title = "پایان حذف و اضافه ترم ".$semester." سال تحصیلی ".$year." درس آموزش مجازی";
                    $text = "آغاز حذف و اضافه: ".$this->en2Jalali(substr($data['WWWDDNAFromTS'],0,10))."<br/> پایان حذف و اضافه: ".$this->en2Jalali(substr($data['WWWDDNAToTS'],0,10));
                    break;

                case substr($data['WWWNDNAFromTS'],0,10) == $enDate:
                    $title = "آغاز حذف و اضافه ترم ".$semester." سال تحصیلی ".$year." درس آموزش نیمه حضوری";
                    $text = "آغاز حذف و اضافه: ".$this->en2Jalali(substr($data['WWWNDNAFromTS'],0,10))."<br/> پایان حذف و اضافه: ".$this->en2Jalali(substr($data['WWWNDNAToTS'],0,10));
                    break;

                case substr($data['WWWNDNAToTS'],0,10) == $enDate:
                    $title = "پایان حذف و اضافه ترم ".$semester." سال تحصیلی ".$year."درس آموزش نیمه حضوری ";
                    $text = "آغاز حذف و اضافه: ".$this->en2Jalali(substr($data['WWWNDNAFromTS'],0,10))."<br/> پایان حذف و اضافه: ".$this->en2Jalali(substr($data['WWWNDNAToTS'],0,10));
                    break;

                /*###
                case substr($data['DSDFromTS'],0,10) == $enDate:
                    $title = "آغاز حذف تک درس ترم ".$semester." سال تحصیلی ".$year." درس آموزش مجازی";
                    $text = "آغاز حذف تک درس: ".$this->en2Jalali(substr($data['DSDFromTS'],0,10))."<br/> پایان حذف تک درس: ".$this->en2Jalali(substr($data['DSDToTS'],0,10));
                    break;

                case substr($data['DSDToTS'],0,10) == $enDate:
                    $title = "پایان حذف تک درس ترم ".$semester." سال تحصیلی ".$year." درس آموزش مجازی";
                    $text = "آغاز حذف تک درس: ".$this->en2Jalali(substr($data['DSDFromTS'],0,10))."<br/> پایان حذف تک درس: ".$this->en2Jalali(substr($data['DSDToTS'],0,10));
                    break;

                case substr($data['NSDFromTS'],0,10) == $enDate:
                    $title = "آغاز حذف تک درس ترم ".$semester." سال تحصیلی ".$year." درس آموزش نیمه حضوری";
                    $text = "آغاز حذف تک درس: ".$this->en2Jalali(substr($data['NSDFromTS'],0,10))."<br/> پایان حذف تک درس: ".$this->en2Jalali(substr($data['NSDToTS'],0,10));
                    break;

                case substr($data['NSDToTS'],0,10) == $enDate:
                    $title = "پایان حذف تک درس ترم ".$semester." سال تحصیلی ".$year."درس آموزش نیمه حضوری ";
                    $text = "آغاز حذف تک درس: ".$this->en2Jalali(substr($data['NSDFromTS'],0,10))."<br/> پایان حذف تک درس: ".$this->en2Jalali(substr($data['NSDToTS'],0,10));
                    break;*/

                ###
                case substr($data['ExamStartTS'],0,10) == $enDate:
                    $title = "آغاز امتحانات ترم ".$semester." سال تحصیلی ".$year;
                    $text = "آغاز امتحانات: ".$this->en2Jalali(substr($data['ExamStartTS'],0,10))."<br/> پایان امتحانات: ".$this->en2Jalali(substr($data['ExamEndTS'],0,10));
                    break;

                case substr($data['ExamEndTS'],0,10) == $enDate:
                    $title = "پایان امتحانات ترم ".$semester." سال تحصیلی ".$year;
                    $text = "آغاز امتحانات: ".$this->en2Jalali(substr($data['ExamStartTS'],0,10))."<br/> پایان امتحانات: ".$this->en2Jalali(substr($data['ExamEndTS'],0,10));
                    break;

            }

            if($title != "")
            {
                $monasebat = array('title'=>$title,'text'=>$text,'catTitle'=>"تقویم آموزشی");
                $this->monasebats[$date][] = $monasebat;
                $check = true;
            }
        }
        return $check;
    }

    /**
     *   رویداد کلاس آنلاین
     */
    private function getEventOnline($y, $m, $d, $date)
    {
        $cMerge = $this->courses_all;
        $courses = "";
        $groups = array();
        //print_r($cMerge);
        foreach($cMerge as $course)
        {
            $courses .= $course['code'].",";
            $groups[$course['code']] = $course['group'];
            //print_r($groups);
        }
        //print_r($groups);
        $courses = substr($courses,0,strlen($courses)-1);
        if($courses == "") return false;

        $check = false;
        $sql = "
            SELECT *
            FROM `dokeos_main`.`chat_sessions`
            WHERE
                cs_course_id in ($courses)
                AND cs_date = '$date'
            order by cs_start";
        $result = api_sql_query($sql, __FILE__, __LINE__);
        # echo $sql."<br/>";
        while($data = Database::fetch_array($result))
        {
            if($groups[(int)$data['cs_course_id']] == $data['cs_group'])
            {
                $monasebat = array('title'=>"کلاس آنلاین درس «<b>".$cMerge[(int)$data['cs_course_id']]['name']."</b>» ساعت ".$data['cs_start'],
                'text'=>$data['text'],
                'catTitle'=>"کلاس آنلاین");
                $this->monasebats[$date][] = $monasebat;
                $check = true;
            }
            else{
              //echo $data['cs_group']."-".(int)$data['cs_course_id']."<br/>";
            }
        }
        return $check;
    }

    /**
     *  رویدادهای امتحانات
     */
    private function getEventEducation($y, $m, $d, $date)
    {
        $courses = "";
        $mdate = $this->jalali2En($date);

        foreach($this->courses as $course)
        {
            if(strlen($course['code']) == 3) $course['code'] = "88".$course['code'];
            $courses .= $course['code'].",";
        }
        $courses = substr($courses,0,strlen($courses)-1);
        if($courses == "") return false;

        $check = false;
        $sql = "
            SELECT `ExamTime`, `ExamDate`, pl.LesCode
            FROM `presentedCourses` AS pl JOIN examdays AS e ON pl.ExamID = e.ExamID
            WHERE
                pl.LesCode in ($courses)
                AND ExamDate = '$mdate'
            order by `ExamTime`";
        $result = api_sql_query($sql, __FILE__, __LINE__);
        # echo $sql."<br/>";
        while($data = Database::fetch_array($result))
        {
            if(substr($data['LesCode'],0,2) == "88") $data['LesCode'] = substr($data['LesCode'],2);
            $monasebat = array('title'=>"امتحان درس «<b>".$this->courses[$data['LesCode']]['name']."</b>» ساعت ".$data['ExamTime'],
            'text'=>$data['text'],
            'catTitle'=>"امتحان پایانترم");
            $this->monasebats[$date][] = $monasebat;
            $check = true;
        }
        return $check;
    }
}


?>
