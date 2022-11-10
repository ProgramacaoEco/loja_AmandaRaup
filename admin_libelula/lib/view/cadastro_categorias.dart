import 'dart:typed_data';
import 'package:admin_newpedido/controller/categoria_controller.dart';
import 'package:admin_newpedido/model/decoration_textfield.dart';
import 'package:admin_newpedido/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CadastroCategorias extends StatelessWidget {
  TextEditingController nomeCategoria = TextEditingController();
  final CategoriaController controller = Get.put(CategoriaController());

  var appbar = AppBar(
    title: Text('Cadastro Categorias', style: TextStyle(color: Color(0xFF6c5b54))),
    elevation: 0,
    backgroundColor: Color(0xFFe2ddda),
    leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.arrow_back, color: Color(0xFF6c5b54))),
  );

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double textScale = MediaQuery.of(context).textScaleFactor;
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: appbar,
          body: CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: size.width,
                    maxHeight: size.height,
                  ),
                  child: Stack(
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: size.width,
                          maxHeight: size.height,
                          minWidth: 280,
                          minHeight: 340,
                        ),
                        margin: Responsive.isMobile(context)
                            ? EdgeInsets.all(0)
                            : EdgeInsets.all(40),
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ]),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buildSelectImage(context, size),
                              buildDescricaoCategoria(size, context),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      buildInserirImage(size, context),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: Responsive.isMobile(context)
                                              ? size.width / 1
                                              : size.width * 0.3,
                                          child: ElevatedButton(
                                              onPressed: () async {
                                                await controller.salvar(
                                                    nomeCategoria.text.trim(),
                                                    context);
                                                controller.limparValores();
                                              },
                                              child: Text("Salvar"),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Color(0xff38377b))),
                                        ),
                                      ),
                                      buildInatiarCategoria(context, size),
                                      buildEditarCategoria(context, size)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ));
      // ),
      // onWillPop: () {
      //   controller.limparValores();
      //   nomeCategoria.text = '';
      //   Get.back();
      // });
    });
  }

  Padding buildEditarCategoria(BuildContext context, Size size) {
    var i;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: Responsive.isMobile(context) ? size.width / 1 : size.width * 0.3,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.yellow),
          child: Text("Editar Imagem"),
          onPressed: () {
            controller.listarCategorias();
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Editar imagem",
                      style: TextStyle(
                          fontSize: Responsive.isMobile(context) ? 14 : 16),
                    ),
                    Container(
                      width: Responsive.isMobile(context)
                          ? size.width / 4
                          : size.width / 10,
                      child: ElevatedButton(
                        child: Text("Voltar"),
                        onPressed: () => Get.back(),
                        style: ElevatedButton.styleFrom(primary: Colors.yellow),
                      ),
                    )
                  ],
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            constraints: BoxConstraints(
                                maxHeight: size.height,
                                maxWidth: size.width * 0.6,
                                minWidth: 360,
                                minHeight: 290),
                            width: size.width * 0.6,
                            height: size.height / 2,
                            child: Obx(
                              () => controller.categorias == null ||
                                      controller.categorias.length < 0 ||
                                      controller.categorias == [] ||
                                      controller.categorias.isEmpty
                                  ? Container()
                                  : Container(
                                      child: ListView.builder(
                                        itemCount: controller.categorias.length,
                                        itemBuilder: (context, index) =>
                                            ListTile(
                                          title: Text(
                                            "Categoria: ${controller.categorias[index]['nome_categoria']}",
                                            style: TextStyle(
                                                fontSize:
                                                    Responsive.isMobile(context)
                                                        ? 13
                                                        : 16),
                                          ),
                                          leading: Container(
                                            width: Responsive.isMobile(context)
                                                ? size.width / 4
                                                : size.width / 10,
                                            child: ElevatedButton(
                                              child: Text(
                                                "Editar imagem",
                                                style: TextStyle(
                                                    fontSize:
                                                        Responsive.isMobile(
                                                                context)
                                                            ? 12
                                                            : 14),
                                              ),
                                              onPressed: () => showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  title: Text(
                                                      "Deseja editar a imagem da categoria ${controller.categorias[index]['nome_categoria']}?"),
                                                  actions: [
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary: Colors
                                                                    .orange),
                                                        onPressed: () =>
                                                            controller
                                                                .getImage(
                                                                    'type')
                                                                .then((value) {
                                                              Get.back();
                                                              i = index;
                                                            }),
                                                        child: Text("Sim")),
                                                     ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary: Colors
                                                                    .green),
                                                        onPressed: () =>
                                                            Get.back(),
                                                        child: Text("Não"))
                                                  ],
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.orange),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 250,
                        height: 250,
                        child: Column(
                          children: [
                            Container(
                                width: 185,
                                height: 185,
                                child: buildSelectImage(context, size)),
                            ElevatedButton(
                                onPressed: () => controller.atualizarImagem(
                                    controller.categorias[i]
                                        ['id_categoria'],
                                    context),
                                child: Text('Atualizar'))
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Padding buildInatiarCategoria(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: Responsive.isMobile(context) ? size.width / 1 : size.width * 0.3,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.red),
          child: Text("Inativar"),
          onPressed: () {
            controller.listarCategorias();
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Inativar categorias",
                      style: TextStyle(
                          fontSize: Responsive.isMobile(context) ? 14 : 16),
                    ),
                    Container(
                      width: Responsive.isMobile(context)
                          ? size.width / 4
                          : size.width / 10,
                      child: ElevatedButton(
                        child: Text("Voltar"),
                        onPressed: () => Get.back(),
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                      ),
                    )
                  ],
                ),
                actions: [
                  Column(
                    children: [
                      Container(
                        constraints: BoxConstraints(
                            maxHeight: size.height,
                            maxWidth: size.width,
                            minWidth: 360,
                            minHeight: 290),
                        width: size.width / 0.08,
                        height: size.height / 2,
                        child: Obx(
                          () => controller.categorias == null ||
                                  controller.categorias.length < 0 ||
                                  controller.categorias == [] ||
                                  controller.categorias.isEmpty
                              ? Container()
                              : Container(
                                  child: ListView.builder(
                                    itemCount: controller.categorias.length,
                                    itemBuilder: (context, index) => ListTile(
                                      title: Text(
                                        "Categoria: ${controller.categorias[index]['nome_categoria']}",
                                        style: TextStyle(
                                            fontSize:
                                                Responsive.isMobile(context)
                                                    ? 13
                                                    : 16),
                                      ),
                                      leading: Container(
                                        width: Responsive.isMobile(context)
                                            ? size.width / 4
                                            : size.width / 10,
                                        child: ElevatedButton(
                                          child: Text(
                                            "Inativar",
                                            style: TextStyle(
                                                fontSize:
                                                    Responsive.isMobile(context)
                                                        ? 14
                                                        : 16),
                                          ),
                                          onPressed: () => showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text(
                                                  "Deseja inativar a categoria ${controller.categorias[index]['nome_categoria']}?"),
                                              actions: [
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                Colors.red),
                                                    onPressed: () => controller
                                                        .inativarCategorias(
                                                            controller
                                                                    .categorias
                                                                    .value[index]
                                                                [
                                                                'id_categoria']),
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
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Padding buildInserirImage(Size size, context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: Responsive.isMobile(context) ? size.width / 1 : size.width * 0.3,
        child: ElevatedButton(
          onPressed: () => controller.getImage("post"),
          child: Text(
            "Inserir imagem",
            style: TextStyle(fontSize: Responsive.isMobile(context) ? 14 : 16),
          ),
          style: ElevatedButton.styleFrom(primary: Color(0xfff58731)),
        ),
      ),
    );
  }

  Padding buildDescricaoCategoria(Size size, context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
          width:
              Responsive.isMobile(context) ? size.width / 1 : size.width * 0.3,
          child: TextFormField(
            style: TextStyle(fontSize: Responsive.isMobile(context) ? 14 : 16),
            controller: nomeCategoria,
            decoration: Decor(
                labelText: "Descrição da categoria; ex: Infantil",
                isDense: true),
          )),
    );
  }

  Container buildSelectImage(BuildContext context, Size size) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Obx(
        () => controller.selectedImage.value.lengthInBytes == 0
            ? Center(child: Text("Selecione a imagem"))
            : Container(
                width: Responsive.isMobile(context)
                    ? size.width * 0.7
                    : size.width * 0.6,
                height: size.height / 3,
                child: Image.memory(
                    Uint8List.fromList(controller.selectedImage.value)),
              ),
      ),
    );
  }
}
