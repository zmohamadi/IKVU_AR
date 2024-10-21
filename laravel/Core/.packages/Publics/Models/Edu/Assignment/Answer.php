<?php

namespace Models\Edu\Assignment;

use Illuminate\Database\Eloquent\Model;
use Database\Factories\Assignment\AnswerFactory;
use Models\Traits\Base;

class Answer extends Model
{
    use Base;
    
    protected $guarded = ['id']; // محافظت فقط از فیلد id
    protected $hidden  = ['deleted_at']; // حذف soft delete اگر نیازی نیست
    protected $dates   = ['created_at', 'updated_at', 'deleted_at']; // مدیریت تاریخ‌ها
    protected $table = 'assignment_answers';
    
    protected static function booted(): void
    {
        static::deleting(function (Answer $answer) {
            // حذف رکوردها از دیتابیس
            $answer->answerDetails()->delete();
        });
    }
    public static function factory()
    {
        return AnswerFactory::new();
    }
    
    public function assignment()
    {
        return $this->belongsTo(Assignment::class, "assignment_id");
    }
    public function user()
    {
        return $this->belongsTo(\Models\Person\User::class,"user_id");
    }
    public function answerDetails()
    {
        return $this->hasMany(AnswerDetail::class, "answer_id");
    }
    public function users()
    {
        return $this->belongsToMany(\Models\Person\User::class, 'assignment_answers_detail', 'answer_id', 'user_id');
    }
    public function userInfo1()
    {
        return $this->belongsTo(\Models\Person\User::class, "user_id")->select("id","firstname","lastname","gender_id","photo");
    }
}
