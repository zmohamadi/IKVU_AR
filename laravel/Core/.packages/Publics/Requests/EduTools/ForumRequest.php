<?php 

namespace Publics\Requests\EduTools;

use Illuminate\Foundation\Http\FormRequest;


class ForumRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {    
        $rules =  [
            'title'=>'required',
            'description'=>'required',
            'semester'=>'required',
        ];
        if(request()->semester > 0)
            $rules['group_code'] = 'required';

        return $rules;
    }
}
    