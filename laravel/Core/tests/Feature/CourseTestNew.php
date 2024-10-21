<?php

namespace Tests\Feature;

use Tests\TestCase;
use Models\Edu\Course;
use Illuminate\Foundation\Testing\RefreshDatabase;

class CourseTestNew extends TestCase
{
    // use RefreshDatabase;

    protected function setUp() :void
    {
        parent::setUp();
        // \Artisan::call('migrate --path=database/migrations/tests');
        // Artisan::call('db:seed', ['--class' => 'TestDatabaseSeeder ', '--database' => 'testing']);
    }

    // Test for viewing a list of courses
    public function testCourseList()
    {
        // $this->createCourses(3);
        $response = $this->getJson('/mastership/courses');
        $response->assertStatus(200);
        $response->assertJsonStructure([
            'data' => [
                '*' => ['code', 'title', 'description']
            ]            
        ]);
    }

    public function createCourses($count = 5) {
        Course::factory()->count($count)->create();
    }


    // Test for viewing course tools
    // public function testCourseTools()
    // {
    //     $courseId = 9; // Ensure this course ID exists
    //     $response = $this->getJson("/courses/tools/{$courseId}");
    //     $response->assertStatus(200);
    //     $response->assertJsonStructure([
    //         '*' => ['id', 'title']
    //     ]);
    // }

    // public function testChangeCourseTools()
    // {
    //     $course = 9;

    //     // Specify the tool to be changed
    //     $tools = 'quiz';

    //     // Send a PATCH request to the endpoint
    //     $response = $this->patch("/courses/change-tools/{$course}/{$tools}");

    //     // Assert the response status is 200
    //     $response->assertStatus(200);

    //     // Assert the JSON response contains the course with the updated tool status
    //     $response->assertJsonFragment([
    //         'id' => $course,
    //         $tools => 1 // Expected to be toggled from 0 to 1
    //     ]);
    // }


    // // Test for viewing course report card
    // public function testCourseReportCard()
    // {
    //     $courseId = 1; // Ensure this course ID exists
    //     $studentId = 1; // Ensure this student ID exists
    //     $response = $this->getJson("/mastership/courses/report-card/{$courseId}/{$studentId}");
    //     $response->assertStatus(200);
    //     $response->assertJsonStructure([
    //         'student' => ['id', 'name'],
    //         'grades' => ['quiz', 'assignment', 'overall']
    //     ]);
    // }

    // // Test for retrieving needles for course status changes
    // public function testChangeStatusGetNeedles()
    // {
    //     $response = $this->get('/courses/change-status/get-needles');
    //     $response->assertStatus(200);
    //     $response->assertJsonStructure([
    //         '*' => ['id', 'label']
    //     ]);
    // }

    // // Test for changing course status
    // public function testChangeCourseStatus()
    // {
    //     $courseId = 1; // Ensure this course ID exists
    //     $studentId = 1; // Ensure this student ID exists
    //     $response = $this->post("/courses/change-status/{$courseId}/{$studentId}", [
    //         'status' => 'active'
    //     ]);
    //     $response->assertStatus(200);
    //     $response->assertJson([
    //         'status' => 'active',
    //     ]);
    // }

    // // Test for retrieving course needles
    // public function testGetCourseNeedles()
    // {
    //     $response = $this->get('/courses/get-needles');
    //     $response->assertStatus(200);
    //     $response->assertJsonStructure([
    //         '*' => ['id', 'label']
    //     ]);
    // }

    // Test for viewing assignments list
    public function testAssignmentList()
    {
        $courseId = 38309; // Ensure this course ID exists
        $response = $this->getJson("/mastership/assignment-list/{$courseId}");
        $response->assertStatus(200);
        $response->assertJsonStructure([
            'data' => [
                '*' => ['id', 'title']
            ]            
        ]);
       
    }

    // Test for viewing quizzes list
    public function testQuizList()
    {
        $courseId = 38309; // Ensure this course ID exists
        $response = $this->getJson("/mastership/quiz-list/{$courseId}");
        $response->assertStatus(200);
        $response->assertJsonStructure([
            'data' => [
                '*' => ['id', 'title']
            ]            
        ]);
    }

    // Test for retrieving needles in online classroom
    // public function testOnlineClassroomGetNeedles()
    // {
    //     $response = $this->getJson("/mastership/onlineClassrooms/get-needles");
    //     $response->assertStatus(200);
    //     $response->assertJsonStructure([
    //         'data' => [
    //             '*' => ['id', 'title']
    //         ]            
    //     ]);

    // }

    // Test for viewing online classroom list
    public function testOnlineClassroomList()
    {
        $courseId = 38309; // Ensure this course ID exists
        $response = $this->getJson("/mastership/onlineClassroom-list/{$courseId}");
        $response->assertStatus(200);
        $response->assertJsonStructure([
            'data' => [
                '*' => ['id', 'title']
            ]            
        ]);
    }

    // Test for retrieving assignment answers
    public function testAssignmentAnswers()
    {
        $toolsId = 1;// Ensure this tools ID exists
        $response = $this->getJson("/mastership/assignment-answers/{$toolsId}");
        $response->assertStatus(200);
        $response->assertJsonStructure([
            'data' => [
                '*' => ['id', 'user_id', 'answer']
                ]            
        ]);
    }

    // Test for retrieving quiz answers
    public function testQuizAnswers()
    {
        $toolsId = 1;// Ensure this tools ID exists
        $response = $this->getJson("/mastership/quiz-answers/{$toolsId}");
        $response->assertStatus(200);
        $response->assertJsonStructure([
            'data' => [
                '*' => ['id', 'user_id', 'answer']
                ]            
        ]);
    }

    // Test for retrieving quiz attempt info
    // public function testQuizReplyInfo()
    // {
    //     $replyId = 1; // Ensure this reply ID exists
    //     $response = $this->getJson("/mastership/quiz/attemp/{$replyId}");
    //     $response->assertStatus(200);
    //     $response->assertJsonStructure([
    //         '*' => ['id', 'quiz_id', 'user_id', 'score']        
    //     ]);
        
    // }

    // Test for retrieving survey users
    // public function testSurveyGetUsers()
    // {
    //     $surveyId = 1; // Ensure this survey ID exists
    //     $response = $this->getJson("/mastership/survey/get-users/{$surveyId}");
    //     $response->assertStatus(200);
    //     $response->assertJsonStructure([
    //         'data' => [
    //             '*' => ['id']
    //         ]            
    //     ]);
    // }

    // Test for retrieving survey reply info
    // public function testSurveyReplyInfo()
    // {
    //     $replyId = 1; // Ensure this reply ID exists
    //     $response = $this->getJson("/mastership/survey/reply-info/{$replyId}");
    //     $response->assertStatus(200);
    //     $response->assertJsonStructure([
    //         'data' => [
    //             '*' => ['id', 'survey_id', 'user_id', 'response']
    //         ]            
    //     ]);

       
    // }

    // Test for saving survey reply
    // public function testSurveyReplySave()
    // {
    //     // Course::factory()->count($count)->create();

    //     $surveyId = 1; // Ensure this survey ID exists
    //     $response = $this->post("/mastership/survey/reply-save/{$surveyId}", [
    //         'user_id' => 1, // Ensure this user ID exists
    //         'response' => 'My response'
    //     ]);
    //     $response->assertStatus(200);
    //     $response->assertJson([
    //         'success' => true
    //     ]);
    // }

    // Test for retrieving survey needles
    // public function testSurveyGetNeedles()
    // {
    //     $response = $this->getJson("/mastership/survey/get-needles");
    //     $response->assertStatus(200);
    //     $response->assertJsonStructure([
    //         '*' => ['id']          
    //     ]);

       
    // }

    // Test for viewing survey list
    public function testSurveyList()
    {
        $courseId = 38309; // Ensure this course ID exists
        $response = $this->getJson("/mastership/survey-list/{$courseId}");
        $response->assertStatus(200);
        $response->assertJsonStructure([
            'data' => [
                '*' => ['id', 'title', 'description']
            ]            
        ]);

    }

    // // Test for updating post status
    // public function testUpdatePostStatus()
    // {
    //     $postId = 1; // Ensure this post ID exists
    //     $response = $this->put("/posts-update/change-status/{$postId}", [
    //         'status' => 'published'
    //     ]);
    //     $response->assertStatus(200);
    //     $response->assertJson([
    //         'status' => 'published',
    //     ]);
    // }

    // // Test for retrieving post statuses
    // public function testGetPostStatus()
    // {
    //     $response = $this->get('/posts-status');
    //     $response->assertStatus(200);
    //     $response->assertJsonStructure([
    //         '*' => ['id', 'status', 'post_id']
    //     ]);
    // }

    // // Test for retrieving posts needing check
    // public function testForumPostsNeedCheck()
    // {
    //     $response = $this->get('/forum/posts-need-check');
    //     $response->assertStatus(200);
    //     $response->assertJsonStructure([
    //         '*' => ['id', 'title', 'content']
    //     ]);
    // }

    // // Test for forum report
    // public function testForumReport()
    // {
    //     $response = $this->get('/forum/report');
    //     $response->assertStatus(200);
    //     $response->assertJsonStructure([
    //         'reports' => ['id', 'details', 'status']
    //     ]);
    // }

    // // Test for saving forum reports
    // public function testSaveForumReport()
    // {
    //     $response = $this->post('/forum/save-report', [
    //         'details' => 'Inappropriate content',
    //         'status' => 'pending'
    //     ]);
    //     $response->assertStatus(201);
    //     $response->assertJson([
    //         'details' => 'Inappropriate content',
    //         'status' => 'pending'
    //     ]);
    // }

    // Test for viewing course enrollment list
    // public function testCourseEnrollmentList()
    // {
        
    //     $courseId = 38309; // Ensure this course ID exists
    //     $response = $this->getJson("/mastership/course-enrollment-list/{$courseId}");
    //     $response->assertStatus(200);
    //     $response->assertJsonStructure([
    //         'data' => [
    //             '*' => ['id', 'student_id', 'status']
    //             ]            
    //     ]);
    // }
    // تست برای مشاهده فهرست پیام‌های صندوق ورودی
    public function testInboxList()
    {
        $inboxId = 1; // Ensure this course ID exists
        $response = $this->getJson("/mastership/inbox-list/{$inboxId}");
        $response->assertStatus(200);
        $response->assertJsonStructure([
            'data' => [
                '*' =>['id', 'sender_id', 'message']
                ]            
        ]);
    }

    // تست برای دریافت اطلاعات پاسخ صندوق ورودی
    // public function testInboxReplyInfo()
    // {
    //     $replyId = 1; // اطمینان حاصل کنید که پاسخی با این ID وجود دارد
    //     $response = $this->getJson("/mastership/inbox/reply-info/{$replyId}");
    //     $response->assertStatus(200);
    //     $response->assertJsonStructure([
    //         '*' =>['id', 'inbox_id', 'reply_text']           
    //     ]);
    // }

    // تست برای پاسخ به صندوق ورودی
    // public function testInboxReply()
    // {
    //     $replyId = 1; // اطمینان حاصل کنید که پاسخی با این ID وجود دارد
    //     $response = $this->put("/inbox/reply/{$replyId}", [
    //         'reply_text' => 'This is a reply'
    //     ]);
    //     $response->assertStatus(200);
    //     $response->assertJson([
    //         'success' => true,
    //     ]);
    // }

    // // تست برای دریافت needles صندوق ورودی
    // public function testInboxGetNeedles()
    // {
    //     $inboxId = 1; // اطمینان حاصل کنید که صندوق ورودی‌ای با این ID وجود دارد
    //     $response = $this->getJson("/mastership/inbox/get-needles/{$inboxId}");
    //     $response->assertStatus(200);
    //     $response->assertJsonStructure([
    //         '*' => ['id', 'label']
    //     ]);
    // }
}
