<?php

namespace Models\Edu\Quiz;

use Illuminate\Database\Eloquent\Model;
use Database\Factories\Quiz\AnswerFactory;
use Models\Traits\Base;


class Answer extends Model
{
    use Base;
    
    protected $guarded = ['updated_at', 'deleted_at', 'id'];
    protected $hidden = [ 'updated_at', 'deleted_at'];
    protected $dates = ['deleted_at'];
    protected $table = 'quiz_answer';

    public static function factory()
    {
        return AnswerFactory::new();
    }

    public function question()
    {
        return $this->belongsTo(Question::class, "question_id");
    }
    public function student()
    {
        return $this->belongsTo(\Models\Person\Student::class,"user_id");
    }
    public function attemp()
    {
        return $this->belongsTo(Attemp::class,"quiz_attemp_id");
    }
}
