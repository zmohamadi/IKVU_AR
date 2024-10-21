<?php
use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateUsersTable extends Migration
{

    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            
            $table->engine  = 'MyISAM';
            $table->charset = 'utf8';
            $table->collation = 'utf8_persian_ci';
            $table->id();
            $table->string('firstname')->comment("نام");
            $table->string('lastname')->comment("نام خانوادگی");
            $table->string('codemeli')->unique()->comment("کد ملی");
            $table->string('username')->unique()->comment("نام کاربری");
            $table->string('mobile')->unique()->comment("شماره همراه");
            $table->string('email')->unique()->comment("ایمیل");
            $table->integer('creator_id')->nullable()->comment('شناسه کاربر ثبت کننده');
            $table->integer('editor_id')->nullable()->comment('شناسه کاربر ویرایش کننده');
            $table->integer('studentID')->nullable()->comment("کد دانشجویی");
            $table->string('password')->nullable()->comment("رمز عبور");
            $table->integer('role_id')->nullable()->comment("نقش");
            $table->integer('count_presented')->default(0)->comment('تعداد دروس ارائه شده استاد');
            $table->integer('count_register')->default(0)->comment('تعداد دروس ثبت نام شده');
            $table->integer('person_id')->nullable()->comment("کد پرسنلی");
            $table->integer('gender_id')->nullable()->comment("جنسیت");
            $table->string('photo')->nullable()->comment("تصویر");
            $table->text('resume')->nullable()->comment("رزومه استاد");
            $table->integer('status_id')->default(1)->comment("شناسه وضعیت فعال/غیر فعال");
            $table->string('lang', 2)->default("fa")->comment("زبان");
            $table->softDeletes();
            $table->timestamps();
        });
    }
    public function down()
    {
        Schema::dropIfExists('users');
    }
}
