import 'package:admin_newpedido/controller/pedidos_controller.dart';
import 'package:admin_newpedido/model/cardMenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardMenuTypes extends StatelessWidget {
  ControllerPedidos cp = ControllerPedidos();

  static CardMenu buildCardRelatorios() {
    return CardMenu(
      color: Colors.cyan,
      text: "Relatórios",
      textColor: Colors.white,
      iconColor: Colors.white,
      icon: Icons.bar_chart,
      onTap: () => Get.toNamed('/menu/relatorios'),
    );
  }

  static CardMenu buildCardTamanhos() {
    return CardMenu(
      color: Colors.cyan,
      text: "Tamanhos",
      textColor: Colors.white,
      iconColor: Colors.white,
      icon: Icons.bar_chart,
      onTap: () => Get.toNamed('/menu/tamanhos'),
    );
  }

  static CardMenu buildCardPedidosFaturados() {
    return CardMenu(
      //icon: Icons.location_on,
      color: Colors.pink,
      text: "Pedidos faturados",
      textColor: Colors.white,
      iconColor: Colors.white,
      icon: Icons.monetization_on_outlined,
      onTap: () => Get.toNamed("/menu/pedidosFaturados"),
    );
  }

  static CardMenu buildCardControleEstoque() {
    return CardMenu(
      icon: Icons.storage,
      color: Colors.indigo,
      text: "Controle de estoque",
      textColor: Colors.white,
      iconColor: Colors.white,
      onTap: () => Get.toNamed("/menu/controleEstoque"),
    );
  }

  static CardMenu buildCardCadastroUsuario() {
    return CardMenu(
      icon: Icons.person_add,
      color: Colors.purple,
      text: "Cadastro de usuários",
      textColor: Colors.white,
      iconColor: Colors.white,
      onTap: () => Get.toNamed("/menu/cadastroUsuarios"),
    );
  }

  static CardMenu buildCardCadastroBandeiras() {
    return CardMenu(
      icon: Icons.credit_card,
      color: Colors.blue,
      text: "Limite parcelamento cartão",
      textColor: Colors.white,
      iconColor: Colors.white,
      onTap: () => Get.toNamed("/menu/cadastroFormaPagamento"),
    );
  }

  static CardMenu buildCardCadastroCategoria() {
    return CardMenu(
      icon: Icons.category,
      color: Colors.orange,
      text: "Cadastro de categorias",
      textColor: Colors.white,
      iconColor: Colors.white,
      onTap: () => Get.toNamed("/menu/cadastroCategorias"),
    );
  }

  static CardMenu buildCardImagemCampanha() {
    return CardMenu(
        icon: Icons.announcement,
        color: Colors.green[900],
        text: "Imagens de campanha",
        textColor: Colors.white,
        iconColor: Colors.white,
        onTap: () => Get.toNamed("/menu/cadastroCampanhas"));
  }

  static CardMenu buildCardCadastroProdutos() {
    return CardMenu(
        icon: Icons.shopping_basket,
        color: Colors.deepOrange,
        text: "Cadastro de produtos",
        textColor: Colors.white,
        iconColor: Colors.white,
        onTap:
          () => Get.toNamed("/menu/cadastroProdutos"),
);
  }

   CardMenu buildCardPedidos() {
    return CardMenu(
      color: Colors.red,
      icon: Icons.article,
      text: "Pedidos",
      textColor: Colors.white,
      iconColor: Colors.white,
      onTap: () { 
        cp.obterPedidos();
        Get.toNamed("/menu/pedidos");
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    Container();
  }
}
