<?php 

namespace Publics\Requests\Assignment;

use Illuminate\Foundation\Http\FormRequest;
use Publics\Controllers\Tools;


class ReplyRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        $assignment =  [
            'response'=>'required',
        ];
        return $assignment;
    }
}
    