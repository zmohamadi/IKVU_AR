<?php 

namespace Publics\Requests\Inbox;

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
        return  [
            'reply'=>'required',
        ];
    }
}
    