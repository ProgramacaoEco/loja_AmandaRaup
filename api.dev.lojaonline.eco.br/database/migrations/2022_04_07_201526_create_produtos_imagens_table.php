<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateProdutosImagensTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('produtos_imagens', function (Blueprint $table) {
            $table->bigIncrements('id_imagem');
            $table->unsignedBigInteger('id_produto');
            $table->string('path');


        });
        Schema::table('produtos_imagens', function (Blueprint $table) {
            $table->foreign('id_produto')
            ->references('id_produto')
            ->on('produtos')
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
        Schema::dropIfExists('produtos_imagens');
        Schema::table('produtos_imagens', function (Blueprint $table) {
            $table->dropForeign('id_produtos');
        });
    }
}
