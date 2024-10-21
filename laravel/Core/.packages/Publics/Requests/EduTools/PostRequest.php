<?php 

namespace Publics\Requests\EduTools;

use Illuminate\Foundation\Http\FormRequest;


class PostRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        $rules =  [
            'message'=>'required',
        ];
        if(request()->has('title'))
            $rules['title'] = 'required';

        return $rules;
    }
}
    