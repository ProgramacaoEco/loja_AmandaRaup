<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class FormaPagamento extends Model
{
    use HasFactory;
    protected $table = 'forma_pagamento';
    protected $fillable = [
                        'descricao_forma'
                        ];
    protected $primaryKey = 'id_forma';
    public $timestamps = false;

    public function pedido(){
        return $this->hasOnes(Pedido::class, 'pedido', 'descricao_forma');
    }
}
