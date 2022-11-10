<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Request;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Tymon\JWTAuth\Facades\JWTAuth;
use Tymon\JWTAuth\Exceptions\JWTException;
use Mail;
use App\Mail\PasswordReset;
use Tymon\JWTAuth\Contracts\JWTSubject;

//use JWTAuth;

class UserController extends Controller
{
    public function register(Request $request){
        $plainPassword = $request->password;
        $password = bcrypt($request->password);
        $request->request->add(['password' => $password]);
        // create the user account
        $created = User::create($request->all());
        $request->request->add(['password' => $plainPassword]);
        // login now..
        return $this->login($request);
    }

    public function login(Request $request)
    {

        $input = $request->only('email', 'password');
        $jwt_token = null;
        if (!$jwt_token = JWTAuth::attempt($input)) {
            return response()->json([
                'success' => false,
                'message' => 'Invalid Email or Password',
            ], 401);
        }
        // get the user
        $user = Auth::user();

        return response()->json([
            'success' => true,
            'token' => $jwt_token,
            'user' => $user
        ]);
    }

public function update(Request $request, $data){
    $user=$this->getCurrentUser($request);
    if(!$user){
        return response()->json([
            'success' => false,
            'message' => 'User is not found'
        ]);
    }

    unset($data['token']);

    $updatedUser = User::where('id', $user->id)->update($data);
    $user =  User::find($user->id);

    return response()->json([
        'success' => true,
        'message' => 'Information has been updated successfully!',
        'user' =>$user
    ]);
}
}
