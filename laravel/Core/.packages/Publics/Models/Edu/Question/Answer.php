<?php
namespace Models\Edu\Question;

use Illuminate\Database\Eloquent\Model;
use Database\Factories\Assignment\AnswerFactory;

class Answer extends Model
{
    protected $guarded = ['created_at', 'updated_at', 'deleted_at', 'id'];
    protected $hidden  = ['created_at', 'updated_at', 'deleted_at'];
    protected $dates   = ['deleted_at'];
    protected $table   = 'question_answers';

    public static function factory()
    {
        return AnswerFactory::new();
    }

    public function category()
    {
        return $this->belongsTo(CategoryQuestion::class);
    }

    public function student()
    {
        return $this->belongsTo(\Models\Person\Student::class,"user_id");
    }
    public function user()
    {
        return $this->belongsTo(\Models\Person\User::class,"user_id");
    }

    public function course()
    {
        return $this->belongsTo(\Models\Edu\Course::class);
    }
}