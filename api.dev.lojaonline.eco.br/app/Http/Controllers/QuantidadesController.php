<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Produtos;
use App\Models\Quantidades;
use App\Models\Tamanhos;
use Illuminate\Http\Request;

class QuantidadesController extends Controller
{
    public function index() {
        $quantidades = Quantidades::all();
        return response($quantidades, 200);
    }


    public function byLike($codigoProduto) {

        $quantidades = Quantidades::where('codigoProduto', 'LIKE', "%$codigoProduto%")
                                         ->with('produtos')
                                         ->with('tamanhos')
                                         ->get();
        return response($quantidades, 200);
     }

    public function storeByProdutoeTamanho(Request $req) {
        $id_produto = $req->id_produto;
        $id_tamanho = $req->id_tamanho;
        $quantidade = $req->quantidade;

        $tamanho = Tamanhos::find($id_tamanho);
        $produto = Produtos::find($id_produto);

        $quantidade = Quantidades::create([
            'id_tamanho' => $id_tamanho,
            'id_produto' => $id_produto,
            'quantidade' => $quantidade,
            'codigoProduto' => $produto->codigoProduto,
            'tamanho' => $tamanho->tamanho
        ]);
        return response($quantidade, 200);
    }

    public function store(Request $req) {
        $rawData = $req->all();
        $quantidade = Quantidades::create($rawData);
        return $quantidade;
    }

    public function update(Request $req, $id_qtde) {
        $quantidade = Quantidades::find($id_qtde);
        $quantidade->update(['quantidade'=>$req->quantidade]);
        $quantidade->save();

        return response('Success', 200);
    }

    public function listByProdutoeTamanho(Request $req) {
        $id_produto = $req->id_produto;
        $id_tamanho = $req->id_tamanho;
        $quantidade = Quantidades::where('id_produto', 'like', "%$id_produto%")
        ->where('id_tamanho', 'like', "%$id_tamanho%")->get();

        return response($quantidade, 200);
    }


}
