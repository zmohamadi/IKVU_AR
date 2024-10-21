<?php
namespace Models\Edu\Survey;

use Illuminate\Database\Eloquent\Model;
use Database\Factories\Survey\QuestionFactory;
use Database\Factories\Survey\Question2Factory;

class Question extends Model
{
    protected $guarded = ['created_at', 'updated_at', 'deleted_at', 'id'];
    protected $hidden  = ['created_at', 'updated_at', 'deleted_at'];
    protected $dates   = ['deleted_at'];
    protected $table = 'survey_questions';

    public static function factory()
    {
        // return QuestionFactory::new();
        return Question2Factory::new();
    }

    public function survey() 
    {
        return $this->belongsTo(Survey::class);
    }
    public function questionOptions() 
    {
        return $this->hasMany(QuestionOption::class);
    }
    public function questionType() 
    {
        return $this->belongsTo(\Models\Base\QuestionType::class, 'question_type_id');
    }    
    // Relations Of Answer
    public function answers()
    {
        return $this->hasMany(Answer::class, 'question_id');
    }
    public function answerUsers()
    {
        return $this->belongsToMany(\Models\Person\User::class, 'survey_answer', 'question_id', 'user_id');
    }
    // public function answerAttemps() فعلا لازم نیست!!!
    // {
    //     return $this->belongsToMany(Attemp::class, 'survey_answer', 'question_id', 'attemp_id');
    // }
    // public function answerSurveys() فعلا لازم نیست!!!
    // {
    //     return $this->belongsToMany(Survey::class, 'survey_answer', 'question_id', 'survey_id');
    // }
    // public function answerOptions() فعلا لازم نیست!!!
    // {
    //     return $this->belongsToMany(QuestionOption::class, 'survey_answer', 'question_id', 'question_option_id');
    // }
}