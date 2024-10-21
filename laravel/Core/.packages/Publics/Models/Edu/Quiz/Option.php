<?php
namespace Models\Edu\Quiz;

use Illuminate\Database\Eloquent\Model;
use Database\Factories\Quiz\OptionFactory;
use Models\Traits\Base;

class Option extends Model
{
    use Base;
    
    protected $guarded = ['created_at', 'updated_at', 'deleted_at', 'id'];
    protected $hidden  = ['created_at', 'updated_at', 'deleted_at'];
    protected $dates   = ['deleted_at'];
    protected $table   = 'quiz_options';
    
    public static function factory()
    {
        return OptionFactory::new();
    }

    public function question()
    {
        return $this->belongsTo(Question::class, "question_id");
    }
    public function correctOption() 
    {
        return $this->hasOne(Question::class, 'correct_option_id');
    }
}