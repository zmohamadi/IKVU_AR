<?php

namespace SAdmin\Requests;

use Illuminate\Foundation\Http\FormRequest;


class MenuRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        $rule = [
            'title'=>'required',
        ];
        return $rule;
    }
}
