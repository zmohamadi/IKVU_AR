<?php 

namespace Publics\Requests\Edu\Tools;

use Illuminate\Foundation\Http\FormRequest;


class OnlineClassroomRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        $rules =  [
            'title'=>'required',
            'date'=>'required',
            'start_hour' => ['required', 'regex:/^\d{2}:\d{2}$/'],
            'duration'=>'required',
            'semester'=>'required',
        ];
        if(request()->semester > 0) $rules['group_code'] = 'required';

        return $rules;
    }
}
    