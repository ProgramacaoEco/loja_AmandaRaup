<?php

namespace App\Http\Middleware;
use DB;
use Closure;
use App\Models\Admin;
use Illuminate\Http\Request;
use Inertia\Inertia;
class Token
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
        if($token == null){
            return response()->json(['message'=>'sem permissão'] , 401);
        }else{
            $admin = Admin::select('id_usuario')->where('token', "$token");
                if($admin->count() == 0 ){
                    echo $token;
                    return response()->json(['message'=>'sem permissão'] , 401);
                }else{
                    return $next($req);
                }       
        };
        
        
    }
}
