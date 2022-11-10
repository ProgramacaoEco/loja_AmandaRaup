<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Quantidades extends Model
{
    use HasFactory;
    protected $table = 'quantidades';
    protected $fillable = [
        'id_produto',
        'id_tamanho',
        'quantidade',
        'codigoProduto',
        'tamanho'

    ];
    protected $primaryKey = 'id_qtde';
    public $timestamps = false;

    public function tamanhos() {
        return $this->hasOne(Tamanhos::class, 'id_tamanho', 'id_tamanho');
    }

    public function produtos() {
        return $this->hasOne(Produtos::class, 'id_produto', 'id_produto');
    }

}
