import 'package:admin_newpedido/data/constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Quantidade {
  final int id;
  final int quantidade;
  final int id_produto;
  final int id_tamanho;
  final String codigoProduto;
  final String tamanho;
  final String descricaoProduto;
  List<Quantidade> items = [];


  Quantidade({this.items = const [], this.codigoProduto, this.descricaoProduto, this.tamanho, this.id, this.id_produto, this.id_tamanho, this.quantidade});

  int get itemsCount {
    return items.length;
  }


}