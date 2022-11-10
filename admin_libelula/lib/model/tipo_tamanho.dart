import 'package:flutter/cupertino.dart';

class TipoTamanho with ChangeNotifier {
  final int id; 
  final String tipo;

  TipoTamanho({
    this.id, 
    this.tipo
  });
  
}