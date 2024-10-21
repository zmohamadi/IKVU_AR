<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('surveys', function (Blueprint $table) {
            $table->engine  = 'MyISAM';
            $table->charset = 'utf8';
            $table->collation = 'utf8_persian_ci';
            $table->id();
            $table->string('title')->nullable()->comment("عنوان");
            $table->unsignedBigInteger('course_id')->nullable()->comment("کد درس");
            $table->string('group')->nullable()->comment("گروه(سال و ترم و گروه)");
            $table->string('start_date')->nullable()->comment("تاریخ شروع نظر سنجی");
            $table->string('expire_date')->nullable()->comment("تاریخ پایان نظر سنجی");
            $table->text('description')->nullable()->comment("توضیح");
            $table->integer('count_question')->default(0)->comment("تعداد سئوالات");
            $table->integer('count_response')->default(0)->comment("تعداد پاسخ ها به نظر سنجی");
            $table->integer('creator_id')->nullable()->comment('شناسه کاربر ثبت کننده');
            $table->integer('editor_id')->nullable()->comment('شناسه کاربر ویرایش کننده');
            $table->string('lang')->default('fa')->comment("زبان");
            $table->integer('status_id')->default(1)->comment("شناسه وضعیت فعال/غیر فعال");
            $table->softDeletes();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('surveys');
    }
};