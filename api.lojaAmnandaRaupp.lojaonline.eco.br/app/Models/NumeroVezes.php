<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class NumeroVezes extends Model
{
    use HasFactory;
    protected $table = 'numero_vezes';
    protected $fillable = [
        'numero_vezes',
        'isActivy'
    ];

    protected $primaryKey = 'id';
    public $timestamps = false;

}
