import 'dart:html';

import 'package:admin_newpedido/data/constants.dart';
import 'package:intl/intl.dart';

import '../model/pedido.dart';
import 'package:get/get.dart' as x;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:async';

class ControllerPedidos extends x.GetxController {
  Timer timer;
  bool carregou = false;
  var value = 0.0;

  @override
  void onInit() {
    obterPedidos();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var pedidos = <Widget>[].obs;

  imprimir(
      var produtos,
      var quantidades,
      var codigoBarras,
      var valores,
      var tamanhos,
      var numeroPedido,
      var status,
      var dataPedido,
      var nomeCliente,
      var cpf,
      var telefone,
      var uf,
      var bairro,
      var cidade,
      var logradouro,
      var complemento,
      var cep,
      var formaPagamento,
      var numeroVezes,
      var somaTotal) {
    final pdf = pw.Document();

    if (valores.length != 0) {
      for (int i = 0; i < valores.length; i++) {
        value = value + double.parse(valores[i]);
      }
      print(value);
    }

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.roll57,
        build: (pw.Context context) {
          return pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Column(children: [
                  pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Container(
                        margin: const pw.EdgeInsets.symmetric(vertical: 1),
                        child: pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: <pw.Text>[
                              pw.Text(
                                'Eco Sistemas e Soluções',
                                style: pw.TextStyle(
                                  fontSize: 5,
                                ),
                              ),
                              pw.Text(
                                'CNPJ: 111111111-1/10',
                                style: pw.TextStyle(
                                  fontSize: 5,
                                ),
                              ),
                            ]),
                      ),
                      pw.Container(
                        margin: const pw.EdgeInsets.symmetric(vertical: 1),
                        child: pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                'Rua da Alta Tensão',
                                style: pw.TextStyle(
                                  fontSize: 5,
                                ),
                              ),
                              pw.Text(
                                'Bairro Mariápolis',
                                style: pw.TextStyle(
                                  fontSize: 5,
                                ),
                              ),
                              pw.Text(
                                'nº 234',
                                style: pw.TextStyle(
                                  fontSize: 5,
                                ),
                              ),
                            ]),
                      ),
                      pw.Container(
                        margin: const pw.EdgeInsets.symmetric(vertical: 1),
                        child: pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text('Capão da Canoa ',
                                  style: pw.TextStyle(
                                    fontSize: 5,
                                  )),
                              pw.Text('CEP: 95590-000',
                                  style: pw.TextStyle(
                                    fontSize: 5,
                                  )),
                            ]),
                      ),
                      pw.Container(
                        margin: const pw.EdgeInsets.symmetric(vertical: 3),
                        child: pw.Row(
                          children: [
                            pw.Expanded(child: pw.Divider(height: 0.25))
                          ],
                        ),
                      ),
                      pw.Container(
                        margin: const pw.EdgeInsets.symmetric(vertical: 3),
                        child: pw.Row(
                          children: [
                            pw.Text(
                              'NÃO É DOCUMENTO FISCAL  - SIMPLES PEDIDO DE MERCADORIA',
                              style: pw.TextStyle(
                                fontSize: 4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      pw.Container(
                        margin: const pw.EdgeInsets.symmetric(vertical: 3),
                        child: pw.Row(
                          children: [
                            pw.Expanded(child: pw.Divider(height: 0.25))
                          ],
                        ),
                      ),
                      pw.Container(
                        margin: const pw.EdgeInsets.symmetric(vertical: 1),
                        child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'Pedido nº ${numeroPedido.toString()}',
                              style: pw.TextStyle(
                                fontSize: 5,
                              ),
                            ),
                            pw.Text('Status: ${status}',
                                style: pw.TextStyle(
                                  fontSize: 5,
                                )),
                            pw.Text(dataPedido,
                                style: pw.TextStyle(
                                  fontSize: 5,
                                )),
                          ],
                        ),
                      ),
                      pw.Container(
                        margin: const pw.EdgeInsets.symmetric(vertical: 1),
                        child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'Cliente: $nomeCliente',
                              style: pw.TextStyle(
                                fontSize: 5,
                              ),
                            ),
                            pw.Text('CPF/CNPJ: $cpf',
                                style: pw.TextStyle(
                                  fontSize: 5,
                                )),
                          ],
                        ),
                      ),
                      pw.Container(
                        margin: const pw.EdgeInsets.symmetric(vertical: 1),
                        child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Telefone: ${telefone}',
                                style: pw.TextStyle(fontSize: 5)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  pw.Container(
                    margin: const pw.EdgeInsets.symmetric(vertical: 3),
                    child: pw.Divider(height: 0.25),
                  ),
                  pw.Container(
                    child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: <pw.Widget>[
                          pw.Text(
                            'Código',
                            style: pw.TextStyle(fontSize: 5),
                          ),
                          pw.Text(
                            'Produto',
                            style: pw.TextStyle(fontSize: 5),
                          ),
                          pw.Text(
                            'Qtde.',
                            style: pw.TextStyle(fontSize: 5),
                          ),
                          pw.Text(
                            'Valor:',
                            style: pw.TextStyle(fontSize: 5),
                          ),
                        ]),
                  ),
                  pw.Container(
                      child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: List.generate(produtos.length, (index) {
                            return pw.Container(
                                margin:
                                    const pw.EdgeInsets.symmetric(vertical: 5),
                                child: pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: <pw.Widget>[
                                      pw.Text(
                                        codigoBarras[index],
                                        style: pw.TextStyle(fontSize: 5),
                                      ),
                                      pw.Text(
                                        '${produtos[index]} (${tamanhos[index]})',
                                        style: pw.TextStyle(fontSize: 5),
                                      ),
                                      pw.Text(
                                        quantidades[index],
                                        style: pw.TextStyle(fontSize: 5),
                                      ),
                                      pw.Text(
                                        '${valores[index].replaceAll(".", ",")}',
                                        style: pw.TextStyle(fontSize: 5),
                                      ),
                                    ]));
                          }))),
                  pw.Container(
                    margin: const pw.EdgeInsets.symmetric(vertical: 3),
                    child: pw.Row(
                      children: [pw.Expanded(child: pw.Divider(height: 0.25))],
                    ),
                  ),
                  pw.Container(
                    margin: const pw.EdgeInsets.symmetric(
                        horizontal: 2, vertical: 1),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Valor total: ',
                            style: pw.TextStyle(fontSize: 8)),
                        pw.Text(
                          'R\$${somaTotal.toString().replaceAll('.', ',')}',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ],
                    ),
                  ),
                  pw.Container(
                    margin: const pw.EdgeInsets.symmetric(
                        horizontal: 2, vertical: 1),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'Pagamento: ',
                          style: pw.TextStyle(fontSize: 6),
                        ),
                        pw.Text('${numeroVezes} ${formaPagamento}',
                            style: pw.TextStyle(fontSize: 6))
                      ],
                    ),
                  ),
                  pw.Container(
                    margin: const pw.EdgeInsets.symmetric(
                        vertical: 1, horizontal: 2),
                    child: pw.Column(
                      children: [
                        pw.Container(
                          margin: const pw.EdgeInsets.symmetric(vertical: 3),
                          child: pw.Row(children: [
                            pw.Expanded(child: pw.Divider(height: 0.5))
                          ]),
                        ),
                        pw.Container(
                          child: pw.Row(
                            children: [
                              pw.Text('Endereço de entrega: ',
                                  style: pw.TextStyle(fontSize: 7)),
                            ],
                          ),
                        ),
                        pw.Container(
                          margin: const pw.EdgeInsets.symmetric(vertical: 1),
                          child: pw.Column(
                            children: [
                              pw.Row(children: [
                                pw.Text(
                                  "Cidade: $cep/$cidade-$uf",
                                  style: pw.TextStyle(fontSize: 5),
                                ),
                              ]),
                              pw.Row(
                                children: [
                                  pw.Text(
                                    'Bairro: ',
                                    style: pw.TextStyle(fontSize: 5),
                                  ),
                                  pw.Text(
                                    '$bairro',
                                    style: pw.TextStyle(fontSize: 5),
                                  ),
                                ],
                              ),
                              pw.Row(
                                children: [
                                  pw.Text(
                                    'Logradouro/nº:',
                                    style: pw.TextStyle(fontSize: 5),
                                  ),
                                  pw.Text(
                                    logradouro,
                                    style: pw.TextStyle(fontSize: 5),
                                  )
                                ],
                              ),
                              pw.Row(
                                children: [
                                  pw.Text(
                                    'Complemento: ',
                                    style: pw.TextStyle(fontSize: 5),
                                  ),
                                  pw.Text(
                                    complemento,
                                    style: pw.TextStyle(fontSize: 5),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ])
              ]);
        }));

    Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  obterPedidos() async {
    var prefs = await SharedPreferences.getInstance();

    List quanti = [];
    List codProd = [];
    List valore = [];
    List tamanh = [];
    List itens = [];

    pedidos.clear();
    var token = prefs.getString('token');
    try {
      await Dio()
          .get('${Constants.BASE_URL}listarPedido',
              options: Options(headers: {'token': token}))
          .then((value) {
        var dados = value.data.reversed.toList();
        for (var i = 0; i < dados.length; i++) {
          var exe = dados[i]['itens_pedido'];

          quanti = [];
          codProd = [];
          valore = [];
          tamanh = [];
          itens = [];

          var data = dados[i]['data_pedido'];
          var corte = data.split("T");
          var corteUm = corte[0].split("-");

          dados[i]['data_pedido'] = "${corteUm[2]}-${corteUm[1]}-${corteUm[0]}";

          for (var z = 0; z < exe.length; z++) {
            String qtde = exe[z]['quantidade'];
            String codbar = exe[z]['codigoProduto'];
            String val = exe[z]['valor_unitario'];
            String taman = exe[z]['tamanho'];
            String it = exe[z]['descricaoProduto'];

            quanti.add(qtde);
            codProd.add(codbar);
            valore.add(val);
            tamanh.add(taman);
            itens.add(it);
          }
          if (dados[i]['status_pedido'] != 'faturado' &&
              dados[i]['status_pedido'] != 'cancelado') {
            pedidos.add(Pedido(
              telefone: dados[i]["telefone"],
              dataPedido: dados[i]["data_pedido"],
              logradouro: dados[i]["endereco_entrega"],
              cep: dados[i]['cep'],
              bairro: dados[i]["bairro"],
              cidade: dados[i]["cidade"],
              complemento: dados[i]['complemento'],
              uf: dados[i]['uf'],
              nomeCliente: dados[i]['nome_cliente'],
              cpf: dados[i]['cpf/cnpj'],
              numeroPedido: dados[i]['id_pedido'],
              produtos: itens,
              status: dados[i]['status_pedido'],
              tamanhos: tamanh,
              quantidades: quanti,
              somaTotal: dados[i]['valor'],
              codigoBarras: codProd,
              valores: valore,
              formaPagamento: dados[i]['forma_pagamento'],
              numeroVezes: dados[i]['vezes_pagamento'],
            ));
          }
        }

        print(pedidos.length);
      });
      carregou = true;
      return pedidos;
    } on DioError catch (e, s) {
      print(e);
      print(s);
    }
  }

  void receber(var context, var idPedido) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    try {
      await Dio().put('${Constants.BASE_URL}editarStatusPedido/$idPedido',
          options: Options(headers: {'token': token}),
          data: {'status_pedido': 'recebido'}).then((value) {
        if (value.statusCode == 200 || value.statusCode == 201) {
          // x.Get.back();
          // x.Get.toNamed('/menu/pedidos');
          x.Get.snackbar('', "Status alterado com sucesso");
          obterPedidos();
        }
      });
    } catch (error) {
      x.Get.snackbar('', 'Ocorreu um erro',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void faturar(var context, var idPedido) {
    x.Get.dialog(
      AlertDialog(
        title: Text("Confirmar faturamento"),
        content: Text(
          'Você tem certeza que deseja faturar o pedido nº$idPedido?',
          style: TextStyle(color: Colors.black54),
        ),
        actions: [
          Container(
            margin: EdgeInsets.all(8),
            child: ElevatedButton(
                onPressed: () async {
                  var prefs = await SharedPreferences.getInstance();
                  var token = prefs.getString('token');
                  try {
                    await Dio().put(
                        '${Constants.BASE_URL}editarStatusPedido/$idPedido',
                        options: Options(headers: {'token': token}),
                        data: {'status_pedido': 'faturado'}).then((value) {
                      if (value.statusCode == 200 || value.statusCode == 201) {
                        x.Get.back();
                        x.Get.toNamed('/menu/pedidos');
                        obterPedidos();
                        x.Get.snackbar('', "Status alterado com sucesso");
                      }
                    });
                  } catch (error) {
                    x.Get.back();
                    x.Get.toNamed('/menu/pedidos');
                    obterPedidos();
                    x.Get.snackbar('', 'Ocorreu um erro',
                        backgroundColor: Colors.red, colorText: Colors.white);
                  }
                },
                child: Text("Confirmar")),
          )
        ],
      ),
      // barrierColor: Colors.green
    );
  }

  void cancelar(var context, var idPedido) async {
    x.Get.dialog(AlertDialog(
      title: Text("Confirmar cancelamento"),
      content: Text(
        'Você tem certeza que deseja cancelar o pedido nº$idPedido?',
        style: TextStyle(color: Colors.black54),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            var prefs = await SharedPreferences.getInstance();
            var token = prefs.getString('token');

            try {
              await Dio().put(
                  '${Constants.BASE_URL}editarStatusPedido/$idPedido',
                  options: Options(headers: {'token': token}),
                  data: {'status_pedido': 'cancelado'}).then((value) {
                if (value.statusCode == 200 || value.statusCode == 201) {
                  x.Get.back();
                  x.Get.toNamed('/menu/pedidos');
                  obterPedidos();
                  x.Get.snackbar('', "Pedido cancelado com sucesso");
                }
              });
            } catch (error) {
              x.Get.back();
              x.Get.toNamed('/menu/pedidos');
              obterPedidos();
              x.Get.snackbar('', 'Ocorreu um erro',
                  backgroundColor: Colors.red, colorText: Colors.white);
            }
          },
          child: Text('Confirmar'),
        ),
      ],
    ));
  }
}
