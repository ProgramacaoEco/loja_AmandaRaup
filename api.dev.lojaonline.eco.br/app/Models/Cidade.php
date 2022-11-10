<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Cidade extends Model
{
    use HasFactory;
    protected $table = 'cidades';
    protected $fillable = [
        'id',
        'nome',
        'id_estado'
    ];
    protected $primaryKey = 'id';

    public function estado(){
        return $this->hasOne(Estado::class, 'id', 'id_estado');
    }
    public function bairros(){
        return $this->hasMAny(Bairro::class, 'id_cidade','id_cidade');
    }
}
