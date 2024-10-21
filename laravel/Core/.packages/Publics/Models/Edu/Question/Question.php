<?php
namespace Models\Edu\Question;

use Illuminate\Database\Eloquent\Model;
use Database\Factories\Question\QuestionFactory;
use Database\Factories\Question\Question2Factory;

class Question extends Model
{
    protected $guarded = ['created_at', 'updated_at', 'deleted_at', 'id'];
    protected $hidden  = ['created_at', 'updated_at', 'deleted_at'];
    protected $dates   = ['deleted_at'];
    protected $table   = 'questions';

   
    public static function factory()
    {
        // return QuestionFactory::new();
        return Question2Factory::new();
    }

    public function category()
    {
        return $this->belongsTo(CategoryQuestion::class);
    }

    public function questionOptions() 
    {
        return $this->hasMany(QuestionOption::class);
    }

    public function questionType() 
    {
        return $this->belongsTo(\Models\Base\QuestionType::class, 'question_type_id');
    }

    public function users() 
    {
        return $this->belongsToMany(\Models\Person\User::class, 'answer', 'user_id', 'question_id');
    }

    public function creator()
    {
        return $this->belongsTo(\Models\Person\User::class, 'creator_id');
    }
}