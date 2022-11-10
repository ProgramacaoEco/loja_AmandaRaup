<?php

namespace App\Http\Controllers;
use DB;
use App\Models\Prelogin;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Mockery\Generator\StringManipulation\Pass\Pass;

class PreloginController extends Controller
{
    public function listPrelogin(){
        return Prelogin::all();
    }


    public function store(Request $req){
        $data = new Prelogin();
        $data = $req->all();

        $prelogin = Prelogin::Create([
            'id_pagador' => $data['id_pagador'],
            'nome' => $data['nome'],
            'cpf' => $data['cpf'],
            'email'=> $data['email'],
            'senha' => bcrypt($data['senha']),
            'telefone' => $data['telefone'],
            'uf' => $data['uf'],
            'municipio' => $data['municipio'],
            'cep' => $data['cep'],
            'bairro' => $data['bairro'],
            'logradouro' => $data['logradouro'],
            'numero' => $data['numero'],
            'complemento' => $data['complemento']
        ]);

        $cpf = Prelogin::where('cpf', $prelogin->cpf)->first();
        $tel = Prelogin::where('telefone', $prelogin->telefone)->first();
        if($cpf && $tel){
            return response()->json(["message" => "cpf já cadastrado"], 402);
        }
        return response()->json($prelogin, 200);
    }

    public function login(Request $req) {
        $array = ['error' => ''];

        $tel = $req->input('telefone');
        $password = $req->input('password');

        $token = auth()->attempt([
            'telefone' => $tel,
            'password' => $password,
        ]);

        if(!$token) {
            return response()->json(['error' => 'Usuario não autorizado'], 401);
        }

        $info = auth()->user();
        $array['data'] = $info;
        $array['token'] = $token;

        return response()->json($array, 200);
    }

    public function getPagadorId(Request $req) {

        $query = Prelogin::query();
        if($req->has('cpf')) {
            $query->where('cpf', 'LIKE', '%' .$req->cpf. '%');
        }
        $id_pagador_pre_login = $query->select('id_pagador')->first()->id_pagador;
        return response()->json($id_pagador_pre_login);

    }
}
