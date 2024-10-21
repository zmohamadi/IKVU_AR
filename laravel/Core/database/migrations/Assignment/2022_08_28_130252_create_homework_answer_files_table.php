<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('assignment_answer_files', function (Blueprint $table) {
            $table->engine  = 'MyISAM';
            $table->charset = 'utf8';
            $table->collation = 'utf8_persian_ci';
            $table->increments('id');
            $table->integer('assignment_answer_id')->comment('شناسه جزییات پاسخ');
            $table->integer('file_category_id')->comment('شناسه دسته بتدی فایل');
            $table->integer('file_type_id')->comment('شناسه نوع فایل');
            $table->string('name', 200)->comment('نام فایل');
            $table->string('url', 200)->comment('مسیر فایل');
            $table->string('extension', 200)->comment('پسوند فایل');
            $table->string('size', 200)->comment('سایز');
            $table->string('width', 200)->comment('عرض');
            $table->string('height', 200)->comment('ارتفاع');
            $table->softDeletes();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('assignment_answer_files');
    }
};
