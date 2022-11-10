<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Tymon\JWTAuth\Contracts\JWTSubject;

class Prelogin extends Authenticatable implements JWTSubject
{
    use HasFactory;
    use Notifiable;

    protected $table = 'prelogin';
    protected $fillable = [
        'id_pagador',
        'nome',
        'cpf',
        'email',
        'senha',
        'telefone',
        'uf',
        'municipio',
        'cep',
        'bairro',
        'logradouro',
        'numero',
        'complemento'

    ];
    protected $primaryKey = 'id_prelogin';

    /*public function pedido(){
        return $this->hasOne(Pedido::class, 'pagador_id', 'id_prelogin');
    }*/

    /**
     * Get the identifier that will be stored in the subject claim of the JWT.
     *
     * @return mixed
     */
    public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    /**
     * Return a key value array, containing any custom claims to be added to the JWT.
     *
     * @return array
     */
    public function getJWTCustomClaims()
    {
        return [];
    }

}

