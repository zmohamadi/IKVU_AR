<?php
namespace SAdmin\Controllers\PublicCLR;

use App\Http\Controllers\Controller;

class PublicClr extends Controller
{
    /**
     * get records condition a field
    */
    public static function getRecords($model="", $field="", $field_value="")
    {
        $m = ucfirst($model);
        $m = str_replace('-','\\',$m);
        $className = 'Models\\' . $m;
        $records = $className::active();
        if($field != "")
        {
            $records = $records->where($field, $field_value);
        }
        $records = $records->get();

        return $records;
    }
    /**
     * show info a record
    */
    public static function showInfoRecord($model="", $id="", $field="")
    {
        $m = ucfirst($model);
        $m = str_replace('-','\\',$m);
        $className = 'Models\\' . $m;
        $record = $className::where('id', $id)
            ->select('id', $field)
            ->first()
            ;
        return $record;
    }
    /**
     * update info a record
    */
    public static function updateRecord($model, $id, $field, $request_value)
    {
        $m = ucfirst($model);
        $m = str_replace('-','\\',$m);
        $className = 'Models\\' . $m;
        $modelObj =  new $className;
        $record = $modelObj->find($id);
        // $record->$field = $request_value;
        // $record->update();
        $record->update([$field=>$request_value]);
        return $record;
    }
    /**
     * insert in tabel Keyword
    */
    public static function insertNewKeyword($obj)
    {
        $lang = request()->lang;
        $keys = explode("-", request()->keywords);
        foreach($keys as $key)
        {
            if($key != '')
            {
                $check_keyword = \Models\Base\Keyword::where("title", $key)->select("id")->first();
                if($check_keyword)
                {
                    $obj->keywords()->attach($check_keyword->id);
                }
                else
                {
                    $new_keyword = new \Models\Base\Keyword();
                    $new_keyword->title = $key;
                    $new_keyword->lang = $lang;
                    $new_keyword->save();
                    $obj->keywords()->attach($new_keyword->id);
                }
            }
        }
        return $obj;
    }
    /**
     * get provinces a country for use in Select2
     */
    public function getProvince()
    {
        $country_id = request()->country_id;
        $pro = \Models\Base\Province::with(["cities" => function($q)
        {
            $q->active();
        }])
        ->where("country_id", $country_id)
        ->get()
        ;
        return \Response::json($pro);
    }
}