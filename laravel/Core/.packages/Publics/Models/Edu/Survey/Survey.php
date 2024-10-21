<?php
namespace Models\Edu\Survey;

use Illuminate\Database\Eloquent\Model;
use Models\Traits\Base;
use Database\Factories\survey\surveyFactory;

class Survey extends Model
{
    use Base;
    
    protected $guarded = ['created_at', 'updated_at', 'deleted_at', 'id'];
    protected $hidden = ['updated_at', 'deleted_at'];
    protected $dates = ['deleted_at'];
    protected $table = 'surveys';
    protected $casts = [
        'created_at' => 'datetime:d.m.Y H:i',
        // 'start_date' => 'datetime:d.m.Y',
        // 'expire_date' => 'datetime:d.m.Y',
    ];

    public static function factory()
    {
        return surveyFactory::new();
    }
    protected static function booted(): void
    {
        static::deleting(function(survey $survey) { // before delete() method call this        
            $survey->questions->each(function($question) { // before delete() question , delete() of relations
                $question->questionOptions->each(function($option) {
                    $option->forceDelete();
                });
                $question->forceDelete();
            });
            $survey->attemps->each(function($attemp) {
                $attemp->forceDelete();
            });
            $survey->answers->each(function($answer) {
                $answer->forceDelete();
            });
        });
    }

    public function creator()
    {
        return $this->belongsTo(\Models\Person\User::class, 'creator_id');
    }
    public function editor()
    {
        return $this->belongsTo(\Models\Person\User::class, "editor_id");
    }
    public function course()
    {
        return $this->belongsTo(\Models\Edu\Course::class);
    }
    public function questions()
    {
        return $this->hasMany(Question::class,"survey_id");
    }
    // Relations Of Attemp
    public function attemps()
    {
        return $this->hasMany(Attemp::class, 'survey_id');
    }
    public function surveyUsers()
    {
        return $this->belongsToMany(\Models\Person\User::class, 'survey_attemp', 'survey_id', 'user_id');
    }
    // Relations Of Answer
    public function answers()
    {
        return $this->hasMany(Answer::class, 'survey_id');
    }
    public function answerUsers()
    {
        return $this->belongsToMany(\Models\Person\User::class, 'survey_answer', 'survey_id', 'user_id');
    }
    // public function answerAttemps() فعلا لازم نیست!!!
    // {
    //     return $this->belongsToMany(Attemp::class, 'survey_answer', 'survey_id', 'attemp_id');
    // }
    // public function answerQuestions() فعلا لازم نیست!!!
    // {
    //     return $this->belongsToMany(Question::class, 'survey_answer', 'survey_id', 'question_id');
    // }
    // public function answerOptions() فعلا لازم نیست!!!
    // {
    //     return $this->belongsToMany(QuestionOption::class, 'survey_answer', 'survey_id', 'question_option_id');
    // }
}
