<?php

namespace Publics\Requests\Base;

use Illuminate\Foundation\Http\FormRequest;


class TypeRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        return [
                'title_fa'=>'required',
                // 'title_en'=>'required',
                // 'title_ar'=>'required',
                'description'=>'required',
        ];
    }
}
    