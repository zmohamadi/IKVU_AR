<?php
namespace Admin\Controllers\Public;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
// use Publics\Controllers\BaseTrait;
use Publics\Controllers\Tools;
use Publics\Traits\FileTrait;
use Models\Person\Role;
use \DB;

// !!!!!! Comments and examples are important !!!!!!!!!!!

abstract class BaseAbstract extends Controller
{
    // use BaseTrait;
    use FileTrait;


    protected $local; //Model file address
    protected $model; //Model file address

    protected $increment; //increment count in base_counts table
    protected $decrement; //decrement count in base_counts table

    protected $request; //Request file address

    protected $with=[]; //What relationships do we have with?

    protected $showWith=[]; //Getting the data that is needed in the view form

    protected $needles=[]; //Getting the data that is needed in the save and edit form
    /* If the data you need has a particular query, you can write it in the init function. for example
    public function init()
    {
        $this->needles = [
            \Base\keyword::class => function($query){
                $query->where('status_id', 1) ;
            },

            \Site\Category::class => function($query){
                $query->with(['contentSubject'=>function($query){
                    $query->where('id','>',0)->where('status_id',1);
                }])->where('status_id',1)->get();
            },
        ];
    } */

    protected $destroy=[]; //What relationships should we remove?
                            /*  If the relationship is 1 to N, name the model file address.
                            If the relation is M to N, write the name of the relationship. */

    protected $except=['_method']; //What fields are not saved and edited?


    protected $files=[];  //Introducing the fields to save to the files
   /*   This variable can include photos, documents, scans, galleries, and more
        If the file you want has a 1 To N relationship, just type field.
        for example
        protected $files   = [
            'file'=>['model'=>'Models\Site\ContentFile', 'url'=>'/../public_html/media/blogs/files','file_category_id=>'1'],
            'img'=>['model'=>'Models\Site\ContentFile', 'url'=>'/../public_html/media/blogs/images'],
            'forumer'
        ];
    */

    protected $urlFile; //File path of uploading images from public_html

    protected $searchFilter=[]; //What fields in the list can be searched?
    protected $searchCondition=[];
    protected $translateFieldFilter=""; //What fields in the list can be searched?

    protected $indexQuery = ""; //If your list has a particular query, write a query for it in the init function

    protected $showQuery = ""; //If the show function has a specific query, write a query for the init function

    protected $storeQuery = "";//If the store function has a specific query, write a query for the init function
    /* If you have a specific field to store in the table, type it in a query. for example
    `creator_id` is a special field that needs to be saved.
    This field is first introduced, quantified and then saved.
    public function init()
    {
        $this->storeQuery = function($query){
            $query->creator_id = \Auth::user()->id;
            $query->status_id = 0;
            $query->save();
        };
    } */
    protected $baseStore = true;

    protected $sync=[]; //Introduce the M to M relationships. They are included in the save and edit functions

    // Who is logged in ???
    public $user;
    public $user_id;
    public $is_admin;
    public $role_id;
    public $lang;
    
    protected $roleStu=false;

    // For Laravel 10, 9, ...
    // public function __construct()
    // {
        // $this->middleware(function ($request, Closure $next)
        // {
        //     $guard = strpos($request->route()->uri, "mastership") > -1 ? "admin" : "web";
        //     $this->lang = \App::getLocale();
        //     $this->user = \Auth::guard($guard)->user();
        //     $this->user_id = isset($this->user->id) ? $this->user->id : "0";
        //     if (isset($this->user->role_id)) $this->role_id = $this->user->role_id;

        //     $this->init();

        //     return $next($request);
        // });        
    // }

    // For Laravel 11
    public function __construct()
    {
        $guard = strpos(request()->route()->uri, "mastership") > -1 ? "admin" : "web";
        $this->lang = \App::getLocale();
        $this->user = \Auth::guard($guard)->user();
        $this->user_id = isset($this->user->id) ? $this->user->id : "0";
        if (isset($this->user->role_id)) $this->role_id = $this->user->role_id;

        $this->init();
    }


    // For Laravel 11
    // public static function middleware()
    // {
    //     return [
    //         function (Request $request, Closure $next) {
    //             $guard = strpos($request->route()->uri, "mastership") > -1 ? "admin": "web";
    //             $this->lang = \App::getLocale();
    //             $this->user = \Auth::guard($guard)->user();
    //             $this->user_id = isset($this->user->id)?$this->user->id: "0";
    //             if(isset($this->user->role_id)) $this->role_id = $this->user->role_id;
    //             // $this->is_admin = \Session::get('is_admin');
    //             // $this->ngo_id = \Session::get('ngo_id');
    //             // $this->panel = \Session::get('panel');

    //             $this->init();
    //             return $next($request);
    //         },
    //     ];
    // }

    public function init(){}

    public function index()
    {
        global $items;

        if(count($this->with)>0) $items = $this->model::with($this->with);
        else $items = $this->model::query();

        //________indexQuery___________
        if($this->indexQuery instanceof \Closure){
            $function = $this->indexQuery;
            $function($GLOBALS['items']);
        }

        if($this->translateFieldFilter != ""){
            $langArray = $this->getFieldForLang($this->translateFieldFilter);
            $filters = array_merge($langArray,$this->searchFilter);
            return $this->grid($items, $filters);
        }
        else
        {
            return $this->grid($items, $this->searchFilter,null,$this->searchCondition);
        }
    }

    public function store(Request $request)
    {
        // ________Request___________
        if($this->request!='')
        {
            $requestMain = new $this->request();
            $attributes = count($requestMain->attributes)>0? $requestMain->attributes:[];
            $messages = $requestMain->messages()? $requestMain->messages(): [];
            $request->validate($requestMain->rules(), $messages, $attributes);
        }
        //_______________________________________________________

        //_____________except_________
            $info = $request->except($this->processExcept($this->except));
            // dd(array_keys($info));
        // _______________________________________________________

        // __________status____________
            // $info['status_id'] = 1;
        //_______________________________________________________
        // __________store____________
        DB::beginTransaction();
        try{
            global $dataInsert;
            if($this->baseStore)
                $dataInsert =  $this->model::create($info);
            else
                $dataInsert = [];
        //_______________________________________________________

        //__________storeQuery____________
            if($this->storeQuery instanceof \Closure){
                $function = $this->storeQuery;
                $function($GLOBALS['dataInsert']);
            }
        //_______________________________________________________
        // __________sync____________
            if(count($this->sync) > 0){
                foreach($this->sync as $sync){
                    $nameField = $this->singularize($sync).'_id';
                    $dataInsert->$sync()->sync($request->$nameField);
                }
            }
        //_______________________________________________________
        }catch (\Exception $e) {
            $message = $e->getMessage();
            DB::rollback();
            if(!env('APP_DEBUG')) $message = $e;
            return response()->json($message, '501');
        }
        DB::commit();

        //__________files____________
        if($this->files) $dataInsert = $this->saveFiles($this->files, $dataInsert, $request);

        // increment
        if($this->increment) $this->plusCount($this->increment);

        return response()->json($dataInsert);
    }

    public function show($id)
    {
        global $item;

        //_____________showWith_________
            if(count($this->showWith)>0)
                $item = $this->model::with($this->showWith);
        //_______________________________________________________

        //_____________With_________
            else if((count($this->with) > 0) && ($this->showWith != null))
                $item = $this->model::with($this->with);
        //_______________________________________________________
            else
                $item = $this->model::query();


        //_____________showQuery_________
            if($this->showQuery instanceof \Closure){
                $function = $this->showQuery;
                $function($item, true);
            }
        //_______________________________________________________
        $item = $item->find($id);

        if($this->showQuery instanceof \Closure){
            $function = $this->showQuery;
            $function($item, false);
        }

        return response()->json($item);
    }

    public function update(Request $request, $id)
    {
        global $item;

        // ________Request___________
            if($this->request!='')
            {
                $requestMain = new $this->request();
                $request->validate($requestMain->rules());
            }
        //_______________________________________________________

        //_____________except_________
            $info = $request->except($this->processExcept($this->except));
            // $info = $request->except($this->except);
        // _______________________________________________________

        //_____________update_________
        DB::beginTransaction();
        try {
            global $item;
            $item = $this->model::findOrFail($id);
            $id = $item->update($info);
        //_______________________________________________________

        //__________storeQuery____________
            if($this->storeQuery instanceof \Closure){
                $function = $this->storeQuery;
                $function($GLOBALS['item']);
            }
        //_______________________________________________________
        // __________sync____________
            if(count($this->sync) > 0){
                foreach($this->sync as $sync){
                    $nameField = $this->singularize($sync).'_id';
                    $item->$sync()->sync($request->$nameField);
                }
            }
        //_______________________________________________________
        }catch(\Exception $e){
            $message = $e->getMessage();
            DB::rollback();
            if(!env('APP_DEBUG')) $message = $e;
            return response()->json($message, '501');
        }
        DB::commit();
            //__________files____________
            if($this->files){
                foreach ($this->files as $key => $value) {

                    if(\is_integer($key)){

                        $item->$value = str_replace("###", "", $request->$value);
                        $item->save();
                    }
                    else{
                        // if($request->$key)
                        {
                            //______ Model File Name _________
                                $model  = $value['model'];
                            //_______________________________
                            //______ FK _________
                                if($value['fk']==''){
                                    $index  = explode('\\',$this->model);
                                    $FK     = strtolower($index[count($index)-1])."_id";
                                }
                                else $FK = $value['fk'];
                            //_______________________________\

                            //______ delete record from file table ::: detach _________
                                $model::where($FK,$item->id)
                                    ->where('file_category_id',$value['file_category_id'])
                                    // ->where('file_type_id',$value['file_type_id'])
                                    ->delete();
                            //_______________________________
                            // dd($request);

                            $data   = $this->getFileInfo($request->$key , base_path().$value['url']);

                            for($i=0; $i<count($data); $i++){

                                $file = new $model;
                                $file->$FK = $item->id;
                                $file->file_category_id = $value['file_category_id'];
                                $file->file_type_id = $data[$i]['file_type_id'];
                                $file->name = $data[$i]['name'].'.'.$data[$i]['extension'];
                                $file->url = $data[$i]['name'];
                                $file->extension = $data[$i]['extension'];
                                $file->size = $data[$i]['size'];
                                $file->width = $data[$i]['width'];
                                $file->height = $data[$i]['height'];
                                $file->save();
                            }
                        }
                    }
                }
            }
        //_______________________________________________________

        return response()->json($id);
    }

    public function destroy($id)
    {
        $item = $this->model::findOrFail($id);

        if(count($this->destroy)>0)
        {
            foreach ($this->destroy as $value)
            {
                //__________1 to N Rel____________
                if(strpos($value,'\\'))
                {
                    $className = 'Models\\' . $value;
                    $index = explode('\\',$this->model);
                    $FK = strtolower($index[count($index)-1])."_id";

                    $modelDestroy =  new $className;
                    $modelDestroy::where($FK, $id)->delete();
                }
                //__________N to M Rel____________
                else
                {
                    $item->$value()->detach();
                }
            }
        }
        //__________delete____________
            $id = $item->delete();
        
        // decrement
        if($this->decrement) $this->minusCount($this->decrement);

        return response()->json($id);
    }

    public function getNeedles($needle = [])
    {
        global $modelObj;
        $info = [];

        // اگر هیچ داده‌ای در آرایه $needle نباشد، از مقدار پیش‌فرض استفاده می‌کنیم
        if (count($needle) == 0) {
            $needle = $this->needles;
        }

        foreach ($needle as $key => $value) {
            // شرط بررسی برای 'group'
            if ($value == 'group' || $key == 'group') {
                $info['group'] = Tools::userGroup(request()->course, $this->user_id);
            } else {
                if (\is_integer($key)) {
                    // ساخت نام کلاس
                    $className = 'Models\\' . $value;
                    $modelObj = new $className;

                    // به دست آوردن نام attribute با توجه به نام کلاس
                    $index = explode('\\', $value);
                    $attr = strtolower($index[count($index) - 1]);

                    // دریافت داده‌ها با متد active
                    $info[$attr] = $modelObj->active()->get();
                } else if ($value instanceof \Closure) {
                    // وقتی $value یک Closure باشد
                    $className = 'Models\\' . $key; // در این حالت $key آدرس کلاس است
                    $modelObj = $className::query();
                    $closure = $value;
                    
                    // فراخوانی Closure با استفاده از $modelObj
                    $closure($modelObj);

                    // به دست آوردن نام attribute
                    $index = explode('\\', $key);
                    $attr = strtolower($index[count($index) - 1]);

                    // دریافت داده‌ها با متد active
                    $info[$attr] = $modelObj->active()->get();
                }
            }
        }

        // بازگشت اطلاعات به صورت JSON
        return response()->json($info);
    }


    private function processExcept($except){
        $newExcept = [];
        foreach($except as $item){
            if(\substr($item, -1, 1) == "*"){
                $search = \substr($item, 0, \strlen($item) - 1);
                foreach(request()->all() as $key=>$req){
                    if(\stripos($key, $search, 0) > -1){
                        $newExcept[] = $key;
                    }
                }
            }
            else{
                $newExcept[] = $item;
            }
        }
        return $newExcept;
    }
    public function getFieldForLang($field)
    {
        $langs = \Models\Base\Language::active()->select('symbol')->get();
       // dd($langs);
        $array=[];

        foreach ($langs as $value) {
            array_push($array,$field.'_'.$value->symbol);
        }
        return $array;

    }

    public function getRepeatValues($values){
        $data = [];
        // dd($values);
        // dd(request()->all());
        foreach(request()->all() as $key=>$value)
        {
            $first = $values[0];
            if(\substr($key, 0, strlen($first)) == $first)
            {
                $i = substr($key, strlen($first));
                foreach($values as $var){
                    $var2 = $var.$i;
                    if(request()->$var2!="")
                    $data[$i][$var] = request()->$var2;
                }
            }
        }
        return $data;
    }

    public function saveFiles($files, $dataInsert, $request)
    {
        foreach ($files as $key => $value) {
            if(\is_integer($key)){
                $dataInsert->$value = str_replace("###", "", $request->$value);
                $dataInsert->save();
            }
            else{
                if($request->$key){

                    $model  = $value['model'];
                    if($value['fk']==''){
                        $index  = explode('\\',$this->model);
                        $FK     = strtolower($index[count($index)-1])."_id";
                    }
                    else $FK = $value['fk'];

                    $data = $this->getFileInfo($request->$key , base_path().$value['url']);

                    for($i=0; $i<count($data); $i++){
                        $file = new $model;
                        $file->$FK = $dataInsert->id;
                        $file->file_category_id = $value['file_category_id'];
                        $file->file_type_id = $data[$i]['file_type_id'];
                        $file->name = $data[$i]['name'].'.'.$data[$i]['extension'];
                        $file->url = $data[$i]['name'];
                        $file->extension = $data[$i]['extension'];
                        $file->size = $data[$i]['size'];
                        $file->width = $data[$i]['width'];
                        $file->height = $data[$i]['height'];
                        $file->save();
                    }
                }
            }
        }

        return $dataInsert;
    }

    public function grid($modelObject, $searchTerm=['name'], $resultCallback = null,$searchCondition=[]){
        $request = request();
        $number = $request->number;
        if($number == ""){
            $number = 10;
        }

        $sort = $request->sort;
        if($sort == ""){
            $sort = "id";
        }

        $sortType = $request->sortType;
        if($sortType == ""){
            $sortType = "DESC";
        }

        if($this->needJoin($sort))
        {
            $items = $modelObject->orderByJoin($sort, $sortType);
        }
        else {
            $items = $modelObject->orderBy($sort, $sortType);
        }


        $search = $request->search;
        if($search != "")
        {
            $i = 0;
            foreach ($searchTerm as $field) {
                $i++;
                if($this->needJoin($sort)){
                    if($i==1)
                        $items->whereJoin($field, 'like', "%$search%");
                    else
                        $items->orWhereJoin($field, 'like', "%$search%");
                }
                else{
                    if($i==1){
                        if($searchCondition) $items->where($field, 'like', "%$search%")->where($searchCondition[0],$searchCondition[1],$searchCondition[2]);
                        else $items->where($field, 'like', "%$search%");
                    }
                    else{
                        if($searchCondition) $items->orWhere($field, 'like', "%$search%")->where($searchCondition[0],$searchCondition[1],$searchCondition[2]);
                        else $items->orWhere($field, 'like', "%$search%");
                    }
                        
                }
            }
        }
        $result = $items->paginate($number);

        if($resultCallback != null){
            $result  = $resultCallback($result);
        }

        return(response()->json($result));
    }
    function needJoin($field){
        if(strpos($field, '.')) return true;
        else return false;
    }
    public function plusCount($field){

         \Models\Base\TotalCount::where('title',$field)->increment("count");
    }
    public function minusCount($field){
        \Models\Base\TotalCount::where('title',$field)->decrement("count");
    }
    public function userInCourse($course,$user_id=null,$group=null)
    {
        if($user_id==null) $user_id = $this->user_id;
        $row = \Models\Edu\Register::where("user_id", $user_id)->where('code', $course);
        if($group!=null) $row = $row->where("group", $group);
        $row =  $row->pluck('role_id')->first();
        return $row;
    }

    /**
     * Filters collection based on user role and request parameters.
     *
     * @param int $course The course ID to filter by.
     * @param int $role_id The role ID of the user.
     * @param int $user_id The user ID for filtering.
     * @param string $model The model class to use for the query.
     * @param \Illuminate\Http\Request $request The request instance containing filter parameters.
     * @param array $relations The relationships to load.
     * @param bool $active Whether to filter by active status.
     * @return \Illuminate\Database\Eloquent\Builder The filtered collection.
     */
    protected function filterCollection(int $course,$menu="courses", array $relations = [], $whereQuery = null)
    {
        $request = request();

        // $isStudent = $this->role_id == 2;
        $this->roleStu = $isStudent = $this->role_id == 2;
        $isTeacherOrStudent = in_array($this->role_id, [1, 2,3]);
        
        if($menu=="myCourses"){

            // $isStudent = $this->userInCourse($course) == 2;
            $this->roleStu = $isStudent = $this->userInCourse($course) == 2;
            $isTeacherOrStudent = in_array($this->userInCourse($course), [1, 2,3]);

        }

        // Initialize collection with course filter and related data
        $collection = $this->model::with($relations)->where('course_id', $course);
        if($whereQuery instanceof \Closure){
            $whereQuery($collection);
        }

        // Load additional relationships and status if the user is not a student
        if (!$isStudent) {
            $collection = $collection->with("activeStatus","creator","editor");
        }
        // Apply group-based filtering for teachers or students
        if ($isStudent) {

            $group = Tools::userGroup($course, $this->user_id);
            $collection = Tools::conditionGroup(["group" => $group, "collection" => $collection]);
        }

        // Filter for active records if the user is a student
        if ($isStudent) {
            $collection = $collection->active();
        }
        

        // Apply additional filters if the user is neither a teacher nor a student
        // if (!$isTeacherOrStudent) {
            $group = '';

            if ($request->has('semester') || $request->has('group')) {
                $semester = $request->get('semester', '');
                $groupPart = $request->get('group', '');

                $group = $semester . $groupPart;
                if ($group != "") {
                    $collection->where('group', 'LIKE', $group . '%');
                }
            }


            if ($request->has('type')) {
                $collection->where('question_type_id', $request->type);
            }
            if ($request->has('code')) {
                $collection->where('course_id', $request->code);
            }
            if ($request->has('correcting')) {
                $op = $request->correcting === "uncorrected" ? "<>" : "=";
                $collection->where('answer_count', $op, "answer_correcting_count");
            }
        // }

        return $collection;
    }
    public function getCourse($code)
    {
        $sessionKey = 'course-' . $code;
    
        // اگر دوره قبلاً در سشن بود، آن را بازگردان
        if (session()->has($sessionKey)) {
            $courseData = session($sessionKey);
            return (object) $courseData; // تبدیل به آبجکت برای سازگاری با شیوه استفاده
        }
    
        // جستجوی دوره بر اساس code و انتخاب فقط فیلدهای مورد نظر
        $course = \Models\Edu\Course::select('system_id', 'code', 'less_id', 'category_id', 'title', 'thumbnail')
                    ->firstWhere('code', $code);
    
        // اگر دوره پیدا شد، ذخیره فیلدهای انتخاب‌شده در سشن و بازگرداندن آن
        if ($course) {
            $selectedFields = $course->only(['system_id', 'code', 'less_id', 'category_id', 'title', 'thumbnail']);
            session([$sessionKey => $selectedFields]);
            return $course;
        }
    
        return null; // اگر دوره پیدا نشد
    }
    /**
     * get role of User Logined For Check access in Operation
     */
    public function setAccessOperation($course,$data)
    {
        $data['accessOperation'] = true;
        
        if(in_array($this->role_id, Role::NONPERSONNEL))
        {
            $userInCourse = $this->userInCourse($course);
            if($userInCourse == null || $userInCourse == 2)
                $data['accessOperation'] = false;
        }

        return $data;
    }
    public function setOperator($query)
    {
        $method = request()->method();

        if ($method === 'PUT' || $method === 'PATCH') {
            $query->editor_id = $this->user_id;
        } else {
            $query->creator_id = $this->user_id;
        }

        return $query;
    }


}
