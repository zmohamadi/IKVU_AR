<?php
namespace Models\Edu;

use Illuminate\Database\Eloquent\Model;
use Database\Factories\Edu\CourseCategoryFactory;
use Models\Traits\Base;

class CourseCategory extends Model
{
    use Base;
    
    protected $guarded = ['created_at', 'updated_at', 'deleted_at', 'id'];
    protected $hidden  = ['created_at', 'updated_at', 'deleted_at'];
    protected $dates   = ['deleted_at'];
    protected $table   = 'course_categories';
    public static function factory()
    {
        return CourseCategoryFactory::new();
    }

    function courses()
    {
        return $this->hasMany(\Models\Edu\Course::class,"category_id");
    }


    public function creator()
    {
        return $this->belongsTo(\Models\Person\User::class, 'creator_id');
    }
    public function editor()
    {
        return $this->belongsTo(\Models\Person\User::class, 'editor_id');
    }
}
