<?php

use Illuminate\Support\Facades\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/


Route::post('/cadastroPrelogin', 'App\Http\Controllers\PreloginController@store');
Route::post('/auth/login', 'App\Http\Controllers\PreloginController@login');
Route::get('/listarCampanha', 'App\Http\Controllers\CampanhaController@list');
Route::get('/listarCategorias', 'App\Http\Controllers\CategoriasController@list');
Route::get('/listarprodutosdestaque', 'App\Http\Controllers\ProdutosController@onlySpotlight');
Route::get('/getProdutosDestaque', 'App\Http\Controllers\ProdutosController@getProdutosDestaque');
Route::get('/pagador', 'App\Http\Controllers\PreloginController@getPagadorId');


//Route::middleware(['tokenorcel'])->group(function () {
    //Categorias

    //campanhas

    //=============================================================================
    //      BAIRROS
    //=============================================================================
    Route::post('/listarBairros', 'App\Http\Controllers\BairroController@byCity');
    Route::post('/bairros', 'App\Http\Controllers\BairroController@store');
    Route::post('/listarBairroLike', 'App\Http\Controllers\BairroController@byCityLike');
    Route::put('/editarBairro', 'App\Http\Controllers\BairroController@put');

    //=============================================================================
    //      PRODUTOS
    //=============================================================================
    Route::post('/listarProdutosLike', 'App\Http\Controllers\ProdutosController@byLike');
    Route::post('/listarProdutosPorCategoria', 'App\Http\Controllers\ProdutosController@ByCategory');
    Route::get('/listarTudoProdutos/{id}', 'App\Http\Controllers\ProdutosController@allAbout');
    Route::get('/listarProduto/{id}', 'App\Http\Controllers\ProdutosController@listById');
    Route::post('/cadastrarProduto', 'App\Http\Controllers\ProdutosController@store');
    Route::post('/listarProodutosIN', 'App\Http\Controllers\ProdutosController@withTamanhos');
    Route::get('/todosOsProdutos', 'App\Http\Controllers\ProdutosController@request');
    Route::get('/tamanhosImagens', 'App\Http\Controllers\ProdutosController@withTm');
    Route::put('/inativarProduto/{id}', 'App\Http\Controllers\ProdutosController@inativa');
    Route::post('/editarProduto', 'App\Http\Controllers\ProdutosController@put');

            //imagens
    Route::get('/listarImagens', 'App\Http\Controllers\ProdutosImagensController@listaImagens');
    Route::post('/cadastrarImagens/{id_produto}', 'App\Http\Controllers\ProdutosImagensController@store');
    //=============================================================================
    //      TAMANHOS
    //=============================================================================
    // Route::get('/listarTamanhoMedida', 'App\Http\Controllers\TamanhosController@medida');
    // Route::get('/listarTamanhoComposto', 'App\Http\Controllers\TamanhosController@composto');
    // Route::get('/listarTamanhoNumerico', 'App\Http\Controllers\TamanhosController@numerico');
    Route::get('/listarTamanhos', 'App\Http\Controllers\TamanhosController@index');
    Route::get('/listarTamanho/{id}', 'App\Http\Controllers\TamanhosController@byId');
    Route::post('/cadastrarTamanho', 'App\Http\Controllers\TamanhosController@store');
    Route::put('/editarTamanho/{id}', 'App\Http\Controllers\TamanhosController@update');
    Route::delete('/excluirTamanho/{id}', 'App\Http\Controllers\TamanhosController@destroy');

    //=============================================================================
    //      QUANTIDADES
    //=============================================================================
    Route::get('/listarAllQtde', 'App\Http\Controllers\QuantidadesController@index');
    Route::post('/cadastrarQtde', 'App\Http\Controllers\QuantidadesController@store');
    Route::put('/editarQtde/{id_qtde}', 'App\Http\Controllers\QuantidadesController@update');
    Route::post('/listarOneQtde', 'App\Http\Controllers\QuantidadesController@listByProdutoeTamanho');
    Route::post('/cadastrarQtdeBy', 'App\Http\Controllers\QuantidadesController@storeByProdutoeTamanho');
    Route::get('/listarPorProduto/{codigoProduto}', 'App\Http\Controllers\QuantidadesController@byLike');

    //=============================================================================
    //      PAGAMENTOS
    //=============================================================================
    Route::post('/listarFormas', 'App\Http\Controllers\PagamentoController@vezesByForm');
    Route::get('/listarFormas', 'App\Http\Controllers\PagamentoController@index');
    Route::get('/listarVezes', 'App\Http\Controllers\PagamentoController@indexVezes');
    Route::post('/cadastrarFormaPagamento', 'App\Http\Controllers\PagamentoController@storeVezesForma');
    Route::post('/editarForma', 'App\Http\Controllers\PagamentoController@updateForma');
    Route::get('/getVezes', 'App\Http\Controllers\NumeroVezesController@getVezes');
    Route::put('/changeVezes/{id}', 'App\Http\Controllers\NumeroVezesController@changeVezes');
    Route::get('/listarVezesActivy', 'App\Http\Controllers\NumeroVezesController@getVezesActivy');

    //=============================================================================
    //      CIDADES
    //=============================================================================
    Route::get('/getCities', 'App\Http\Controllers\CidadesController@getRS');
    Route::get('/getCitiesByName', 'App\Http\Controllers\CidadesController@cityLike');

    //=============================================================================
     //     PEDIDOS
    //=============================================================================
    Route::get('/listarPedido', 'App\Http\Controllers\PedidosController@index');
    Route::get('/listarPedidoById/{id_pedido}', 'App\Http\Controllers\PedidosController@byId');
    Route::post('/cadastrarPedido', 'App\Http\Controllers\PedidosController@store');
    Route::get('/listarBasicoPedidos', 'App\Http\Controllers\PedidosController@basic');
    Route::put('/editarStatusPedido/{id_pedido}', 'App\Http\Controllers\PedidosController@putStatus');

    //=============================================================================
    //       ESTADOS
    //=============================================================================
    Route::get('/getState', 'App\Http\Controllers\EstadoController@getState');
    Route::get('/getStateById/{id}', 'App\Http\Controllers\EstadoController@getStateById');
    Route::get('/getStateByName', 'App\Http\Controllers\EstadoController@getStateByName');
//});
//Route::middleware(['verificaToken'])->group(function () {

    //=============================================================================
    //      CATEGORIA
    //=============================================================================
    Route::put('/inativarCategoria', 'App\Http\Controllers\CategoriasController@inativa');
    Route::post('/cadastrarCategoria', 'App\Http\Controllers\CategoriasController@store');
    Route::post('/cadastrarCategoriaNoImage', 'App\Http\Controllers\CategoriasController@insert');

    //=============================================================================
    //      CAMPANHA
    //=============================================================================
    Route::post('/cadastrarCampanha', 'App\Http\Controllers\CampanhaController@store');
    Route::delete('/deletarCampanha', 'App\Http\Controllers\CampanhaController@destroy');


    //=============================================================================
    //      LOGIN E CADASTRO / USUARIOS
    //=============================================================================
    Route::get('/prelogin', 'App\Http\Controllers\PreloginController@listPrelogin');
    Route::post('/login', 'App\Http\Controllers\AdminController@login');
    Route::post('/criarConta', 'App\Http\Controller\UserController@register');

    //USUARIOS
    Route::post('/criarUsuario', 'App\Http\Controllers\AdminController@register');
    Route::get('/listarAdmins', 'App\Http\Controllers\AdminController@index');
    Route::put('/editarAdmins', 'App\Http\Controllers\AdminController@edit');
    Route::delete('/deletarAdmins', 'App\Http\Controllers\AdminController@destroy');

//});




