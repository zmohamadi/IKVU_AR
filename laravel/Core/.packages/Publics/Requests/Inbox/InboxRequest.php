<?php 

namespace Publics\Requests\Inbox;

use Illuminate\Foundation\Http\FormRequest;

class InboxRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        $rules =  [
            'title'=>'required',
            'text'=>'required',
            // 'semester'=>'required',
        ];
        // if(request()->semester > 0) $rules['group_code'] = 'required';

        return $rules;

    }
}
    