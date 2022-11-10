import 'dart:convert';
import 'package:loja_libelula/utils/constants.dart';

import '../../database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/colors.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Cores cor = Cores();
DatabaseHelper dbHelper = DatabaseHelper.instance;

class FinalizarCompraState extends State<FinalizarCompra> {
  //Gerenciamento de estado
  @override
  void initState() {
    super.initState();
    obterItensPedido();
    getEstado();
  }

  @override
  void dispose() {
    super.dispose();
    //ChecarInternet().listener.cancel();
  }

//variaveis dos valores
  late bool selectbool = false;
  var forma;
  var tipoPessoa;
  var bairros = [];
  var itensPedido = [];
  var formaSelecionada;
  var freteSelecionado;
  var bairroSelecionado;
  var cidadeSelecionada;
  late bool carregou;
  var valorTotalCarrinho;
  var pedido = [];
  var busca = 'buscar na loja';
  String pendente = 'pendente';
  var value;

  var cidades = [];
  var estados = [];
  var estadoSelecionado;

  //variaveis da tela (CPF/CNPJ)
  var campoNum;
  var campoText;
  var campoNome;

  DatabaseHelper dbHelper = DatabaseHelper.instance;

  late http.Response responsebairro;
  late http.Response responseforma;
  late http.Response responseparcela;
  late http.Response responsepedido;
  late http.Response responsecidade;
  late http.Response responseEstado;

  var urlbairro = Uri.https(
      '${Constants.API_ROOT_ROUTE}', '${Constants.API_FOLDERS}listarBairros');

  var urlforma = Uri.https(
      '${Constants.API_ROOT_ROUTE}', '${Constants.API_FOLDERS}listarFormas');

  var urlpedido = Uri.https(
      '${Constants.API_ROOT_ROUTE}', '${Constants.API_FOLDERS}cadastrarPedido');

  var urlEstado = Uri.https(
      '${Constants.API_ROOT_ROUTE}', '${Constants.API_FOLDERS}getState');

  TextEditingController uf = TextEditingController();
  TextEditingController cidade = TextEditingController();
  TextEditingController bairro = TextEditingController();
  TextEditingController logradouro = TextEditingController();
  TextEditingController complemento = TextEditingController();
  TextEditingController numero = TextEditingController();
  MaskedTextController cep = MaskedTextController(mask: '00000-000');

  TextEditingController nome = TextEditingController();
  TextEditingController email = TextEditingController();
  MaskedTextController telefone = MaskedTextController(mask: "(00)00000-0000");
  MaskedTextController cpf = MaskedTextController(mask: '000.000.000-00');
  MaskedTextController cnpj = MaskedTextController(mask: '00.000.000/0000-00');
  late MaskedTextController mascara;
  GlobalKey<FormFieldState> keyDpBairro = GlobalKey();
  GlobalKey<FormFieldState> keyDpParcelas = GlobalKey();

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

// ===========================================================================
// MÉTODOS REFERENTES AOS COMPONENTES DA TELA
// ===========================================================================

  defineCampoTipoDePessoa(tipoPessoa) {
    if (tipoPessoa == 1) {
      setState(() {
        campoNum = 11;
        campoText = "CPF";
        campoNome = "Nome";
        mascara = cpf;
      });
    } else {
      setState(() {
        campoNum = 14;
        campoText = "CNPJ";
        campoNome = "Razão Social";
        mascara = cnpj;
      });
    }
  }

  formaRetirada() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(
      () {
        forma = prefs.getInt('formaDeRetirada');
        tipoPessoa = prefs.getInt('tipoPessoa');
      },
    );
    defineCampoTipoDePessoa(tipoPessoa);
  }

  getEstado() async {
    responseEstado = await http.get(urlEstado);
    var dados = json.decode(responseEstado.body);

    for (int i = 0; i < dados.length; i++) {
      setState(() {
        estados.add(dados[i]['uf']);
      });
    }
    print(estados);
  }

  getCidades() async {
    //var list = await dbHelper.queryAllRowsLogado();
    //keyDpBairro.currentState.reset();
    var queryParams = {'uf': estadoSelecionado};
    var urlcidade = Uri.https('${Constants.API_ROOT_ROUTE}',
        '${Constants.API_FOLDERS}getStateByName', queryParams);
    responsecidade = await http.get(
      urlcidade,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
    );
    var dados = json.decode(responsecidade.body);
    print("Essas são as cidades: $dados");
    var dataCity = dados[0]['cidades'];

    for (int i = 0; i < dataCity.length; i++) {
      setState(() {
        cidades.add(dataCity[i]['nome']);
      });
    }
  }

  obterItensPedido() async {
    List dados = await dbHelper.queryAllRows();
    for (int i = 0; i < dados.length; i++) {
      value = dados[i]['valor'];
      var quant = dados[i]['quantidade'];
      double valquant = value / quant;
      setState(
        () {
          itensPedido.add(
            {
              "id_produto": dados[i]['id_produto'],
              "tamanho": dados[i]['tamanho'],
              "quantidade": dados[i]['quantidade'],
              // "valor": dados[i]['valor'],
              "valor_unitario": valquant,
              "descricaoProduto": dados[i]['descricaoProduto'],
              "codigoProduto": dados[i]['codigoProduto'],
            },
          );
        },
      );
      valorTotalCarrinho = await dbHelper.valorTotalCarrinho();
      valorTotalCarrinho = valorTotalCarrinho[0]['sum(valor)']
          .toStringAsFixed(2)
          .replaceAll(".", ",");
      print(itensPedido);
    }
  }

  guardarDadosEntrega() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('valorTotal', valorTotalCarrinho.toString());
    prefs.setString('uf', estadoSelecionado);
    prefs.setString('cidade', cidadeSelecionada);
    prefs.setString('bairro', bairro.text);
    prefs.setString('logradouro', logradouro.text);
    prefs.setString('complemento', complemento.text);
    prefs.setString('numero', numero.text);
    prefs.setString('cep', cep.text);
    prefs.setString('nome', nome.text);
    prefs.setString('email', email.text);
    prefs.setString('telefone', telefone.text);
    prefs.setString('cpf', mascara.text);

    Navigator.pushNamed(context, '/dadosCartao');
  }

  guardarDadosRetirada() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('valorTotal', valorTotalCarrinho.toString());
    prefs.setString('uf', 'retirada');
    prefs.setString('cidade', 'retirada');
    prefs.setString('bairro', 'retirada');
    prefs.setString('logradouro', 'retirada');
    prefs.setString('complemento', 'retirada');
    prefs.setString('numero', 'retirada');
    prefs.setString('cep', 'retirada');
    prefs.setString('nome', nome.text);
    prefs.setString('email', email.text);
    prefs.setString('telefone', telefone.text);
    prefs.setString('cpf', mascara.text);
    Navigator.pushNamed(context, '/dadosCartao');
  }

//Escolhe a tela, a partir da variável forma, que representa a forma de entrega ou retirada do produto
  escolherLayout() {
    formaRetirada();
    //Se a forma for a 2, o usuário deverá digitar dados de entrega.
    if (forma == 2) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                "Pedido com entrega",
                style: GoogleFonts.nanumGothic(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6c5c54),
                    fontSize: 22),
              ),
            ],
          ),
          backgroundColor: Color(cor.tema),
          toolbarHeight: MediaQuery.of(context).size.height >= 650
              ? MediaQuery.of(context).size.height / 13
              : MediaQuery.of(context).size.height / 11,
        ),
        body: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              color: Colors.blueGrey.shade50,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      height: MediaQuery.of(context).size.height / 12,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.only(top: 5, left: 5),
                              child: Text(
                                "Preencha os dados de entrega",
                                style: GoogleFonts.nanumGothic(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF6c5c54),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: EdgeInsets.only(top: 2),
                              child: Text(
                                " * - Campos obrigatórios",
                                style: GoogleFonts.nanumGothic(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              margin: const EdgeInsets.only(left: 5),
                              decoration: const BoxDecoration(
                                  color: Colors.white54,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  )),
                              child: DropdownButtonFormField(
                                  hint: Text("UF"),
                                  items: estados.map((estado) {
                                    return DropdownMenuItem(
                                        child: Text(estado), value: estado);
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      estadoSelecionado = value;
                                    });
                                    cidades = [];
                                    getCidades();
                                  },
                                  validator: (estadoSelecionado) {
                                    if (estadoSelecionado == null) {
                                      return "Escolha o UF";
                                    }
                                    return null;
                                  })),
                        ),
                        SizedBox(width: 30),
                        Expanded(
                            child: Container(
                                margin: const EdgeInsets.only(right: 5),
                                decoration: const BoxDecoration(
                                    color: Colors.white54,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    )),
                                child: DropdownButtonFormField(
                                    hint: Text("Cidade"),
                                    items: cidades.map((cidade) {
                                      return DropdownMenuItem(
                                          child: Text(cidade), value: cidade);
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        cidadeSelecionada = value;
                                      });
                                    },
                                    validator: (cidadeSelecionada) {
                                      if (cidadeSelecionada == null) {
                                        return "Escolha a cidade";
                                      }
                                      return null;
                                    })),
                            flex: 3),
                      ],
                    ),

                    SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 5),
                            decoration: const BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                )),
                            child: TextFormField(
                                controller: logradouro,
                                decoration: InputDecoration(
                                  labelText: " Logradouro*",
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length < 5) {
                                    return "Digite um logradouro válido";
                                  }
                                  return null;
                                }),
                          ),
                          flex: 2,
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Expanded(
                            child: Container(
                          margin: const EdgeInsets.only(right: 5),
                          decoration: const BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              )),
                          child: TextFormField(
                              controller: numero,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: " Número*",
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Digite o número residencial";
                                }
                                return null;
                              }),
                        )),
                      ],
                    ),

                    SizedBox(height: 20),

                    // DropdownButtonFormField<dynamic>(
                    //   hint: const Text("Selecione a cidade*"),
                    //   items: cidades,
                    //   onChanged: (value) {
                    //     FocusScope.of(context).requestFocus(FocusNode());
                    //     setState(
                    //       () {
                    //         cidadeSelecionada = value;
                    //       },
                    //     );
                    //     print(value);
                    //     obterBairro(value);
                    //   },
                    // ),
                    // DropdownButtonFormField(
                    //   key: keyDpBairro,
                    //   hint: Text("Selecione o bairro*"),
                    //   items: bairros.map(
                    //     (tamanho) {
                    //       return DropdownMenuItem(
                    //           child: Text(tamanho), value: tamanho);
                    //     },
                    //   ).toList(),
                    //   onChanged: (value) {
                    //     FocusScope.of(context).requestFocus(
                    //       FocusNode(),
                    //     );
                    //     setState(
                    //       () {
                    //         bairroSelecionado = value;
                    //         var index = bairros.indexOf(value);
                    //         freteSelecionado = valorFretes[index];
                    //       },
                    //     );
                    //   },
                    // ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 5),
                            decoration: const BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                )),
                            child: TextFormField(
                                controller: bairro,
                                decoration: InputDecoration(
                                  labelText: " Bairro*",
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length < 4) {
                                    return "Digite um Bairro válido";
                                  }
                                  return null;
                                }),
                          ),
                          flex: 2,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(right: 5),
                            decoration: const BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                )),
                            child: TextFormField(
                                controller: cep,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: " CEP*",
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length < 9) {
                                    return "Digite um CEP válido";
                                  }
                                  return null;
                                }),
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 20),

                    Container(
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      decoration: const BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          )),
                      child: TextFormField(
                          controller: complemento,
                          decoration: InputDecoration(
                            labelText: " Complemento*",
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 3) {
                              return "Digite um complemento";
                            }
                            return null;
                          }),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),
                      height: MediaQuery.of(context).size.height / 12,
                      margin: const EdgeInsets.only(top: 20, bottom: 5),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: const EdgeInsets.only(top: 5, left: 5),
                              child: Text(
                                "Dados pessoais",
                                style: GoogleFonts.nanumGothic(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF6c5c54),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: EdgeInsets.only(top: 2),
                              child: Text(
                                " * - Campos obrigatórios",
                                style: GoogleFonts.nanumGothic(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10),

                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      decoration: const BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: TextFormField(
                          controller: nome,
                          decoration: InputDecoration(
                            labelText: "$campoNome*",
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 8) {
                              return "Digite um nome válido";
                            }
                            return null;
                          }),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.only(left: 3, right: 3),
                      decoration: const BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: TextFormField(
                          controller: mascara,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "$campoText*",
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < campoNum) {
                              return "Digite os $campoNum dígitos do $campoText";
                            }
                            return null;
                          }),
                    ),

                    SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      decoration: const BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: TextFormField(
                          controller: telefone,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Telefone*",
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 14) {
                              return "Digite um número válido";
                            }
                            return null;
                          }),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      decoration: const BoxDecoration(
                        color: Colors.white54,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: TextFormField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: "Email*",
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 10) {
                              return "Digite um email válido";
                            }
                            return null;
                          }),
                    ),

                    Container(
                      margin: EdgeInsets.only(bottom: 50, top: 10),
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 25,
                            margin: EdgeInsets.only(bottom: 3),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Valor total do pedido: R\$ $valorTotalCarrinho",
                              style: GoogleFonts.nanumGothic(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              margin: EdgeInsets.all(5),
                              child: ElevatedButton(
                                  child: Text('Enviar Dados'),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Procesando...')),
                                      );
                                      guardarDadosEntrega();
                                    }
                                  }),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else if (forma == 1) {
      return Scaffold(
        appBar: AppBar(
          title: Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            height: MediaQuery.of(context).size.height >= 650
                ? MediaQuery.of(context).size.height / 13
                : MediaQuery.of(context).size.height / 11,
            child: Row(
              children: [
                Text(
                  "Pedido com retirada",
                  style: GoogleFonts.nanumGothic(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6c5c54),
                      fontSize: 22),
                ),
              ],
            ),
          ),
          backgroundColor: Color(cor.tema),
          toolbarHeight: MediaQuery.of(context).size.height >= 650
              ? MediaQuery.of(context).size.height / 13
              : MediaQuery.of(context).size.height / 11,
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Container(
            color: Colors.indigo.shade50,
            child: Form(
              key: _formKey2,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      margin: EdgeInsets.only(bottom: 20),
                      color: Colors.white54,
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Preencha seus dados",
                                  style: GoogleFonts.nanumGothic(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF6c5c54)))),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: EdgeInsets.only(top: 2),
                              child: Text(" * - Campos obrigatórios",
                                  style: GoogleFonts.nanumGothic(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 3, left: 3),
                      decoration: const BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          )),
                      child: TextFormField(
                          controller: nome,
                          decoration: InputDecoration(
                            labelText: "$campoNome*",
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 8) {
                              return "Digite um nome válido";
                            }
                            return null;
                          }),
                    ),
                    SizedBox(height: 25),
                    Container(
                      margin: const EdgeInsets.only(left: 3, right: 3),
                      decoration: const BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: TextFormField(
                          controller: mascara,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "$campoText*",
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < campoNum) {
                              return "Digite os $campoNum dígitos do seu $campoText";
                            }
                            return null;
                          }),
                    ),
                    SizedBox(height: 25),
                    Container(
                      margin: EdgeInsets.only(left: 3, right: 3),
                      decoration: const BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          )),
                      child: TextFormField(
                          controller: telefone,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Telefone*",
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 14) {
                              return "Digite um número válido";
                            }
                            return null;
                          }),
                    ),
                    SizedBox(height: 25),
                    Container(
                      margin: EdgeInsets.only(left: 3, right: 3),
                      decoration: const BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          )),
                      child: TextFormField(
                          controller: email,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(labelText: "Email"),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 10) {
                              return "Digite um email válido";
                            }
                            return null;
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Valor total do pedido: R\$$valorTotalCarrinho",
                              style: GoogleFonts.nanumGothic(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          Text(
                            "Você deve retirar seu produto em: Av. Assis Brasil, 316, Arroio do Sal - RS, 95585-000",
                            style: GoogleFonts.nanumGothic(
                                fontSize: 16, color: Colors.grey),
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              child: ElevatedButton(
                                  child: Text('Enviar Dados'),
                                  onPressed: () async {
                                    if (_formKey2.currentState!.validate()) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Processando...')),
                                      );
                                      guardarDadosRetirada();
                                    }
                                  }),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );

    return Scaffold(body: escolherLayout());
  }
}

class FinalizarCompra extends StatefulWidget {
  State<StatefulWidget> createState() {
    return FinalizarCompraState();
  }
}
