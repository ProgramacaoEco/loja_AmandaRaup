import 'package:admin_newpedido/controller/usuario_controller.dart';
import 'package:admin_newpedido/model/decoration_textfield.dart';
import 'package:admin_newpedido/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class CadastroUsuarios extends StatelessWidget {
  final controller = Get.put(UsuarioController());
  TextEditingController codigoPermissao = TextEditingController();
  var codigo = '1';

  ScrollController scrollController = ScrollController();

  TextEditingController login = TextEditingController();
  TextEditingController senha = TextEditingController();
  TextEditingController confirmarSenha = TextEditingController();

  var appbar = AppBar(
        title: Text('Cadastro de usúarios', style: TextStyle(color: Color(0xFF6c5b54))),
      elevation: 0,
      backgroundColor: Color(0xFFe2ddda),
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Color(0xFF6c5b54))),
  );

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: Responsive.isMobile(context)
                  ? EdgeInsets.all(0)
                  : EdgeInsets.all(40),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                )
              ]),
              child: Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.width / 60,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: login,
                                      cursorColor: Colors.grey[800],
                                      decoration: Decor(labelText: "Login"),
                                    ),
                                  ],
                                )),
                            SizedBox(
                              height: MediaQuery.of(context).size.width / 60,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: senha,
                                      obscureText: true,
                                      cursorColor: Colors.grey[800],
                                      decoration: Decor(labelText: "Senha"),
                                    ),
                                  ],
                                )),
                            SizedBox(
                              height: MediaQuery.of(context).size.width / 60,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: confirmarSenha,
                                    obscureText: true,
                                    cursorColor: Colors.grey[800],
                                    decoration:
                                        Decor(labelText: "Confirmar senha"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      controller.salvar(context, login.text,
                                          senha.text, confirmarSenha.text);
                                      login.text = '';
                                      senha.text = '';
                                      confirmarSenha.text = '';
                                    },
                                    child: Text("Salvar"),
                                    style: ElevatedButton.styleFrom(
                                        primary: Color(0xff38377b)),
                                  )),
                            ),
                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width / 30,
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(bottom: 5),
                            //   child: Container(
                            //       width: MediaQuery.of(context).size.width / 4,
                            //       child: ElevatedButton(
                            //         onPressed: () {
                            //           controller.novo(context, login.text,
                            //               senha.text, confirmarSenha.text);
                            //           login.text = '';
                            //           senha.text = '';
                            //           confirmarSenha.text = '';
                            //         },
                            //         child: Text("Novo"),
                            //         style: ElevatedButton.styleFrom(
                            //             primary: Color(0xfff58731)),
                            //       )),
                            // ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(
                                              "Digite o código de permissão"),
                                          actions: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 20),
                                              width:
                                                  Responsive.isMobile(context)
                                                      ? MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          4.2
                                                      : MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          10.5,
                                              child: TextFormField(
                                                controller: codigoPermissao,
                                                decoration: InputDecoration(
                                                    hintText: "Código"),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                codigo = codigoPermissao.text;
                                                if (codigo ==
                                                    controller
                                                        .codigoPermissao) {
                                                  Get.back();
                                                  showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Column(
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      5,
                                                                  child:
                                                                      ElevatedButton(
                                                                    child: Text(
                                                                        "Voltar"),
                                                                    onPressed:
                                                                        () {
                                                                      Get.back();
                                                                      codigoPermissao
                                                                          .text = '';
                                                                    },
                                                                    style: ElevatedButton.styleFrom(
                                                                        primary:
                                                                            Colors.red),
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  'Selecione para Inativar',
                                                                  style: TextStyle(
                                                                      fontSize: Responsive.isMobile(
                                                                              context)
                                                                          ? 14
                                                                          : 16),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          actions: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        2,
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height /
                                                                        2,
                                                                    child:
                                                                        Scrollbar(
                                                                      child: ListView
                                                                          .builder(
                                                                        scrollDirection:
                                                                            Axis.vertical,
                                                                        controller:
                                                                            scrollController,
                                                                        itemCount: controller
                                                                            .usuarios
                                                                            .length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          return ListTile(
                                                                              onTap: () => showDialog(
                                                                                    context: context,
                                                                                    builder: (context) => AlertDialog(
                                                                                      title: Text("Deseja inativar o usuario ${controller.usuarios[index]['usuario']}?"),
                                                                                      actions: [
                                                                                        Container(
                                                                                          child: ElevatedButton(
                                                                                            child: Text("Sim"),
                                                                                            onPressed: () {
                                                                                              controller.inativar(context, controller.usuarios[index]['usuario'], codigoPermissao.text);
                                                                                              codigoPermissao.text = '';
                                                                                            },
                                                                                            style: ElevatedButton.styleFrom(primary: Colors.red),
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          child: ElevatedButton(
                                                                                            child: Text("Não"),
                                                                                            onPressed: () => Get.back(),
                                                                                            style: ElevatedButton.styleFrom(primary: Colors.green),
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                              title: Text(controller.usuarios[index]['usuario']));
                                                                        },
                                                                      ),
                                                                      controller:
                                                                          scrollController,
                                                                      isAlwaysShown:
                                                                          true,
                                                                      hoverThickness:
                                                                          10.0,
                                                                      showTrackOnHover:
                                                                          true,
                                                                      thickness:
                                                                          10.0,
                                                                    )),
                                                              ],
                                                            )
                                                          ],
                                                        );
                                                      });
                                                } else {
                                                  Get.snackbar(
                                                      '', 'Código inválido');
                                                }
                                              },
                                              child: Text("Validar"),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.green),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 15),
                                              child: Container(
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                Colors.red),
                                                    onPressed: () {
                                                      Get.back();
                                                      codigoPermissao.text = '';
                                                    },
                                                    child: Text("Voltar")),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: Text("Inativar"),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.red),
                                  )),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 30,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 4,
                              child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title:
                                          Text("Digite o código de permissão"),
                                      actions: [
                                        Container(
                                          margin: EdgeInsets.only(bottom: 20),
                                          width: Responsive.isMobile(context)
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4.2
                                              : MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  10.5,
                                          child: TextFormField(
                                            controller: codigoPermissao,
                                            decoration: InputDecoration(
                                                hintText: "Código"),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            codigo = codigoPermissao.text;
                                            if (codigo ==
                                                controller.codigoPermissao) {
                                              Get.back();
                                              showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  5,
                                                              child:
                                                                  ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(
                                                                          primary: Colors
                                                                              .red),
                                                                      child: Text(
                                                                          "Voltar"),
                                                                      onPressed:
                                                                          () {
                                                                        Get.back();
                                                                        codigoPermissao.text =
                                                                            '';
                                                                      }),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                                "Selecione para editar",
                                                                style: TextStyle(
                                                                    fontSize: Responsive.isMobile(
                                                                            context)
                                                                        ? 14
                                                                        : 16)),
                                                          ),
                                                        ],
                                                      ),
                                                      actions: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          10),
                                                              child: Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      1,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height /
                                                                      2,
                                                                  child:
                                                                      Scrollbar(
                                                                    child: ListView
                                                                        .builder(
                                                                      scrollDirection:
                                                                          Axis.vertical,
                                                                      controller:
                                                                          scrollController,
                                                                      itemCount: controller
                                                                          .usuarios
                                                                          .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return ListTile(
                                                                            onTap:
                                                                                () {
                                                                              login.text = '';
                                                                              senha.text = '';
                                                                              confirmarSenha.text = '';
                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (context) => AlertDialog(
                                                                                  title: Text("Editar usuario ${controller.usuarios[index]['usuario']}"),
                                                                                  actions: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Column(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          SizedBox(
                                                                                            height: MediaQuery.of(context).size.width / 60,
                                                                                          ),
                                                                                          Container(
                                                                                              width: MediaQuery.of(context).size.width / 1,
                                                                                              child: TextFormField(
                                                                                                controller: login,
                                                                                                cursorColor: Colors.grey[800],
                                                                                                decoration: Decor(labelText: "Login"),
                                                                                              )),
                                                                                          SizedBox(
                                                                                            height: MediaQuery.of(context).size.width / 60,
                                                                                          ),
                                                                                          Container(
                                                                                              width: MediaQuery.of(context).size.width / 1,
                                                                                              child: TextFormField(
                                                                                                controller: senha,
                                                                                                obscureText: true,
                                                                                                cursorColor: Colors.grey[800],
                                                                                                decoration: Decor(labelText: "Senha"),
                                                                                              )),
                                                                                          SizedBox(
                                                                                            height: MediaQuery.of(context).size.width / 60,
                                                                                          ),
                                                                                          Container(
                                                                                              width: MediaQuery.of(context).size.width / 1,
                                                                                              child: TextFormField(
                                                                                                obscureText: true,
                                                                                                controller: confirmarSenha,
                                                                                                cursorColor: Colors.grey[800],
                                                                                                decoration: Decor(labelText: "Confirmar senha"),
                                                                                              )),
                                                                                          Center(
                                                                                            child: Container(
                                                                                              margin: EdgeInsets.only(top: 20),
                                                                                              child: Column(
                                                                                                children: [
                                                                                                  Padding(
                                                                                                    padding: const EdgeInsets.only(bottom: 5),
                                                                                                    child: Container(
                                                                                                      width: MediaQuery.of(context).size.width / 4,
                                                                                                      child: ElevatedButton(
                                                                                                        onPressed: () {
                                                                                                          controller.editar(context, login.text, senha.text, controller.usuarios[index]['id']);
                                                                                                          login.text = '';
                                                                                                          senha.text = '';
                                                                                                          confirmarSenha.text = '';
                                                                                                          codigoPermissao.text = '';
                                                                                                        },
                                                                                                        child: Text("Salvar"),
                                                                                                        style: ElevatedButton.styleFrom(primary: Color(0xff38377b)),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Container(
                                                                                                    width: MediaQuery.of(context).size.width / 4,
                                                                                                    child: ElevatedButton(
                                                                                                      onPressed: () {
                                                                                                        codigoPermissao.text = '';
                                                                                                        login.text = '';
                                                                                                        senha.text = '';
                                                                                                        confirmarSenha.text = '';
                                                                                                        Get.back();
                                                                                                      },
                                                                                                      child: Text("Cancelar"),
                                                                                                      style: ElevatedButton.styleFrom(primary: Colors.red),
                                                                                                    ),
                                                                                                  )
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            },
                                                                            title:
                                                                                Text(controller.usuarios[index]['usuario']));
                                                                      },
                                                                    ),
                                                                    controller:
                                                                        scrollController,
                                                                    isAlwaysShown:
                                                                        true,
                                                                    hoverThickness:
                                                                        10.0,
                                                                    showTrackOnHover:
                                                                        true,
                                                                    thickness:
                                                                        10.0,
                                                                  )),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    );
                                                  });
                                            } else {
                                              Get.snackbar(
                                                  '', 'Código inválido');
                                            }
                                          },
                                          child: Text("Validar"),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.green),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: 15),
                                          child: Container(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                codigoPermissao.text = '';
                                                login.text = '';
                                                senha.text = '';
                                                confirmarSenha.text = '';
                                                Get.back();
                                              },
                                              child: Text("Voltar"),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.red),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                child: Text("Buscar"),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
