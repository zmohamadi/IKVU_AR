<?php
namespace Models\Edu\Forum;

use Illuminate\Database\Eloquent\Model;
use Database\Factories\Forum\LikeFactory;
use Models\Traits\Base;

class Like extends Model
{
    use Base;
    
    protected $guarded = ['created_at', 'updated_at', 'deleted_at', 'id'];
    protected $hidden  = ['created_at', 'updated_at', 'deleted_at'];
    protected $dates   = ['deleted_at'];
    protected $table   = 'forum_likes';

    public static function factory()
    {
        return LikeFactory::new();
    }

    public function user()
    {
        return $this->belongsTo(\Models\Person\User::class, "user_id");
    }
    public function post()
    {
        return $this->belongsTo(Post::class, "post_id");
    }
    public function likeType()
    {
        return $this->belongsTo(\Models\Base\Status::class, "like_type_id");
    }
}
