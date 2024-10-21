<?php
namespace Models\Edu\Forum;

use Illuminate\Database\Eloquent\Model;
use Database\Factories\Forum\ForumFactory;
use Models\Traits\Base;

class Forum extends Model
{
    use Base;
    
    protected $guarded = ['updated_at', 'deleted_at', 'id'];
    protected $hidden  = ['deleted_at'];
    protected $dates   = ['deleted_at'];
    protected $table   = 'forums';
    
    public static function factory()
    {
        return ForumFactory::new();
    }
    protected static function booted(): void
    {
        static::deleting(function(Forum $forum) { // before delete() method call this        
            $forum->posts->delete();
        });
    }
    // public function newQuery($excludeDeleted = true)
    // {
    //     return parent::newQuery($excludeDeleted)->where($this->table.'.lang', \App::getLocale());
    // }
    
    // public function yearSemester() این فیلد ارتباطی ترکیبی می باشد
    // {
    //     return $this->hasOne(\Models\Base\YearSemester::class, "group");
    // }
    public function course()
    {
        return $this->hasOne(\Models\Edu\Course::class, "code");
    }
    public function creator()
    {
        return $this->belongsTo(\Models\Person\User::class, "creator_id");
    }
    public function editor()
    {
        return $this->belongsTo(\Models\Person\User::class, "editor_id");
    }
    public function lastPost() // هر فروم در صورت داشتن موضوع باید آخرین گفتگوی مربوطه را در فیلد last_post_id ثبت کند.
    {
        return $this->belongsTo(Post::class, "last_post_id");
    }
    public function posts() // هر فروم می تواند چند گفتگو داشته باشد.
    {
        return $this->hasMany(Post::class, "forum_id");
    }
    public function uncheckedPosts() // هر فروم می تواند چند گفتگوی بررسی نشده داشته باشد.
    {
        return $this->hasMany(Post::class, "forum_id")->where("type_id", 0);
    }
    public function parentPosts() // هر فروم می تواند چند گفتگوی اصلی یا همان موضوع را داشته باشد.
    {
        return $this->hasMany(Post::class, "forum_id")->where("parent_id", 0);
    }
    public function childPosts() // هر فروم در صورت داشتن موضوع ، می تواند چند گفتگوی سطح 2 داشته باشد.
    {
        return $this->hasMany(Post::class, "forum_id")->where("parent_id", ">", 0);
    }
    /**
     * Scopes
     */
    public function scopeFree($query) // برای یک تالار عمومی بدون وابستگی به درس
    {
        return $query->where('course_id', 0);
    }
    public function scopeNotFree($query) // برای یک تالار خصوصی با وابستگی به درس
    {
        return $query->where('course_id', '>', 0);
    }
    public function scopeHasPostNotCheck($query) // برای یک تالار خصوصی با وابستگی به درس
    {
        return $query->where('count_post_not_check', '>', 0);
    }
    /**
     * Dates
     */
    public function getLastPostAttribute($date)
    {
        if ($date)
        {
            $data = explode("&nbsp", $date);
            $fullName = $data[0];
            $dateTime = $data[1];
            if(\App::getLocale() == "fa")
            {
                $dateTime = new \Verta($dateTime);
                $dateTime = $dateTime->format('Y-m-d H:m:s');
            }
            return $dateTime." ".$fullName;
        }
        else
            return null;
    }
    public function getLastPostGeneralAttribute($date)
    {
        if ($date)
        {
            $data = explode("&nbsp", $date);
            $fullName = $data[0];
            $dateTime = $data[1];
            if(\App::getLocale() == "fa")
            {
                $dateTime = new \Verta($dateTime);
                $dateTime = $dateTime->format('Y-m-d H:m:s');
            }
            return $dateTime." ".$fullName;
        }
        else
            return null;
    }
}
