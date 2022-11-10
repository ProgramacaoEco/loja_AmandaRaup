<?php

namespace App\Http\Controllers;
use App\Models\Estado;
use App\Models\Cidade;
use Illuminate\Http\Request;


class EstadoController extends Controller
{
    public function getState() {
        $estados = Estado::with('cidades')->get();
        return response()->json($estados);
    }

    public function getStateById($id) {
        $estados = Estado::with('cidades')->find($id);
        if(!empty($estados)) {
            return response()->json($estados, 200);
        } else {
              return response()->json('Esse id não existe :(', 401);
          }
    }

    public function getStateByName(Request $req) {
        $query = Estado::query();
        if($req->has('uf')){
            $query->with('cidades')->where('uf', 'LIKE', '%'.$req->uf.'%');
        }
        $estado = $query->get();
        return response()->json($estado, 200);
    }
}
