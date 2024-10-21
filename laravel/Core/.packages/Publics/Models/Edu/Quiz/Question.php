<?php
namespace Models\Edu\Quiz;

use Illuminate\Database\Eloquent\Model;
use Database\Factories\Quiz\QuestionFactory;
use Models\Traits\Base;

class Question extends Model
{
    use Base;
    const TYPE = [
        'text' => 1,
        'option' => 2,
    ];
    protected $guarded = ['created_at', 'updated_at', 'deleted_at', 'id'];
    protected $hidden  = ['created_at', 'updated_at', 'deleted_at'];
    protected $dates   = ['deleted_at'];
    protected $table   = 'quiz_questions';
    
    protected static function booted(): void
    {
        // parent::booted();
        static::deleted(function (Question $question) {
            foreach($question->questionOptions as $questionOption){
              $questionOption->delete();
            }
        });
    }
    
    public static function factory()
    {
        return QuestionFactory::new();
    }

    public function questionOptions() 
    {
        return $this->hasMany(Option::class, 'question_id');
    }
    public function correctOption() 
    {
        return $this->belongsTo(Option::class, 'correct_option_id');
    }
    public function questionType() 
    {
        return $this->belongsTo(\Models\Base\QuestionType::class, 'question_type_id');
    }
    function userAnswers()
    {
        return $this->belongsToMany(\Models\Person\User::class, "edu_quiz_answer", 'question_id', "user_id");
    }
    function answers()
    {
        return $this->hasMany(Answer::class, 'question_id');
    }
}
