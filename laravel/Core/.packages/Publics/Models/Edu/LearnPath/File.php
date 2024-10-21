<?php
namespace Models\Edu\LearnPath;

use Illuminate\Database\Eloquent\Model;
use Models\Traits\Base;

class File extends Model
{
    use Base;

    protected $guarded = ['created_at', 'updated_at', 'deleted_at', 'id'];
    protected $hidden  = ['created_at', 'updated_at', 'deleted_at'];
    protected $dates   = ['deleted_at'];
    protected $table   = 'learnpaths_files';

}
