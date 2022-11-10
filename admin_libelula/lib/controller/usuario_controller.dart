import 'package:admin_newpedido/data/constants.dart';
import 'package:get/get.dart' as x;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsuarioController extends x.GetxController {
  void onInit() {
    super.onInit();
    listarUsuarios();
  }

  List<Map<String, dynamic>> usuarios = <Map<String, dynamic>>[];
  var codigoPermissao = '123';

  void salvar(var context, var usuario, var senha, var confirmarSenha) async {
    if (usuario.isEmpty ||
        usuario.length < 0 ||
        usuario == '' ||
        usuario == null ||
        senha.isEmpty ||
        senha.length < 0 ||
        senha == '' ||
        senha == null) {
      x.Get.snackbar('', 'Preencha todos os campos corretamente');
    } else {
      if (senha != confirmarSenha) {
        x.Get.snackbar('', 'As senhas não conferem');
      } else {
        var prefs = await SharedPreferences.getInstance();
        var token = prefs.getString('token');
        try {
          x.Get.snackbar('', 'Salvando...');
          await Dio().post(
              '${Constants.BASE_URL}criarUsuario',
              options: Options(headers: {'token': token}),
              data: {
                'novoUsuario': usuario,
                'novaSenha': senha,
              }).then((value) {
            if (value.statusCode == 200 || value.statusCode == 201) {
              usuarios.clear();
              listarUsuarios();
              x.Get.back();
              x.Get.back();
              x.Get.snackbar('', 'Usuário cadastrado com sucesso');
            }
          });
        } catch (error) {
          if (error.toString().contains('403')) {
            x.Get.snackbar(
                '', 'Usuário já existente, tente outro nome de usuário');
          } else {
            x.Get.snackbar('', 'Ocorreu um erro',
                backgroundColor: Colors.red, colorText: Colors.white);
          }
        }
      }
    }
  }

  void novo(var context, var usuario, var senha, var confirmarSenha) async {
    if (usuario.isEmpty ||
        usuario.length < 0 ||
        usuario == '' ||
        usuario == null ||
        senha.isEmpty ||
        senha.length < 0 ||
        senha == '' ||
        senha == null) {
      x.Get.snackbar('', 'Preencha todos os campos corretamente');
    } else {
      if (senha != confirmarSenha) {
        x.Get.snackbar('', 'As senhas não conferem');
      } else {
        x.Get.snackbar('', "Salvando...");
        var prefs = await SharedPreferences.getInstance();
        var token = prefs.getString('token');
        try {
          await Dio().post(
              '${Constants.BASE_URL}criarUsuario',
              options: Options(headers: {'token': token}),
              data: {
                'novoUsuario': usuario,
                'novaSenha': senha,
              }).then((value) {
            if (value.statusCode == 200 || value.statusCode == 201) {
              usuarios.clear();
              listarUsuarios();
              x.Get.back();
              x.Get.back();
              x.Get.toNamed('/menu/cadastroUsuarios');
              x.Get.snackbar('', 'Usuário cadastrado com sucesso');
            }
          });
        } catch (error) {
          if (error.toString().contains('403')) {
            x.Get.snackbar(
                '', 'Usuário já existente, tente outro nome de usuário');
          } else {
            x.Get.snackbar('', 'Ocorreu um erro',
                backgroundColor: Colors.red, colorText: Colors.white);
          }
        }
      }
    }
  }

  Future listarUsuarios() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    await Dio()
        .get('${Constants.BASE_URL}listarAdmins',
            options: Options(headers: {'token': token}))
        .then((value) {
      var dados = value.data;
      for (var i = 0; i < dados.length; i++) {
        usuarios.add(
          {'usuario': dados[i]['usuario'], 'id': dados[i]['id_usuario']},
        );
      }
    });
    return usuarios;
  }

  void inativar(var context, var usuario, var codigoPermissao) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var usuarioPrefs = prefs.getString('usuario');

    if (usuarioPrefs == usuario) {
      x.Get.snackbar('', 'Não é possível fazer alterações no usuário atual');
    } else {
      x.Get.back();
      x.Get.snackbar('', "Inativando...");
      try {
        await Dio()
            .delete('${Constants.BASE_URL}deletarAdmins',
                data: {
                  'usuario_deletado': usuario,
                  'codigo_permissao': codigoPermissao
                },
                options: Options(headers: {'token': token}))
            .then((value) {  
          if (value.statusCode == 200 || value.statusCode == 201) {
            x.Get.back();
            x.Get.back();
            usuarios.clear();
            listarUsuarios();
            x.Get.snackbar('', 'Usuário inativado com sucesso');
          }
        });
      } catch (error) {
        if (error.toString().contains('401')) {
          x.Get.snackbar('', 'Não permitido');
          x.Get.back();
        } else {
          x.Get.snackbar('', 'Ocorreu um erro',
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      }
    }
  }

  void editar(var context, var usuario, var senha, var idUsuario) async {
    if (usuario.isEmpty ||
        usuario.length < 0 ||
        usuario == '' ||
        usuario == null ||
        senha.isEmpty ||
        senha.length < 0 ||
        senha == '' ||
        senha == null) {
      x.Get.snackbar('', 'Preencha todos os campos corretamente');
    } else {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var usuarioPrefs = prefs.getString('usuario');

      if (usuarioPrefs == usuario) {
        x.Get.snackbar('', 'Não é possível fazer alterações no usuário logado');
      } else {
        x.Get.snackbar('', "Salvando...");
        try {
          await Dio()
              .put('${Constants.BASE_URL}editarAdmins',
                  data: {
                    'usuario': usuario,
                    'senha': senha,
                    'id_usuario': idUsuario
                  },
                  options: Options(headers: {'token': token}))
              .then((value) => {
                    if (value.statusCode == 201 || value.statusCode == 200)
                      {
                        usuarios.clear(),
                        listarUsuarios(),
                        x.Get.back(),
                        x.Get.back(),
                        x.Get.snackbar('', 'Usuário editado com sucesso'),
                      }
                  });
        } catch (error) {
          x.Get.back();
          x.Get.snackbar('', 'Ocorreu um erro',
              backgroundColor: Colors.red, colorText: Colors.white);
          x.Get.back();
          x.Get.back();
        }
      }
    }
  }
}
