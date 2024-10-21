<?php

namespace Publics\Requests\Base;

use Illuminate\Foundation\Http\FormRequest;


class ToolsRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        return [
                'title_fa'=>'required',
                'href'=>'required',
                'order'=>'required',
                'img'=>'required',
              
               
        ];
    }
}
    