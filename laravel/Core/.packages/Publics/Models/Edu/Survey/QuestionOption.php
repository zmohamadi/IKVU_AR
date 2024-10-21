<?php
namespace Models\Edu\Survey;

use Illuminate\Database\Eloquent\Model;
use Database\Factories\Survey\OptionFactory;
use Models\Traits\Base;

class QuestionOption extends Model
{
    use Base;
    protected $guarded = ['created_at', 'updated_at', 'deleted_at', 'id'];
    protected $hidden  = ['created_at', 'updated_at', 'deleted_at'];
    protected $dates   = ['deleted_at'];
    protected $table = 'survey_question_options';

    public static function factory()
    {
        return OptionFactory::new();
    }

    public function question() 
    {
        return $this->belongsTo(Question::class);
    }
    // Relations Of Answer
    public function answers()
    {
        return $this->hasMany(Answer::class, 'question_option_id');
    }
    public function answerUsers()
    {
        return $this->belongsToMany(\Models\Person\User::class, 'survey_answer', 'question_option_id', 'user_id');
    }
    // public function answerAttemps() فعلا لازم نیست!!!
    // {
    //     return $this->belongsToMany(Attemp::class, 'survey_answer', 'question_option_id', 'attemp_id');
    // }
    // public function answerSurveys() فعلا لازم نیست!!!
    // {
    //     return $this->belongsToMany(Survey::class, 'survey_answer', 'question_option_id', 'survey_id');
    // }
    // public function answerQuestions() فعلا لازم نیست!!!
    // {
    //     return $this->belongsToMany(Question::class, 'survey_answer', 'question_option_id', 'question_id');
    // }
}
