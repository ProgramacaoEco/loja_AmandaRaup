import 'dart:convert';

import 'package:admin_newpedido/data/constants.dart';
import 'package:admin_newpedido/data/dummy_data.dart';
import 'package:admin_newpedido/model/quantidade.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as x;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../model/produto.dart';

class LocaisEntregaController extends x.GetxController {
  void onInit() {
    super.onInit();
    quantidades.clear();
    listarQuantidades("P-");
  }

  List quantidades = [].obs;

  void editarQuantidade(id, quantidade) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    try {
      final response = await http.put(
          Uri.parse('${Constants.BASE_URL}editarQtde/$id'),
          body: {"quantidade": quantidade.toString()});

      print(quantidade);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 400 || response.statusCode == 401 || response.statusCode == 404) {
        x.Get.snackbar('', 'Ocorreu um erro inesperado!',
            backgroundColor: Colors.red, colorText: Colors.white);

      } else if (response.statusCode == 200 || response.statusCode == 201) {
        x.Get.snackbar('', 'Estoque do produto alterado com sucesso!',
            backgroundColor: Colors.green, colorText: Colors.white);
      }
    } catch (error) {
      print(error);
      x.Get.snackbar('', 'Ocorreu um erro inesperado!',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void listarQuantidades(codigoProduto) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    try {
      print('searching quantitys of $codigoProduto');

      final response = await http.get(
        Uri.parse('${Constants.BASE_URL}listarPorProduto/$codigoProduto'),
      );
      List data = jsonDecode(response.body);
      quantidades.clear();
      if (response.statusCode == 400) {
        print('Não há itens');
        return;
      }
      if (response.statusCode == 200) {
        for (var i = 0; i < data.length; i++) {
          print(data[i]);
          quantidades.add(Quantidade(
              id: data[i]['id_qtde'],
              quantidade: data[i]['quantidade'] ?? 0,
              id_produto: data[i]['id_produto'],
              id_tamanho: data[i]['id_tamanho'],
              tamanho: data[i]['tamanhos']['tamanho'],
              codigoProduto: data[i]['produtos']['codigoProduto'],
              descricaoProduto: data[i]['produtos']['descricaoProduto']));
        }
      }
    } catch (error) {
      print(error);
    }
  }
}
