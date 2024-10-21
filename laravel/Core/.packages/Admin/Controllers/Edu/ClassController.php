<?php
namespace Admin\Controllers\Edu;

use Admin\Controllers\Public\BaseAbstract;
use Illuminate\Http\Request;
use Models\Edu\CoursePresented;
use Models\Edu\Register;
use Models\Person\Student;
use Models\Person\User;
use Models\Person\Teacher;
use Models\Base\Status;
use Models\Base\YearSemester;
use Admin\Controllers\Public\PublicController;
use Publics\Controllers\Tools;
use Models\Edu\Course;

class ClassController extends BaseAbstract {

    protected $model = CoursePresented::class; // مستقیم به مدل اشاره می‌کنیم
    protected $with = ["course.system", "teacher","assistants", "activeStatus", "course.category"];
    protected $showWith = ["course.system", "teacher","assistants", "activeStatus", "course.category","creator","editor"];
    protected $needles = ['Base\YearSemester', 'Edu\CourseCategory', 'Base\System'];
    protected $increment = "classes";
    protected $decrement = "classes";
    protected $listFunction = "classes";
    // protected $destroy = ["registers"];
    
    public function init() {
        // $this->needles = [
        //     \Base\YearSemester::class => fn($query) => $query->active(),
        //     \Edu\Course::class => fn($query) => $query->active()->select('code'),
        //     \Edu\CourseCategory::class => fn($query) => $query->active(),
        // ];
        $this->indexQuery = function ($query) {
            // فیلتر بر اساس گروه و ترم
            $group = $this->buildGroupFilter();
            if ($group != "") {
                $query->where('group', 'LIKE', $group);
            }
            if (request()->has('course')) {
                $query->where('code', request()->course);
            }
            if (request()->has('code')) {
                $query->where('code', request()->code);
            }
        };
    }
    /**
     * ساخت فیلتر گروه بر اساس ترم و گروه
     */
    private function buildGroupFilter()
    {
        $semester = request()->get('semester', '');
        $groupPart = request()->get('group', '');

        if ($semester && $groupPart) {
            return $semester . $groupPart;
        } elseif ($semester) {
            return $semester . '%';
        } elseif ($groupPart) {
            return '%' . $groupPart;
        }

        return '';
    }
    public function students($id) {
        $enroll = CoursePresented::find($id);
        $stu_ids = Register::where("code", $enroll->code)->where('group', $enroll->group)->where('role_id',2)->pluck("user_id");
        $collection = User::whereIn('id', $stu_ids)->with('role');
        return $this->grid($collection, ['firstname', 'lastname']);
    }

    public function updateScore($record) {
        $eventData = $record->record;
        $courseId = $eventData['courseId'];
        $max = Enroll::where('course_id', $courseId)->max('total_score');
        $avg = Enroll::where('course_id', $courseId)->avg('total_score');
        $course = Course::where('id', $courseId)->update(['top_score' => $max, 'average_score' => $avg]);
        return $course;
    }

    public function list(int $course) {
        $role_id = auth()->user()->role_id; // گرفتن نقش کاربر از سیستم احراز هویت
        $model = new $this->model; // ساخت نمونه‌ای از مدل

        // تصمیم‌گیری بر اساس نقش کاربر
        $collection = $role_id === $this->model::ROLE_STUDENT 
            ? $model::query() 
            : $model::with("activeStatus");

        if (!in_array($role_id, [$this->model::ROLE_TEACHER, $this->model::ROLE_STUDENT])) {
            $group = Tools::userGroup($course, auth()->id());
            $collection = Tools::conditionGroup(["group" => $group, "collection" => $collection]);
        }

        if ($role_id === $this->model::ROLE_STUDENT) {
            $collection = $collection->active();
        }

        if (!in_array($role_id, [$this->model::ROLE_TEACHER, $this->model::ROLE_STUDENT])) {
            if (request()->has('semester')) {
                $semester = request()->semester;
                $group = request()->has('group') ? $semester . request()->group : $semester . '%';
                $collection->where('group', 'LIKE', $group);
            }
        }

        return $this->grid($collection, $this->searchFilter);
    }

    public function newStudent($id, Request $request) {
        $validatedData = $request->validate([
            'student_code' => 'required',
            'student' => 'required',
        ]);
    
        $courseUsersData = $this->buildCourseUserData($request, $id);
       
    
        $newRecord = Register::insert($courseUsersData);
    
        if ($newRecord) {
            $countOld = Register::where('role_id', $this->model::ROLE_STUDENT)
            ->where('course_presented', $id)->count();

            $count = CoursePresented::where('id', $id)->update(['count_students'=>$countOld]);
        }
    
        return response()->json($newRecord);
    }

    // ساخت داده‌های جدید برای جدول course_users
    private function buildCourseUserData(Request $request, $courseId) {
        return [
            'user_id' => $request->user_id,
            'role_id' => $this->model::ROLE_STUDENT,
            'group' => $request->group,
            'code' => $request->code,
            'less_id' => $request->less_id,
            'start_date' => $request->start_date,
            'end_date' => $request->end_date,
            'course_presented' => $courseId,
            // 'created_at' => now(),
        ];
    }

    // بررسی وجود رکورد تکراری
    private function isDuplicateRecord($userId, $courseId) {
        return Register::where([
            ['user_id', '=', $userId],
            ['role_id', '=', $this->model::ROLE_STUDENT],
            ['course_presented', '=', $courseId],
        ])->exists();
    }

    public function deleteStudent($id, $sid) {
        $del =  Register::where('role_id', $this->model::ROLE_STUDENT)
            ->where('user_id', $sid)
            ->where('course_presented', $id)
            ->delete();
        if($del) {
            $countOld = Register::where('role_id', $this->model::ROLE_STUDENT)
            ->where('course_presented', $id)->count();
            $count = CoursePresented::where('id', $id)->update(['count_students'=>$countOld]);
        }
        
        return $count;

    }
    public function searchStudent($text,$course)
    {
        // dd($course);
        $str = explode("-",$course);
        $code = $str[0];
        $group = $str[1];
        // dd($code);

        $users = User::where('mobile', 'like', '%' . $text . '%')
            ->orWhere('email', 'like', '%' . $text . '%')
            ->orWhere('firstname', 'like', '%' . $text . '%')
            ->orWhere('lastname', 'like', '%' . $text . '%')
            ->select('id','firstname','email','lastname','role_id')
            ->get();
        foreach ($users as $value) {
            $value->userInCourse = $this->userInCourse($code,$value->id,$group);

        }
        return response()->json($users);
    }
    public function destroy($id){
        $class = CoursePresented::find($id);
        if (!$class) {
            return response()->json(['message' => 'Course not found'], 404); // اگر کلاس پیدا نشد
        }
    
        $code = $class->code;
        $teacher_person_id = $class->teacher_person_id;
        $del = $class->delete();
    
        if ($del) {
            Register::where("course_presented", $id)->delete();
    
            // بروزرسانی تعداد کلاس‌های ارائه شده
            $countCoursePresented = CoursePresented::where('code', $code)->count();
            $countCoursePresentedTeacher = CoursePresented::where('code', $code)
                ->where('teacher_person_id', $teacher_person_id)
                ->count();
    
            \Models\Edu\Course::where('code', $code)->update(["count_presented" => $countCoursePresented]);
            \Models\Person\User::where('id', $teacher_person_id)->update(["count_presented" => $countCoursePresentedTeacher]);
    
            return response()->json(['message' => 'Course deleted successfully']);
        } else {
            return response()->json(['message' => 'Error deleting course'], 500);
        }
    }
    

}
