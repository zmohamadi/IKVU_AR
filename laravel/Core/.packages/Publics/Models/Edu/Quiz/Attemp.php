<?php

namespace Models\Edu\Quiz;

use Illuminate\Database\Eloquent\Model;
use Database\Factories\Quiz\AnswerFactory;
use Models\Traits\Base;


class Attemp extends Model
{
    use Base;
    
    protected $guarded = ['updated_at', 'deleted_at', 'id'];
    protected $hidden = [ 'updated_at', 'deleted_at'];
    protected $dates = ['deleted_at'];
    protected $table = 'quiz_attemp';

    public static function factory()
    {
        return AnswerFactory::new();
    }

    public function quiz()
    {
        return $this->belongsTo(Quiz::class, "quiz_id");
    }
    public function student()
    {
        return $this->belongsTo(\Models\Person\Student::class, "user_id");
    }
    public function user()
    {
        return $this->belongsTo(\Models\Person\User::class, "user_id");
    }
    public function course()
    {
        return $this->belongsTo(\Models\Edu\Course::class, "course_id");
    }
    public function answers()
    {
        return $this->hasMany(Answer::class,"quiz_attemp_id");
    }
}
