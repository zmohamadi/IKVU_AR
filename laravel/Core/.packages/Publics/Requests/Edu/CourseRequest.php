<?php 

namespace Publics\Requests\Edu;

use Illuminate\Foundation\Http\FormRequest;


class CourseRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        return [
                'title'=>'required',
                'code'=>'required',
                // 'less_id'=>'required',
                'system_id'=>'required',
                'description'=>'required',
                'thumbnail'=>'required',
                // 'status_id'=>'required',
                'category_id'=>'required'
            ];
    }
}
    