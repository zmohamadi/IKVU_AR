<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

return new class extends Migration
{

    public function up()
    {
        Schema::create('forum_posts', function (Blueprint $table) {
            $table->engine  = 'MyISAM';
            $table->charset = 'utf8';
            $table->collation = 'utf8_persian_ci';
            $table->id();
            $table->integer('forum_id')->nullable()->comment('شناسه تالار');
            $table->integer('sender_id')->nullable()->comment('شناسه ارسال کننده');            
            $table->integer('parent_id')->default(0)->comment('شناسه پیام اصلی');            
            $table->integer('reply_to')->nullable()->comment('پاسخ به پیام منظور');            
            $table->text('title')->nullable()->comment('عنوان (موضوع)');
            $table->text('message')->nullable()->comment('متن پیام');
            $table->integer('type_id')->length(1)->default(0)->comment('شناسه نوع پیام کابر(ثبت، عمومی،خصوصی،رد)');
            $table->string('last_post')->nullable()->comment('نام فرستنده و تاریخ ثبت آخرین گفتگو برای موضوع یا والد');            
            $table->string('last_post_general')->nullable()->comment('نام فرستنده و تاریخ ثبت آخرین گفتگوی عمومی برای موضوع یا والد');            
            $table->integer('last_post_id')->nullable()->comment('شناسه آخرین گفتگوی ثبت شده برای موضوع یا والد');            
            $table->integer('last_post_general_id')->nullable()->comment('شناسه آخرین گفتگوی عمومی ثبت شده برای موضوع یا والد');            
            $table->integer('count_view')->default(0)->comment('تعداد بازدید');
            $table->integer('count_like')->default(0)->comment('تعداد لایک');
            $table->integer('count_dislike')->default(0)->comment('تعداد دیس لایک');
            $table->integer('count_attachment')->default(0)->comment('تعداد فایل');
            $table->string('lang', 2)->default('fa')->comment('زبان');
            $table->integer('status_id')->length(1)->default(1)->comment('شناسه وضعیت فعال/غیر فعال');
            $table->softDeletes();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('forum_posts');
    }
};
