<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProdutoImagens extends Model
{
    use HasFactory;

    protected $table = 'produtos_imagens';
    protected $primarykey = 'id';
    protected $fillable = [
        'id_produto',
        'path'
    ];
    public $timestamps = false;

    public function produtos(){
        return $this->belongsTo('ProdutoImagens');
    }

}
