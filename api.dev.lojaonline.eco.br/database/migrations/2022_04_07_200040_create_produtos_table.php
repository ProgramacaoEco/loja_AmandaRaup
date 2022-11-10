<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateProdutosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('produtos', function (Blueprint $table) {
            $table->bigIncrements('id_produto');
            $table->unsignedBigInteger('id_categoria');
            $table->string('descricaoProduto', 60);
            $table->decimal('valor', 9,2);
            $table->string('descricao_pagamento');
            $table->boolean('isActive')->default(1);
            $table->boolean('destaque');
            $table->string('codigoProduto', 45);
            $table->timestamps();
        });

        Schema::table('produtos', function (Blueprint $table) {
            $table->foreign('id_categoria')
            ->references('id_categoria')
            ->on('categorias')
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
        Schema::dropIfExists('produtos');

        Schema::table('produtos', function (Blueprint $table) {
            $table->dropForeign('id_produto');
        });
    }


}
