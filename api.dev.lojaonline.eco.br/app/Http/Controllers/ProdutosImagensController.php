<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\ProdutoImagens;
use Illuminate\Http\Request;

class ProdutosImagensController extends Controller
{
    public function listaImagens(Request $req) {
        $id_produto = $req->id_produto;
        $images = ProdutoImagens::where('id_produto','LIKE',"$id_produto")->get();

        return response($images, 200);
    }

    public function store(Request $req, $id_produto) {
        $images = ($req->images);
        $image = new ProdutoImagens();

        if($images == null) {
            return response('Fail, images == null', 400);
        }

        foreach ($images as $key => $value)
        {
            if ( $value != null) {

                $extension = $value->getClientOriginalExtension();
                $filename = "produto.[$key]".rand(0,5).time().'.'.$extension;
                $path = $value->storeAs('produtos', $filename);
                $image::create([
                    'id_produto' => $id_produto,
                    'path'=> $path
                ]);

            }
        }
    }
}
