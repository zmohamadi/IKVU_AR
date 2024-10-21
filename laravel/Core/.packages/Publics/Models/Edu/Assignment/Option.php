<?php
namespace Models\Edu\Assignment;

use Illuminate\Database\Eloquent\Model;
use Database\Factories\Assignment\OptionFactory;
use Models\Traits\Base;

class Option extends Model
{
    use Base;
    
    protected $guarded = ['created_at', 'updated_at', 'deleted_at', 'id'];
    protected $hidden  = ['created_at', 'updated_at', 'deleted_at'];
    protected $dates   = ['deleted_at'];
    protected $table   = 'assignment_options';
    
    public static function factory()
    {
        return OptionFactory::new();
    }
    public function assignment()
    {
        return $this->belongsTo(Assignment::class, "assignment_id");
    }
    public function correctOption() 
    {
        return $this->hasOne(Assignment::class, 'correct_option_id');
    }
}
