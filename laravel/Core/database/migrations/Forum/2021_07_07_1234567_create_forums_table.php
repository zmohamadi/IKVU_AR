<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

return new class extends Migration
{

    public function up()
    {
        Schema::create('forums', function (Blueprint $table) {
            $table->engine  = 'MyISAM';
            $table->charset = 'utf8';
            $table->collation = 'utf8_persian_ci';
            $table->id();
            $table->string('title', 200)->nullable()->comment('عنوان');
            $table->unsignedBigInteger('course_id')->nullable()->comment("کد درس");
            $table->string('group')->nullable()->comment("گروه(سال و ترم و گروه)");
            $table->integer('creator_id')->nullable()->comment('شناسه کاربر ثبت کننده');  
            $table->integer('editor_id')->nullable()->comment('شناسه کاربر ویرایش کننده');          
            $table->string('last_post')->nullable()->comment('نام فرستنده و تاریخ ثبت آخرین گفتگو');            
            $table->string('last_post_general')->nullable()->comment('نام فرستنده و تاریخ ثبت آخرین گفتگو عمومی');            
            $table->integer('last_post_id')->nullable()->comment('شناسه آخرین گفتگوی ثبت شده');            
            $table->integer('last_post_general_id')->nullable()->comment('شناسه آخرین گفتگوی عمومی ثبت شده');            
            $table->text('description')->nullable()->comment("توضیح");
            $table->integer('lock')->length(1)->default(1)->comment('پیام قفل است؟');
            $table->integer('need_to_apply')->length(1)->default(1)->comment('پیام ها نیاز به تایید دارد؟');
            $table->integer('count_post')->default(0)->comment('تعداد پست');
            $table->integer('count_post_not_check')->default(0)->comment('تعداد پست بررسی نشده');
            $table->integer('count_post_parent')->default(0)->comment('تعداد پست والد (موضوعات)');
            $table->string('lang', 2)->default('fa')->comment('زبان');
            $table->integer('status_id')->length(1)->default(1)->comment('شناسه وضعیت فعال/غیر فعال');
            $table->softDeletes();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('forums');
    }
};
