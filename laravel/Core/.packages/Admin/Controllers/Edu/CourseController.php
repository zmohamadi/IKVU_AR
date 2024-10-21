<?php
namespace Admin\Controllers\Edu;

use Admin\Controllers\Public\BaseAbstract;
use Illuminate\Http\Request;
use Models\Edu\CoursePresented;
use Models\Edu\Register;
use Models\Base\Tools;
use Models\Person\Student;
use Models\Base\Status;
use Admin\Controllers\Public\PublicController;
use Models\Base\YearSemester;
use Illuminate\Support\Facades\File;
use \Carbon\Carbon;
use Morilog\Jalali\Jalalian;

class CourseController extends BaseAbstract{

    protected $model = "Models\Edu\Course";
    protected $request = "Publics\Requests\Edu\CourseRequest";
    protected $with = ["activeStatus",'category','system'];
    protected $showWith = ["activeStatus",'category','system',"creator","editor"];
    protected $needles = ['Edu\CourseCategory','Base\System'];
    protected $searchFilter = ["title","code","less_id"];
    protected $increment = "courses";
    protected $decrement = "courses";
    protected $files = ["thumbnail"];
   
    public function init()
    {
        $this->indexQuery = function ($query)
        {            
            if(request()->has('category')) $query->where('category_id',request()->category);
            if(request()->has('system')) $query->where('system_id',request()->system);
            if(request()->has('status')) $query->where('status_id', request()->status);       

        };
        $this->storeQuery = function ($query)
        {
            $query->less_id = $query->code;
            $query = $this->setOperator($query);        
            $this->createCourseFolders($query->code);
        };
        
    }
    function createCourseFolders($courseCode)
    {
        $basePath = public_path('media/courses/' . $courseCode);

        // بررسی اگر پوشه با کد درس وجود نداشت، آن را بسازیم
        if (!File::exists($basePath)) {
            // ایجاد پوشه درس
            File::makeDirectory($basePath, 0755, true);

            // ایجاد پوشه‌های ویدئو و صوت
            File::makeDirectory($basePath . '/video', 0755, true);
            File::makeDirectory($basePath . '/audio', 0755, true);
            File::makeDirectory($basePath . '/pdf', 0755, true);
            File::makeDirectory($basePath . '/image', 0755, true);
        }
    }
        
    public function list()
    {
        $url = request()->has('url') ? request()->has('url') : "courses";

        // Initialize the collection with active status and category for all courses
        $courses = $this->model::with("activeStatus", "category");

        // Check if the user is not a teacher or student
        $isTeacherOrStudent = in_array($this->role_id, [1, 2]);
        $isStudent = $this->role_id == 2;

        // If the user is neither a teacher nor a student, filter courses based on registration data
        if ($url=="myCourses") {
            $today = Jalalian::now();

            // $yearSemester = YearSemester::where('current', 1)->first();
            // $currentSemester = $yearSemester->year . $yearSemester->semester;

            // Get all courses the user is registered for
            $registers = Register::where("user_id", $this->user_id)
            ->where('end_date', '>=', $today) // شرط: تاریخ پایان باید بزرگتر یا برابر امروز باشد
            // ->where('group', 'LIKE', "$currentSemester%")
            ->get();
           

            // dd($registers);
            // Extract group codes and lesson IDs
            $groupCodes = $registers->pluck('group')->toArray();
            $lessonIds = $registers->pluck('code')->toArray();

            // dd($groupCodes);

            // Filter courses based on group and lesson IDs
            $courses = $courses->withPresentedsByGroups($groupCodes)
            ->whereIn('code', $lessonIds) 
            ;
            
        }

        // If the user is a student, show only active records
        if ($isStudent) {
            $courses = $courses->active();
        }

        // Return the list of courses with search filters
        return $this->grid($courses, $this->searchFilter);
    }




    public function tools($id)
    {
       // Retrieve the course and the role of the user
        $course = $this->model::find($id);
        if (!$course) {
            return response()->json(['message' => 'Course not found'], 404);
        }

        // Retrieve role with optional() to avoid error if not found
        $role = Register::where('user_id', $this->user_id)
            ->where('code', $id)
            ->select('role_id')
            ->first();

        // Check if $role is null, handle accordingly
        if (!$role) {
            $tools = Tools::orderBy('order')->get();
        } else {
            // Retrieve tools, conditionally filtering based on the user's role
            $tools = Tools::orderBy('order')
                // ->when($role->role_id == Register::ROLE_STUDENT, function ($query) use ($course) {
                //     $enabledTools = array_keys(array_filter($course->getAttributes(), fn ($value) => $value == 1));
                //     return $query->whereIn('title_en', $enabledTools);
                // })
                ->get();
        }

        return response()->json([
            'tools' => $tools,
            'course' => $course,
            'role' => $role,
        ], 200);

    }

    public function changeTools($id, $tool)
    {
        // Retrieve the course by ID
        $course = $this->model::find($id);
        if (!$course) {
            return response()->json(['message' => 'Course not found'], 404);
        }
        // dd($course);

        // Check if the specified tool exists as an attribute in the course
        if (!array_key_exists($tool, $course->getAttributes())) {
            return response()->json(['message' => 'Invalid tool specified'], 400);
        }

        // Toggle the tool status and save the course
        $course->$tool = $course->$tool == 1 ? 0 : 1;
        $course->save();

        return response()->json($course, 200);
    }
}
