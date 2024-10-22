<?php

use Illuminate\Support\Facades\Route;
// use Morilog\Jalali\Jalalian;

Route::get('/user',"Auth\UserInfo@getInfo");
Route::post('/login',"Auth\AuthenticatedController@store");
Route::post('/logout',"Auth\AuthenticatedController@destroy");

Route::get('/bbb/{sid}', "Edu\BBBController@join");
Route::get('/changepass',function(){
    // dd(Morilog\Jalali\Jalalian::fromCarbon(\Carbon\Carbon::now())->format('Y/m/d H:i'));
    $students = Models\Person\Student::get();
    foreach($students as $user){
        $user->password = bcrypt($user->mobile);
        $user->save();
    }
});

Route::get('/langs',function(){
    $objects = [
        "public"=>\Lang::get("AdminLang::public"),
        'local'=>\Config::get("app.locale"),
        'langs'=> \Models\Base\Language::where('status_id', 1)->get()];
    return response()->json($objects);
});

Route::get('/users-info',function(){
    $students = Models\Person\Student::get();
    dd($students);
});


// ================ Start Routes Uploads =======================================
Route::post('tinyUpload/{dir}', 'Public\Upload@tinyUpload');
Route::post('upload/{dir}', 'Public\Upload@uploadFile');
Route::post('ckupload/{dir}', 'Public\Upload@ckUpload');
Route::get('deleteFile/{dir}/{file}', 'Public\Upload@deleteFile');
// ================ End Routes Uploads =========================================

// Route::resource('/users',"Users");    
// Route::resource('/groups', "Groups");
// Route::resource('/forums', "Forums");

Route::get('/home', 'Base\HomeController@home');
// ================ Start Routes Courses =========================================

Route::get("courses/change-tools/{id}/{tools}", "Edu\CourseController@changeTools");
Route::get("courses/tools/{id}", "Edu\CourseController@tools");
Route::get("courses/report-card/{course}/{stu}", "Edu\CourseController@reportCard");
Route::get("courses/change-status/get-needles", "Edu\CourseController@changeStatusGetNeedles");
Route::post("courses/change-status/{course}/{stu}", "Edu\CourseController@changeStatus");
Route::get("courses/get-needles", "Edu\CourseController@getNeedles");
Route::get("courses/list", "Edu\CourseController@list");
Route::resource("courses", "Edu\CourseController");
Route::resource("categories", "Edu\CourseCategoryController");

Route::get("present/get-needles", "Edu\PresentController@getNeedles");
Route::resource("present", "Edu\PresentController");

// Route::post("goToClass/{id}", "Edu\OnlineClassroomController@goToClass");

Route::get("search-student/{student}/{course}", "Edu\ClassController@searchStudent");
Route::get("classes/{id}/students", "Edu\ClassController@students");
Route::post("classes/{id}/students/new", "Edu\ClassController@newStudent");
Route::delete("classes/{id}/students/delete/{sid}", "Edu\ClassController@deleteStudent");
Route::get("classes/get-needles", "Edu\ClassController@getNeedles");
Route::resource("classes", "Edu\ClassController");
// ================ Start Routes Tools Course =========================================
// Route::get("onlineClassroom-mainList", "Edu\OnlineClassroomController@mainList");

Route::put("onlineClassroom/{id}/canceledInsert", "Edu\OnlineClassroomController@canceledInsert");
Route::put("onlineClassroom/{id}/canceledRemove", "Edu\OnlineClassroomController@canceledRemove");

Route::post("onlineClassroom/excel", "Edu\OnlineClassroomController@importExcel");
Route::get("onlineClassroom/{id}/archives", "Edu\OnlineClassroomController@archives");
Route::get("onlineClassroom/{id}/students", "Edu\OnlineClassroomController@students");
Route::get("onlineClassroom-list/{id}", "Edu\OnlineClassroomController@list");
Route::get("onlineClassrooms/get-needles", "Edu\OnlineClassroomController@getNeedles");
Route::resource("onlineClassrooms", "Edu\OnlineClassroomController");
Route::resource("onlineClassroom-files", "Edu\OnlineClassroomFileController");

Route::get("/assignment/reply-info/{id}", "Edu\AssignmentController@replyInfo");
Route::put("/assignment/reply/{id}", "Edu\AssignmentController@reply");
Route::put("/assignments-answer/visit-reply", "Edu\AssignmentController@setSeeing");
Route::put("/assignments-answer/{id}/{user}/num", "Edu\AssignmentController@setScore");
Route::put("/assignments-answer/{id}/{user}/text", "Edu\AssignmentController@setReply");
Route::get("/assignments-answer/{id}/{user}", "Edu\AssignmentController@getAnswer");
Route::get("assignment-list/{id}", "Edu\AssignmentController@list");
Route::get("assignment-answers/{toolsId}", "Edu\AssignmentController@answers");
Route::put("assignment-correcting/{tools}/{toolsId}", "Edu\AssignmentController@correcting");

Route::get("assignments/get-students", "Edu\AssignmentController@getStudents");
Route::get("assignments/get-needles", "Edu\AssignmentController@getNeedles");
Route::resource("assignments", "Edu\AssignmentController");

Route::get("content-visited/{id}", "Edu\LearnPathController@visits");
Route::get("content-list/{id}", "Edu\LearnPathController@list");
Route::get("contents/get-needles", "Edu\LearnPathController@getNeedles");
Route::resource("contents", "Edu\LearnPathController");

Route::get("/survey/get-users/{id}", "EduTools\SurveyController@getUsers");
Route::get("/survey/reply-info/{id}", "EduTools\SurveyController@replyInfo");
Route::post("/survey/reply-save/{id}", "EduTools\SurveyController@replySave");
Route::get("/survey/get-needles", "EduTools\SurveyController@getNeedles");
Route::get("/survey-list/{course}", "EduTools\SurveyController@list");
Route::resource("survey", "EduTools\SurveyController");

Route::put("/quiz-correcting/{tools}/{toolsId}", "Edu\AssignmentController@correcting");
Route::put("/quiz-attemp/{attempId}", "Quiz\QuizController@setAttemp");
Route::get("/quiz-attemp/{attempId}", "Quiz\QuizController@getAttemp");
Route::get("/quiz-answers/{toolsId}", "Quiz\QuizController@answers");
Route::get("/quiz-mainList", "Quiz\QuizController@mainList");
Route::get("/quiz-list/{id}", "Quiz\QuizController@list");
Route::get("/quiz/get-needles", "Quiz\QuizController@getNeedles");
Route::resource("quiz", "Quiz\QuizController");

Route::post("/quiz/reply/{id}", "Quiz\ReplyController@reply");
Route::get("/quiz/attemp/{id}", "Quiz\ReplyController@attemp");

Route::put("/posts-update/change-status/{id}", "EduTools\PostController@updateStatus");
Route::get("/posts-status", "EduTools\PostController@getStatus");
Route::get("/forum/posts-need-check", "EduTools\ForumController@listNeedCheck");
Route::get("/forum/report", "EduTools\ForumController@reportForum");

Route::post("/posts-action/{id}", "EduTools\PostController@saveAction");
Route::get("/posts-reply", "EduTools\PostController@getRely");
Route::get("/posts", "EduTools\PostController@list");
Route::resource("/posts", "EduTools\PostController")->except(['index']);

Route::get("/forum/get-needles", "EduTools\ForumController@getNeedles");
Route::get("/forum/show-info/{id}", "EduTools\ForumController@showInfo");
Route::get("/forum-list", "EduTools\ForumController@list");
Route::resource("/forum", "EduTools\ForumController");

Route::get("/inbox/reply-info/{id}", "Edu\InboxController@replyInfo");
Route::put("/inbox/reply/{id}", "Edu\InboxController@reply");
// Route::get("inbox/get-needles/{id}", "Edu\InboxController@getNeedle");
Route::get("inbox/get-needles", "Edu\InboxController@getNeedle");
Route::get("inbox-list/{id}", "Edu\InboxController@list");
Route::resource("inbox", "Edu\InboxController");
// ================ Start Routes Base =========================================

Route::resource("keywords","Base\KeywordController");
Route::get("getCurrentSemester", "Base\YearSemesterController@getCurrentSemester");
Route::resource("yearSemesters","Base\YearSemesterController");
Route::resource("systems","Base\SystemController");
Route::get("baseTools/list", "Base\ToolsController@list");
Route::resource("baseTools","Base\ToolsController");
Route::resource("questionTypes","Base\QuestionTypeController");

// ================ Start Routes Users ==========================================
Route::get("myTeachers", "Person\TeacherController@myTeachers");

Route::get("users/change-status/get-needles", "Person\UserController@changeRoleGetNeedles");
Route::post("users/change-status/{id}", "Person\UserController@changeRole");
Route::put("users/change-password", "Person\UserController@changePassword");

Route::put("users/edit-email/{id}", "Person\UserController@editEmail");
Route::get("users/show-info/{id}", "Person\UserController@showInfo");
Route::get("users/get-needles", "Person\UserController@getNeedles");
Route::resource("users", "Person\UserController");
Route::resource("personnels", "Person\PersonnelController");
Route::resource("teachers", "Person\TeacherController");
Route::resource("assistants", "Person\AssistantController");


Route::resource("students", "Person\StudentController");

Route::resource("roles", "Person\RoleController");

/*** get All events for a person */
Route::get("get-all-events", "Person\UserController@getAllEvents");

/*** learn-path getting pdf */
Route::post('/get-file','Edu\LearnPathController@getFile');


Route::get("getUserGroup/{course}", "Edu\OnlineArchiveController@getUserGroup");
Route::get("onlineClassroomArchives/{course}/{group}", "Edu\OnlineArchiveController@getList");
Route::get("onlineClassroomPastArchives/{course}/{group}", "Edu\OnlineArchiveController@getPastList");




use Faker\Generator;

Route::get('/faker-locale', function (Generator $faker) {
    return $faker->locale;
});
