
import 'package:admin_newpedido/data/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var token;
  var dados;

  void onInit() {
    super.onInit();
  }

  void login(var usuario, var senha, var context) async {
    Get.snackbar('', "Logando...");
    var prefs = await SharedPreferences.getInstance();

    try {
      await Dio().post(
          '${Constants.BASE_URL}login',
          data: {"usuario": usuario, "senha": senha}).then((value) {
        dados = value.data;
        token = dados["token"];
        prefs.setString("token", token);

        if (value.statusCode == 200 || value.statusCode == 201) {
          Get.toNamed('/menu');
        } else if (value.statusCode == 401 || value.statusCode == 400) {
          Get.snackbar(
              '', 'Dados inválidos, verifique seus dados e tente novamente');
        } else {
          Get.snackbar('', 'Ocorreu um erro',
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      });
    } catch (error) {
      print(error);
    }
  }

  void deslogar() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    Get.offAllNamed("/principal");
  }

  void checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("token") == null) {
      Get.offAllNamed("/principal");
    }
  }

  void ableToPass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("token") != null) {
      Get.toNamed("/menu");
    }
  }
}
