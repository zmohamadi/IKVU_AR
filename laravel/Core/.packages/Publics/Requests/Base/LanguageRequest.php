<?php

namespace Publics\Requests\Base;

use Illuminate\Foundation\Http\FormRequest;


class LanguageRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        return [
            'title'=>'required',
            'symbol'=>'required|alpha|max:2',
            'dir'=>'required|alpha|max:3',
            'currency'=>'required',
        ];
    }
}
