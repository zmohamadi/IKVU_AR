<?php
use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

return new class extends Migration
{

    public function up()
    {
        Schema::create('assignments', function (Blueprint $table) {
            $table->engine  = 'MyISAM';
            $table->charset = 'utf8';
            $table->collation = 'utf8_persian_ci';
            $table->id();
            $table->string('title')->nullable()->comment('عنوان');
            $table->integer('course_id')->default(1)->comment("کد درس");
            $table->string('group')->default(0)->comment("گروه(سال و ترم و گروه)");
            $table->text('for_students')->nullable()->comment('آرایه جیسون از دانشجویان جهت اختصاص تکلیف');
            $table->integer('to_students')->default(0)->comment('نمایش(نمره،سوال،پاسخ ها)به دانشجویان در هرتکلیف مقدار 1 در غیر اینصورت مقدار 0');
            $table->integer('seeing')->default(0)->comment('مشاهده پاسخ توسط گیرنده مقدار 1 درغیر این صورت مقدار 0');
            $table->string('files')->nullable()->comment('بارگزاری ها');
            $table->integer('session')->nullable()->comment('شماره جلسه ای که تکلیف مختص آنست');
            $table->integer('question_type_id')->default(1)->comment('شناسه نوع سئوال');
            $table->integer('correct_option_id')->default(1)->comment('شناسه پاسخ صحیح');
            $table->string('start_date')->nullable()->comment('تاریخ شروع');
            $table->string('expire_date')->nullable()->comment('تاریخ پایان');
            $table->string('score', 5)->default(0)->comment("نمره");
            $table->integer('creator_id')->nullable()->comment('شناسه کاربر ثبت کننده');
            $table->integer('editor_id')->nullable()->comment('شناسه کاربر ویرایش کننده');
            $table->text('description')->nullable()->comment('توضیحات');
            $table->integer('answer_count')->default(0)->comment('تعداد پاسخ');
            $table->integer('corrected_count')->default(0)->comment('تعداد پاسخ صحیح');
            $table->integer('avg')->nullable()->comment('میانگین');
            $table->integer('max')->nullable()->comment('حداکثر');
            $table->integer('min')->nullable()->comment('حداقل');
            $table->integer('order')->nullable()->comment('ترتیب');
            $table->integer('status_id')->length(1)->default(1)->comment('شناسه وضعیت فعال/غیر فعال');
            $table->softDeletes();
            $table->timestamps();
        });
    }
    public function down()
    {
        Schema::dropIfExists('assignments');
    }
};
