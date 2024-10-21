<?php 

namespace Publics\Requests\Edu\Tools;

use Illuminate\Foundation\Http\FormRequest;


class OnlineClassroomFileRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        return [
            'link'=>'required',
            'size'=>'required',
            'description'=>'required',
    ];
    }
}
    