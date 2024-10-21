<?php 

namespace Publics\Requests\Person;

use Illuminate\Foundation\Http\FormRequest;

class UserRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        $role_id = \Auth::guard("admin")->user()->role_id;
        $user_id = \Auth::guard("admin")->user()->id;

        $item =  [
            'firstname'=>'required',
            'lastname'=>'required',
            'gender_id'=>'required',
            'role_id'=>'required',
            'photo'=>'required',
        ];
        if(request()->_method == "PUT")
        {
            $url = explode("/", request()->path());
            $id = $url[2];
            $mobileRequired = ($user_id == $id)? "nullable" : "required";

            $item["codemeli"] = "nullable|unique:users,codemeli,".$id.",id,deleted_at,NULL";
            $item["username"] = $mobileRequired."|unique:users,username,".$id.",id,deleted_at,NULL";
            $item["mobile"] = $mobileRequired."|unique:users,mobile,".$id.",id,deleted_at,NULL";
            $item["email"] = "nullable|unique:users,email,".$id.",id,deleted_at,NULL";
            if(request()->role_id == 2 && $role_id != 2) $item["studentID"] = "required|unique:users,studentID,".$id.",id,deleted_at,NULL";
        }
        else
        {
            $item["codemeli"] = "nullable|unique:users,codemeli,NULL,id,deleted_at,NULL";
            $item["username"] = "required|unique:users,username,NULL,id,deleted_at,NULL";
            $item["mobile"] = "required|unique:users,mobile,NULL,id,deleted_at,NULL";
            $item["email"] = "nullable|unique:users,email,NULL,id,deleted_at,NULL";
            if(request()->role_id == 2 && $role_id != 2) $item["studentID"] = "required|unique:users,studentID,NULL,id,deleted_at,NULL";
        }
        // if(str_contains(request()->path(),"users") || str_contains(request()->path(),"personnels"))
        // {
        //     $item["role_id"] = "required";
        // }
       
        return $item;
    }
}
    