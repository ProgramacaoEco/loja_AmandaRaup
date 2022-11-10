import 'package:admin_newpedido/controller/locaisentrega_controller.dart';
import 'package:admin_newpedido/data/dummy_data.dart';
import 'package:admin_newpedido/model/produto.dart';
import 'package:admin_newpedido/model/quantidade.dart';
import 'package:admin_newpedido/model/tamanho.dart';
import 'package:admin_newpedido/view/widgets/card_estoque.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';
import '../model/decoration_textfield.dart';
import 'package:get/get.dart';

class ControleEstoque extends StatelessWidget {
  final controller = Get.put(LocaisEntregaController());

  var appbar = AppBar(
        title: Text('Controle de estoque', style: TextStyle(color: Color(0xFF6c5b54))),
      elevation: 0,
      backgroundColor: Color(0xFFe2ddda),
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Color(0xFF6c5b54))),
  );

  TextEditingController txt = TextEditingController();

  Widget build(BuildContext context) {
    List loadedQuantitys = controller.quantidades;
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      child: Scaffold(
        appBar: appbar,
        body: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                margin: EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: Container(
                  color: Colors.white,
                  child: Column(children: [
                    //Todos os objetos da Tela aqui dentro=================

                    Container(
                      child: Column(
                        children: [
                         
                          // ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.075,
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: 'Pesquisar',
                                      contentPadding:
                                          EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    ),
                                    controller: txt,
                                    onChanged: (value) {
                                      if (value.isEmpty) {
                                        controller.listarQuantidades(1);
                                        loadedQuantitys =
                                            controller.quantidades;
                                      }
                                      controller.listarQuantidades(value);
                                      loadedQuantitys = controller.quantidades;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              height: 75,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.grey.shade100,
                                      Colors.grey.shade50,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Código Produto',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text('Descrição Produto',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text('Tamanho',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text('Quantidade',
                                    style: TextStyle(fontSize: 20),
                                  ),  
                                ],
                              ),
                            ),
                          ),
                          Obx(() => controller.quantidades != null ||
                                  controller.quantidades != [] ||
                                  controller.quantidades.length != 0
                              ? Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ListView.builder(
                                          itemCount:
                                              controller.quantidades.length,
                                          itemBuilder: (ctx, i) {
                                            return Container(
                                              child: CardEstoqueProduto(
                                                  controller.quantidades[i],
                                                ),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 2.5,
                                                  horizontal: 12),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Center(
                                  child: CircularProgressIndicator(),
                                )),
                        ],
                      ),
                    ),

                    //=====================================================
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
      onWillPop: () {
        Get.back();
      },
    );
  }
}
