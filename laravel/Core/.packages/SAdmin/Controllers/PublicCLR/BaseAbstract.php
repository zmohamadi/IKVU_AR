<?php
namespace SAdmin\Controllers\PublicCLR;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
// use Publics\Controllers\BaseTrait;
use Publics\Traits\FileTrait;
use Publics\Controllers\SMSIR\SMSIR_SendMessage;
use \DB;

// !!!!!! Comments and examples are important !!!!!!!!!!!

abstract class BaseAbstract extends Controller
{
    // use BaseTrait;
    use FileTrait;


    protected $model; //Model file address

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

    public function __construct()
    {
        $this->middleware(function ($request, $next)
        {
            // Who is logged in ???
            $this->lang = \App::getLocale();
            $this->user = \Auth::user();
            // $this->user_id = $this->user->id;
            // $this->is_admin = \Session::get('is_admin');
            // $this->role_id = \Session::get('role_id');
            // $this->ngo_id = \Session::get('ngo_id');
            // $this->panel = \Session::get('panel');

            $this->init();

            return $next($request);
        });
    }

    public function init(){}

    public function index()
    {
        global $items;

        if(count($this->with)>0)
            $items = $this->model::with($this->with);
        else
            $items = $this->model::query();

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
            $info['status_id'] = 1;
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
                                    ->delete();
                            //_______________________________

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

        return response()->json($id);
    }

    public function getNeedles($needle=[])
    {
        
        global $modelObj;
        $info=[];
        if(count($needle)==0) $needle = $this->needles;
        foreach ($needle as $key => $value)
        {
            if(\is_integer($key)){
                $className = 'Models\\' . $value;
                $modelObj =  new $className;
                $index = explode('\\',$value);
                $attr = strtolower($index[count($index)-1]);
                $info[$attr] = $modelObj->get();
            }
            else if($value instanceof \Closure){
                $className = 'Models\\' . $key; // in this case $key is a class address
                $modelObj  = $className::query();
                $closure = $value;
                $closure($GLOBALS['modelObj']); // in this case $value is a closure
                $index = explode('\\',$key);
                $attr = strtolower($index[count($index)-1]);
                $info[$attr] = $modelObj->get();
            }
        }
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

    public function sendMessage($userId, $messages)
    {
        $user = \Models\Person\User::find($userId);
        $mobileNumbers = $user->mobile;
        // dd($user);


        $sms = new SMSIR_SendMessage;
        $send = $sms->sendSMS($mobileNumbers,$messages);
        // dd($send);
        return $send;

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
                        // $file->url = $data[$i]['name'];
                        $file->extension = $data[$i]['extension'];
                        $file->size = $data[$i]['size'];
                        // $file->width = $data[$i]['width'];
                        // $file->height = $data[$i]['height'];
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
            $number = 5;
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

        $sumLength = 300;
        for ($i = 0; $i < count($result); $i++) {
            if (strlen($result[$i]->comment) > 700) {
                $length = strpos($result[$i]->comment, " ", $sumLength);
                $result[$i]->comment = substr($result[$i]->comment, 0, $length);
                $result[$i]->comment = $result[$i]->comment . " ...";
            }
        }

        for($i=0; $i<count($result); $i++){
            if($result[$i]->users && count($result[$i]->users) > 0){
                $result[$i]->users[0]['info'] = $result[$i]->users[0]['name']." ".$result[$i]->users[0]['family'];
                $result[$i]['manager'] = $result[$i]->users[0];
            }
        }

        if($resultCallback != null){
            $result  = $resultCallback($result);
        }

        return(response()->json($result));
    }
    function needJoin($field){
        if(strpos($field, '.')) return true;
        else return false;
    }
}
