<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Produtos extends Model
{
    use HasFactory;

    protected $table = 'produtos';
    protected $primaryKey = 'id_produto';
    protected $fillable = [
        'id_produto',
        'id_categoria',
        'isActive',
        'descricaoProduto',
        'valor',
        'descricao_pagamento',
        'destaque',
        'codigoProduto'
    ];
    protected $hidden = ['pivot'];


    public function pedidos(){
    return $this->belongsToMany(Pedido::class,'pedidos_produtos', 'id_produto','id_pedido');
    }
    public function categoria(){
        return $this->hasOne(Categoria::class, 'id_categoria', 'id_categoria');
    }
    public function imagens(){
        return $this->hasMany(ProdutoImagens::class, 'id_produto', 'id_produto', 'path');
    }
    public function quantidades(){
        return $this->hasMany(Quantidades::class, 'id_produto', 'id_produto', 'id_tamanho');
    }
}
