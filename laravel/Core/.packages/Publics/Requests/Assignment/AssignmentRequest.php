<?php 

namespace Publics\Requests\Assignment;

use Illuminate\Foundation\Http\FormRequest;
use Publics\Controllers\Tools;


class AssignmentRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        $assignment =  [
            'title'=>'required',
            'semester'=>'required',
            'description'=>'required',
            'score'=>'required',
            'question_type_id'=>'required',
            'start_date'=>'required',
            'expire_date'=>'required|after:'.request()->start_date,
        ];
        if(request()->semester > 0) $assignment['group_code'] = 'required';
        if(request()->selectFor == 2) $assignment['students'] = 'required';

        return $assignment;
    }
}
    