<?php
namespace Admin\Controllers\Public;

use App\Http\Controllers\Controller;
use Models\Person\User;

class Index extends Controller
{
    public function changeStatus($model, $id, $field='status_id'){
        $status=1;
        $m = ucfirst($model);
        $m = str_replace('-','\\',$m);
        $className = 'Models\\' . $m;
        $modelObj =  new $className;

        $record = $modelObj->find($id);
        if($record->$field==1){
            $record->$field=0;
            $status = 0;
        }
        elseif ($record->$field==0){
            $record->$field=1;
            $status = 1;
        }
        $record->save();
    }

     public function getdata($model, $id=null){
        $m = ucfirst($model);
        $m = str_replace('-','\\',$m);
        $className = 'Models\\' . $m;
        $modelObj =  new $className;

        if($id){
            $record = $modelObj->find($id);
        }
        else{
            $record = $modelObj->where('status_id',1)->get();
        }
        return response()->json($record);
    }

    public function getInfo()
    {
        $id = \Auth::user()->id;
        $user = User::select('id','name','family','role_id','mobile','pic');
        $user = User::find($id);
        $user['role_id'] = \Session::get('role_id');
        $user['currency'] = \Session::get('currency');

        return \Response::json($user);
    }
}

