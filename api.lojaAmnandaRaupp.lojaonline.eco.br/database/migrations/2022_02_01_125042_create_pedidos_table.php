<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePedidosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('pedidos', function (Blueprint $table) {
            $table->bigIncrements('id_pedido');
            $table->decimal('valor', 7,2);
            $table->string('vezes_pagamento');
            $table->string('forma_pagamento');
            $table->string('nome_cliente');
            $table->string('cpf/cnpj', 20);
            $table->string('telefone');
            $table->string('uf', 2);
            $table->string('cep', 9);
            $table->string('cidade');
            $table->string('endereco_entrega');
            $table->string('bairro');
            $table->string('complemento');
            $table->dateTime('data_pedido');
            $table->timestamp('updated_at');
            $table->string('status_pedido');


        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('pedidos');
    }
}
