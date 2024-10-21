<?php

namespace Models\Edu\Survey;

use Illuminate\Database\Eloquent\Model;
use Models\Traits\Base;


class Attemp extends Model
{
    use Base;
    
    protected $guarded = ['updated_at', 'deleted_at', 'id'];
    protected $hidden = [ 'updated_at', 'deleted_at'];
    protected $dates = ['deleted_at'];
    protected $table = 'survey_attemp';

    public function answers()
    {
        return $this->hasMany(Answer::class, 'attemp_id');
    }
    public function survey()
    {
        return $this->belongsTo(Survey::class, 'survey_id');
    }
    public function user()
    {
        return $this->belongsTo(\Models\Person\User::class, 'user_id');
    }
}
