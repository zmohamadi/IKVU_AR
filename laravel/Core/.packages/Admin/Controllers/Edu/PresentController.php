<?php
namespace Admin\Controllers\Edu;

use Admin\Controllers\Public\BaseAbstract;
use Illuminate\Http\Request;
use Models\Edu\CoursePresented;
use Models\Edu\Register;
use Models\Person\Student;
use Models\Person\Teacher;
use Models\Person\Assistant;
use Models\Base\Status;
use Models\Base\YearSemester;
use Admin\Controllers\Public\PublicController;
use Publics\Controllers\Tools;

class PresentController extends BaseAbstract{

    protected $model = "Models\Edu\CoursePresented";
    protected $needles = ['Person\Teacher','Person\Assistant','Base\YearSemester'];
    protected $request = "Publics\Requests\Edu\CoursePresentedRequest";
    protected $with = ["teacher","creator","editor"];
    protected $showWith = ["teacher","assistants","userAssistants","creator","editor"];
   
  
    public function init()
    {
        // $this->showQuery = function ($query) {

        // };
        $this->storeQuery = function ($query) {
            $query = $this->setOperator($query);
            
            $requestData = request()->only(['semester', 'group_code', 'code', 'start_date', 'end_date', 'teacher_person_id', 'assistants']);
            
            \DB::transaction(function () use ($query, $requestData) {
                $group = Tools::setGroup([
                    "semester" => $requestData['semester'], 
                    "group" => $requestData['group_code']
                ]);
                // dd($requestData['code']);
                $course = $this->getCourse($requestData['code']);
                
                if (!$course) {
                    throw new \Exception('Course not found');
                }

                $query->group = $group;
                $query->system_id = $course->system_id;
                $query->less_id = $course->less_id;
                $query->start_date = $requestData['start_date'];
                $query->end_date = $requestData['end_date'];
                $query->save();
            
                $teacher = [
                    'user_id' => $requestData['teacher_person_id'],
                    'role_id' => Register::ROLE_TEACHER,
                    'group' => $group,
                    'code' => $requestData['code'],
                    'less_id' => $course->less_id,
                    'start_date' => $requestData['start_date'],
                    'end_date' => $requestData['end_date'],
                    'course_presented' => $query->id,
                ];
            
                $assistants = array_map(function($assistantId) use ($group, $requestData, $course, $query) {
                    return [
                        'user_id' => $assistantId,
                        'role_id' => Register::ROLE_ASSISTANT,
                        'group' => $group,
                        'code' => $requestData['code'],
                        'less_id' => $course->less_id,
                        'start_date' => $requestData['start_date'],
                        'end_date' => $requestData['end_date'],
                        'course_presented' => $query->id,
                    ];
                }, $requestData['assistants']);
            
                $course_users = array_merge([$teacher], $assistants);

                // Delete previous records only if they exist
                Register::where('course_presented', $query->id)->delete();

                // Insert new records
                Register::insert($course_users);
                
                $countCoursePresented = CoursePresented::where('code',$requestData['code'])->count();
                $countCoursePresentedTeacher = CoursePresented::where('code',$requestData['code'])->where('teacher_person_id',$requestData['teacher_person_id'])->count();
                \Models\Edu\Course::where('code',$requestData['code'])->update(["count_presented"=>$countCoursePresented]);
                \Models\Person\User::where('id',$requestData['teacher_person_id'])->update(["count_presented"=>$countCoursePresentedTeacher]);

            });
        };
    }

}
