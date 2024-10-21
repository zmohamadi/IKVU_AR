<?php 

namespace Publics\Requests\Edu;

use Illuminate\Foundation\Http\FormRequest;


class CoursePresentedRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        return [
            'teacher_person_id'=>'required',
            // 'assistants'=>'required',
            'start_date' => 'required|regex:/^\d{4}\/\d{2}\/\d{2}$/',
            'end_date' => 'required|regex:/^\d{4}\/\d{2}\/\d{2}$/',

        ];
    }
}
    