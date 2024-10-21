<?php
namespace Models\Edu\Resource;

use Illuminate\Database\Eloquent\Model;
use Models\Traits\Base;
use Database\Factories\Edu\ResourceFactory;

class Resource extends Model
{
    use Base;

    protected $guarded = ['created_at', 'updated_at', 'deleted_at', 'id'];
    protected $hidden  = ['created_at', 'updated_at', 'deleted_at'];
    protected $dates   = ['deleted_at'];
    protected $table   = 'resources';

    // public function __construct(array $attributes = array())
    // {
    //     dd(request()->course);
    //     $this->setRawAttributes(array(
    //       'course_id' => request()->course
    //     ), true);
    //     parent::__construct($attributes);
    // }

    public static function factory()
    {
        return ResourceFactory::new();
    }
    protected static function booted(): void
    {
        static::deleting(function(Resource $resource) { // before delete() method call this        
            $resource->resourceUsers->each(function($users) {
                $users->forceDelete();
            });
        });
    }
    public function fileType()
    {
        return $this->belongsTo(\Models\Base\Type::class, "file_type_id");
    }
    function course()
    {
        return $this->belongsTo(\Models\Edu\Course::class, 'course_id');
    }
    function resourceUsers()
    {
        return $this->hasMany(ResourceUser::class, 'resource_id');
    }
    function users()
    {
        return $this->belongsToMany(\Models\Person\User::class ,'resource_user', 'resource_id', 'user_id');
    }
}
