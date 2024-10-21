<?php
namespace Models\Edu\LearnPath;

use Illuminate\Database\Eloquent\Model;
use Database\Factories\Edu\LearnPathFactory;
use Models\Traits\Base;

class LearnPath extends Model
{
    use Base;
    
    protected $guarded = ['created_at', 'updated_at', 'deleted_at', 'id'];
    protected $hidden  = ['created_at', 'updated_at', 'deleted_at'];
    protected $dates   = ['deleted_at'];
    protected $table   = 'learnpaths';
    
    public static function factory()
    {
        return LearnPathFactory::new();
    }

    function course()
    {
        return $this->belongsTo(\Models\Edu\Course::class);
    }

    function files()
    {
        return $this->hasMany(File::class, 'learnPath_id');
    }
    function visits()
    {
        return $this->belongsToMany(\Models\Person\Student::class,'learnpath_view_user', 'user_id', 'learnPath_id');

    }
}
