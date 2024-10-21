<?php
namespace Models\Edu\Forum;

use Illuminate\Database\Eloquent\Model;
use Database\Factories\Forum\PostFactory;
use Models\Traits\Base;

class Post extends Model
{
    use Base;
    
    protected $guarded = ['created_at', 'updated_at', 'deleted_at', 'id'];
    protected $hidden  = ['deleted_at'];
    protected $dates   = ['deleted_at'];
    protected $table   = 'forum_posts';
    protected $casts = [
        'created_at' => 'datetime:d.m.Y H:i',
    ];
    
    public static function factory()
    {
        return PostFactory::new();
    }
    protected static function booted(): void
    {
        static::deleting(function(Post $post) { // before delete() method call this        
            // حذف فایل‌های مرتبط از دیتابیس و حذف فیزیکی فایل‌ها
            foreach ($post->attachments as $attachment) {
                $filePath = public_path('media/forum/' . $file->name);
                if (File::exists($filePath)) {
                    File::delete($filePath);
                }
            }
            // $post->childs->forceDelete();
            $post->childs->delete();
            $post->attachments->delete();
            $post->likes->delete();
        });
    }
    /**
     * رکوردهایی که parent_id=0 می باشد
     * موضوع تالار محسوب می شوند
     * که فیلد title آن ها خالی نباید باشد.
     */
    public function parent() // هر گفتگویی فقط می تواند در یک گروه موضوعی ثبت شود
    {
        return $this->belongsTo(Post::class, "parent_id");
    }
    public function childs() //  هر گفتگویی می تواند چند گفتگو را در گروه موضوعی خود داشته باشد
    {
        return $this->hasMany(Post::class, "parent_id");
    }
    public function uncheckedChilds() // گفتگوهای سطح 2 که هنوز بررسی نشده اند
    {
        return $this->hasMany(Post::class, "parent_id")->where("type_id", 0);
    }
    public function replys() // هر گفتگو می تواند چند پاسخ داشته باشد
    {
        return $this->hasMany(Post::class, "reply_to");
    }
    public function parentReply() // هر گفتگو می تواند پاسخ یک گفتگوی دیگر باشد یا نباشد
    {
        return $this->belongsTo(Post::class, "reply_to");
    }
    public function lastPost() // هر گفتگوی والد(اولین پیام یک موضوع) ک فیلد parent_id=0 است ، آخرین پیام آن گروه موضوعی در فیلد last_post_id ثبت می شود
    {
        return $this->belongsTo(Post::class, "last_post_id");
    }
    public function parentLastPost() // هر گفتگویی که آخرین پیام گروه موضوعی خود باشد حتما در رکورد والد ثبت می شود.
    {
        return $this->hasOne(Forum::class, "last_post_id");
    }
    public function forum() // هر گفتگویی فقط با یک فروم ارتباط دارد
    {
        return $this->belongsTo(Forum::class, "forum_id");
    }
    public function lastPostForum() // هر گفتگویی می تواند آخرین گفتگوی فروم خود باشد ک در فیلد last_post_id ثبت می شود
    {
        return $this->hasOne(Forum::class, "last_post_id");
    }
    public function sender() // هر گفتگو فقط توسط یک کاربر ثبت و ارسال می شود
    {
        return $this->belongsTo(\Models\Person\User::class, "sender_id");
    }
    public function type() // هر گفتگو، فقط یک وضعیت برای نمایش دارد (نیاز به بررسی،عمومی،خصوصی،رد)
    {
        return $this->belongsTo(\Models\Base\Status::class, 'type_id', 'code')->where('group_id', '4');
    }
    public function attachments() // هر گفتگو می تواند چند فایل،عکس،... در پیام خود آپلود کند
    {
        return $this->hasMany(Attachment::class, "post_id");
    }
    public function likes() // هر گفتگو برای هر کاربر فقط یک عملیات like | dislike را دارد.
    {
        return $this->hasMany(Like::class, 'post_id');
    }
    public function users() // هر گفتگو می تواند توسط چند کاربر عملیات like,dislike را داشته باشد.
    {
        return $this->belongsToMany(\Models\Person\User::class, 'forum_likes', 'post_id', 'user_id');
    }
    // public function likeTypes() // فعلا لازم نیست!!!
    // {
    //     return $this->belongsToMany(\Models\Base\Status::class, 'forum_likes', 'post_id', 'like_type_id');
    // }
    /**
     * Scopes
     */
    public function scopeAllOnePost($query, $forum, $post="")
    {
        return $query->where('parent_id', $post)->orWhere('id', $post);
        // return $query->where('forum_id', $forum)->where('parent_id', $post)->orWhere('id', $post);
        // return $query->find($post)->orWhere(function($q) use($forum, $post){$q->where('forum_id', $forum)->where('parent_id', $post);});
    }
    public function scopeStarterPost($query, $forum)
    {
        return $query->where('parent_id', 0)->where('forum_id', $forum);
    }
    public function scopeSubjects($query) // موضوعات
    {
        return $query->where('parent_id', 0);
    }
    public function scopeSubjectPosts($query) // پاسخ های موضوعات
    {
        return $query->where('parent_id', ">", 0);
    }
    public function scopeNeedCheck($query) // پیام های نیاز به بررسی
    {
        return $query->where('type_id', 0);
    }
    public function scopChecked($query) // پیام های بررسی شده
    {
        return $query->where('type_id', '>', 0);
    }
    public function scopePublic($query) // پیام های بررسی شده و در وضعیت عمومی
    {
        return $query->where('type_id', 1);
    }
    public function scopePrivate($query) // پیام های بررسی شده و در وضعیت خصوصی
    {
        return $query->where('type_id', 2);
    }
    public function scopeRejected($query)  // پیام های بررسی شده و در وضعیت رد شده
    {
        return $query->where('type_id', 3);
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
            return $dateTime."<br/>توسط&nbsp".$fullName;
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
            return $dateTime."<br/>توسط&nbsp".$fullName;
        }
        else
            return null;
    }
}
