<?php

namespace Models\Edu\Assignment;

use Illuminate\Database\Eloquent\Model;
use Database\Factories\Assignment\AnswerDetailFactory;
use Models\Traits\Base;
use Illuminate\Support\Facades\File;

class AnswerDetail extends Model
{
    use Base;
    
    protected $guarded = ['id']; // محافظت فقط از فیلد id
    protected $hidden  = ['deleted_at']; // حذف soft delete اگر نیازی نیست
    protected $dates   = ['created_at', 'updated_at', 'deleted_at']; // مدیریت تاریخ‌ها
    protected $table = 'assignment_answers_detail';
    
    protected static function booted(): void
    {
        static::deleting(function (AnswerDetail $answer) {
            //
        });
    }
    public static function factory()
    {
        return AnswerDetailFactory::new();
    }

    public function option()
    {
        return $this->belongsTo(Option::class,"answer_option_id");
    }
    public function answer()
    {
        return $this->belongsTo(Answer::class, "answer_id");
    }
    public function user()
    {
        return $this->belongsTo(\Models\Person\User::class, "user_id");
    }
    public function userInfo1()
    {
        return $this->belongsTo(\Models\Person\User::class, "user_id")->select("id","firstname","lastname","gender_id","photo");
    }
}
