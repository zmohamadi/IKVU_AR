<?php
namespace Models\Edu\Survey;

use Illuminate\Database\Eloquent\Model;

class Answer extends Model
{
    protected $guarded = ['created_at', 'updated_at', 'deleted_at', 'id'];
    protected $hidden  = ['created_at', 'updated_at', 'deleted_at'];
    protected $dates   = ['deleted_at'];
    protected $table = 'survey_answer';

    public function attemp()
    {
        return $this->belongsTo(Attemp::class, 'attemp_id');
    }
}