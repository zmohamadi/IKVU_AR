<?php 

namespace Publics\Requests\Quiz;

use Illuminate\Foundation\Http\FormRequest;
use Publics\Controllers\Tools;

class QuizRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        $rules =  [
            'title'=>'required',
            'start_date'=>'required',
            'start_time'=>'required',
            'semester'=>'required',
        ];
        if(request()->semester > 0) $rules['group_code'] = 'required';
        
        $tools = new Tools;
        $questions = $tools->getRepeatValues(["question"]);
        foreach ($questions as $key=>$item) {
            $rules['score_'.$key] = 'required';
            $rules['order_'.$key] = 'required|integer';
            $rules['qTypes_'.$key] = 'required';
            if(request()['qTypes_'.$key]==2)   $rules['correctOption_'.$key] = 'required';
        }
        return $rules;
    }
}