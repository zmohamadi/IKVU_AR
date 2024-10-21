<?php

namespace Publics\Requests\Base;

use Illuminate\Foundation\Http\FormRequest;


class YearSemesterRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        return [
                'year' => 'required|regex:/^\d{4}$/',
                'semester' => 'required|in:1,2,3',
                'start_date' =>'required|regex:/^\d{4}\/\d{2}\/\d{2}$/',
                'end_date' => 'required|regex:/^\d{4}\/\d{2}\/\d{2}$/',
                // 'current' => 'required',
        ];
    }
}
    