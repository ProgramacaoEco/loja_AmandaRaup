<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pedido extends Model
{
    use HasFactory;

    protected $table = 'pedidos';
    protected $fillable = [
        'valor',
        'vezes_pagamento',
        'forma_pagamento',
        'nome_cliente',
        'cpf/cnpj',
        'telefone',
        'uf',
        'cep',
        'cidade',
        'endereco_entrega',
        'bairro',
        'complemento',
        'status_pedido'
    ];
    protected $primaryKey = 'id_pedido';
    const CREATED_AT = 'data_pedido';
    const UPDATED_AT = 'updated_at';

    public function bairro()
    {
        return $this->hasOne(Bairro::class, 'id_bairro' , 'id_bairro');
    }
    public function pagamento()
    {
        return $this->hasOne(VezesForma::class, 'id_vezes_forma', 'pagamento');

    }
    public function produtos()
    {
    return $this->belongsToMany(Produtos::class, 'id_produto', 'id_produto');
    }

    public function formaPagamento(){
        return  $this->hasOne(FormaPagamento::class, 'descricao_forma', 'pagamento');
    }

    public function tamanho(){
        return $this->hasOne(Tamanho::class, 'tamanho');
    }

    public function itensPedido(){
        return $this->hasMany(ItensPedido::class, 'id_pedido', 'id_pedido');
    }

    public function prelogin() {
        return $this->hasOne(Prelogin::class, 'id_prelogin', 'pagador_id');
    }

}
