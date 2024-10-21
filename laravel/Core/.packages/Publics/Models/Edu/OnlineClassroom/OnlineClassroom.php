<?php
namespace Models\Edu\OnlineClassroom;

use Illuminate\Database\Eloquent\Model;
use Database\Factories\Edu\OnlineClassroomFactory;
use Models\Traits\Base;

class OnlineClassroom extends Model
{
    use Base;
    
    protected $guarded = ['id']; // محافظت فقط از فیلد id
    protected $hidden  = ['deleted_at']; // حذف soft delete اگر نیازی نیست
    protected $dates   = ['created_at', 'updated_at', 'deleted_at']; // مدیریت تاریخ‌ها
    protected $table   = 'online_classrooms';

     // استفاده از soft delete آبشاری به‌صورت خودکار
     protected static function booted(): void
    {
        static::deleting(function (OnlineClassroom $recode) {
        $recode->files()->delete();
            
        });
    }

     
    public static function factory()
    {
        return OnlineClassroomFactory::new();
    }

    function files()
    {
        return $this->hasMany(ArchiveFile::class);
    }

    function course()
    {
        return $this->belongsTo(\Models\Edu\Course::class, "course_id");
    }
    public function canceledClass()
    {
        return $this->hasOne(OnlineClassCanceled::class, 'online_classroom_id');
    }

    function students()
    {
        return $this->belongsToMany(\Models\Person\Student::class ,'online_classroom_user', 'onlineClassroom_id', 'user_id');
    }
    public function creator()
    {
        return $this->belongsTo(\Models\Person\User::class, 'creator_id');
    }
    public function editor()
    {
        return $this->belongsTo(\Models\Person\User::class, 'editor_id');
    }

}
