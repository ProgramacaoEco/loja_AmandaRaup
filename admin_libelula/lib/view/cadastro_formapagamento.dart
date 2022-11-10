import 'package:admin_newpedido/controller/formapagamento_controller.dart';
import 'package:admin_newpedido/view/widgets/creditCards_grid_view.dart';
import 'package:admin_newpedido/view/widgets/numero_parcelas_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class CadastroFormaPagamento extends StatelessWidget {
  var appbar = AppBar(
    title: Text('Formas de Pagamento', style: TextStyle(color: Color(0xFF6c5b54))),
    elevation: 0,
    backgroundColor: Color(0xFFe2ddda),
    leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.arrow_back, color: Color(0xFF6c5b54))),
  );

  final controller = Get.put(CadastroFormaPagamentoController());
  TextEditingController descricaoForma = TextEditingController();

  GlobalKey<FormFieldState<dynamic>> multiselectParcela;

  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: appbar,
        body: Container(
          margin: EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                                "Ative ou desative as parcelas disponíveis para compra")),
                        Obx(() => controller.listParcelas != null ||
                                controller.listParcelas != [] ||
                                controller.listParcelas.length != 0
                            ? Container(
                                height: Get.height * 0.4,
                                width: Get.width * 0.3,
                                child: ListView.builder(
                                  itemCount: controller.listParcelas.length,
                                  itemBuilder: (ctx, i) {
                                    return Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: NumeroParcelasCard(
                                        parcela: controller.listParcelas[i],
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Center(child: CircularProgressIndicator())),
                        Container(
                          width: Get.width * 0.30,
                          height: Get.height * 0.22,
                          margin: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                    'Bandeiras aceitas pela plataforma de pagamentos (fixo): '),
                              ),
                              CreditCardsGridView(),
                            ],
                          ),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.grey.shade100,
                                Colors.grey.shade200,
                                Colors.grey.shade300
                              ]),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () {
        controller.limparValores();
        Get.back();
      },
    );
  }
}
