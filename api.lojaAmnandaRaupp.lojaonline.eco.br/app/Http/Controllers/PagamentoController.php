<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\DB;
use App\Models\FormaPagamento;
use App\Models\VezesForma;
use App\Models\NumeroVezes;
use Illuminate\Http\Request;

class PagamentoController extends Controller
{
   public function index()
   {
       return FormaPagamento::all();
   }
   public function store(Request $req)
   {
        $forma = FormaPagamento::create($req ->all());
        return response($forma, 200);
   }
   public function indexVezes()
   {
        $vezes = DB::table('numero_vezes')->groupBy('numero_vezes')->orderBy(DB::raw('sum(numero_vezes)'))->get();
        return response($vezes , 200);
   }
   public function storeVezesForma(Request $req)
   {
   	$forma = FormaPagamento::create([
   			'descricao_forma' => $req->descricao_forma
   		]);
        $VZF = new VezesForma();

        $numeroVezes = $req->numero_vezes ;
        foreach ($numeroVezes as $key => $value) {
            $VZF::create([
                'id_forma' => $forma->id_forma,
                'numero_vezes'=> $value
            ]);
        };
        return response('sucess', 200);
   }
   public function vezesByForm(Request $req)
   {
       $forma = FormaPagamento::select('id_forma')->where('descricao_forma', $req->descricao_forma)->first();
       $vezesForma = VezesForma::where('id_forma', $forma->id_forma)->get();

       return $vezesForma;
    }
    public function updateForma(Request $req)
    {
        $numero_vezes = $req->numero_vezes;
        $forma = FormaPagamento::where('descricao_forma', $req->descricao_forma)->first();
        if($forma == null){
            return response()->json(
                ['message'=> 'dados invalidos tente novamente']
                , 400);
        }

        $delete = VezesForma::where('id_forma', $forma->id_forma)->delete();

            foreach ($numero_vezes as $key => $value) {
                $insert = VezesForma::create
                ([
                    'id_forma'=> $forma->id_forma,
                    'numero_vezes' => $value
                ]);
            }
            return response('SUCESS', 200);


    }
}
