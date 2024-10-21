<?php
namespace Models\Edu\Question;

use Illuminate\Database\Eloquent\Model;
use Database\Factories\Assignment\AssignmentAnswerFactory;
use Models\Traits\Base;

class QuestionAnswer extends Model
{
    use Base;

    protected $guarded = ['created_at', 'updated_at', 'deleted_at', 'id'];
    protected $hidden = ['created_at', 'updated_at', 'deleted_at'];
    protected $dates = ['deleted_at'];
    protected $table = 'question_answers';

    public static function factory()
    {
        return AssignmentAnswerFactory::new();
    }

}
