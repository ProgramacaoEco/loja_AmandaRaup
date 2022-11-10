<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Categoria extends Model
{
    use HasFactory;
    protected $table = 'categorias';

    protected $fillable = [
        'id_categoria',
        'nome_categoria',
        'path'
    ];
    protected $primaryKey = 'id_categoria';
    public $timestamps = false;

    public function produtos(){
        return $this->belongsToMany('produtos', 'id_produto');
    }

}
