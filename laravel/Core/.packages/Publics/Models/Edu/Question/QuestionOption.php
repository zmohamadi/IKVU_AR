<?php
namespace Models\Edu\Question;

use Illuminate\Database\Eloquent\Model;
use Database\Factories\Question\OptionFactory;

class QuestionOption extends Model
{
    protected $guarded = ['created_at', 'updated_at', 'deleted_at', 'id'];
    protected $hidden  = ['created_at', 'updated_at', 'deleted_at'];
    protected $dates   = ['deleted_at'];
    protected $table   = 'question_options';

    public static function factory()
    {
        return OptionFactory::new();
    }

    public function question() 
    {
        return $this->belongsTo(Question::class);
    }
}
