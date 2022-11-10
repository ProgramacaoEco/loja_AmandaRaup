<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Campanha extends Model
{
    use HasFactory;
    protected $table = 'campanhas';
    protected $fillable = [
        'path'       
    ];
    protected $primaryKey = 'id_campanha';
    public $timestamps = false;

}
