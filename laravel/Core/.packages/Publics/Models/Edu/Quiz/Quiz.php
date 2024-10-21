<?php
namespace Models\Edu\Quiz;

use Illuminate\Database\Eloquent\Model;
use Database\Factories\Quiz\QuizFactory;
use Models\Traits\Base;

class Quiz extends Model
{
    use Base;
    const TYPE = [
        'text' => 1,
        'option' => 2,
    ];
    protected $guarded = ['created_at', 'updated_at', 'deleted_at', 'id'];
    protected $hidden  = ['updated_at', 'deleted_at'];
    protected $dates   = ['deleted_at'];
    protected $table   = 'quizs';
    
    public static function factory()
    {
        return QuizFactory::new();
    }

    public function course()
    {
        return $this->belongsTo(\Models\Edu\Course::class, 'course_id');
    }
    
    public function questions()
    {
        return $this->hasMany(Question::class,"quiz_id");
    }

    function userAttemps()
    {
        return $this->belongsToMany(\Models\Person\User::class, "edu_quiz_attemp",'quiz_id',"user_id");
    }

    function attemps()
    {
        return $this->hasMany(Attemp::class, 'quiz_id');
    }

    public function creator()
    {
        return $this->belongsTo(\Models\Person\User::class, 'creator_id');
    }

    public function editor()
    {
        return $this->belongsTo(\Models\Person\User::class, 'editor_id');
    }
    // public function getCreatedAtAttribute($date)
    // {
    //     return \Carbon\Carbon::parse($date)->format('d M Y');
    // }
    
}
