<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class Admin extends Model
{
    use HasFactory;
    protected $table  = 'admin';
    protected $fillable = [
        'usuario',
        'token'
    ];
    protected $primaryKey = 'id_usuario';
    public $timestamps = false;
}
