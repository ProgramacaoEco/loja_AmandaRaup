import 'dart:convert';

import 'package:admin_newpedido/data/constants.dart';
import 'package:admin_newpedido/model/parcela.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as x;
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CadastroFormaPagamentoController extends x.GetxController {
  void onInit() {
    super.onInit();
    limparValores();
    listarParcelas();
  }

  var listaParcelas = <MultiSelectItem>[].obs;
  var dpSelecaoParcela = [].obs;
  var listParcelas = [].obs;

  void listarParcelas() async {
    var response = await http.get(
      Uri.parse('${Constants.BASE_URL}getVezes'),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      var dados = jsonDecode(response.body);
      for (var i = 0; i < dados.length; i++) {
        listaParcelas.add(MultiSelectItem(
            dados[i]["id"], dados[i]["numero_vezes"]));
            listParcelas.add(Parcela(
              id: dados[i]['id'], 
              isActivy: dados[i]['isActivy'], 
              parcela: dados[i]['numero_vezes']
              )
            );
      }
      update(listParcelas);
    }
  }

 void selecionaParcelas(int idParcela, int newStatus) async {
   print('alterando parcela');
   print(idParcela);
   var response = await http.put(
     Uri.parse('${Constants.BASE_URL}changeVezes/${idParcela}'),
     body: {
       "isActivy": newStatus.toString(),
     }
   );
   if (response.statusCode == 200 || response.statusCode == 201) {
     print(response.body);
     limparValores();
     listarParcelas();

   } else {
     print(response.statusCode);
   }
 }

  void limparValores() {
    listParcelas.clear();
  }
}
