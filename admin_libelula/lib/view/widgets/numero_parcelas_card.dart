import 'package:admin_newpedido/controller/formapagamento_controller.dart';
import 'package:admin_newpedido/model/parcela.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NumeroParcelasCard extends StatefulWidget {
  final Parcela parcela;
  const NumeroParcelasCard({this.parcela, Key key}) : super(key: key);

  @override
  State<NumeroParcelasCard> createState() => _NumeroParcelasCardState();
}

class _NumeroParcelasCardState extends State<NumeroParcelasCard> {
  final controller = Get.put(CadastroFormaPagamentoController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 3),
      color: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: Text(
                widget.parcela.parcela,
                style: TextStyle(fontSize: 14),
              ),
           ),
           Container(
              child: ElevatedButton(
                  onPressed: () {
                    controller.limparValores();
                    var ativo = widget.parcela.isActivy == 1 ? 0 : 1;
                    controller.selecionaParcelas(widget.parcela.id.toInt(), ativo.toInt());
                  },
                  style: widget.parcela.isActivy == 1
                  ? ElevatedButton.styleFrom(
                    primary: Colors.red
                  ) 
                  : ElevatedButton.styleFrom(
                    primary: Colors.green
                  ),
                  child: widget.parcela.isActivy == 1
                      ? Text('Desativar')
                      : Text('Ativar')),
            ),
          ],
        ),
      ),
    );
  }
}
