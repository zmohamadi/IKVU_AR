<?php
namespace Admin\Controllers\Edu;

use Admin\Controllers\Public\BaseAbstract;
use Illuminate\Http\Request;
use Models\Person\Student;
use Models\Person\User;
use Models\Edu\OnlineClassroom\Persence;
use Models\Edu\OnlineClassroom\OnlineClassroomUser;
use Models\Edu\Register;
use Models\Edu\OnlineClassroom\ArchiveFile;
use Publics\Controllers\Tools;
use Admin\Controllers\Edu\BBBController;
use Morilog\Jalali\Jalalian;
use Maatwebsite\Excel\Facades\Excel;
use PhpOffice\PhpSpreadsheet\Shared\Date;
use Carbon\Carbon;

class OnlineClassroomController extends BaseAbstract{

    protected $model = "Models\Edu\OnlineClassroom\OnlineClassroom";
    protected $request = "Publics\Requests\Edu\Tools\OnlineClassroomRequest";
    protected $showWith = ['activeStatus',"creator","editor",'course'];
    protected $searchFilter = ["title"];
    protected $needles = ['Base\QuestionType', 'Base\YearSemester','group'];
    protected $increment = "onlineClassrooms";
    protected $decrement = "onlineClassrooms";
    
    public function init()
    {
        $this->storeQuery = function ($query) {
            $query = $this->setOperator($query);
            
            $group = request()->semester ? request()->semester . request()->group_code : 0;
            $query->group = $group;
            $query->save();
        };
        $this->showQuery = function ($query, $before) {
            if ($before == false)
            {
                // dd($query->id);
                $query->checkDateTime = Tools::checkDateTime([
                    "start_time_date" => $query->date. " " . $query->start_hour,
                    "duration" => $query->duration,
                    "before_time" => "15"
                ]);
                
                $userInClass = OnlineClassroomUser::where('onlineClassroom_id', $query->id)
                ->where('user_id', $this->user_id)
                ->get();
        
                $query->userInClass = $this->checkUserAttendance($userInClass, $query->id);
            }
        };
        
    }
    public function list($course)
    {
        $menuPath = request()->menuPath;

        // ایجاد مجموعه اولیه با روابط
        $collection = $course == 0 ? $this->baseCollection() : $this->filterCollection($course, $menuPath);
        
        // اعمال فیلترها
        $collection = $this->applyFilters($collection);

        // پردازش نتایج و بررسی کاربران در کلاس‌ها
        $stu_ids = [];
        $callback = function ($result) use ($course, &$stu_ids) {
            return $this->processResults($result, $course, $stu_ids);
        };

        return $this->grid($collection->orderBy('order')->with('course:code,title'), $this->searchFilter, $callback);
    }

    /**
     * ایجاد مجموعه اولیه با روابط
     */
    private function baseCollection()
    {
        $collection = $this->model::with("activeStatus", 'creator', 'editor');

        // فیلتر بر اساس گروه و ترم
        $group = $this->buildGroupFilter();
        if ($group != "") {
            $collection = $collection->where('group', 'LIKE', $group);
        }

        return $collection;
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

    /**
     * اعمال فیلترهای تاریخ، ساعت و کد دوره
     */
    private function applyFilters($collection)
    {
        $date = request()->date;
        $hour = request()->hour;
        $code = request()->code;

        if ($date) {
            $collection = $collection->where('date', $date);
        }
        if ($hour) {
            $collection = $collection->where('start_hour', $hour);
        }
        if ($code) {
            $collection = $collection->where('course_id', request()->code);
        }

        return $collection;
    }

    /**
     * پردازش نتایج و بررسی حضور کاربران در کلاس‌ها
     */
    private function processResults($result, $course, &$stu_ids)
    {
        foreach ($result as $value) {
            $stu_ids[] = $value['id'];

            if ($course != null) {
                $value->userInCourse = $this->userInCourse($course);
            }

            $value->checkDateTime = Tools::checkDateTime([
                "start_time_date" => $value["date"] . " " . $value["start_hour"],
                "duration" => $value["duration"],
                "before_time" => "5"
            ]);
        }

        $userInClass = $this->getUserInClass($stu_ids);

        foreach ($result as $value) {
            $value->userInClass = $this->checkUserAttendance($userInClass, $value['id']);
        }

        return $result;
    }

    /**
     * گرفتن کاربران شرکت‌کننده در کلاس‌ها
     */
    private function getUserInClass($stu_ids)
    {
        return OnlineClassroomUser::whereIn('onlineClassroom_id', $stu_ids)
            ->where('user_id', $this->user_id)
            ->get();
    }

    /**
     * بررسی حضور کاربر در کلاس
     */
    private function checkUserAttendance($userInClass, $classId)
    {
        $userClass = $userInClass->firstWhere('onlineClassroom_id', $classId);
        // return $userClass ? $userClass['presence_time']: "غائب";
        return $userClass ? $userClass: "غائب";
    }


    

    public function students($id)
    {
        
        // $data = OnlineClassroomUser::get();
        // foreach ($data as $value) {
        //     // $presenceDate = Jalalian::fromCarbon(Carbon::parse($value->created_at))->format('Y/m/d');
        //     $presenceTime = $value->created_at; // استفاده از متد getCreatedAtAttribute
            
        //     OnlineClassroomUser::where('user_id', $value->user_id)
        //         ->where('onlineClassroom_id', $value->onlineClassroom_id)
        //         ->update([
        //             // 'presence_date' => $presenceDate,
        //             'presence_time' => $presenceTime,
        //         ]);
        // }

        $collection = User::whereHas('presenceOnlineClassrooms', function($q) use ($id) {
            $q->where('onlineClassroom_id', $id);
        })->with(['presenceOnlineClassrooms' => function($q) use ($id) {
            $q->where('onlineClassroom_id', $id);
        }]);
        
        return $this->grid($collection, ['lastname', 'firstname']);
    }

    public function archives($id){
        $collection = ArchiveFile::where("onlineClassroom_id",$id);
        return $this->grid($collection,['link']);
    }
    public function goToClass($id)
    {
        $class = $this->model::where('id',$id)->increment("presence_count");        
        $bbb = new BBBController;
        $link = $bbb->join($id)->original['url'];
        
        // استفاده از header برای هدایت کاربر به URL
        header("Location: " . $link);
        exit; // تضمین می‌کند که کدهای بعدی اجرا نمی‌شوند.
    }

    public function importExcel(Request $request)
    {
        // اعتبارسنجی برای اطمینان از اینکه فایل اکسل آپلود شده است
        $request->validate([
            'excel_file' => 'required',
            'year' => 'required',
            'semester' => 'required',
        ]);
    
        $course = $request->input('course');
        $filename = rtrim($request->input('excel_file'), '###');
        $filePath = public_path('media/onlineclass/' . $filename);
    
        // بررسی وجود فایل
        if (!file_exists($filePath)) {
            return response()->json(['message' => 'فایل اکسل یافت نشد.'], 404);
        }
    
        $year = $request->input('year');
        $semester = $request->input('semester');
        
        // داده‌های اکسل را خوانده و پردازش می‌کنیم
        $data = Excel::toArray([], $filePath);
        $rows = $data[0];
    
        // آرایه‌ای برای ذخیره داده‌ها جهت استفاده در createMany
        $onlineClassesData = [];
    
        // از ردیف دوم شروع به خواندن می‌کنیم (ردیف اول شامل هدرها است)
        foreach ($rows as $index => $row) {
            if ($index == 0) continue; // هدر را نادیده می‌گیریم
    
            $course_id = $row[0];
    
            // اگر group_code تک‌رقمی باشد، یک 0 به آن اضافه می‌کنیم
            $group_code = str_pad($row[1], 2, '0', STR_PAD_LEFT);
    
            $start_hour = $row[2];
            $duration = "60";
    
            // اگر کاربر فقط ساعت را وارد کرده باشد، دقیقه به آن اضافه می‌کنیم
            if (strpos($start_hour, ':') === false) {
                $start_hour .= ':00'; // افزودن دقیقه 00 به ساعت
            }
    
            // پردازش تاریخ‌ها در ستون‌های بعدی
            for ($i = 3; $i < count($row); $i++) {
                $date = $row[$i];
    
                // فرمت تاریخ را اصلاح کنید
                if (!empty($date)) {
                    $dateParts = explode('/', $date);
                    $formattedDate = str_pad($dateParts[0], 4, '0', STR_PAD_LEFT) . '/' . 
                                     str_pad($dateParts[1], 2, '0', STR_PAD_LEFT) . '/' . 
                                     str_pad($dateParts[2], 2, '0', STR_PAD_LEFT);
    
                    $onlineClassesData[] = [
                        'course_id' => $course_id,
                        'title' => "جلسه " . ($i - 2),  // جلسه 1 تا 12
                        'order' => ($i - 2),
                        'start_hour' => $start_hour,
                        'duration' => $duration,
                        'group' => $year . $semester . $group_code,
                        'date' => $formattedDate,  // ذخیره تاریخ شمسی به فرمت مناسب
                        'status_id' => 1, // مقدار پیش‌فرض
                        'created_at' => now(),
                        'creator_id' => $this->user_id,
                    ];
                }
            }
        }
    
        // اگر داده‌ای برای وارد کردن وجود دارد، از insert استفاده می‌کنیم
        if (!empty($onlineClassesData)) {
            $this->model::insert($onlineClassesData);
            $count = $this->model::count();
            \Models\Base\TotalCount::where('title','online_classrooms')->update(["count"=>$count]);

        }
    
        return response()->json(['message' => 'داده‌ها با موفقیت وارد شدند']);
    }
    

    public function canceledInsert(Request $request, $id) {
        // اعتبارسنجی برای مطمئن شدن از وارد کردن دلیل کنسل شدن
        $request->validate([
            'is_cancel' => 'required',
        ]);

        $update = $this->model::where('id', $id)
        ->update(['is_cancel' => $request->input('is_cancel')]);
        
        // اگر درج موفقیت‌آمیز بود، وضعیت کلاس را تغییر دهید
        if ($update) { 
            return response()->json(['message' => 'داده‌ها با موفقیت وارد شدند']);
        }
    
        // اگر خطایی رخ دهد
        return response()->json(['message' => 'خطا در ثبت داده‌ها'], 500);
    }
    public function canceledRemove(Request $request, $id){
        OnlineClassroom::where('id', $id)->update(['is_cancel' => null]);
    }

}
