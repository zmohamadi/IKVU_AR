<?php
namespace Models\Base;

use Illuminate\Database\Eloquent\Model;

class TotalCount extends Model
{
    public $timestamps = false;
    protected $table   = 'base_counts';
}
