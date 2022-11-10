import 'package:flutter/widgets.dart';

class Produto with ChangeNotifier{
  final int id; 
  final int idCategoria;
  final String descricaoProduto;
  final double valor;
  final String descricaoPagamento;
  final int destaque;
  final String codigoProduto;

  Produto({
     this.id,
     this.idCategoria,
     this.descricaoProduto,
     this.valor,
     this.descricaoPagamento,
     this.destaque,
     this.codigoProduto,
  }); 

}