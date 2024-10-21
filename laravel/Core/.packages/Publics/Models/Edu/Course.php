<?php
namespace Models\Edu;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Carbon\Carbon;
use Database\Factories\Edu\CourseFactory;
use Models\Traits\Base;
use Illuminate\Support\Facades\File;

class Course extends Model
{
    use Base;

    const ROLE_TEACHER = 1;
    const ROLE_STUDENT = 2;
    const ROLE_ASSISTANT = 3;

    protected $guarded = ['id']; // محافظت فقط از فیلد id
    protected $hidden  = ['deleted_at']; // حذف soft delete اگر نیازی نیست
    protected $dates   = ['created_at', 'updated_at', 'deleted_at']; // مدیریت تاریخ‌ها
    protected $table   = 'courses';
    protected $primaryKey = 'code';
    public $incrementing = false;

    // استفاده از soft delete آبشاری به‌صورت خودکار
    protected static function booted(): void
    {
        static::deleting(function (Course $course) {
            $course->presenteds()->delete();
            $course->registers()->delete();
            $course->onlineClassrooms()->delete();
            $course->contents()->delete();
            $course->assignments()->delete();
            $course->surveys()->delete();
            $course->quizs()->delete();
            // $course->forumSubjects()->delete();

            // حذف فایل‌های مربوط به دوره
            $courseMediaPath = public_path('media/courses/' . $course->code);

            if (File::exists($courseMediaPath)) {
                File::deleteDirectory($courseMediaPath);
            }
            // حذف فایل thumbnail
            if (!empty($course->thumbnail)) {
                $thumbnailPath = public_path('media/courses/' . $course->thumbnail); // مسیر thumbnail
                if (File::exists($thumbnailPath)) {
                    File::delete($thumbnailPath);
                }
            }
        });
    }

    public static function factory()
    {
        return CourseFactory::new();
    }

    // تعریف روابط
    public function presenteds()
    {
        return $this->hasMany(CoursePresented::class, 'code');
    }

    public function registers()
    {
        return $this->hasMany(Register::class, 'code');
    }

    public function category()
    {
        return $this->belongsTo(CourseCategory::class, 'category_id');
    }

    public function system()
    {
        return $this->belongsTo(\Models\Base\System::class, 'system_id');
    }

    public function onlineClassrooms()
    {
        return $this->hasMany(OnlineClassroom\OnlineClassroom::class, 'course_id');
    }

    public function contents()
    {
        return $this->hasMany(LearnPath\LearnPath::class, 'course_id');
    }

    public function assignments()
    {
        return $this->hasMany(Assignment\Assignment::class, 'course_id');
    }

    public function surveys()
    {
        return $this->hasMany(Survey\Survey::class, 'course_id');
    }

    public function quizs()
    {
        return $this->hasMany(\Models\Edu\Quiz\Quiz::class, 'course_id');
    }

    // public function forumSubjects()
    // {
    //     return $this->hasMany(Forum\Subject::class, 'course_id');
    // }

    public function creator()
    {
        return $this->belongsTo(\Models\Person\User::class, 'creator_id');
    }

    public function editor()
    {
        return $this->belongsTo(\Models\Person\User::class, 'editor_id');
    }

    // استفاده از Mutator برای تاریخ‌ها
    public function getCreatedAtAttribute($date)
    {
        return Carbon::parse($date)->format('d M Y');
    }
    // استفاده از Mutator برای تاریخ‌ها
    public function getUpdatedAtAttribute($date)
    {
        return Carbon::parse($date)->format('d M Y');
    }

    // Scope برای گروه‌ها
    public function scopeWithPresentedsByGroups($query, array $groupCodes)
    {
        return $query->with(['presenteds' => function ($query) use ($groupCodes) {
            $query->where(function ($q) use ($groupCodes) {
                $q->whereIn('group', $groupCodes)
                    ->orWhere('group', 0); // برای همه گروه ها و ترم ها
            })->with('teacher');
        }]);
    }
}
