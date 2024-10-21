<?php
namespace Admin\Controllers\Edu;

use Admin\Controllers\Public\BaseAbstract;
use Illuminate\Http\Request;
use Models\Person\User;

class LearnPathController extends BaseAbstract
{

    protected $model = "Models\Edu\LearnPath\LearnPath";
    protected $request = "Publics\Requests\Edu\Tools\LearnPathRequest";
    protected $with = ['activeStatus', 'files'];
    protected $showWith = ['activeStatus', 'visits'];
    protected $searchFilter = ["title"];
    protected $needles = ['Base\YearSemester'];
    protected $increment = "learnpaths";
    protected $decrement = "learnpaths";
    // protected $files = ['img_pdf' => ['model' => 'Models\Edu\LearnPath\File', 'url' => '/../public_html/media/courses/learnpath', 'file_category_id' => 1, 'fk'=> 'learnPath_id' ]];

    public function init()
    {
        $this->showQuery = function ($q, $before) {
            // $query = $this->setOperator($query);

            $user = auth()->guard('admin')->user();
            $id = last(request()->segments()); //learnpath_id
            $files = \Models\Edu\LearnPath\File::where('learnPath_id', $id)->get();

            /***
             * added learn path to visited with user
             */
            // if ($this->user->role_id == 2) {
            //     $user->visits()->attach($id);
            // }
            if (is_null($this->user->visits()->find($id))) {
                $user->visits()->attach($id, ['view_count' => 1]);
            }else{
                $count = intval($user->visits()->findOrFail($id)->pivot->view_count) + 1;
                $user->visits()->updateExistingPivot($id, ['view_count' => $count]);
            }

            /***
             * added view count  to learn path for all users
             */
            \Models\Edu\LearnPath\LearnPath::find($id)->increment('view_count');

            /***
             * classification of learnPath's files
             */

            if ($before == false) {
                if (request()->mode !== 'edit') {
                    /**
                     * تصویر و فایل پی دی اف با هم
                     */

                    $image_pdf = explode('###', $q->image_pdf);

                    // بررسی اینکه آیا آخرین عنصر خالی است یا خیر
                    if (empty(end($image_pdf))) {
                        // اگر خالی بود، آن را حذف می‌کنیم
                        array_pop($image_pdf);
                    }

                    $img_pdf = [];

                    foreach ($image_pdf as $key => $value) {
                        $ext = explode('.', $value);
                        if(end($ext) == 'pdf'){
                            $img_pdf[] = base64_encode($value) . '.bcr';
                        }else{
                            $img_pdf[] = $value;
                        }
                    }

                    $q->image_pdf = $img_pdf;

                    /***
                     * فایل پی دی اف نسخه موبایل
                     */
                    $mobile_pdf = explode('###', $q->mobile_pdf);

                    // بررسی اینکه آیا آخرین عنصر خالی است یا خیر
                    if (empty(end($mobile_pdf))) {
                        // اگر خالی بود، آن را حذف می‌کنیم
                        array_pop($mobile_pdf);
                    }

                    $moboleVersion = [];

                    foreach ($mobile_pdf as $key => $value) {
                        $ext = explode('.', $value);
                        if(end($ext) == 'pdf'){
                            $moboleVersion[] = base64_encode($value) . '.bcr';
                        }else{
                            $moboleVersion[] = $value;
                        }
                    }

                    $q->mobile_pdf = $moboleVersion;

                    /***
                     * audio
                     */

                    $audio = explode('###', $q->audio);

                    if (empty(end($audio))) {
                        array_pop($audio);
                    }

                    $video = explode('###', $q->video);

                    if (empty(end($video))) {
                        array_pop($video);
                    }

                    $q->audio = $audio;
                    $q->video = $video;
                }

            }

            /***
             * getting all users that visited this learnPath
             */
            // $user_ides = \DB::table('learnpath_view_user')->where('user_id', $user->id)->where('learnPath_id', $id)->pluck('user_id');
            // $users = \Models\Person\User::whereIn('id', $user_ides)->get();
            // $q->visited_users = $users;
        };
    }

    public function list($course)
    {
        $collection = $this->model::with("activeStatus")->where('course_id', $course)->orderBy('order', 'ASC');
        // $collection = $this->model::with("activeStatus")->where('course_id', $course)->orderBy('order', 'ASC');

        $data = json_decode($this->grid($collection, $this->searchFilter)->getContent(), true);


        $userInCourse = $this->userInCourse($course);
        $userAccess = false;
        
        if ($userInCourse !== 2 || auth()->guard('admin')->user()->role_id == 4) {
            $userAccess = true;
        }

        $data['userAccess'] = $userAccess;

        return response()->json($data);
    }

    public function visits($id)
    {
        $stu_ids = \DB::table("learnpath_view_user")->where('learnPath_id', $id)->pluck('user_id');
        $collection = User::whereIn('id', $stu_ids)->select('id', 'firstname', "lastname", "photo", "email", "mobile");
        return $this->grid($collection);
    }

    public function getFile()
    {
        $referer = request()->header('Referer');

        if (is_null($referer)) {
            return response()->json(['error' => 'Invalid request'], 500);
        }

        if ($referer[strlen($referer) - 1] === '/') {
            $referer = substr($referer, 0, -1);
        }

        // if (env('FRONTEND_URLS') == $referer) {
            if (request()->ajax()) {
                if (request()->has('file')) {

                    $file = base64_decode(str_replace('.bcr', '', request()->file));
                    $filePath = public_path('media/' . request()->url . $file);

                    if (file_exists($filePath)) {
                        return response()->file($filePath);
                    }

                }
            }
        // }
        return response()->json(['error' => 'The requested file is not available'], 404);
    }
    
}
