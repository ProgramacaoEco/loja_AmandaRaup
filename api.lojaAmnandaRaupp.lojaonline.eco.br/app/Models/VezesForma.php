<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class VezesForma extends Model
{
    use HasFactory;
    protected $table = 'vezes_forma';
    protected $fillable = [ 
        'id_forma',
        'numero_vezes',
    ];
    protected $primaryKey = 'id_vezes_forma';
    public $timestamps = false;
}
