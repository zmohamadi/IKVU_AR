<?php 

namespace Publics\Requests\Person;

use Illuminate\Foundation\Http\FormRequest;

class RoleRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        return [
            'title_'.\Config::get("app.locale")=>'required',
            // 'title_en'=>'required',
        ];
    }
}
    