<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

return new class extends Migration
{

    public function up()
    {
        Schema::create('base_languages', function (Blueprint $table) {
            $table->engine  = 'MyISAM';
            $table->charset = 'utf8';
            $table->collation = 'utf8_persian_ci';
            $table->id();
            $table->string('title', 10)->nullable()->comment("عنوان");
            $table->string('symbol', 5)->nullable()->comment("عنوان اختصاری");
            $table->string('dir', 3)->default("rtl")->comment("چینش");
            $table->string('icon', 50)->nullable()->comment("آیکون");
            $table->integer('status_id')->length(1)->default(1)->comment('شناسه وضعیت فعال/غیر فعال');
            $table->softDeletes();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('base_languages');
    }
};
