<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateItensPedidoTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('itens_pedido', function (Blueprint $table) {
            $table->bigIncrements('id_itens_pedido');
            $table->decimal('valor_unitario', 7,2);
            $table->string('descricaoProduto');
            $table->string('codigoProduto');
            $table->string('tamanho');
            $table->string('quantidade');
            $table->unsignedBigInteger('id_pedido');
            $table->unsignedBigInteger('id_produto');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('itens_pedido');
    }
}
