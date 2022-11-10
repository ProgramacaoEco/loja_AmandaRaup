import 'dart:convert';

import 'package:admin_newpedido/data/constants.dart';
import 'package:admin_newpedido/model/tamanho.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TamanhoList with ChangeNotifier {
  List<Tamanho> _items = [];

  List<Tamanho> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  Future<void> index(int id) async {
    _items.clear();

    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    await Dio()
        .get("${Constants.BASE_URL}listarTamanhoByTipo/$id",
            options: Options(headers: {"token": token}))
        .then((response) {
      var tamanhosLista = response.data;

      for (var tamanho in tamanhosLista) {
        _items.add(
          Tamanho(
              id: tamanho['id_tamanho'],
              tamanho: tamanho['tamanho'],
              idTipoTamanho: tamanho['id_tipo_tamanho']),
        );
      }
    });
    notifyListeners();
  }

  Future<void> store(int idTipo, String tamanho) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var Data = jsonEncode({"tamanho": tamanho, "id_tipo_tamanho": idTipo});

    await Dio()
        .post("${Constants.BASE_URL}cadastrarTamanho",
            data: Data, options: Options(headers: {"token": token}))
        .then((response) {
          index(idTipo);
        });
  }

  Future<void> delete(int id, int idTipo) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    await Dio()
        .delete("${Constants.BASE_URL}excluirTamanho/$id",
            options: Options(headers: {"token": token}))
        .then((response) {
      index(idTipo);
    });
  }

  Future<void> put(int id, int idTipo, String tamanho) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    await Dio()
        .put("${Constants.BASE_URL}editarTamanho/$id",
            data: {"tamanho": tamanho},
            options: Options(headers: {"token": token}))
        .then((response) {
      index(idTipo);
    });
  }
}
