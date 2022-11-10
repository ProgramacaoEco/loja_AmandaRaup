<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Estado extends Model
{
    use HasFactory;
    protected $table = 'estados';
    protected $filalble = [
        'id',
        'nome',
        'uf'
    ];
    protected $primaryKey = 'id';

    public function cidades() {
        return $this->hasMany(Cidade::class, 'id_estado', 'id');
    }
}
