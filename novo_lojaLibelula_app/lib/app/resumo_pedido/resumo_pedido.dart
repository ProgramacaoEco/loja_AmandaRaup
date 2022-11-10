// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:loja_libelula/app/pdf/pdf_view.dart';
import 'package:loja_libelula/app/providers/itens_pedido_list.dart';
import 'package:loja_libelula/app/widgets/cardResumo.dart';
import 'package:loja_libelula/database/database.dart';
import 'package:loja_libelula/utils/constants.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:io';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:share_extend/share_extend.dart';
import 'package:path_provider/path_provider.dart';

class ResumoPedidoState extends State<ResumoPedido> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    carregarValoresPedido();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> cardsResumo = [];
  var valorTotal;

  late http.Response response;
  final dbHelper = DatabaseHelper.instance;
  var url = Uri.https('${Constants.API_ROOT_ROUTE}',
      '${Constants.API_FOLDERS}listarTudoProdutos');

  List tamanhos = [];
  List itensPedido = [];
  List valor = [];
  late double valorOriginal;

  var uf;
  var cidade;
  var cep;
  var endereco_entrega;
  var bairro;
  var complemento;
  var nome;
  var cpf;
  var id_pedido;
  int contador = 0;
  var formaRetirada;
  var mensagemEntrega;
  var enderecoLoja =
      'Av. Assis Brasil, 316, Arroio do Sal - RS, 95585-000';

  carregarValoresPedido() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      valorTotal = prefs.getString('valorTotal');
      nome = prefs.getString('nome');
      id_pedido = prefs.getInt('id_pedido');
      formaRetirada = prefs.getInt('formaDeRetirada');
      cpf = prefs.getString('cpf');
    });
    Provider.of<ListaItensPedido>(context, listen: false)
        .indexList(id_pedido)
        .then((value) => setState(() => isLoading = false));
    getPedidoById();
    carregarWidgetsTela();
  }

  carregarWidgetsTela() {
    print(formaRetirada);
    if (formaRetirada == 1) {
      setState(() {
        mensagemEntrega = "Você deve retirar seu produto na loja";
      });
    } else {
      setState(() {
        mensagemEntrega = 'Você deve combinar a entrega com o vendedor!';
      });
    }
  }

  getPedidoById() async {
    http.Response response;
    print('dentro do getPedido esse é o id $id_pedido');

    var urlGetPedido = Uri.https('${Constants.API_ROOT_ROUTE}',
        '${Constants.API_FOLDERS}listarPedidoById/$id_pedido');

    try {
      response = await http.get(urlGetPedido);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var dados = jsonDecode(response.body);
        print(dados);
        itensPedido = dados['itens_pedido'];
        uf = dados['uf'];
        cidade = dados['cidade'];
        cep = dados['cep'];
        endereco_entrega = dados['endereco_entrega'];
        bairro = dados['bairro'];
        complemento = dados['complemento'];
        valor = dados['valor'];
      }

      for (int i = 0; i < itensPedido.length; i++) {
        var value = double.parse(itensPedido[i]['valor_unitario']);
        var quant = int.parse(itensPedido[i]['quantidade']);

        setState(() {
          valor.add({'value': value * quant});
        });
      }
    } catch (error) {
      print(error);
    }
  }

  createPdf(BuildContext context) async {
    final pdfLib.Document pdf = pdfLib.Document(deflate: zlib.encode);
    print(itensPedido.length);

    pdf.addPage(pdfLib.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pdfLib.Context context) => [
              pdfLib.Container(
                color: PdfColors.grey100,
                child: pdfLib.Container(
                  child: pdfLib.Column(
                    children: <pdfLib.Widget>[
                      pdfLib.Container(
                        height: 100,
                        color: PdfColors.blue,
                        child: pdfLib.Padding(
                          padding: pdfLib.EdgeInsets.all(16),
                          child: pdfLib.Row(
                              crossAxisAlignment:
                                  pdfLib.CrossAxisAlignment.center,
                              mainAxisAlignment:
                                  pdfLib.MainAxisAlignment.spaceBetween,
                              children: [
                                pdfLib.Column(
                                    mainAxisAlignment:
                                        pdfLib.MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        pdfLib.CrossAxisAlignment.center,
                                    children: [
                                      // pdfLib.Padding(
                                      //     padding: pdfLib.EdgeInsets.all(8),
                                      //     child: pdfLib.PdfLogo(
                                      //       fit: pdfLib.BoxFit.contain
                                      //     )),
                                      pdfLib.Text(
                                        'Pedido nº$id_pedido',
                                        style: pdfLib.TextStyle(
                                            fontSize: 20,
                                            color: PdfColors.white),
                                      )
                                    ]),
                                pdfLib.Column(
                                    mainAxisAlignment:
                                        pdfLib.MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        pdfLib.CrossAxisAlignment.end,
                                    children: [
                                      pdfLib.Text(
                                        'ECO S. S.',
                                        style: pdfLib.TextStyle(
                                            fontSize: 18,
                                            color: PdfColors.white),
                                      ),
                                      pdfLib.Text('CAPÃO DA CANOA',
                                          style: pdfLib.TextStyle(
                                              fontSize: 18,
                                              color: PdfColors.white)),
                                      pdfLib.Text('3661-3616',
                                          style: pdfLib.TextStyle(
                                              fontSize: 18,
                                              color: PdfColors.white))
                                    ]),
                              ]),
                        ),
                      ),

                      pdfLib.Container(
                        height: cep != 'retirada' ? 160 : 85,
                        child: pdfLib.Column(children: [
                          pdfLib.Padding(
                            padding: pdfLib.EdgeInsets.all(5),
                            child: pdfLib.Row(
                                mainAxisAlignment:
                                    pdfLib.MainAxisAlignment.center,
                                children: [
                                  pdfLib.Text(
                                      'NÃO É DOCUMENTO FISCAL  - SIMPLES PEDIDO DE MERCADORIA')
                                ]),
                          ),
                          pdfLib.Divider(),
                          pdfLib.Padding(
                            padding: const pdfLib.EdgeInsets.all(5),
                            child: pdfLib.Expanded(
                              child: pdfLib.Row(
                                mainAxisAlignment:
                                    pdfLib.MainAxisAlignment.spaceAround,
                                children: [
                                  pdfLib.Expanded(
                                    child: pdfLib.Row(
                                      children: [
                                        pdfLib.Container(
                                          margin:
                                              pdfLib.EdgeInsets.only(left: 5),
                                          child: pdfLib.Text(
                                            'Comprador: ',
                                            style: pdfLib.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pdfLib.FontWeight.bold),
                                          ),
                                        ),
                                        pdfLib.Text(' $nome ',
                                            style:
                                                pdfLib.TextStyle(fontSize: 12)),
                                      ],
                                    ),
                                  ),
                                  pdfLib.Expanded(
                                    child: pdfLib.Row(
                                      mainAxisAlignment:
                                          pdfLib.MainAxisAlignment.start,
                                      children: [
                                        pdfLib.Container(
                                          margin:
                                              pdfLib.EdgeInsets.only(left: 5),
                                          child: pdfLib.Text(
                                            'CPF: ',
                                            style: pdfLib.TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  pdfLib.FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        pdfLib.Text(
                                          ' $cpf',
                                          style: pdfLib.TextStyle(fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          pdfLib.Divider(color: PdfColors.grey),
                          cep == 'retirada'
                              ? pdfLib.Center(
                                  child: pdfLib.Text('Pedido com retirada'),
                                )
                              : pdfLib.Padding(
                                  padding: const pdfLib.EdgeInsets.all(5),
                                  child: pdfLib.Expanded(
                                    child: pdfLib.Row(
                                      mainAxisAlignment:
                                          pdfLib.MainAxisAlignment.start,
                                      children: [
                                        pdfLib.Container(
                                          margin:
                                              pdfLib.EdgeInsets.only(left: 15),
                                          child: pdfLib.Text(
                                            'CEP: ',
                                            style: pdfLib.TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  pdfLib.FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        pdfLib.Container(
                                          margin:
                                              pdfLib.EdgeInsets.only(left: 1),
                                          child: pdfLib.Text(
                                            cep,
                                            style: pdfLib.TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  pdfLib.FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        pdfLib.Container(
                                          margin:
                                              pdfLib.EdgeInsets.only(left: 15),
                                          child: pdfLib.Text(
                                            'Cidade: ',
                                            style: pdfLib.TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  pdfLib.FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        pdfLib.Container(
                                          margin:
                                              pdfLib.EdgeInsets.only(left: 1),
                                          child: pdfLib.Text(
                                            '$cidade',
                                            style: pdfLib.TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  pdfLib.FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        pdfLib.Container(
                                          margin:
                                              pdfLib.EdgeInsets.only(left: 15),
                                          child: pdfLib.Text(
                                            'UF: ',
                                            style: pdfLib.TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  pdfLib.FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        pdfLib.Container(
                                          margin:
                                              pdfLib.EdgeInsets.only(left: 1),
                                          child: pdfLib.Text(
                                            '$uf',
                                            style: pdfLib.TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  pdfLib.FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          pdfLib.Padding(
                            padding: const pdfLib.EdgeInsets.all(5),
                            child: pdfLib.Expanded(
                              child: pdfLib.Row(
                                mainAxisAlignment:
                                    pdfLib.MainAxisAlignment.start,
                                children: [
                                  pdfLib.Container(
                                    margin: pdfLib.EdgeInsets.only(left: 15),
                                    child: pdfLib.Text(
                                      'Endereço: ',
                                      style: pdfLib.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pdfLib.FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  pdfLib.Container(
                                    margin: pdfLib.EdgeInsets.only(left: 1),
                                    child: pdfLib.Text(
                                      '$endereco_entrega, Bairro $bairro.',
                                      style: pdfLib.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pdfLib.FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          pdfLib.Padding(
                            padding: const pdfLib.EdgeInsets.all(5),
                            child: pdfLib.Expanded(
                              child: pdfLib.Row(
                                  mainAxisAlignment:
                                      pdfLib.MainAxisAlignment.start,
                                  children: [
                                    pdfLib.Container(
                                      margin: pdfLib.EdgeInsets.only(left: 15),
                                      child: pdfLib.Text(
                                        'Complemento: $complemento.',
                                        style: pdfLib.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pdfLib.FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ]),
                      ),
                      pdfLib.Divider(),
                      pdfLib.Container(
                        child: pdfLib.Row(children: <pdfLib.Widget>[
                          pdfLib.Expanded(
                            child: pdfLib.Column(children: [
                              pdfLib.Text(
                                'Produto: ',
                                style: pdfLib.TextStyle(fontSize: 14),
                              ),
                            ]),
                          ),
                          pdfLib.Expanded(
                            child: pdfLib.Column(children: [
                              pdfLib.Text(
                                'Valor Un.:',
                                style: pdfLib.TextStyle(fontSize: 14),
                              ),
                            ]),
                          ),
                          pdfLib.Expanded(
                            child: pdfLib.Column(children: [
                              pdfLib.Text(
                                'Tamanho: ',
                                style: pdfLib.TextStyle(fontSize: 14),
                              ),
                            ]),
                          ),
                          pdfLib.Expanded(
                            child: pdfLib.Column(children: [
                              pdfLib.Text(
                                'Quantidade: ',
                                style: pdfLib.TextStyle(fontSize: 14),
                              ),
                            ]),
                          ),
                          pdfLib.Expanded(
                            child: pdfLib.Column(children: [
                              pdfLib.Text(
                                'Valor Total: ',
                                style: pdfLib.TextStyle(fontSize: 14),
                              ),
                            ]),
                          ),
                        ]),
                      ),

                      pdfLib.Container(
                        child: pdfLib.Column(
                          children: List.generate(itensPedido.length, (index) {
                            return pdfLib.Row(
                              children: [
                                pdfLib.Expanded(
                                  child: pdfLib.Column(children: [
                                    pdfLib.Text(
                                      itensPedido[index]['descricaoProduto'],
                                      style: pdfLib.TextStyle(fontSize: 12),
                                    ),
                                  ]),
                                ),
                                pdfLib.Expanded(
                                  child: pdfLib.Column(children: [
                                    pdfLib.Text(
                                      'R\$${itensPedido[index]['valor_unitario'].toString().replaceAll('.', ',')}',
                                      style: pdfLib.TextStyle(fontSize: 14),
                                    ),
                                  ]),
                                ),
                                pdfLib.Expanded(
                                  child: pdfLib.Column(children: [
                                    pdfLib.Text(
                                      itensPedido[index]['tamanho'],
                                      style: pdfLib.TextStyle(fontSize: 14),
                                    ),
                                  ]),
                                ),
                                pdfLib.Expanded(
                                  child: pdfLib.Column(children: [
                                    pdfLib.Text(
                                      itensPedido[index]['quantidade']
                                          .toString(),
                                      style: pdfLib.TextStyle(fontSize: 14),
                                    ),
                                  ]),
                                ),
                                pdfLib.Expanded(
                                  child: pdfLib.Column(children: [
                                    pdfLib.Text(
                                      'R\$${valor[index]['value'].toString().replaceAll('.', ',')}',
                                      style: pdfLib.TextStyle(fontSize: 14),
                                    ),
                                  ]),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                      pdfLib.Divider(thickness: 0.8),

                      pdfLib.Container(
                        margin: pdfLib.EdgeInsets.all(5),
                        child: pdfLib.Row(
                            mainAxisAlignment:
                                pdfLib.MainAxisAlignment.spaceBetween,
                            children: [
                              pdfLib.Column(children: [
                                pdfLib.Text(
                                  'Valor Total da Compra: ',
                                  style: pdfLib.TextStyle(fontSize: 19),
                                ),
                              ]),
                              pdfLib.Column(children: [
                                pdfLib.Text(
                                    'R\$${valorTotal.replaceAll('.', ',')}',
                                    style: pdfLib.TextStyle(
                                        fontSize: 20,
                                        fontWeight: pdfLib.FontWeight.bold)),
                              ]),
                            ]),
                      ),

                      // pdfLib.Divider(thickness: 0.8),

                      // pdfLib.Container(
                      //   margin: pdfLib.EdgeInsets.all(5),
                      //   child: pdfLib.Row(
                      //       mainAxisAlignment:
                      //           pdfLib.MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         pdfLib.Column(children: [
                      //           pdfLib.Text(
                      //             'Valor Pago: ',
                      //             style: pdfLib.TextStyle(fontSize: 19),
                      //           ),
                      //         ]),
                      //         pdfLib.Column(children: [
                      //           pdfLib.Text('RS1600,00',
                      //               style: pdfLib.TextStyle(
                      //                   fontSize: 20,
                      //                   fontWeight: pdfLib.FontWeight.bold)),
                      //         ]),
                      //       ]),
                      // ),

                      pdfLib.Container(
                          margin: pdfLib.EdgeInsets.only(
                              top: 20, bottom: 10, left: 25, right: 25),
                          height: 35,
                          child: pdfLib.Container(
                              decoration: const pdfLib.BoxDecoration(
                                color: PdfColors.green,
                                borderRadius: pdfLib.BorderRadius.all(
                                    pdfLib.Radius.circular(15)),
                              ),
                              child: pdfLib.Column(
                                  mainAxisAlignment:
                                      pdfLib.MainAxisAlignment.center,
                                  children: [
                                    pdfLib.Row(
                                        mainAxisAlignment:
                                            pdfLib.MainAxisAlignment.center,
                                        children: [
                                          pdfLib.Text(
                                            'Pagamento realizado com sucesso!',
                                            style: pdfLib.TextStyle(
                                                color: PdfColors.white,
                                                fontSize: 18,
                                                fontWeight:
                                                    pdfLib.FontWeight.bold),
                                          )
                                        ])
                                  ]))),

                      pdfLib.Container(
                          height: 100,
                          margin: pdfLib.EdgeInsets.only(bottom: 10, top: 10),
                          child: pdfLib.Column(
                              // mainAxisAlignment: pdfLib.MainAxisAlignment.spaceBetween,
                              children: [
                                pdfLib.Text(
                                  'Em caso de dúvidas referentes ao seu pedido,',
                                  style: pdfLib.TextStyle(
                                      fontSize: 20, color: PdfColors.grey700),
                                ),
                                pdfLib.Text(
                                  'você pode entrar em contato com o vendedor:',
                                  style: pdfLib.TextStyle(
                                      fontSize: 20, color: PdfColors.grey700),
                                ),
                                pdfLib.Text(
                                  'Número do WhatsApp: (51) 980392188',
                                  style: pdfLib.TextStyle(
                                      fontSize: 20, color: PdfColors.grey800),
                                ),
                              ])),

                      pdfLib.Container(
                        height: 75,
                        color: PdfColors.blue,
                        child: pdfLib.Row(
                            mainAxisSize: pdfLib.MainAxisSize.max,
                            mainAxisAlignment: pdfLib.MainAxisAlignment.end,
                            children: [
                              pdfLib.Column(
                                  mainAxisAlignment:
                                      pdfLib.MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      pdfLib.CrossAxisAlignment.end,
                                  children: [
                                    pdfLib.Padding(
                                      padding:
                                          pdfLib.EdgeInsets.only(bottom: 0),
                                      child: pdfLib.Column(
                                          mainAxisAlignment:
                                              pdfLib.MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              pdfLib.CrossAxisAlignment.center,
                                          children: [
                                            pdfLib.Padding(
                                                padding: pdfLib.EdgeInsets.only(
                                                    bottom: 0, right: 5),
                                                child: pdfLib.Text('TOTAL PAGO',
                                                    style: pdfLib.TextStyle(
                                                        color: PdfColors.white,
                                                        fontSize: 26))),
                                            pdfLib.Padding(
                                              padding: pdfLib.EdgeInsets.only(
                                                  right: 10),
                                              child: pdfLib.Text(
                                                  'R\$: $valorTotal',
                                                  style: pdfLib.TextStyle(
                                                      color: PdfColors.white,
                                                      fontSize: 24)),
                                            )
                                          ]),
                                    ),
                                  ]),
                            ]),
                      ),

                      //fecha coluna principal
                    ],
                  ),
                ),
              ),
            ]));

    final String dir = (await getApplicationDocumentsDirectory()).path;

    final String path = '$dir/pdfPedido.pdf';

    final File file = File(path);
    final bytes = await pdf.save();

    file.writeAsBytesSync(bytes);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PDFView(path)));
  }

  // obterItensCarrinho() async {
  //   final itens = await dbHelper.queryAllRows();

  //   itens.forEach((dadosItens) {
  //     setState(() {
  //       //enviando o id do produto através de um post e recebendo os dados
  //       cardsResumo.add(GestureDetector(
  //         onTap: () async {
  //           setState(() {
  //             for (int i = 0; i < dadosItens['tamanhos'].length; i++) {
  //               tamanhos.add(dadosItens['tamanhos'][i]['tamanho']);
  //             }
  //             tamanhos = dadosItens['tamanhos'];
  //             String valorOrigin = dadosItens['valor'];
  //             valorOrigin.replaceAll(',', '.');
  //             valorOriginal = double.parse(valorOrigin);
  //           });
  //         },
  //         child: CardResumo(
  //             codigoProduto: dadosItens["codigoProduto"],
  //             id_produto: dadosItens['id_produto'],
  //             descricaoProduto: dadosItens['descricaoProduto'],
  //             valor: dadosItens['valor'],
  //             descricao_pagamento: dadosItens['descricao_pagamento'],
  //             imagem: dadosItens['imagem'],
  //             quantidade: dadosItens['quantidade'],
  //             tamanho: dadosItens['tamanho']),
  //       ));
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ListaItensPedido>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false);
              //Navigator.pop(context);
            }),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: Colors.indigo.shade50,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 75,
                      margin: EdgeInsets.only(
                          left: 5, right: 5, top: 15, bottom: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.white,
                      ),
                      child: Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text('Seu pedido é o nº$id_pedido',
                                    style: TextStyle(fontSize: 24)),
                              ],
                            ),
                            Divider(thickness: 2),
                            Row(
                              children: [
                                Text(mensagemEntrega,
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.orange,
                                        fontWeight: FontWeight.w600))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      height: 90,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.grey.shade300,
                            Colors.grey.shade200
                          ]),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          )),
                      child: Column(children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Text(
                            'Endereço da loja:',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          child: Text(
                            enderecoLoja,
                            textAlign: TextAlign.justify,
                            style:
                                TextStyle(fontSize: 18, color: Colors.black54),
                          ),
                        ),
                      ]),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  color: Colors.white54,
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    ' Itens do pedido:',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  )),
                            ],
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: cardsResumo.length <= 2 ? 200 : 350,
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(5),
                              child: ListView.builder(
                                  itemCount: provider.itemsCount,
                                  itemBuilder: (context, i) {
                                    return CardResumo(provider.items[i]);
                                  })),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      height: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.white,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              width: MediaQuery.of(context).size.width / 1.3,
                              child: Text(
                                  'Clique no botão ao lado para fazer o download do seu pedido em PDF.',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(fontSize: 18)),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: IconButton(
                                icon: Icon(Icons.picture_as_pdf_sharp,
                                    size: 35, color: Colors.red.shade900),
                                onPressed: () {
                                  createPdf(context);
                                },
                              ),
                            ),
                          ]),
                    ),
                    Container(
                      height: 90,
                      margin: EdgeInsets.only(left: 5, right: 5),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.white54,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Divider(thickness: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 5),
                                child: Text('Valor total: ',
                                    style: TextStyle(fontSize: 16)),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 5),
                                child: Text(
                                  'R\$: $valorTotal',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          const Divider(thickness: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 5),
                                child: Text('Valor pago: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey.shade700)),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 5),
                                child: Text(
                                  'R\$ $valorTotal',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade700),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Container(
                      height: 52.5,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        gradient: LinearGradient(
                            colors: [Colors.green, Colors.green.shade800]),
                      ),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(5),
                                  child: const Text(
                                    'Seu pagamento foi realizado com sucesso!',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      //  margin: EdgeInsets.all(5),
                      height: 140,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(5),
                                  child: Text(
                                      'Para maiores esclarecimentos sobre o envio do pedido consulte o vendedor via WhatsApp.',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFFFFB700))),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8.0, bottom: 8),
                                      child: Container(
                                        //margin: EdgeInsets.all(8),
                                        width: 190,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          color: Color(0xFF01AF55),
                                        ),
                                        child: GestureDetector(
                                          //   child:   Align(
                                          // alignment: Alignment.bottomRight,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Image(
                                                image: AssetImage(
                                                    'lib/app/images/wpp.png'),
                                                height: 38,
                                              ),
                                              Text('Enviar Mensagem',
                                                  style: GoogleFonts.aBeeZee(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ))
                                            ],
                                          ),
                                          onTap: () async {
                                            //Whats
                                            try {
                                              await launch(
                                                  'https://api.whatsapp.com/send?phone=51980392188');
                                            } catch (error) {
                                              print(error);
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            decoration: const BoxDecoration(
                              color: Colors.white54,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(height: 100)
                  ],
                ),
              ),
            ),
    );
  }
}

class ResumoPedido extends StatefulWidget {
  State<StatefulWidget> createState() {
    return ResumoPedidoState();
  }
}
