<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCidadesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('cidades', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('nome', 120);
            $table->unsignedBigInteger('id_estado');
        });

        Schema::table('cidades', function (Blueprint $table) {
            $table->foreign('id_estado')
            ->references('id')
            ->on('estados')
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
        Schema::dropIfExists('cidades');
        Schema::table('cidades', function (Blueprint $table) {
            $table->dropForeign('id_estado');
        });
    }
}
