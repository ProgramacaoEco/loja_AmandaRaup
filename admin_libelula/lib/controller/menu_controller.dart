import 'package:admin_newpedido/data/constants.dart';
import 'package:get/get.dart' as x;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

class MenuController extends x.GetxController {
  Timer timer;

  var response = [];

  void onInit() {
    super.onInit();
    giraNovosPedidos();
    timer = Timer.periodic(Duration(seconds: 60), (timer) {
      //obterPedidos();
      giraNovosPedidos();
    });
  }

  giraNovosPedidos() async {
    var prefs = await SharedPreferences.getInstance();
    print(response.length);
    //if ( response.length != 0) {
    prefs.setInt('qtdePedAtual', response.length);
    // }

    // print(response.length);

    var token = prefs.getString('token');
    try {
      await Dio()
          .get(
              '${Constants.BASE_URL}listarPedido',
              options: Options(headers: {'token': token}))
          .then((value) {
        response = value.data;

        if (response.length > prefs.getInt('qtdePedAtual')) {
          x.Get.dialog(
              AlertDialog(
                title: Text("Novo pedido!"),
                actions: [
                  ElevatedButton(
                      onPressed: () => x.Get.back(), child: Text("Ok"))
                ],
              ),
              barrierDismissible: false,
              barrierColor: Colors.green);
          prefs.setInt('qtdePedAtual', response.length);
        }
      });
    } catch (error) {
      x.Get.snackbar('', 'Ocorreu um erro',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}