import 'package:admin_newpedido/data/dummy_data.dart';
import 'package:admin_newpedido/model/decoration_textfield.dart';
import 'package:admin_newpedido/model/produto.dart';
import 'package:admin_newpedido/model/quantidade.dart';
import 'package:admin_newpedido/model/tamanho.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/locaisentrega_controller.dart';

class CardEstoqueProduto extends StatefulWidget {
  final Quantidade quantidade;
  CardEstoqueProduto(this.quantidade, {Key key}) : super(key: key);

  @override
  State<CardEstoqueProduto> createState() => _CardEstoqueProdutoState();
}

class _CardEstoqueProdutoState extends State<CardEstoqueProduto> {
  final controller = Get.put(LocaisEntregaController());

  @override
  Widget build(BuildContext context) {
    TextEditingController _quantidade =
        TextEditingController(text: widget.quantidade.quantidade.toString());

    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.grey.shade100,
              Colors.grey.shade50,
            ],
          ),
          borderRadius: BorderRadius.circular(8)),
      height: 80,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 136,
                      ),
                      Text(
                        widget.quantidade.codigoProduto,
                        style: TextStyle(fontSize: 18),
                      ),
                      
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                       SizedBox(
                        width: 106,
                      ),
                      Container(
                        width: 150,
                        child: Text(widget.quantidade.descricaoProduto,
                            style: TextStyle(fontSize: 18)),
                      ),
                      
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 176,
                      ),
                      Text(
                        widget.quantidade.tamanho,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 56,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 10),
                        height: 65,
                        width: 75,
                        child: TextFormField(
                            controller: _quantidade,
                            decoration: InputDecoration(labelText: 'Qtde.')),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          int valueQtdeController = int.parse(_quantidade.text);
                          print(valueQtdeController);
                          controller.editarQuantidade(
                              widget.quantidade.id, valueQtdeController);
                        },
                        child: Text('Atualizar'),
                        style: ButtonStyle(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
