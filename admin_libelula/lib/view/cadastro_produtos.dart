import 'dart:html';
import 'dart:typed_data';
import 'package:admin_newpedido/controller/login_controller.dart';
import 'package:admin_newpedido/controller/produtos_controller.dart';
import 'package:admin_newpedido/model/decoration_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class CadastroProdutos extends StatelessWidget {
  final ProdutosController controller = Get.put(ProdutosController());
  TextEditingController descricaoProduto = TextEditingController();
  final auth = Get.find<LoginController>();

  Widget build(BuildContext context) {
    auth.checkToken();

    var _imagem1;
    var _imagem2;
    var _imagem3;
    List<Widget> _images = [_imagem1, _imagem2, _imagem3];

    TextEditingController _codigoBarras = TextEditingController();
    TextEditingController _descricaoProduto = TextEditingController();
    MoneyMaskedTextController _valor = MoneyMaskedTextController(
        decimalSeparator: ",", thousandSeparator: ".");
    MoneyMaskedTextController _avista = MoneyMaskedTextController(
        decimalSeparator: ",", thousandSeparator: ".");
    MaskedTextController _aprazo = MaskedTextController(mask: '00');
    TextEditingController tamanhoNumerico = TextEditingController();

    GlobalKey<FormFieldState> multiselectTamanhoNumerico = GlobalKey();

    var appbar = AppBar(
      title: Text('Cadastro de Produtos', style: TextStyle(color: Color(0xFF6c5b54))),
      elevation: 0,
      backgroundColor: Color(0xFFe2ddda),
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Color(0xFF6c5b54))),
    );

    return WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appbar,
        body: Stack(
          children: [
            CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Container(
                      width: Get.width,
                      margin: EdgeInsets.all(40),
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        )
                      ]),
                      child: Column(
                        children: [
                          Flexible(
                            child: Flex(
                              direction: Axis.vertical,
                              children: [
                                buildInserirImage(_images, context),
                                buildInputCodigoDeBarras(
                                    _codigoBarras, context),
                                buildInputDescricaoProduto(
                                    _descricaoProduto, context),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 20),
                                  child: buildInputsDescricaoFormaPagamento(
                                      context, _aprazo, _valor, _avista),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(right: 75, left: 10),
                                  child: buildCategorias(),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  child: buildInputTamanhos(
                                      multiselectTamanhoNumerico,
                                      context,
                                      tamanhoNumerico),
                                ),
                                Container(
                                  width: Get.width,
                                  child: buildButtomProdutoDestaque(),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 10),
                                      alignment: Alignment.centerLeft,
                                      child: SizedBox(
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            await controller.salvar(
                                                _codigoBarras.text,
                                                _descricaoProduto.text,
                                                _avista.text,
                                                _valor.text,
                                                _aprazo.text);
                                          },
                                          child: Text("Salvar"),
                                          style: ElevatedButton.styleFrom(
                                              primary: Color(0xff38377b)),
                                        ),
                                        width: Get.width / 10,
                                      ),
                                    ),
                                    buildButtomBuscarEditarInativar(
                                        context,
                                        _avista,
                                        _descricaoProduto,
                                        _codigoBarras),
                                  ],
                                )
                              ],
                            ),
                            flex: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      onWillPop: () {
        controller.limparValores();
        Get.back();
      },
    );
  }

  Flexible buildInserirImage(List<Widget> _images, context) {
    return Flexible(
      flex: 2,
      child: Container(
        margin: EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 2.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              controller.getImage1();
                              _images[0] = Obx(() => Container(
                                  child: Image.memory(Uint8List.fromList(
                                      controller.selectedImage1.value))));
                            },
                            child: Text("Escolher imagem 1"),
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xfff58731)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, right: 2.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              controller.getImage2();
                              _images[1] = Obx(() => Image.memory(
                                  Uint8List.fromList(
                                      controller.selectedImage2.value)));
                            },
                            child: Text("Escolher imagem 2"),
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xfff58731),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 2.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                controller.getImage3();
                                _images[2] = Obx(() => Image.memory(
                                    Uint8List.fromList(
                                        controller.selectedImage3.value)));
                              },
                              child: Text("Escolher imagem 3"),
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xfff58731))),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, left: 2.5),
                      child: ElevatedButton(
                          onPressed: () => controller.limparImagens(),
                          child: Text("Remover imagens"),
                          style: ElevatedButton.styleFrom(primary: Colors.red)),
                    ),
                  ],
                ),
              ],
            ),
            Obx(
              () => controller.selectedImage1.value.buffer.lengthInBytes == 0 &&
                      controller.selectedImage2.value.buffer.lengthInBytes ==
                          0 &&
                      controller.selectedImage3.value.buffer.lengthInBytes == 0
                  ? Center(
                      child: Container(
                        child: Text("Selecione a imagem"),
                        margin: EdgeInsets.only(top: 20),
                      ),
                    )
                  : Container(
                      child: CarouselSlider(
                        items: _images,
                        options: CarouselOptions(
                          height: 350,
                          aspectRatio: GetPlatform.isAndroid ? 4 / 3 : 16 / 9,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildButtomBuscarEditarInativar(
    BuildContext context,
    TextEditingController _parcelaEdit,
    TextEditingController _descricaoProdutoEdit,
    TextEditingController _codigoBarrasEdit,
  ) {
    return Container(
      margin: EdgeInsets.only(right: 30),
      width: Get.width / 10,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.yellow[600]),
        child: Text("Buscar"),
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: Get.width / 5,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        onPressed: () => Get.back(),
                        child: Text(
                          "Voltar",
                          style: TextStyle(fontSize: 16),
                        )),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Editar e inativar produtos",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            actions: [
              Column(
                children: [
                  Center(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Container(
                            width: Get.width / 1.8,
                            child: TextFormField(
                              onChanged: (value) {
                                controller.produtos.clear();
                                controller.listarProdutos(value);
                              },
                              controller: descricaoProduto,
                              decoration: InputDecoration(
                                  hintText: "Nome ou Cod do produto"),
                            ),
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              controller.produtos.clear();
                              controller.listarProdutos(descricaoProduto.text);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: Get.width,
                    height: Get.height / 2,
                    child: Obx(
                      () => controller.produtos == null ||
                              controller.produtos.length < 0 ||
                              controller.produtos == [] ||
                              controller.produtos.isEmpty
                          ? Container()
                          : Container(
                              child: ListView.builder(
                                itemCount: controller.produtos.length,
                                itemBuilder: (context, index) => ListTile(
                                  title: Text(
                                      "${controller.produtos[index]['descricaoProduto']}"),
                                  subtitle: Text(
                                      "${controller.produtos[index]['codigoProduto']}"),
                                  leading: Container(
                                    width: Get.width / 8,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ElevatedButton(
                                          child: Text("Inativar"),
                                          onPressed: () => showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text(
                                                  "Deseja inativar o produto ${controller.produtos[index]['descricaoProduto']}?"),
                                              actions: [
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary: Colors
                                                                .red),
                                                    onPressed: () => controller
                                                        .inativarProdutos(
                                                            controller.produtos
                                                                        .value[
                                                                    index]
                                                                ['id_produto']),
                                                    child: Text("Sim")),
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                Colors.green),
                                                    onPressed: () => Get.back(),
                                                    child: Text("Não"))
                                              ],
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.red),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: ElevatedButton(
                                            child: Text("Editar"),
                                            onPressed: () => showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(controller
                                                            .produtos[index]
                                                        ['descricaoProduto']),
                                                    Container(
                                                      width: Get.width / 10,
                                                      child: ElevatedButton(
                                                        child: Text("Voltar"),
                                                        onPressed: () {
                                                          controller
                                                              .dpSelecaoTamanhoEdit
                                                              .clear();
                                                          Get.back();
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary:
                                                                    Colors.red),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                actions: [
                                                  Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        /* Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                /* Container(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(bottom: 10),
                                                                        child:
                                                                            Flexible(
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                Get.width / 8,
                                                                            child:
                                                                                TextFormField(
                                                                              initialValue: controller.produtos[index]['codigoProduto'],
                                                                              onChanged: (values) {
                                                                                controller.codigoBarrasEdit = values;
                                                                              },
                                                                              cursorColor: Colors.grey[800],
                                                                              decoration: Decor(labelText: "Código de barras", isDense: true),
                                                                            ),
                                                                          ),
                                                                          flex:
                                                                              0,
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                          width:
                                                                              Get.width / 8),
                                                                      Container(
                                                                          width:
                                                                              Get.width / 8),
                                                                    ],
                                                                  ),
                                                                ), */
                                                               /*  Container(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Flexible(
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              Get.width / 2.65,
                                                                          margin: EdgeInsets.only(
                                                                              left: 30,
                                                                              right: 30),
                                                                          child:
                                                                              TextFormField(
                                                                            maxLength:
                                                                                60,
                                                                            initialValue:
                                                                                controller.produtos[index]['descricaoProduto'],
                                                                            onChanged:
                                                                                (values) {
                                                                              controller.descricaoProdutoEdit = values;
                                                                            },
                                                                            cursorColor:
                                                                                Colors.grey[800],
                                                                            decoration:
                                                                                Decor(labelText: "Descrição do produto", isDense: true),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ), */
                                                                /* Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 20),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Container(
                                                                              margin: EdgeInsets.only(left: 8),
                                                                              child: Text(
                                                                                "Em até",
                                                                                style: TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontSize: 14,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              margin: EdgeInsets.only(left: 8),
                                                                              height: Get.height / 20,
                                                                              width: Get.width / 14,
                                                                              child: TextFormField(
                                                                                onChanged: (values) {
                                                                                  controller.parcelaEdit = values;
                                                                                },
                                                                                cursorColor: Colors.grey[800],
                                                                                decoration: Decor(labelText: 'Parcelas', isDense: true),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 10, right: 10),
                                                                              child: Container(
                                                                                width: Get.width / 32,
                                                                                margin: EdgeInsets.only(left: 5),
                                                                                child: Text(
                                                                                  "de R\$",
                                                                                  style: TextStyle(color: Colors.black, fontSize: 14),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              child: SizedBox(
                                                                                child: TextFormField(
                                                                                    //keyboardType: TextInputType.number,
                                                                                    decoration: Decor(labelText: "Valor", isDense: true),
                                                                                    cursorColor: Colors.black,
                                                                                    onChanged: (values) {
                                                                                      controller.aprazoEdit = values;
                                                                                    }),
                                                                                width: Get.width / 11,
                                                                                height: Get.height / 20,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ), */
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 20),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(
                                                                            top:
                                                                                20,
                                                                            left:
                                                                                4,
                                                                          ),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Padding(
                                                                                padding: EdgeInsets.only(right: 10),
                                                                                child: Container(
                                                                                  margin: EdgeInsets.only(left: 5),
                                                                                  child: Text(
                                                                                    "À vista com 10% de desconto:",
                                                                                    style: TextStyle(color: Colors.black, fontSize: 14),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                child: SizedBox(
                                                                                  child: TextFormField(
                                                                                      keyboardType: TextInputType.number,
                                                                                      decoration: Decor(labelText: "Valor", isDense: true),
                                                                                      cursorColor: Colors.black,
                                                                                      onChanged: (values) {
                                                                                        controller.avistaEdit = values;
                                                                                      }),
                                                                                  width: Get.width / 9.5,
                                                                                  height: Get.height / 20,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ), */
                                                        Container(
                                                          width:
                                                              Get.width / 2.65,
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 0),
                                                            child: SizedBox(
                                                              child:
                                                                  DropdownButtonFormField(
                                                                hint: Text(
                                                                    '${controller.produtos[index]['categoria']['nome_categoria']}'),
                                                                items: controller
                                                                    .listaCategorias
                                                                    .value,
                                                                onChanged:
                                                                    (value) {
                                                                  controller
                                                                      .dpSelecaoCategoria
                                                                      .value = value;
                                                                  print(controller
                                                                      .dpSelecaoCategoria
                                                                      .value);
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width:
                                                              Get.width / 2.65,
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 0),
                                                            child: SizedBox(
                                                              child:
                                                                  MultiSelectDialogField(
                                                                buttonText: Text(
                                                                    "Tamanhos"),
                                                                items: controller
                                                                    .listaTamanho,
                                                                listType:
                                                                    MultiSelectListType
                                                                        .LIST,
                                                                onConfirm:
                                                                    (values) {
                                                                  controller
                                                                          .dpSelecaoTamanhoEdit =
                                                                      values;
                                                                },
                                                                title: Text(
                                                                    "Tamanhos"),
                                                              ),
                                                              width: Get.width /
                                                                  2.65,
                                                            ),
                                                          ),
                                                        ),
                                                        // Container(
                                                        //   width:
                                                        //       Get.width / 2.65,
                                                        //   child: Container(
                                                        //     margin:
                                                        //         EdgeInsets.only(
                                                        //             left: 0),
                                                        //     child: SizedBox(
                                                        //       child:
                                                        //           MultiSelectDialogField(
                                                        //         buttonText: Text(
                                                        //             "Tamanho escala"),
                                                        //         items: controller
                                                        //             .listaTamanhoEscala,
                                                        //         listType:
                                                        //             MultiSelectListType
                                                        //                 .LIST,
                                                        //         onConfirm:
                                                        //             (values) {
                                                        //           controller
                                                        //                   .dpSelecaoTamanhoEscalaEdit =
                                                        //               values;
                                                        //         },
                                                        //         title: Text(
                                                        //             "Tamanho escala"),
                                                        //       ),
                                                        //     ),
                                                        //     width: Get.width /
                                                        //         2.65,
                                                        //   ),
                                                        // ),
                                                        // Container(
                                                        //   width:
                                                        //       Get.width / 2.65,
                                                        //   child: Container(
                                                        //     margin:
                                                        //         EdgeInsets.only(
                                                        //             left: 0),
                                                        //     child: SizedBox(
                                                        //       child:
                                                        //           MultiSelectDialogField(
                                                        //         buttonText: Text(
                                                        //             "Tamanho medida"),
                                                        //         items: controller
                                                        //             .listaTamanhoMedida,
                                                        //         listType:
                                                        //             MultiSelectListType
                                                        //                 .LIST,
                                                        //         onConfirm:
                                                        //             (values) {
                                                        //           controller
                                                        //                   .dpSelecaoTamanhoMedidaEdit =
                                                        //               values;
                                                        //         },
                                                        //         title: Text(
                                                        //             "Tamanho medida"),
                                                        //       ),
                                                        //     ),
                                                        //     width: Get.width /
                                                        //         2.65,
                                                        //   ),
                                                        // ),
                                                        Container(
                                                          width:
                                                              Get.width / 2.65,
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      30,
                                                                  vertical: 10),
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: SizedBox(
                                                            child: Obx(
                                                              () =>
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        controller
                                                                            .ativarProdutoDestaqueEdit();
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        "Produto destaque",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                      style: ElevatedButton.styleFrom(
                                                                          primary: Color(controller
                                                                              .produtoDestaqueColorEdit
                                                                              .value))),
                                                            ),
                                                            width: Get.width /
                                                                2.65,
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 20),
                                                          width: Get.width / 10,
                                                          child: ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              primary: Color(
                                                                  0xff38377b),
                                                            ),
                                                            onPressed: () {
                                                              controller
                                                                  .editarProdutos(
                                                                index,
                                                                controller.produtos[
                                                                        index][
                                                                    'id_produto'],
                                                              );
                                                            },
                                                            child:
                                                                Text("Salvar"),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.yellow[600],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildButtomProdutoDestaque() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      alignment: Alignment.centerLeft,
      child: SizedBox(
        child: Obx(
          () => ElevatedButton(
              onPressed: () {
                controller.ativarProdutoDestaque();
              },
              child: Text(
                "Produto destaque",
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Color(controller.produtoDestaqueColor.value))),
        ),
        width: Get.width,
      ),
    );
  }

  Row buildInputTamanhos(GlobalKey<FormFieldState<dynamic>> multiselectTamanho,
      BuildContext context, TextEditingController tamanho) {
    return Row(
      children: [
        Flexible(
          child: Container(
            margin: EdgeInsets.only(right: 0),
            child: SizedBox(
              child: MultiSelectDialogField(
                key: multiselectTamanho,
                onSelectionChanged: (newValue) {},
                buttonText: Text("Tamanhos"),
                items: controller.listaTamanho,
                listType: MultiSelectListType.LIST,
                onConfirm: (values) {
                  controller.dpSelecaoTamanho.value = values;
                },
                title: Text("Tamanhos"),
              ),
              width: Get.width / 1,
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.add_circle_outlined),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Novo tamanho"),
                  actions: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20, right: 20),
                      width: Get.width,
                      child: TextFormField(
                        controller: tamanho,
                        decoration: InputDecoration(hintText: "Digite aqui"),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          controller.cadastrarNovoTamanho(
                              tamanho.text, context);
                        },
                        child: Text("Salvar"),
                      ),
                    )
                  ],
                );
              },
            );
          },
          tooltip: "Cadastrar novo tamanho",
        ),
      ],
    );
  }

  Container buildCategorias() {
    return Container(
      child: Container(
        child: SizedBox(
          child: Obx(
            () => controller.listaCategorias == null
                ? DropdownButtonFormField(
                    items: [],
                  )
                : DropdownButtonFormField(
                    hint: Text("Categorias"),
                    items: controller.listaCategorias,
                    onChanged: (value) {
                      controller.dpSelecaoCategoria.value = value;
                      print(controller.dpSelecaoCategoria.value);
                    },
                  ),
          ),
        ),
        margin: EdgeInsets.only(left: 20),
        width: Get.width / 10,
      ),
    );
  }

  Column buildInputsDescricaoFormaPagamento(
      BuildContext context,
      MaskedTextController _aprazo,
      MoneyMaskedTextController _valor,
      MoneyMaskedTextController _avista) {
    return buildColumnFormaPagamento(context, _aprazo, _valor, _avista);
  }

  Container buildInputDescricaoProduto(
      TextEditingController _descricaoProduto, context) {
    return Container(
      child: Row(
        children: [
          Flexible(
            child: Container(
              width: Get.width / 2,
              margin: EdgeInsets.only(left: 30, right: 30),
              child: TextFormField(
                maxLength: 60,
                controller: _descricaoProduto,
                cursorColor: Colors.grey[800],
                decoration: Decor(labelText: "Descrição do produto"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildInputCodigoDeBarras(
      TextEditingController _codigoBarras, context) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 5),
            height: Get.height / 12.5,
            width: Get.width / 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ Text(
                    'P - ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), 
              color: Colors.grey.shade200
            ),
          ),
          Flexible(
            child: Container(
              width: Get.width / 8,
              child: TextFormField(
                controller: _codigoBarras,
                cursorColor: Colors.grey[800],
                decoration: Decor(labelText: "Código do Produto"),
              ),
            ),
            flex: 0,
          )
        ],
      ),
    );
  }

  iconButtonEdit(context, index) {
    return IconButton(
        onPressed: () => showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => AlertDialog(
                title: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: Get.width / 10,
                        child: ElevatedButton(
                          child: Text("Voltar"),
                          onPressed: () {
                            controller.dpSelecaoTamanhoEdit.clear();
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        controller.produtos[index]['descricaoProduto'],
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                actions: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildContainerEditCategoria(context),
                        Container(
                          width: Get.width / 1,
                          child: Container(
                            margin: EdgeInsets.only(right: 0),
                            child: SizedBox(
                              child: MultiSelectDialogField(
                                buttonText: Text("Tamanhos"),
                                items: controller.listaTamanho,
                                listType: MultiSelectListType.LIST,
                                onConfirm: (values) {
                                  controller.dpSelecaoTamanhoEdit = values;
                                },
                                title: Text("Tamanhos"),
                              ),
                              width: Get.width / 2.65,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          width: Get.width / 10,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff38377b),
                            ),
                            onPressed: () {},
                            // => controller.editarProdutos(
                            // controller.produtos[index]['id_produto'],
                            //),
                            child: Text("Salvar"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        icon: Icon(
          Icons.edit,
          color: Colors.yellow,
        ));
  }

  Container buildContainerEditCategoria(BuildContext context) {
    return Container(
      width: Get.width / 2.65,
      child: Container(
        margin: EdgeInsets.only(right: 0),
        child: SizedBox(
          child: DropdownButtonFormField(
            hint: Text("Categorias"),
            items: controller.listaCategorias,
            onChanged: (value) {
              controller.dpSelecaoCategoria.value = value;
              print(controller.dpSelecaoCategoria.value);
            },
          ),
        ),
      ),
    );
  }
}

Column buildColumnFormaPagamento(
    BuildContext context,
    MaskedTextController _aprazo,
    MoneyMaskedTextController _valor,
    MoneyMaskedTextController _avista) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 8, top: 4, right: 8, bottom: 8),
        child: Container(
          width: Get.width / 1,
          child: Text(
            "Valor do produto: ",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      // Row(
      //   children: [
      //     Container(
      //       margin: EdgeInsets.only(left: 8),
      //       child: Text(
      //         "Em até",
      //         style: TextStyle(color: Colors.black, fontSize: 16),
      //       ),
      //     ),
      //     Container(
      //       margin: EdgeInsets.only(left: 8),
      //       height: Get.height / 20,
      //       width: Get.width / 15,
      //       child: TextFormField(
      //         controller: _aprazo,
      //         cursorColor: Colors.grey[800],
      //         decoration: Decor(labelText: 'Parcela', isDense: true),
      //       ),
      //     ),
      //     Container(
      //       //margin: EdgeInsets.only(left: 10),
      //       child: Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 5),
      //         child: Text(
      //           "X",
      //           style: TextStyle(color: Colors.black, fontSize: 14),
      //         ),
      //       ),
      //     ),
      //     Container(
      //       width: Get.width / 30,
      //       //margin: EdgeInsets.only(left: 5),
      //       child: Text(
      //         "de R\$",
      //         style: TextStyle(color: Colors.black, fontSize: 14),
      //       ),
      //     ),
      //     Container(
      //       child: SizedBox(
      //         child: TextFormField(
      //           controller: _valor,
      //           decoration: Decor(labelText: "Valor"),
      //           cursorColor: Colors.black,
      //         ),
      //         width: Get.width / 10,
      //         height: Get.height / 20,
      //       ),
      //     ),
      //   ],
      // ),
      Padding(
        padding: const EdgeInsets.only(top: 20, left: 4, right: 4),
        child: Row(
          children: [
            // Padding(
            //   padding: EdgeInsets.only(right: 10),
            //   child: Container(
            //     margin: EdgeInsets.only(left: 5),
            //     child: Text(
            //       "Valor do Produto: ",
            //       style: TextStyle(color: Colors.black, fontSize: 16),
            //     ),
            //   ),
            // ),
            Container(
              child: SizedBox(
                child: TextFormField(
                  controller: _avista,
                  decoration: Decor(labelText: "Valor"),
                  cursorColor: Colors.black,
                ),
                width: Get.width / 10,
                height: Get.height / 20,
              ),
            ),
          ],
        ),
      )
    ],
  );
}
