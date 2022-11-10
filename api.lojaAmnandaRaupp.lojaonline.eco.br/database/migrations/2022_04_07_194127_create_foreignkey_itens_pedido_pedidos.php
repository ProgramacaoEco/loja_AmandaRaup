<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::table('itens_pedido', function (Blueprint $table) {
            $table->foreign('id_pedido')
            ->references('id_pedido')
            ->on('pedidos')
            ->onDelete('CASCADE');
        });
    }

    public function down()
    {
        Schema::table('itens_pedido', function (Blueprint $table) {
            $table->dropForeign('id_pedido');
        });
    }
};


