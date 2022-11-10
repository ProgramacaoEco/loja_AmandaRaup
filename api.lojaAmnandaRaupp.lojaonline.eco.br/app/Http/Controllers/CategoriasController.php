<?php

namespace App\Http\Controllers;
use DB;
use App\Models\Categoria;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class CategoriasController extends Controller
{
    public function list()
    {
         $categorias = Categoria::where('isActive', 1)->get();
         return response($categorias, 200);
    }

     public function store(Request $req)
    {
        $data = new Categoria();
        $data = $req->all();

            if ($req ->image-> isValid()){
                $image = $req ->image-> store('categorias');
                $data['image'] = $image;
            }

            $categoria = Categoria::create([
                'nome_categoria' => $data['nome_categoria'],
                'path' => $image,
            ]);

        return response($req,200);
    }

    public function insert(Request $req) {
        $rawData = $req->all();
        $rawData['image'] = $req->image;
        $categoria = Categoria::create($rawData);
        return response($categoria, 200);
    }



    public function inativa(Request $req)
    {
        $categoria = Categoria::find($req['id_categoria']);
        $categoria->isActive = 0;
        $categoria->save();
            if($categoria->wasChanged()){
                return response($categoria,200);
            }else if (!$categoria->wasChanged()){
                return response()->json(['message' => 'erro, verifique os dados e tente nvamente',
                                        'alert'=> 'verifique se a categoria ja não esta inativada'], 403);
            }else {
                return response('error', 404);
            }
    }
}
