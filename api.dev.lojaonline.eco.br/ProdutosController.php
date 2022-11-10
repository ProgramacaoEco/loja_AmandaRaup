<?php

namespace App\Http\Controllers;

use DB;
use App\Models\Produtos;
use App\Models\ProdutoImagens;
use App\Models\ProdutoTamanhos;
use App\Models\PedidosProdutos;
use App\Models\Categoria;
use App\Models\Tamanhos;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;


class ProdutosController extends Controller
{


    public function request() {
        $produtos = Produtos::all();

        return response()->json($produtos, 200);
    }

    public function withTm(Request $req){
        $id = $req['id_produto'];
        $destaques = Produtos::with('imagens')
                               ->with('tamanhos')
                               ->where('id_produto', $id)
                               ->where('isActive', 1)
                               ->where('destaque', 1)
                               ->get();

        return response()->json($destaques, 200);
    }


    public function onlySpotlight()
    {
        $destaques = Produtos::with('imagens')->where('isActive', 1)->where('destaque', 1)->get();

        return response($destaques , 200);

    }
    public function byLike(Request $req)
    {
        $produto = $req->descricaoProduto;
        $produtos = Produtos::with('imagens')
        		 ->with('categoria')
                        ->where('descricaoProduto', 'like', "%$produto%")
                        ->where('isActive', 1)
                        ->get();
        if($produtos->isEmpty()){
             return response()->json(['message' => 'sem produtos'],400);
        }else{
            return $produtos;
        };


    }

    public function ByCategory(Request $req)
    {
        $categoria = $req['nome_categoria'];
        $data = Produtos::with('imagens')
                                ->join("categorias", "categorias.id_categoria", "produtos.id_categoria")
                                ->where("nome_categoria","$categoria")
                                ->where("produtos.isActive", 1)
                                ->get();
        return response($data , 200);
    }
    public function withTamanhos()
    {
        $produtos = Produtos::with('tamanhos')
                            ->where('isActive',  1)
                            ->get();
        return $produtos;
    }

    public function allAbout(Request $req)
    {
        $id = $req['id_produto'];
        $data = Produtos::with('tamanhos')->with('imagens')->with('categoria')->where('id_produto', $id)->first();


        return $data;
    }
    public function store(Request $req)
    {

        $dados = $req->images;
        $tamanhos = json_decode($req->tamanhos,true);
        $categoria = Categoria::where('nome_categoria', $req->nome_categoria)->first();
        $images = $req->images;

        $produto = Produtos::Create([
            'id_categoria' => $categoria->id_categoria,
            'nome_categoria' => $categoria->nome_categoria,
            'descricaoProduto'=> $req->descricaoProduto,
            'valor' => $req->valor,
            'descricao_pagamento' => $req->descricao_pagamento,
            'destaque'=> $req->destaque,
            'codigoProduto' => $req->codigoProduto,
        ]);


        if($images == null || $tamanhos == null){
        	return response('fail 400', 400);
        }


            foreach ($tamanhos as $key => $value)
        	{
            $id = Tamanhos::where('tamanho', $value)->first();


	     $create = new ProdutoTamanhos();
            $create = ProdutoTamanhos::create
            ([
                'id_produto' => $produto->id_produto,
                'id_tamanho' => $id->id_tamanho
            ]);
        	}



            foreach ($images as $key => $value)
        	{
            $image = new ProdutoImagens();


                   if ($value->isValid() && $value != null) {

                     $extension = $value->getClientOriginalExtension();
                     $filename  = "produto.[$key]". rand(0,5). time() .'.' . $extension;
                     $path = $value->storeAs('produtos', $filename);
                     $image::create([
                     	 'id_produto' => $produto->id_produto,
                        'path' => $path
                     ]);
                 }else{
                    echo 'invalido';
                 }
       	}
		return response('sucess',200);


    }
   public function put(Request $req)
     {
        $images = $req->images;
        $produto = Produtos::find($req['id_produto']);
	 $tamanhos = $req->tamanho;
        //$prodImagens = ProdutoImagens::where('id_produto', $req->id_produto)->get();
        $prodTamanhos = ProdutoTamanhos::where('id_produto', $req->id_produto)->get();
        //$beforeImagens = $prodImagens;
        $beforeTamanhos = $prodTamanhos;


        $categoria = Categoria::where('nome_categoria', $req->nome_categoria)->first();
        $produto->update([
            	'descricaoProduto'=> $req->descricaoProduto,
            	'valor' => $req->valor,
            	'descricao_pagamento'=> $req->descricao_pagamento,
            	'destaque' => $req->destaque,
            	'codigoProduto' => $req->codigoProduto,
            	'destaque' => $req->destaque
            ]);

        if($req->nome_categoria != null && $req->nome_categoria != ''){
        	$categoria = Categoria::where('nome_categoria', $req->nome_categoria)->first();
        	$produto->id_categoria = $categoria->id_categoria;
        }
        $produto->save();



        if($tamanhos != null){
            $delTamanho = ProdutoTamanhos::where('id_produto', $req->id_produto)->delete();
            foreach ($tamanhos as $tamanho => $value)
            {
            $id = Tamanhos::select('id_tamanho')->where('tamanho', $value)->first();
            $tamanho = new ProdutoTamanhos();

            $tamanho = ProdutoTamanhos::create
            ([
                'id_produto' => $req->id_produto,
                'id_tamanho' => $id->id_tamanho
            ]);
           }
        }




        if($produto->wasChanged()){
            return response()->json(['message'  => 'sucesso'], 200);
        }else if(!$produto->wasChanged()){
            return response('fail', 400);
        }else{
            return response('not found', 404);
        }
    }
    public function inativa(Request $req)
    {
        $id = $req['id_produto'];
        $produto = Produtos::find($id);
        $produto->isActive = 0;
        $produto->save();

        if($produto->wasChanged()){
            return response("$produto alterado com sucesso",200);
        }else{
            return response('erro', 404);
        }
    }

}
