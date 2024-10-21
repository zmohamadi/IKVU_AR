<?php
namespace Models\Edu\Question;

use Illuminate\Database\Eloquent\Model;
use Models\Traits\Base;
use Database\Factories\Question\QuestionFactory;
use Database\Factories\Assignment\AssignmentFactory;


class CategoryQuestion extends Model
{
    use Base;
    
    protected $guarded = ['created_at', 'updated_at', 'deleted_at', 'id'];
    protected $hidden = ['updated_at', 'deleted_at'];
    protected $dates = ['deleted_at'];
    protected $table = 'question_course-categories';
    protected $casts = [
        'created_at' => 'datetime:d.m.Y H:i',
        // 'start_date' => 'datetime:d.m.Y',
        // 'expire_date' => 'datetime:d.m.Y',
    ];

    public static function factory()
    {
        return AssignmentFactory::new();
    }


    function answers()
    {
        return $this->hasMany(Answer::class, 'category_id');
    }
    function userAnswers()
    {
        return $this->belongsToMany(QuestionAnswer::class, "edu_question_answers",'category_id',"user_id");

    }

    public function questions()
    {
        return $this->hasMany(Question::class,"category_id");
    }

    public function course()
    {
        return $this->belongsTo(\Models\Edu\Course::class);
    }

    public function creator()
    {
        return $this->belongsTo(\Models\Person\User::class, 'creator_id');
    }

}
