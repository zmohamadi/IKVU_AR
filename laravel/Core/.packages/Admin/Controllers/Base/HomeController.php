<?php

namespace Admin\Controllers\Base;
use App\Http\Controllers\Controller;
use Models\Person\Mentor;
use Models\Person\User;
use Models\Person\Teacher;
use Models\Person\Student;
use Models\Edu\Course;
class HomeController extends Controller
{
    public function home()
    {
        $collection = [
                    'counts' => \DB::table('base_counts')->orderBy('id')->get(),
                    'teachers' => Teacher::active()->orderBy('id','desc')->select('id','firstname','lastname','photo')->limit(5)->get(),
                    'students' => Student::active()->orderBy('id','desc')->select('id','firstname','lastname','photo')->limit(5)->get(),
                    'courses' => Course::active()->orderBy('id','desc')->select('code','thumbnail','title','category_id','status_id')->with('category','activeStatus')->limit(5)->get(),
                    
                    ];

        return response()->json($collection);

    }
}
