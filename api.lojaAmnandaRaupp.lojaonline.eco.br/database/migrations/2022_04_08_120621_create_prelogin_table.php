<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePreloginTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('prelogin', function (Blueprint $table) {
            $table->bigIncrements('id_prelogin');
            $table->string('nome');
            $table->string('email');
            $table->string('senha');
            $table->string('telefone');
            $table->string('uf');
            $table->string('municipio');
            $table->string('cep');
            $table->string('bairro');
            $table->string('logradouro');
            $table->string('numero');
            $table->string('complemento');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('prelogin');
    }
}
