import 'package:admin_newpedido/model/cardMenuType.dart';
import 'package:admin_newpedido/responsive.dart';
import '../controller/menu_controller.dart';
import 'package:admin_newpedido/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class Menu extends StatelessWidget {
  final auth = Get.find<LoginController>();
  final controller = Get.put(MenuController());
  CardMenuTypes cMT = CardMenuTypes();

  Timer timer;

  Widget build(BuildContext context) {
    auth.checkToken();
    Size _size = MediaQuery.of(context).size;

    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: buildAppBar(_size, context),
        body: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                margin: EdgeInsets.all(15),
                child: Responsive(
                  mobile: MenuMobile(),
                  desktop: buildMenuColumn(),
                  tablet: buildMenuColumn(),
                ),
              ),
            )
          ],
        ),
      ),
      onWillPop: () {
        Get.offAllNamed('/menu');
      },
    );
  }

  AppBar buildAppBar(Size _size, BuildContext context) {
    double textScale = MediaQuery.of(context).textScaleFactor;
    return AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFe2ddda),
                Color(0xFFFFFFFF),
                Color(0xFFFFFFFF),
                Color(0xFFe2ddda),
              ],
            ),
          ),
        ),
      automaticallyImplyLeading: false,
      // backgroundColor: Color(0xfff35764),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 15, top: 10, bottom: 10),
          width: Responsive.isMobile(context)
              ? _size.width / 7
              : _size.width / 14, // Padrao / 10
          height: MediaQuery.of(context).size.height,
          child: ElevatedButton(
            onPressed: () {
              auth.deslogar();
            },
            child: Text(
              "Sair",
              textScaleFactor: textScale,
            ),
            style: ElevatedButton.styleFrom(primary: Color(0xFF6c5b54)),
          ),
        ),
      ],
      title: Center(
        child: Image.asset('../../images/appstore.png', width: 110),
      ),
      leading: Icon(Icons.home, color: Color(0xFF6c5b54)),
    );
  }

  Column buildMenuColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            cMT.buildCardPedidos(),
            CardMenuTypes.buildCardCadastroProdutos(),
            CardMenuTypes.buildCardImagemCampanha()
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CardMenuTypes.buildCardCadastroCategoria(),
            CardMenuTypes.buildCardCadastroBandeiras(),
            CardMenuTypes.buildCardCadastroUsuario()
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CardMenuTypes.buildCardControleEstoque(),
            CardMenuTypes.buildCardPedidosFaturados(),
            CardMenuTypes.buildCardTamanhos()
          ],
        ),
      ],
    );
  }
}

class MenuMobile extends StatelessWidget {
  CardMenuTypes cMT = CardMenuTypes();

  final auth = Get.find<LoginController>();
  // final controller = Get.put(ControllerPedidos());

  Timer timer;

  Widget build(BuildContext context) {
    auth.checkToken();
    Size _size = MediaQuery.of(context).size;

    return WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: Responsive.isMobile(context)
                              ? _size.width
                              : _size.width * 0.5, //height: ,
                          child: cMT.buildCardPedidos(),
                        ),
                        Container(
                            width: Responsive.isMobile(context)
                                ? _size.width
                                : _size.width * 0.5,
                            child: CardMenuTypes.buildCardCadastroProdutos()),
                        Container(
                            width: Responsive.isMobile(context)
                                ? _size.width
                                : _size.width * 0.5,
                            child: CardMenuTypes.buildCardImagemCampanha())
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: Responsive.isMobile(context)
                                ? _size.width
                                : _size.width * 0.5,
                            child: CardMenuTypes.buildCardCadastroCategoria()),
                        Container(
                            width: Responsive.isMobile(context)
                                ? _size.width
                                : _size.width * 0.5,
                            child: CardMenuTypes.buildCardCadastroBandeiras()),
                        Container(
                            width: Responsive.isMobile(context)
                                ? _size.width
                                : _size.width * 0.5,
                            child: CardMenuTypes.buildCardCadastroUsuario())
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: Responsive.isMobile(context)
                                ? _size.width
                                : _size.width * 0.5,
                            child: CardMenuTypes.buildCardControleEstoque()),
                        Container(
                            width: Responsive.isMobile(context)
                                ? _size.width
                                : _size.width * 0.5,
                            child: CardMenuTypes.buildCardPedidosFaturados()),
                        Container(
                            width: Responsive.isMobile(context)
                                ? _size.width
                                : _size.width * 0.5,
                            child: CardMenuTypes.buildCardTamanhos())
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      onWillPop: () {
        Get.offAllNamed('/menu');
      },
    );
  }
}
