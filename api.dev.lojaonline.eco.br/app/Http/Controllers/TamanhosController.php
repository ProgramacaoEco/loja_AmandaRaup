<?php

namespace App\Http\Controllers;

use DB;
use App\Models\Tamanhos;
use Illuminate\Http\Request;

class TamanhosController extends Controller
{

    public function index() {
        $tamanhos = Tamanhos::all();
        return response($tamanhos, 200);
    }

    public function byId($id) {
        $tamanhos = Tamanhos::find($id);
        return response($tamanhos, 200);
    }

    public function store(Request $req)
    {
        $rawData = $req->all();
        $tamanho = Tamanhos::create($rawData);
        return response($tamanho, 200);
    }

    public function update(Request $req, $id) {
        $tamanho = Tamanhos::find($id);
        $tamanho->update(['tamanho'=>$req->tamanho]);
        $tamanho->save();

        $retorno = Tamanhos::all();
        return response($retorno, 200);

    }

    public function destroy($id) {
        $tamanho = Tamanhos::find($id)->delete();

        if($tamanho) {
            return response("Sucess!", 200);
        } else return ('Error!');



    }
}
