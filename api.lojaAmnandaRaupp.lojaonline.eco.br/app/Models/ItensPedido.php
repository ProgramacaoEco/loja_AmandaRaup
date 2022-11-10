<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ItensPedido extends Model
{
    use HasFactory;
    protected $table = 'itens_pedido';
    protected $fillable = [
        'id_produto',
        'quantidade',
        'valor_unitario',
        'tamanho',
        'id_pedido',
        'descricaoProduto',
        'codigoProduto',
    ];
    protected $primaryKey = 'id_itens_pedido';
    public $timestamps = false;

    public function pedido(){
        return $this->belongsTo(Pedido::class, 'id_pedido', 'id_pedido');
    }

}
