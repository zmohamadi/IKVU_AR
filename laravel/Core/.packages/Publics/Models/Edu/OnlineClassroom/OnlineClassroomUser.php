<?php
namespace Models\Edu\OnlineClassroom;

use Illuminate\Database\Eloquent\Model;
use Database\Factories\Edu\OnlineClassroomFactory;
use Carbon\Carbon;
use Morilog\Jalali\Jalalian;

class OnlineClassroomUser extends Model
{
    
    protected $table   = 'online_classroom_user';
    public $timestamps = true;
    protected $guarded = ['id']; // محافظت فقط از فیلد id
    protected $hidden  = ['deleted_at']; // حذف soft delete اگر نیازی نیست
    protected $dates   = ['created_at', 'updated_at', 'deleted_at']; // مدیریت تاریخ‌ها
   
    // استفاده از Mutator برای تاریخ‌ها
    public function getCreatedAtAttribute($date)
    {
        return Jalalian::fromCarbon(Carbon::parse($date))->format('H:i');    
    }
    // public static function factory()
    // {
    //     return OnlineClassroomUserFactory::new();
    // }

}
