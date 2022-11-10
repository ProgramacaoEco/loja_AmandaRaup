<?php

namespace App\Http\Controllers;
use App\Models\Bairro;
use App\Models\Cidade;
use DB;
use Illuminate\Http\Request;

class BairroController extends Controller
{
    public function byCity(Request $req)
    {
        $cidade = Cidade::select('id_cidade')->where('nome', "$req->cidade")->first();
       
        $bairros = Bairro::where('id_cidade', $cidade->id_cidade)->get();
        return $bairros;
    }

    public function byCityLike(Request $req)
    {
       
        $cidade = $req->cidade;
        $bairros = Bairro::select('id_bairro','bairro.nome', 'valor_frete')
                        ->join('cidades', '.cidades.id_cidade', 'bairro.id_cidade')
                        ->where('cidades.nome','like', "%$cidade%")->get();
        return $bairros;
    }
    
    public function store(Request $req)
    {
        $bairro = new Bairro();
        $bairro = $req->all();
        $id = Cidade::where('nome', "$req->cidade")->get();
        
        $store = Bairro::create([
            'nome' => $bairro["nome"],
            'id_cidade' => $id[0]->id_cidade,
            'valor_frete' => $bairro["valor_frete"]
        ]);
        return response($store, 200);
    }
    public function put(Request $req)
    {
        $bairro = Bairro::find($req->id_bairro);
        $bairro->update([
            'nome' => $req->bairro,
            'valor_frete' => $req->valor_frete
        ]);
        $bairro->save();
        
        if($bairro->wasChanged()){
            return response('sucess', 200);
        }else if(!$bairro->wasChanged()){
            return response('falha ao tentar editar', 400);
        }else{
            return response('not found', 404);
        }
    }

}
