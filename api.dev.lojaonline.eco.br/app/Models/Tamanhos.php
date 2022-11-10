<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tamanhos extends Model
{
    use HasFactory;
    protected $table = 'tamanhos';
    protected $fillable = [
        'id_tamanho',
        'tamanho'
    ];

    protected $primaryKey = 'id_tamanho';
    protected $hidden = ['pivot'];
    public $timestamps = false;


    // public function produtos(){
    //     return $this->belongsToMany(Produtos::class,'quantidades', 'id_tamanho','id_produto');
    // }
}
