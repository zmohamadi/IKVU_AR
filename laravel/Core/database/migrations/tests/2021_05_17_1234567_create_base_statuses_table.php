<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

return new class extends Migration
{

    public function up()
    {
        Schema::create('base_statuses', function (Blueprint $table) {
            $table->engine  = 'MyISAM';
            $table->charset = 'utf8';
            $table->collation = 'utf8_persian_ci';
            $table->id();
            $table->string('title_fa', 200)->nullable()->comment('عنوان به زبان فارسی');
            $table->string('title_en', 200)->nullable()->comment('عنوان به زبان عربی');
            $table->integer('group_id')->length(2)->nullable()->comment('شناسه گروه وضعیت');
            $table->string('code', 3)->nullable()->comment('کد وضعیت');
            $table->string('color', 20)->nullable()->comment('رنگ');
            $table->integer('status_id')->length(1)->default(1)->comment('شناسه وضعیت فعال/غیر فعال');
            $table->softDeletes();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('base_statuses');
    }
};
