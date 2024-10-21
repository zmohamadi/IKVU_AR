<?php
namespace Admin\Controllers\Edu;

use Admin\Controllers\Public\BaseAbstract;
use Illuminate\Http\Request;
use Models\Person\Student;
use Models\Edu\OnlineClassroom\Persence;
use Models\Edu\OnlineClassroom\ArchiveFile;

class OnlineClassroomFileController extends BaseAbstract{

    protected $model = "Models\Edu\OnlineClassroom\ArchiveFile";
    protected $request = "Publics\Requests\Edu\Tools\OnlineClassroomFileRequest";

}
