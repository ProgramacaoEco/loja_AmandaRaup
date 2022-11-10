<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateVezesFormaTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('vezes_forma', function (Blueprint $table) {
            $table->bigIncrements('id_vezes_forma');
            $table->unsignedBigInteger('id_forma');
            $table->string('numero_vezes');
        });

        Schema::table('vezes_forma', function (Blueprint $table) {
            $table->foreign('id_forma')
            ->references('id_forma')
            ->on('forma_pagamento')
            ->onDelete('CASCADE');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('vezes_forma');
    }
}
