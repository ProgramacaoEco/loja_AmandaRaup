import 'package:admin_newpedido/data/constants.dart';
import 'package:admin_newpedido/model/tipo_tamanho.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TipoTamanhoList with ChangeNotifier {
  List<TipoTamanho> _items = [];

  List<TipoTamanho> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  Future<void> index() async {
    _items.clear();

    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    await Dio()
        .get("${Constants.BASE_URL}getTiposTamanhos",
            options: Options(headers: {"token": token}))
        .then((response) {
      var tipoTamanhosLista = response.data;

      for (var tipoTamanho in tipoTamanhosLista) {
        _items.add(
            TipoTamanho(id: tipoTamanho['id_tipo_tamanho'], tipo: tipoTamanho['tipo']));
      }
    });
    notifyListeners();
  }
}
