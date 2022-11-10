<?php

namespace App\Http\Controllers;

use DB;
use App\Models\Produtos;
use App\Models\ProdutoImagens;
use App\Models\Quantidades;
use App\Models\PedidosProdutos;
use App\Models\Categoria;
use App\Models\Tamanhos;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Symfony\Component\HttpFoundation\Response;


class ProdutosController extends Controller
{


    public function request() {
        $produtos = Produtos::all();

        return response()->json($produtos, 200);
    }

    public function withTm(Request $req){
        $id = $req['id_produto'];
        $destaques = Produtos::with('imagens')->with('tamanhos')->where('id_produto', $id)->where('isActive', 1)->where('destaque', 1)->get();

        return response()->json($destaques, 200);
    }

    public function getProdutosDestaque() {
        $produtosDestaque = Produtos::with('imagens')->with('quantidades')->where('isActive', 1)->where('destaque', 1)->get();

        return response($produtosDestaque, 200);
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

    public function allAbout($id)
    {
        $id_produto = $id;
        $data = Produtos::with('imagens')->with('categoria')->with('quantidades')->find($id_produto);

        if($data){
            return response()->json($data, 200);
        }
        else{
            return response()->json('id não encontrado', 409);
        }
    }


    public function store(Request $req)
    {
        //$tamanhos = json_decode($req->tamanhos,true);
        $tamanhos = ($req->tamanhos);
        $categoria = Categoria::where('nome_categoria', $req->nome_categoria)->first();
        $images = $req->images;
        $codigoProduto = $req->codigoProduto;

        if($req->id_categoria == null){
            return response()->json([
                'message' => 'id_categoria não informado',
            ], 422);
        }
        $produto = Produtos::Create([
            'id_categoria' => $categoria->id_categoria,
            'nome_categoria' => $categoria->nome_categoria,
            'descricaoProduto'=> $req->descricaoProduto,
            'valor' => $req->valor,
            'descricao_pagamento' => $req->descricao_pagamento,
            'destaque'=> $req->destaque,
            'codigoProduto' => "P-$codigoProduto",
        ]);


        if($tamanhos == null){
        	return response('fail 400', 400);
        }


            foreach ($tamanhos as $key => $value)
        	{
            $id = Tamanhos::where('tamanho', $value)->first();


	     $create = new Quantidades();
            $create = Quantidades::create
            ([
                'id_produto' => $produto->id_produto,
                'id_tamanho' => $id->id_tamanho,
                'codigoProduto' => "P=$codigoProduto"
            ]);
        	}



            // foreach ($images as $key => $value)
        	// {
            // $image = new ProdutoImagens();


            //        if ( $value != null) {

            //          $extension = $value->getClientOriginalExtension();
            //          $filename  = "produto.[$key]". rand(0,5). time() .'.' . $extension;
            //          $path = $value->storeAs('produtos', $filename);
            //          $image::create([
            //          	 'id_produto' => $produto->id_produto,
            //             'path' => $path
            //          ]);
            //      }else{
            //         echo 'invalido';
            //      }
        	// }
		return response($produto,200);


    }


    public function put(Request $req)
    {
        $images = $req->images;
        $produto = Produtos::find($req['id_produto']);
	    $tamanhos = $req->tamanho;
        //$prodImagens = ProdutoImagens::where('id_produto', $req->id_produto)->get();
        $prodTamanhos = Quantidades::where('id_produto', $req->id_produto)->get();
        //$beforeImagens = $prodImagens;
        $beforeTamanhos = $prodTamanhos;

        $categoria = Categoria::where('nome_categoria', $req->nome_categoria)->first();
        $produto->update([
            	'descricaoProduto'=> $req->descricaoProduto,
            	'valor' => $req->valor,
            	'descricao_pagamento'=> $req->descricao_pagamento,
            	'destaque' => $req->destaque,
            	'codigoProduto' => $req->codigoProduto
            ]);

        if($req->nome_categoria != null && $req->nome_categoria != ''){
        	$categoria = Categoria::where('nome_categoria', $req->nome_categoria)->first();
        	$produto->id_categoria = $categoria->id_categoria;
        }
        $produto->save();

        if($tamanhos != null){
            $delTamanho = Quantidades::where('id_produto', $req->id_produto)->delete();
            foreach ($tamanhos as $tamanho => $value)
            {
            $id = Tamanhos::select('id_tamanho')->where('tamanho', $value)->first();
            $tamanho = new Quantidades();

            $tamanho = Quantidades::create
            ([
                'id_produto' => $req->id_produto,
                'quantidade' => $req->quantidade,
                'id_tamanho' => $id->id_tamanho,
                'codigoProduto' => $produto->codigoProduto
            ]);
           }
        }

        if($produto->wasChanged()){
            return response()->json(['message'  => 'sucesso'], Response::HTTP_OK);
        }else if(!$produto->wasChanged()){
            return response('fail', 400);
        }else{
            return response('not found', 404);
        }
    }


    public function inativa($id)
    {
        $produto = Produtos::where('id_produto', $id)->first();
        $produto->isActive = 0;
        $produto->save();

        if($produto->isActive === 0){
            return response()->json([
                "produto"  => $produto,
                "response" => "$produto->descricaoProduto numero $produto->id_produto desativado com sucesso"
            ], Response::HTTP_OK);
        }
        else if(empty($produto)) {
            return response()->json(["produto invalido"], Response::HTTP_BAD_REQUEST);
        }
        else{
            return response()->json(["não foi possível desativar o produto"], Response::HTTP_BAD_REQUEST);
        }
    }


    // public function updateImages(Request $req) {

    //     $img1 = ProdutoImagens::find($req->id_img1);
    //     $img1->update(['path'=>$req->path1]);
    //     $img1->save();

    //     $img2 = ProdutoImagens::find($req->id_img2);
    //     $img2->update(['path'=>$req->path2]);
    //     $img2->save();

    //     $img3 = ProdutoImagens::find($req->id_img3);
    //     $img3->update(['path'=>$req->path3]);
    //     $img3->save();

    //     return response('Imagens alteradas com sucesso', 200);

    //     $images = $req->images;

    //     foreach ($images as $key => $value)
    //     	{


    //                if ( $value != null) {

    //                 //  $extension = $value->getClientOriginalExtension();
    //                 //  $filename  = "produto.[$key]". rand(0,5). time() .'.' . $extension;
    //                 //  $path = $value->storeAs('produtos', $filename);
    //                 $path = $value->path;
    //                  $image = ProdutoImagens::find($value->id);
    //                  $value->update(['path'=>$path]);
    //              }else{
    //                 echo 'invalido';
    //              }
    //    	}
    // }

}
