<?php

namespace Publics\Requests\Base;

use Illuminate\Foundation\Http\FormRequest;


class SystemRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        return [
                'title'=>'required',
                'api_key'=>'required',
                'ip'=>'required',
                'photo'=>'required',
                'domain'=>'required',
                'description'=>'required',
               
        ];
    }
}
    