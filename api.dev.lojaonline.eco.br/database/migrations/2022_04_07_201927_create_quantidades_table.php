<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateQuantidadesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('quantidades', function (Blueprint $table) {
            $table->bigIncrements('id_qtde');
            $table->integer('quantidade')->nullable();
            $table->unsignedBigInteger('id_produto');
            $table->unsignedBigInteger('id_tamanho');
            $table->string('codigoProduto', 45);
            $table->string('tamanho', 45);
        });
        Schema::table('quantidades', function (Blueprint $table) {
            $table->foreign('id_produto')
            ->references('id_produto')
            ->on('produtos')
            ->onDelete('CASCADE');
        });
        Schema::table('quantidades', function (Blueprint $table) {
            $table->foreign('id_tamanho')
            ->references('id_tamanho')
            ->on('tamanhos')
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
        Schema::dropIfExists('quantidades');

        Schema::table('quantidades', function (Blueprint $table) {
            $table->dropForeign('id_tamanho');
            $table->dropForeign('id_produto');
        });
    }
}
