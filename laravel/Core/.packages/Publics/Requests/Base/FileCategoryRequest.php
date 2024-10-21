<?php

namespace Publics\Requests\Base;

use Illuminate\Foundation\Http\FormRequest;


class FileCategoryRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        return [
                'title'=>'required',
                'name'=>'required',
                'description'=>'required',
        ];
    }
}
    