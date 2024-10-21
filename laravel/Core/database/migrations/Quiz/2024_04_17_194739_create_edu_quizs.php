<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('quizs', function (Blueprint $table) {
            $table->engine  = 'MyISAM';
            $table->charset = 'utf8';
            $table->collation = 'utf8_persian_ci';
            $table->id();
            $table->integer('course_id')->nullable()->comment('شناسه درس');
            $table->string('title', 250)->nullable()->comment("عنوان");
            $table->text('description')->nullable()->comment("توضیح");
            $table->string('group')->nullable();
            $table->string('start_time_date', 20)->nullable()->comment("تاریخ شروع آزمون");
            $table->string('end_time_date', 20)->nullable()->comment("تاریخ پایان آزمون");
            $table->string('limit_time', 5)->default(0)->nullable()->comment("مدت زمان آزمون (دقیقه)");
            $table->string('one_page', 1)->default(1)->comment("تعداد صفحات آزمون(مقدار یک یعنی تمام سئوالات در یک صفحه|مقدار صفر هر سئوال در یک صفحه)");
            $table->string('total_score', 5)->default(0)->comment("جمع نمرات آزمون");
            $table->integer('corrected_count')->default(0)->comment('تعداد ازمون های تصحیح شده');
            $table->integer('question_count')->default(0)->comment('تعداد سئوالات آزمون');
            $table->integer('response_count')->default(0)->comment('تعداد پاسخ های آزمون');
            $table->string('randomize', 1)->default(1)->comment("تعداد صفحات آزمون(مقدار یک یعنی تمام سئوالات در یک صفحه|مقدار صفر هر سئوال در یک صفحه)");
            $table->string('min', 5)->nullable();
            $table->string('max', 5)->nullable();
            $table->string('avg', 5)->nullable();
            $table->string('use_editor', 1)->default(1)->comment("تعداد صفحات آزمون(مقدار یک یعنی تمام سئوالات در یک صفحه|مقدار صفر هر سئوال در یک صفحه)");
            $table->integer('creator_id')->nullable()->comment("ثبت کننده آزمون");
            $table->integer('status_id')->length(1)->default(1)->comment("شناسه وضعیت فعال/غیر فعال");
            $table->string('lang', 2)->default("en")->comment("زبان");
            $table->softDeletes();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('quizs');
    }
};
