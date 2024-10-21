<?php 

namespace Publics\Requests\Edu\Tools;

use Illuminate\Foundation\Http\FormRequest;


class LearnPathRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        $rules =  [
            'title'=>'required',
            'description'=>'required',
            // 'duration'=>'required',
            'image_pdf'=>'required',
            // 'audio'=>'required_without:video',
            // 'video'=>'required_without:audio',
        ];

        return $rules;
    }
}
    