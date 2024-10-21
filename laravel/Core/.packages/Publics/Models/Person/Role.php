<?php
namespace Models\Person;

use Illuminate\Database\Eloquent\Model;
use Models\Traits\Base;

class Role extends Model
{
    use Base;

    const ISPERSONNEL = [4,5,6,7,8,9]; // نقش های پرسنل در مدیریت
    const NONPERSONNEL = [1,2,3]; // نقش های غیر پرسنل در پنل کاربری
    const POSTNEEDCHACK = [2]; // نقش هایی که گفتگوهای آنها نیاز به بررسی و تأیید دارد
    const POSTNOTNEEDCHACK = [1,3,4,5,6,7,8,9]; // نقش هایی که گفتگوهای آنها نیاز به بررسی و تأیید ندارد
    const ACCESSOPERATION = [1,3,4,5,6,7,8,9]; // نقش هایی که مجوز و دسترسی به عملیات (جدید،ویرایش،حذف،...) را دارند

    protected $guarded = ['created_at', 'updated_at', 'deleted_at', 'id'];
    protected $hidden  = ['created_at', 'updated_at', 'deleted_at'];
    protected $dates   = ['deleted_at'];
    protected $table   = 'user_roles';

    function users()
    {
        return $this->hasMany(User::class, 'role_id');
    }
    function registers()
    {
        return $this->hasMany(\Models\Edu\Register::class, 'role_id');
    }
}
