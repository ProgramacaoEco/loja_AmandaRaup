import 'dart:html';

import 'package:admin_newpedido/data/constants.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart' as x;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ControllerPedidosFaturados extends x.GetxController {
  var faturados = [];

  Future obterPedidosFaturados(var estado) async {
    faturados.clear();

    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    try {
      await Dio().get('${Constants.BASE_URL}listarBasicoPedidos',
          options: Options(headers: {'token': token}),
          queryParameters: {'status_pedido': estado}).then((value) {
        faturados = value.data.reversed.toList();

        for (var i = 0; i < faturados.length; i++) {
          var data = faturados[i]['data_pedido'];
          var corte = data.split("T");
          var corteUm = corte[0].split("-");

          faturados[i]['data_pedido'] =
              "${corteUm[2]}-${corteUm[1]}-${corteUm[0]}";
        }
      });
      return faturados;
    } catch (error) {}
  }

  reimprimir(var idPedido) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var dados;
    var dataPedido;
    var produtos = [];
    try {
      await Dio()
          .get('${Constants.BASE_URL}listarPedidoById/$idPedido',
              options: Options(headers: {'token': token}))
          .then((value) {
        dados = value.data;

        for (var i = 0; i < faturados.length; i++) {
          var data = faturados[i]['data_pedido'];
          var corte = data.split("T");
          var corteUm = corte[0].split("-");

          dataPedido = "${corteUm[2]}-${corteUm[1]}-${corteUm[0]}";
        }

        print(dados);
        produtos = dados['itens_pedido'];
        print(produtos);
      });

      final pdf = pw.Document();

      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.roll57,
          build: (pw.Context context) {
            var data = dados['data_pedido'];
            var corte = data.split("T");
            var corteUm = corte[0].split("-");

            dataPedido = "${corteUm[2]}-${corteUm[1]}-${corteUm[0]}";


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
                          margin: const pw.EdgeInsets.symmetric(vertical: 1),
                          child: pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                'Pedido nº ${dados['id_pedido'].toString()}',
                                style: pw.TextStyle(
                                  fontSize: 5,
                                ),
                              ),
                              pw.Text('Status: ${dados['status_pedido']}',
                                  style: pw.TextStyle(
                                    fontSize: 5,
                                  )),
                              pw.Text('${dataPedido}',
                                  style: pw.TextStyle(
                                    fontSize: 5,
                                  )),
                            ],
                          ),
                        ),
                        pw.Container(
                          margin: const pw.EdgeInsets.symmetric(vertical: 1),
                          child: pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                'Cliente: ${dados['nome_cliente']}',
                                style: pw.TextStyle(
                                  fontSize: 5,
                                ),
                              ),
                              pw.Text('CPF/CNPJ: ${dados['cpf/cnpj']}',
                                  style: pw.TextStyle(
                                    fontSize: 5,
                                  )),
                            ],
                          ),
                        ),
                        pw.Container(
                          margin: const pw.EdgeInsets.symmetric(vertical: 1),
                          child: pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text('Telefone: ${dados['telefone']}',
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
                                  margin: const pw.EdgeInsets.symmetric(
                                      vertical: 5),
                                  child: pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.spaceBetween,
                                      children: <pw.Widget>[
                                        pw.Text(
                                          produtos[index]['codigoProduto'],
                                          style: pw.TextStyle(fontSize: 5),
                                        ),
                                        pw.Text(
                                          '${produtos[index]['descricaoProduto']} (${produtos[index]['tamanho']})',
                                          style: pw.TextStyle(fontSize: 5),
                                        ),
                                        pw.Text(
                                          produtos[index]['quantidade'],
                                          style: pw.TextStyle(fontSize: 5),
                                        ),
                                        pw.Text(
                                          '${produtos[index]['valor_unitario'].replaceAll(".", ",")}',
                                          style: pw.TextStyle(fontSize: 5),
                                        ),
                                      ]));
                            }))),
                    pw.Container(
                      margin: const pw.EdgeInsets.symmetric(vertical: 3),
                      child: pw.Row(
                        children: [
                          pw.Expanded(child: pw.Divider(height: 0.25))
                        ],
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
                            'R\$${dados['valor'].toString().replaceAll('.', ',')}',
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
                          pw.Text(
                              '${dados['vezes_pagamento']} ${dados['forma_pagamento']}',
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
                                    "Cidade: ${dados['cep']}/${dados['cidade']}-${dados['uf']}",
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
                                      "${dados['bairro']}",
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
                                      "${dados['endereco_entrega']}",
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
                                      '${dados['complemento']}',
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
    } catch (error) {
      x.Get.snackbar('', 'Ocorreu um erro', backgroundColor: Colors.red);
    }
  }
}
