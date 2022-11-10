<?php

namespace App\Http\Controllers;
use App\Models\Cidade;
use Illuminate\Http\Request;

class CidadesController extends Controller
{
    public function getRS(){
        $cidades = Cidade::with('estado')->get();
        return response()->json($cidades);
    }


    public function cityLike(Request $req){
        $query = Cidade::query();
        if($req->has('nome')) {
            $query->with('estado')
                  ->where('nome', 'LIKE', '%'. $req->nome .'%');
        }
        $cidade = $query->get();
        return response()->json($cidade);
    }
}
