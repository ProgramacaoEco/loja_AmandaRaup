<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\DB;
use App\Models\Campanha;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
class CampanhaController extends Controller
{
    public function list(){
        return Campanha::all();
    }


    public function store(Request $req){

    //deleta campanhas
    	if($req->images == 'deletar'){
    	    DB::table('campanhas')->truncate();
    	    return response('deletado com sucesso', 200);
    	}else{
           $campanha = new Campanha();
           $dados = $req->images;
              foreach ($dados as $key => $value) {
                   if ($value->isValid() && $value != null) {

                     $extension = $value->getClientOriginalExtension();
                     $filename  = "campanha.[$key]". rand(0,5). time() .'.' . $extension;
                     $path = $value->storeAs('app/public/campanhas', $filename);
                     $campanha::create([
                        'path' => $path
                     ]);
                 }else{
                    echo 'invalido';
                 }
             }
    	}

        return $dados;





        /*$images = $req->file('images');
        for ($i = 0; $i < count($images); $i++){
            if ($images[$i]-> isValid()){
                $extension = $images[0][$i]->getClientOriginalExtension();
                $filename  = 'campanha' . time() . '.' . $extension;
                $path = $images[0][$i]->storeAs('campanhas', $filename);
                $paths[] = $path;
                //$path = $image->store('campanhas');

               // DB::insert("insert into campanhas (path) values ($path)");
                Campanha::create([
                    'path' => $path
                ]);
            }else if(!$images[$i]-> isValid()){
                return response()->json(['message' =>'invalido'],400);
            }else{
                return response('fail', 404);
            }

        }*/
       /* foreach ($images as $image) {

            if ($image-> isValid()){
                $extension = $image->getClientOriginalExtension();
                $filename  = 'campanha' . time() . '.' . $extension;
                $path = $image->storeAs('campanhas', $filename);
                $paths[] = $path;
                //$path = $image->store('campanhas');

               // DB::insert("insert into campanhas (path) values ($path)");
                Campanha::create([
                    'path' => $path
                ]);
            }else if(!$image-> isValid()){
                return response()->json(['message' =>'invalido'],400);
            }else{
                return response('fail', 404);
            }

		}*/

    }


    public function getbtid(Request $req){
        return Campanha::find($req['id_campanha']);
    }
    public function destroy(Request $id_campanha)
    {

        $id = $id_campanha['id_campanha'] ;
        // Recupera o usuário pelo seu id
        if ( !$campanha = Campanha::find($id) )
            return response(Campanha::find(6))/*->json(['message' =>'categria não encontrada'], 400)*/;

        // Deleta o registro do usuário
        if ( $campanha->delete()  ) {
            // Deleta a imagem (Não esqueça: use Illuminate\Support\Facades\Storage;)
            Storage::delete("{$campanha->path}"); // true ou false
            // Redireciona, informando que deu tudo certo!
            $results = $campanha->delete();

             return response()
                      ->json(['message' =>"$campanha->path}"], 200);


        // Em caso de falhas redireciona o usuário de vola e informa que não foi possível deletar
        return response()
                    ->json(['message' => 'falha ao deletar']);
        }
    }
}
