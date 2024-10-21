<?php
namespace Models\Edu\Assignment;

use Illuminate\Database\Eloquent\Model;
use Database\Factories\Assignment\AssignmentFactory;
use Models\Traits\Base;

class Assignment extends Model
{
    use Base;

    protected $guarded = ['id']; // محافظت فقط از فیلد id
    protected $hidden  = ['deleted_at']; // حذف soft delete اگر نیازی نیست
    protected $dates   = ['created_at', 'updated_at', 'deleted_at']; // مدیریت تاریخ‌ها
    protected $table   = 'assignments';
    protected $casts = ['created_at' => 'datetime:d-m-Y H:i'];

     // استفاده از soft delete آبشاری به‌صورت خودکار
     protected static function booted(): void
    {
        static::deleting(function (Assignment $recode) {
            $recode->options()->delete();
            $recode->answers()->delete();
        });
    }

    public static function factory()
    {
        return AssignmentFactory::new();
    }

    public function course()
    {
        return $this->belongsTo(\Models\Edu\Course::class, 'course_id');
    }
    public function options()
    {
        return $this->hasMany(Option::class,"assignment_id");
    }
    public function correctOption()
    {
        return $this->hasOne(Option::class,"correct_option_id");
    }
    public function answers()
    {
        return $this->hasMany(Answer::class,"assignment_id");
    }
    public function users()
    {
        return $this->belongsToMany(\Models\Person\User::class, 'assignment_answers', 'assignment_id', 'user_id');
    }
    
    public function questionType() 
    {
        return $this->belongsTo(\Models\Base\QuestionType::class, 'question_type_id');
    }
    // public function yearSemester() این فیلد ارتباطی ترکیبی می باشد
    // {
    //     return $this->hasOne(\Models\Base\YearSemester::class, "group");
    // }
    public function creator()
    {
        return $this->belongsTo(\Models\Person\User::class, 'creator_id');
    }
    public function editor()
    {
        return $this->belongsTo(\Models\Person\User::class, 'editor_id');
    }
}
