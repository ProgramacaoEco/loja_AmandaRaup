import 'dart:convert';

import 'package:admin_newpedido/data/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
                           return pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Column(children: [
                    pw.Column(
                      children: [
                        pw.Container(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Row(
                            children: [
                              pw.Text(
                                "Nº do pedido: ",
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 5,
                                ),
                              ),
                              pw.Text(dados['id_pedido'].toString(),
                                  style: pw.TextStyle(fontSize: 5))
                            ],
                          ),
                        ),
                        pw.Container(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Row(
                            children: [
                              pw.Text(
                                "Estado do pedido: ",
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 5,
                                ),
                              ),
                              pw.Text(dados['status_pedido'],
                                  style: pw.TextStyle(fontSize: 5))
                            ],
                          ),
                        ),
                        pw.Container(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Row(
                            children: [
                              pw.Text("Data: ",
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 5)),
                              pw.Text(dados['data_pedido'],
                                  style: pw.TextStyle(fontSize: 5)),
                            ],
                          ),
                        ),
                        pw.Container(
                          child: pw.Row(
                            children: [
                              pw.Text("Nome do cliente: ",
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 5)),
                              pw.Container(
                                  width: 80,
                                  child: pw.Text(dados['nome_cliente'],
                                      style: pw.TextStyle(fontSize: 5)))
                            ],
                          ),
                        ),
                        pw.Container(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Row(
                            children: [
                              pw.Text("Telefone: ",
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 5)),
                              pw.Text(dados['telefone'],
                                  style: pw.TextStyle(fontSize: 5))
                            ],
                          ),
                        ),
                        pw.Container(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Row(
                            children: [
                              pw.Text("Local de entrega: ",
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 5)),
                              dados['endereco_entrega'] == '"buscar na loja"'
                                  ? pw.Text("Retirada na loja",
                                      style: pw.TextStyle(fontSize: 5))
                                  : pw.Container(
                                      width: 80,
                                      child: pw.Text(
                                          "${dados['endereco_entrega']} - ${dados['bairro']} - ${dados['cidade']}",
                                          style: pw.TextStyle(fontSize: 5)),
                                    ),
                            ],
                          ),
                        ),
                        pw.Container(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Row(
                            children: [
                              pw.Text("Forma de pagamento: ",
                                  style: pw.TextStyle(
                                      fontSize: 5,
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text(
                                  "${dados['forma_pagamento']} - ${dados['vezes_pagamento']}",
                                  style: pw.TextStyle(fontSize: 5))
                            ],
                          ),
                        )
                      ],
                    ),
                    pw.SizedBox(height: 20),
                    pw.Container(width: 200, child: pw.Column(children: [])),
                    pw.Container(
                        width: 200,
                        child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: List.generate(
                                produtos.length, (index) {
                              return pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Container(
                                    padding: pw.EdgeInsets.all(0),
                                    child: pw.Text(
                                      "Cod.",
                                      style: pw.TextStyle(
                                          fontSize: 5,
                                          fontWeight: pw.FontWeight.bold),
                                    ),
                                  ),
                                  pw.Container(
                                    margin: pw.EdgeInsets.only(
                                        bottom: 10, left: 0, top: 5),
                                    child: pw.Text(
                                        produtos[index]['codigoProduto'],
                                        style: pw.TextStyle(fontSize: 5)),
                                  ),
                                  pw.Container(
                                    padding: pw.EdgeInsets.all(0),
                                    child: pw.Text(
                                      "Produto",
                                      style: pw.TextStyle(
                                          fontSize: 5,
                                          fontWeight: pw.FontWeight.bold),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 80,
                                    margin: pw.EdgeInsets.only(
                                        bottom: 10, left: 0, top: 5),
                                    child: pw.Text(
                                      "${produtos[index]['descricaoProduto']} (${produtos[index]['tamanho']})",
                                      style: pw.TextStyle(
                                        fontSize: 5,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    padding: pw.EdgeInsets.all(0),
                                    child: pw.Text(
                                      "Qtd.",
                                      style: pw.TextStyle(
                                          fontSize: 5,
                                          fontWeight: pw.FontWeight.bold),
                                    ),
                                  ),
                                  pw.Container(
                                    margin: pw.EdgeInsets.only(
                                        bottom: 10, left: 0, top: 5),
                                    child: pw.Text(produtos[index]['quantidade'],
                                        style: pw.TextStyle(fontSize: 5)),
                                  ),
                                  pw.Container(
                                    padding: pw.EdgeInsets.all(0),
                                    child: pw.Text(
                                      "Valor",
                                      style: pw.TextStyle(
                                          fontSize: 5,
                                          fontWeight: pw.FontWeight.bold),
                                    ),
                                  ),
                                  pw.Container(
                                    margin: pw.EdgeInsets.only(
                                        bottom: 10, left: 0, top: 5),
                                    child: pw.Text(
                                        "R\$${produtos[index]['valor_unitario'].replaceAll(".", ",")}",
                                        style: pw.TextStyle(fontSize: 5)),
                                  ),
                                ],
                              );
                            }))),
                  ])
                ]);
}
