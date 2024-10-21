<?php 

namespace Publics\Requests\EduTools;

use Illuminate\Foundation\Http\FormRequest;
use Publics\Controllers\Tools;

class SurveyRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        $rules =  [
            'title'=>'required',
            'semester'=>'required',
            'start_date'=>'required',
            'expire_date'=>'required|after:'.request()->start_date,
        ];
        if(request()->semester > 0)
            $rules['group_code'] = 'required';

        $tools = new Tools;
        $questions = $tools->getRepeatValues(["question"]);
        foreach ($questions as $key=>$item) {
            $rules['order_'.$key] = 'required|integer';
        }
        return $rules;
    }
}