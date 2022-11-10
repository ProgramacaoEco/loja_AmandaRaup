<?php

namespace App\Http\Controllers;

use App\Models\NumeroVezes;
use DB;
use Illuminate\Http\Request;

class NumeroVezesController extends Controller
{
    public function getVezes() {
        $vezes = NumeroVezes::all();
        if(!empty($vezes)) {
            return response()->json($vezes, 200);
        } else {
            return response()->json('Número de vezes não cadastrado', 400);
        }
    }

    public function changeVezes(Request $req, $id) {
        $vezes = NumeroVezes::find($id);
        $vezes->update(['isActivy'=>$req->isActivy]);
        return response("Parcelas de $vezes->numero_vezes alterada!", 200);
    }

    public function getVezesActivy() {
        $vezes = NumeroVezes::where('isActivy', 'like', 1)->get();
        return response($vezes, 200);
    }


}
