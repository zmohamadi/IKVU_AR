<?php

namespace Database\Seeders\Base;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ToolsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $tools = [
            ['id' => 1, 'title_fa' => 'خط سیر آموزشی', 'title_en' => 'learnpath', 'href' => 'learnpath', 'img' => 'learnpath.png', 'order' => 1, 'status_id' => 1, 'description' => '', 'created_at' => NULL, 'updated_at' => NULL, 'deleted_at' => NULL],
            ['id' => 2, 'title_fa' => 'کلاس آنلاین', 'title_en' => 'online_classroom', 'href' => 'onlineClassroom', 'img' => 'onlineclassroom.jpg', 'order' => 2, 'status_id' => 1, 'description' => '', 'created_at' => NULL, 'updated_at' => NULL, 'deleted_at' => NULL],
            ['id' => 3, 'title_fa' => 'آرشیو کلاس آنلاین', 'title_en' => 'online_archives', 'href' => 'onlineClassroomArchives', 'img' => 'online_archives.jpg', 'order' => 3, 'status_id' => 1, 'description' => '', 'created_at' => NULL, 'updated_at' => NULL, 'deleted_at' => NULL],
            ['id' => 4, 'title_fa' => 'آرشیو کلاس آنلاین سنوات قبل', 'title_en' => 'online_past_archives', 'href' => 'onlineClassroomPastArchives', 'img' => 'online_past_archives.jpg', 'order' => 4, 'status_id' => 1, 'description' => '', 'created_at' => NULL, 'updated_at' => NULL, 'deleted_at' => NULL],
            ['id' => 5, 'title_fa' => 'آزمون', 'title_en' => 'quiz', 'href' => 'quiz', 'img' => 'quiz.jpg', 'order' => 5, 'status_id' => 1, 'description' => '', 'created_at' => NULL, 'updated_at' => NULL, 'deleted_at' => NULL],
            ['id' => 6, 'title_fa' => 'تکلیف', 'title_en' => 'assignments', 'href' => 'assignment', 'img' => 'assignment.jpg', 'order' => 6, 'status_id' => 1, 'description' => '', 'created_at' => NULL, 'updated_at' => NULL, 'deleted_at' => NULL],
            ['id' => 7, 'title_fa' => 'پیامگاه', 'title_en' => 'forum', 'href' => 'forum', 'img' => 'forum.jpg', 'order' => 7, 'status_id' => 1, 'description' => '', 'created_at' => NULL, 'updated_at' => NULL, 'deleted_at' => NULL],
            ['id' => 8, 'title_fa' => 'ارسال و دریافت تحقیقات', 'title_en' => 'inbox', 'href' => 'inbox', 'img' => 'message_box.jpg', 'order' => 8, 'status_id' => 1, 'description' => '', 'created_at' => NULL, 'updated_at' => NULL, 'deleted_at' => NULL],
            ['id' => 9, 'title_fa' => 'نظرسنجی', 'title_en' => 'survey', 'href' => 'survey', 'img' => 'survey.jpg', 'order' => 9, 'status_id' => 1, 'description' => '', 'created_at' => NULL, 'updated_at' => NULL, 'deleted_at' => NULL],
        ];

        DB::table('tools')->insert($tools);
    }
}
