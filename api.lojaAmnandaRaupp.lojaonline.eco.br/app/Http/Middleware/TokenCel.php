<?php

namespace App\Http\Middleware;
use App\Models\Admin;
use App\Models\Prelogin;
use Closure;
use Illuminate\Http\Request;

class TokenCel
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle(Request $req, Closure $next)
    {
        $token = $req->header('token');
        $senha = $req->header('senha');

        if($token == null && $senha == null){
            return response()->json(['message'=>'sem permissão'] , 401);
        }else{
            $admin = Admin::select('id_usuario')->where('token', "$token");
            $senha = Prelogin::select('id_prelogin')->where('senha' , "$senha");

            if($admin->count() == 0 && $senha->count() == 0){
                    return response()->json(['message'=>'sem permissão'] , 401);
                }else{
                    return $next($req);
                }
        };

    }
}
