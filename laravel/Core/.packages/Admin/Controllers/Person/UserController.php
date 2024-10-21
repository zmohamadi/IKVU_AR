<?php

namespace Admin\Controllers\Person;

use Admin\Controllers\Public\BaseAbstract;
use Carbon\Carbon;use DateInterval;use DateTime;use Models\Base\YearSemester;
use Models\Edu\Assignment\Assignment;

use Models\Edu\OnlineClassroom\OnlineClassroom;

use Models\Edu\Quiz\Quiz;

use Models\Edu\Register;

use Models\Edu\Survey\Survey;
use Verta;

class UserController extends BaseAbstract
{
    protected $model = "Models\Person\User";
    protected $request = "Publics\Requests\Person\UserRequest";
    protected $with = ["role", "gender", "activeStatus"];
    protected $showWith = ["role", "gender", "activeStatus"];
    protected $searchFilter = ["firstname", "lastname", "email", "mobile", "codemeli", "username"];
    protected $files = ["photo"];
    protected $userPathInEvent = "/panel/myCourses/";

    public function init()
    {
        $this->storeQuery = function ($query) {
            $query = $this->setOperator($query);
            if (request()->_method != "PUT") {
                $query->password = bcrypt(request()->mobile);
            }

            $query->save();
        };

        $this->needles = [
            \Person\Role::class => fn($query) => $query->active(),
            \Base\Gender::class,
        ];
    }

    public function showInfo($id)
    {
        $data = [
            "item" => $this->model::with("role", "gender", "activeStatus", "creator", "editor")->find($id),
            "registers" => Register::with("course", "role")->where("user_id", $id)->orderBy("group", "desc")->get(),
        ];
        return response()->json($data);
    }

    public function editEmail()
    {
        $user = $this->model::find($this->user->id);
        $user->email = request()->email;
        $user->save();

        return response()->json(['status' => 200]);
    }

    public function changePassword()
    {
        $userId = request()->id > 0 ? request()->id : $this->user->id;

        request()->validate([
            'new_password' => 'required|confirmed',
        ]);

        $user = $this->model::find($userId);
        $user->password = bcrypt(request()->new_password);
        $user->save();

        return response()->json(['status' => 200]);
    }

    public function getAllEvents()
    {
        $year = $this->getCurrentYearSemester();
        $registers = $this->getUserRegisters($this->user->id, $year->year . $year->semester);

        $courseCodes = $registers->pluck('code');
        $groups = $registers->pluck('group');

        if (request()->has('startDate')) {
            $previousMonth = Verta(\Carbon\Carbon::parse(request()->startDate))->format('Y/m/d');
            $nextMonth = Verta(\Carbon\Carbon::parse(request()->startDate)->addMonth())->format('Y/m/d');
        } else {
            $now = Verta::now();
            $previousMonth = $now->copy()->subMonth()->format('Y/m/d');
            $nextMonth = $now->copy()->addMonth()->format('Y/m/d');
        }

        $events = array_merge(
            // $this->processCourseUsersForEvents($this->getUserWithCourseUsers($this->user->id, $courseCodes, $groups, $previousMonth, $nextMonth)),
            $this->processClassesForEvents($this->getClasses($courseCodes, $groups, $previousMonth, $nextMonth)),
            $this->processQuizForEvents($this->getQuiz($courseCodes, $groups, $previousMonth, $nextMonth)),
            $this->processAssignmentsForEvents($this->getAssignments($courseCodes, $groups, $previousMonth, $nextMonth)),
            $this->processSurveysForEvents($this->getSurveys($courseCodes, $groups, $previousMonth, $nextMonth)),
        );

        $events = [
            'codes' => $courseCodes->toArray(),
            'events' => $events
        ];

        return response()->json($events);
    }

    protected function getCurrentYearSemester()
    {
        return YearSemester::where("current", 1)->first();
    }

    protected function getUserRegisters($userId, $current)
    {
        return Register::where("user_id", $userId)
            ->where("group", "LIKE", "$current%")
            ->get();
    }

    protected function getAssignments($courseCodes, $groups, $previousMonth, $nextMonth)
    {
        return Assignment::whereIn('course_id', $courseCodes)
            ->whereIn('group', $groups)
            ->with('course:code,title')
            ->orderBy('order')
            ->where(function ($query) use ($previousMonth, $nextMonth) {
                $query->whereBetween('start_date', [$previousMonth, $nextMonth])
                    ->orWhereBetween('expire_date', [$previousMonth, $nextMonth]);
            })
            ->get();
    }

    protected function getSurveys($courseCodes, $groups, $previousMonth, $nextMonth)
    {
        return Survey::whereIn('course_id', $courseCodes)
            ->whereIn('group', $groups)
            ->with('course:code,title')
            ->whereBetween('start_date', [$previousMonth, $nextMonth])
            ->get();
    }

    protected function getClasses($courseCodes, $groups, $previousMonth, $nextMonth)
    {
        return OnlineClassroom::whereIn('course_id', $courseCodes)
            ->whereIn('group', $groups)
            ->with('course:code,title')
            ->orderBy('order')
            ->whereBetween('date', [$previousMonth, $nextMonth])
            ->get();
    }

    protected function getQuiz($courseCodes, $groups, $previousMonth, $nextMonth)
    {
        return Quiz::whereIn('course_id', $courseCodes)
            ->whereIn('group', $groups)
            ->with('course:code,title')
            ->where(function ($query) use ($previousMonth, $nextMonth) {
                $query->whereBetween('start_date', [$previousMonth, $nextMonth])
                    ->orWhereBetween('end_date', [$previousMonth, $nextMonth]);
            })
            ->get();
    }

    protected function getUserWithCourseUsers($userId, $courseCodes, $groups, $previousMonth, $nextMonth)
    {
        return $this->model::with(['courseUsers' => function ($q) use ($courseCodes, $groups, $previousMonth, $nextMonth) {
            $q->whereIn('course_users.code', $courseCodes)
                ->whereIn('course_users.group', $groups);
        }])->find($userId);
    }

    protected function processCourseUsersForEvents($courseUsers)
    {
        return $courseUsers->map(function ($courseUser) {
            if (!is_null($courseUser->pivot->start_date)) {
                $startDate = explode('/', $courseUser->pivot->start_date);
                $start = $this->convertJalaliToGregorian($startDate);
                return [
                    'code' => "دوره :" . $courseUser->code,
                    'title' => "دوره :" . $courseUser->title,
                    'start' => $start,
                    'end' => $start,
                    'url' => $this->userPathInEvent . $courseUser->code,
                ];
            }
            return null;
        })->filter()->all();
    }

    protected function processClassesForEvents($classes)
    {
        $classesArray = $classes->toArray(); // Convert the collection to an array
        // dd($classes);

        return array_map(function ($classe) {
            // dd($classe['course']['title']);

            $startDate = explode('/', $classe['date']); // Access the array key
            $startHour = explode(':', $classe['start_hour']);
            $endTime = $this->calculateEndTime($classe['start_hour'], $classe['duration']);
            $endHour = explode(':', $endTime);

            return [
                'code' => $classe['course']['code'],
                'title' => "کلاس آنلاین : درس " . $classe['course']['title'],
                'start' => $this->convertJalaliToGregorianWithTime($startDate, $startHour),
                'end' => $this->convertJalaliToGregorianWithTime($startDate, $endHour),
                'url' => $this->userPathInEvent . $classe['course_id'] . "/tools/onlineClassroom/" . $classe['id'],
            ];
        }, $classesArray);
    }

    protected function processQuizForEvents($quiz)
    {
        $quizArray = $quiz->toArray(); // Convert the collection to an array

        return array_map(function ($q) {
            $startDate = explode('/', $q['start_date']); // Access the array key
            $endDate = explode('/', $q['end_date']); // Access the array key
            $startHour = explode(':', $q['start_time']);
            $endHour = explode(':', $q['end_time']);

            return [
                // 'title' => "آزمون : " . $q['title'],
                'code' => $quiz['course']['code'],
                'title' => "آزمون : درس " . $q['course']['title'],
                'start' => $this->convertJalaliToGregorianWithTime($startDate, $startHour),
                'end' => $this->convertJalaliToGregorianWithTime($endDate, $endHour),
                'url' => $this->userPathInEvent . $q['course_id'] . "/tools/quiz/" . $q['id'],
            ];
        }, $quizArray);
    }

    protected function processAssignmentsForEvents($assignments)
    {
        return $assignments->map(function ($assignment) {
            $startDate = explode('/', $assignment->start_date);
            $expireDate = explode('/', $assignment->expire_date);

            return [
                // 'title' => "تکلیف :" . $assignment->title,
                'code' => $assignment['course']['code'],
                'title' => "تکلیف : درس " . $assignment['course']['title'],
                'start' => $this->convertJalaliToGregorian($startDate),
                'end' => $this->convertJalaliToGregorian($expireDate),
                'url' => $this->userPathInEvent . $assignment->course_id . "/tools/assignment/" . $assignment->id,
            ];
        })->all();
    }

    protected function processSurveysForEvents($surveys)
    {
        return $surveys->map(function ($survey) {
            $startDate = explode('/', $survey->start_date);

            return [
                // 'title' => "نظرسنجی :" . $survey->title,
                'code' => $survey['course']['code'],
                'title' => "نظرسنجی : درس " . $survey['course']['title'],
                'start' => $this->convertJalaliToGregorian($startDate),
                'end' => $this->convertJalaliToGregorian($startDate),
                'url' => $this->userPathInEvent . $survey->course_id . "/tools/survey/" . $survey->id,
            ];
        })->all();
    }

    protected function convertJalaliToGregorian(array $date)
    {
        // بررسی اینکه تاریخ ورودی به درستی تعریف شده است
        if (count($date) !== 3) {
            throw new InvalidArgumentException('Date array must contain exactly three elements: year, month, and day.');
        }

        // تبدیل تاریخ شمسی به میلادی
        $gregorianDateArray = Verta::jalaliToGregorian((int) $date[0], (int) $date[1], (int) $date[2]);

        return $gregorianDateArray;
    }

    private function convertJalaliToGregorianWithTime(array $date, array $time)
    {
        $gregorianDate = $this->convertJalaliToGregorian($date);
        if (is_array($time)) {
            return array_merge($gregorianDate, $time);
        } else {
            return $gregorianDate;
        }

    }
    private function calculateEndTime($startHour, $duration)
    {
        if (explode(':', $startHour)[0] > 24) {
            $startHour = '00:00'; // اگر ساعت شروع بیشتر از 24 بود، به 00:00 تنظیم می‌شود
        }

        // تبدیل duration از فرمت H:i به دقیقه‌ها
        $timeParts = explode(':', $duration);
        $hours = isset($timeParts[0]) ? (int) $timeParts[0] : 0;
        $minutes = isset($timeParts[1]) ? (int) $timeParts[1] : 0;
        $totalMinutes = $hours * 60 + $minutes;

        // محاسبه زمان پایان
        $startTime = new DateTime($startHour);
        $interval = new DateInterval('PT' . $totalMinutes . 'M');
        $endTime = clone $startTime;
        $endTime->add($interval);

        return $endTime->format('H:i');
    }

    // private function calculateEndTime00($startHour, $duration)
    // {
    //     if (explode(':', $startHour)[0] > 24) {
    //         $startHour = '00:00'; // if start hour is greater than 24, set it to 00:00
    //     }
    //     $startTime = new DateTime($startHour);
    //     $interval = new DateInterval('PT' . $duration . 'M');
    //     $endTime = clone $startTime;
    //     $endTime->add($interval);

    //     return $endTime->format('H:i');
    // }

}
