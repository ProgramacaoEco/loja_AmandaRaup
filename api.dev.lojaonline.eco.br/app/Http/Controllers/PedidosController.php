<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use App\Models\Pedido;
use App\Models\ItensPedido;
use MelhorEnvio\Resources\Shipment\Product;
use MelhorEnvio\Shipment;
use MelhorEnvio\Resources\Shipment\Package;
use MelhorEnvio\Enums\Service;
use MelhorEnvio\Enums\Environment;


use Illuminate\Http\Request;

class PedidosController extends Controller
{

    public function index()
    {
        $itens_pedido = Pedido::with('itensPedido')->get();
        if(!empty($itens_pedido)){
            return response()->json($itens_pedido);
        } else {
            return response()->json('nenhum pedido encontrado :(', 200);
        }

    }


    public function byId($id)
    {
        $pedido = Pedido::with('itensPedido')->find($id);
        if($pedido){
            return response()->json($pedido, 200);
        }else{
            return response()->json('id não encontrado :(');
        }
    }


    public function store(Request $req)
    {
        $access_token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjEwMjNjYzdjOGJkZTg2NTM2NGI4MDRkNTY2YWM5YmQyZmI3ZTIzZTgwOTlhZGQ0ZWNlMzllZTE1MTg1YzExYWUyNzExMTIwNzM4YjUxZDg5In0.eyJhdWQiOiIxIiwianRpIjoiMTAyM2NjN2M4YmRlODY1MzY0YjgwNGQ1NjZhYzliZDJmYjdlMjNlODA5OWFkZDRlY2UzOWVlMTUxODVjMTFhZTI3MTExMjA3MzhiNTFkODkiLCJpYXQiOjE2NjQzNjY1MDYsIm5iZiI6MTY2NDM2NjUwNiwiZXhwIjoxNjk1OTAyNTA2LCJzdWIiOiJiZWUxYjRmNy0zNmU5LTQ0NDctOTJkMS1lM2NkNWFkMGQ2MWIiLCJzY29wZXMiOlsiY2FydC1yZWFkIiwiY2FydC13cml0ZSIsImNvbXBhbmllcy1yZWFkIiwiY29tcGFuaWVzLXdyaXRlIiwiY291cG9ucy1yZWFkIiwiY291cG9ucy13cml0ZSIsIm5vdGlmaWNhdGlvbnMtcmVhZCIsIm9yZGVycy1yZWFkIiwicHJvZHVjdHMtcmVhZCIsInByb2R1Y3RzLWRlc3Ryb3kiLCJwcm9kdWN0cy13cml0ZSIsInB1cmNoYXNlcy1yZWFkIiwic2hpcHBpbmctY2FsY3VsYXRlIiwic2hpcHBpbmctY2FuY2VsIiwic2hpcHBpbmctY2hlY2tvdXQiLCJzaGlwcGluZy1jb21wYW5pZXMiLCJzaGlwcGluZy1nZW5lcmF0ZSIsInNoaXBwaW5nLXByZXZpZXciLCJzaGlwcGluZy1wcmludCIsInNoaXBwaW5nLXNoYXJlIiwic2hpcHBpbmctdHJhY2tpbmciLCJlY29tbWVyY2Utc2hpcHBpbmciLCJ0cmFuc2FjdGlvbnMtcmVhZCIsInVzZXJzLXJlYWQiLCJ1c2Vycy13cml0ZSIsIndlYmhvb2tzLXJlYWQiLCJ3ZWJob29rcy13cml0ZSIsInRkZWFsZXItd2ViaG9vayJdfQ.22IdyzsQWDpCOa4fl3xw9XK9lnjiHZ2spGBd_rd8eLDCLJ84Bgf8EKeOUdNo0RqqWi8DQa6839dOZWoBBsgYYoYZYbU57ia9H2sgY83dyNXBq5QSUy0ENWFjUdueVSkJ-6qwxm63l3lFjddJ3NavfLVkeEOe6o80S_llmwCoE0qhytql3Ro5ycCp55mrQzPy9Y2c44vheZw__-XNCXGI_7HuRJrmi9r5os0Hs4YNFX3CBubgcdKKGsTu0YY91llnzytUob63fWRq2R0-VAO8GboYE9HWlMAvjf5Ck4H4dOLQFQp0XLSmwItgqn2UVCurVF4j18j1fI9B7nvnErZT7-iGeK4B9q_-MffX3cmVk0GTtApmfL4U28D95ZFOQbqIFF4NCZVpM07HRsV1G9V3QndFAflqVqFmLimei4T1CUXP-STmWxbXU5HYm9NuYvoem6zpb6po-PgLOqLYCo3xQdERNLYVVuVPmJzxFqavoYUfmIIu96C_niqlgWcbm-6hS_KME-c8_Y2ueHBfRK84NwNPXPcDrvdC9WLvH9JxfDi9jPWFmFjxrRZfodKiXf14amm0biWcLRKNYxLEDbDWKz2mr57YRN8bH-EeRYdiCDaTlixm2sgp6Hy6FJbzK1TyuNzTSgo_s2B6zfpg4ogxuFC8vQBffrITXnUrI4_X2wk';
        $pedido_req = $req;
        $itens = $req['itens_pedido'];
        $valorPedido = doubleval($pedido_req['valor']);


            $pedidos = Pedido::create([
            'valor' => $valorPedido,
            'vezes_pagamento' => $pedido_req['vezes_pagamento'],
            'forma_pagamento' => $pedido_req['forma_pagamento'],
            'nome_cliente' => $pedido_req['nome_cliente'],
            'cpf/cnpj' =>  $pedido_req['cpf/cnpj'],
            'telefone' => $pedido_req['telefone'],
            'uf' => $pedido_req['uf'],
            'cep' => $pedido_req['cep'],
            'cidade' => $pedido_req['cidade'],
            'endereco_entrega' => $pedido_req['endereco_entrega'],
            'bairro' => $pedido_req['bairro'],
            'complemento' => $pedido_req['complemento'],
            'status_pedido' => $pedido_req['status_pedido'],
        ]);

        foreach($itens as $value) {

            $itensPedido = ItensPedido::create
            ([
            'id_produto' => $value['id_produto'],
            'tamanho' => $value['tamanho'],
            'quantidade' => $value['quantidade'],
            'valor_unitario' => $value['valor_unitario'],
            'id_pedido' => $pedidos->id_pedido,
            'descricaoProduto' => $value['descricaoProduto'],
            'codigoProduto' => $value['codigoProduto'],
            ]);

        }

        $data = Pedido::with('itensPedido')->find($pedidos->id_pedido);
        $produtos = $data->itensPedido;

        $shipment = new Shipment($access_token, Environment::PRODUCTION);
        $calculator = $shipment->calculator();
        $calculator->postalCode('01153000', $pedidos->cep);

        echo '<pre>';
        print_r($produtos);
        echo '</pre>';

        if($produtos != null || $produtos != ''){
            foreach($produtos as $produto) {
                $calculator->addProducts(
                    new Product($produto->id_produto, 40, 30, 50, 10.00,
                        floatval($produto->valor_unitario), intval($produto->quantidade))
                );
            }

            $calculator->addServices(
                Service::CORREIOS_PAC,
                Service::CORREIOS_SEDEX,
                Service::CORREIOS_MINI,
            );

            $quotations = $calculator->calculate();

            return response()->json([
                "dados" => $data,
                "frete" => $quotations
            ], 200);
        }

        return response()->json(
            ['message' => "não há nenhum produto para calcular o frete"], 403);

    }

    public function basic(Request $req)
    {
       $query = Pedido::query();
       if($req->has('status_pedido')) {
           $query->with('itensPedido')->where('status_pedido', 'LIKE', '%'.$req->status_pedido.'%');
       }
       $pedidos = $query->get();
       return response()->json($pedidos);
    }


    public function putStatus(Request $req, $id)
    {
       $data = Pedido::with('itensPedido')->find($id);
       $data->status_pedido = $req->status_pedido;
       $data->save();

        return response()->json($data, 200);



    }


    public function listPending()
    {
        $pedidos = Pedido::with('itensPedido')->whereIn('status_pedido', array('recebido', 'pendente'))->get();
        return response()->json($pedidos);
    }
}
