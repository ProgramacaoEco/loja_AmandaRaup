<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Bairro extends Model
{
    use HasFactory;
    protected $table = 'bairro';
    protected $fillable = [
        'id_bairro',
        'nome',    
        'id_cidade',
        'valor_frete'
        
    ];
    protected $primaryKey = 'id_bairro';

    public function cidade(){
        return $this->hasOne(Cidade::class, 'id_cidade' , 'id_cidade');
    }
}
