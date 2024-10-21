<?php

namespace SAdmin\Requests;

use Illuminate\Foundation\Http\FormRequest;


class RoleRequest extends FormRequest
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
