<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\Request;
use App\Models\Admin;


class AdminController extends Controller
{

    public function index()
    {
        return Admin::all();
    }
    public function register(Request $req)
    {
        $novaSenha = $req->novaSenha; //pegando o corpo da requisição e transformando em uma variavel
        $senha = \bcrypt($novaSenha); // gerando token encriptado da $novaSenha
        $admin = Admin::create([
            'usuario' => $req->novoUsuario,
            'token' => $senha
        ]);                             //criando um novo model admin com o novoUsuario(corpo da requisiçã) e senha($novaSenha criptografada)
        return response()->json(['message'=>'sucesso em criar admin'] , 200);    // retornando mensagem e status 200(sucesso)
    }
     public function login(Request $req)
    {
        if($req->usuario == null){ //validando que o usuario não deixou o campo de usuario em branco
            return response ()->json(['message'=>'preencha seu usuario corretamente'],400);
        }
        if($req->senha == null ){ //validando que o usuario não deixou o campo de senha em branco
            return response ()->json(['message'=>'preencha sua senha corretamente'],400);
        }
        $admin = Admin::where('usuario', $req->usuario)->first(); //verificando se esse usuario existe
        if($admin == null){
            return response()->json(['message'=>'usuario invalido, tente novamente'], 401);
        }
        $token = $admin['token']; //buscando o hash da senha do usuario existente no bancoo

        //comparações do hash da senha do usuario com a senha digitada
       if($admin->count() == 0){
            return response ()->json(['message'=>'usuario incorreto'],401);
        }else if(!Hash::check("$req->senha", $token)){
            return response()->json(['message'=> 'senha incorreta'], 401);
        }else if(Hash::check("$req->senha", $token)){
            //return $admin; //se tudo ok então retorna $admin + status(200)
            return response()->json(["usuario" => $admin->usuario, "token" => $admin->token], 200);
        }else{
            return response()->json(['message'=> 'notFound'], 404);
        }
    }


    public function edit(Request $req)
    {
        $admin = Admin::find($req['id_usuario']);
        if($admin == null){
            return response()->json(['message' => 'usuario não encontrado'], 400);
        }
        $admin->update([
            'usuario' => $req->usuario,
            'token' => \bcrypt($req->senha)
        ]);
        $admin->save();
        if(!$admin->wasChanged())
            return response()->json(['message' => 'falha ao editar'],400);
        else if($admin->wasChanged())
            return response()->json(['message' => 'sucesso']);
        else{
            return response()->status(404);
        }
    }

    public function destroy(Request $req){
        if($req->codigo_permissao == '123'){
            $id = Admin::where('usuario', "$req->usuario_deletado")->first();
            $deletado = Admin::destroy($id->id_usuario);
            if($deletado == 1){
                return response('sucess', 200);
            }else {
                return response('falha ao deletar', 406);
            }
        }else{
            return response()->json(
                ['message' => 'codigo de permissão invalido']
                , 403);
        }
    }
}
