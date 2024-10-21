<?php

namespace Tests\Feature;

use Tests\TestCase;
use Models\Edu\Course;
use Illuminate\Foundation\Testing\RefreshDatabase;

class CourseTest extends TestCase
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

    // public function testCreateCourse()
    // {
    //     // داده‌های ورودی برای ثبت دوره جدید
    //     $data = [
    //         "code" => rand(10000, 99999),  // تولید عدد تصادفی 5 رقمی            
    //         "less_id"=>"15356796",
    //         "title"=>"آموزش فلسفه",
    //         "category_id"=>1,
    //         "system_id"=>1,
    //         // "thumbnail"=>"1.png",
    //         // "description"=>"آموزش فلسفه",
    //     ];

    //     // ارسال درخواست POST برای ثبت دوره
    //     $response = $this->postJson('/mastership/courses', $data);
    //     // dd($response->status(), $response->json());


    //     // بررسی وضعیت پاسخ (201: Created)
    //     $response->assertStatus(200);

    //     // بررسی ساختار پاسخ
    //     $response->assertJsonStructure([
    //         'code', 'title', 'description'
    //     ]);

    //     // بررسی اینکه داده‌ها در دیتابیس ذخیره شده‌اند
    //     $this->assertDatabaseHas('courses', $data);
    // }
    // public function testUpdateCourse()
    // {
    //     // ایجاد یک دوره آزمایشی
    //     $course = Course::factory()->create();

    //     // داده‌های جدید برای ویرایش دوره
    //     $data = [
    //         'title' => 'Updated Course Title',
    //         'description' => 'Updated description'
    //     ];

    //     // ارسال درخواست PUT برای ویرایش دوره
    //     $response = $this->putJson("/mastership/courses/{$course->id}", $data);
    //     // dd($response->status(), $response->json());

    //     // بررسی وضعیت پاسخ
    //     $response->assertStatus(200);

    //     // بررسی اینکه داده‌ها در دیتابیس به‌روزرسانی شده‌اند
    //     $this->assertDatabaseHas('courses', [
    //         'id' => $course->id,
    //         'title' => 'Updated Course Title',
    //         'description' => 'Updated description'
    //     ]);
    // }
    // public function testDeleteCourse()
    // {
    //     // ایجاد یک دوره آزمایشی
    //     $course = Course::factory()->create();

    //     // ارسال درخواست DELETE برای حذف دوره
    //     $response = $this->deleteJson("/mastership/courses/{$course->id}");

    //     // بررسی وضعیت پاسخ
    //     $response->assertStatus(200);

    //     // بررسی اینکه دوره از دیتابیس حذف شده است
    //     $this->assertDatabaseMissing('courses', [
    //         'id' => $course->id
    //     ]);
    // }


    // public function createCourses($count = 5) {
    //     Course::factory()->count($count)->create();
    // }
}
