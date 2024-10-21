<?php

namespace Admin\Controllers\Public;

use App\Http\Controllers\Controller;
use Publics\Controllers\Tools as Convert;
use Models\Edu\CourseChangeLog;
use Models\Edu\Tools;
use Models\Edu\Course;
use Models\Edu\ToolsChild;
use Publics\Controllers\Tools as PubTools;
class Logs extends Controller
{
    /**
     * if in Form edit Course,Tools in panel NGO & Panel
     */
    public static function createCourseChangeLOg($creator, $course_id, $record_id="0", $tools_child_id="0")
    {
        $create_array = [
            'course_id' => $course_id,
            'record_id' => $record_id,
            'tools_child_id' => $tools_child_id,
            'change_url' => request()->change_url,
            'creator_user_id' => $creator,
            'check_change' => 0,
        ];
        $create_log = CourseChangeLog::create($create_array);
        self::updateNotCheckedCount($course_id);
    }
    /**
     * if in Form edit Course,Tools in panel Manege
     */
    public static function checkCourseChangeLog($checker, $course_id, $record_id="0", $tools_child_id="0")
    {
        $update_array = [
            'checker_user_id' => $checker,
            'check_change' => 1,
        ];
        $check_log = CourseChangeLog::where("course_id", $course_id)
            ->where("record_id", $record_id)
            ->where("tools_child_id", $tools_child_id)
            ->where("check_change", "0")
            ->update($update_array)
        ;
        self::updateNotCheckedCount($course_id);
    }
    /**
     * Update field not_checked_count of tables edu_courses For a course
     */
    public static function updateNotCheckedCount($course_id)
     {
        \DB::update("UPDATE edu_courses SET `not_checked_count` =
                (SELECT count(edu_course_change_log.course_id) FROM edu_course_change_log WHERE edu_course_change_log.course_id = edu_courses.id AND edu_course_change_log.check_change =0)
                WHERE edu_courses.id = $course_id");    
        // \DB::update("UPDATE edu_courses SET `not_checked_count` =
        //         (SELECT count(edu_course_change_log.course_id) FROM edu_course_change_log WHERE edu_course_change_log.course_id = edu_courses.id AND edu_course_change_log.check_change =0)");    
    }
    public function list($courseId)
    {
        $items = [];
        $toolsChilds = ToolsChild::all();
        $logs = CourseChangeLog::where("course_id", $courseId)
            ->where("check_change", 0)
            ->with("toolsChild","creatorUser")
            ->get()
        ;

        foreach($logs as $log)
        {
            Convert::convertDateTime($log, 'created_at', 'created', '', '');

            if($log->tools_child_id == 0)
            {
                if(!isset($items['course']))
                {
                    $items['course'] = [];
                }
                $object = Course::find($log->course_id);
                $log['record'] = $object;
                $items['course'][] = $log;
            }
            else
            {
                foreach($toolsChilds as $child)
                {
                    if($log->tools_child_id  == $child->id)
                    {
                        if(!isset($items[$child->table]))
                        {
                            $items[$child->table] = [];
                        }
                        $object = \App::make($log->toolsChild->model);
                        $object = $object->find($log->record_id);
                        $log['record'] = $object;
                        $items[$child->table][] = $log;
                        break;
                    }
                }
            }
        }

        return \Response::json($items);
    }
}
