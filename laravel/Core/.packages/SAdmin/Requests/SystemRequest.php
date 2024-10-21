<?php

namespace SAdmin\Requests;

use Illuminate\Foundation\Http\FormRequest;


class SystemRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        $rule = [
            'name'=>'required',
            'title_fa'=>'required',
            'comments'=>'required',
            'type'=>'required',
        ];
        return $rule;
    }
}
