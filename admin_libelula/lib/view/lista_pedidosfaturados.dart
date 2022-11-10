import 'package:admin_newpedido/controller/pedidosfaturados_controller.dart';
import 'package:admin_newpedido/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PedidosFaturados extends StatelessWidget {
  ScrollController _controller = ScrollController();
  final controllerPedidosFaturados = Get.put(ControllerPedidosFaturados());

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double textScale = MediaQuery.of(context).textScaleFactor;

    controllerPedidosFaturados.obterPedidosFaturados('faturado');
    var appbar = AppBar(
    title: Text('Pedidos faturados', style: TextStyle(color: Color(0xFF6c5b54))),
      elevation: 0,
      backgroundColor: Color(0xFFe2ddda),
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Color(0xFF6c5b54))),
    );

    return Scaffold(
      appBar: appbar,
      body: Container(
        margin: Responsive.isMobile(context)
            ? EdgeInsets.all(0)
            : EdgeInsets.all(40),
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
        child: FutureBuilder(
          future: controllerPedidosFaturados.obterPedidosFaturados('faturado'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              );
            } else {
              return Container(
                width: size.width,
                height: size.height,
                child: Column(
                  children: [
                    Container(
                      child: Table(
                        columnWidths: {
                          0: FixedColumnWidth(
                            (Responsive.isMobile(context)
                                ? size.width * 0.25
                                : size.width * 0.22),
                          ),
                          1: FixedColumnWidth(
                            (Responsive.isMobile(context)
                                ? size.width * 0.2
                                : size.width * 0.15),
                          ),
                          2: FixedColumnWidth(
                            (Responsive.isMobile(context)
                                ? size.width * 0.26
                                : size.width * 0.2),
                          ),
                          3: FixedColumnWidth(
                            (Responsive.isMobile(context)
                                ? size.width * 0.26
                                : size.width * 0.22),
                          ),
                        },
                        children: [
                          TableRow(
                            children: [
                              Container(
                                padding: EdgeInsets.all(18),
                                child: Text(
                                  Responsive.isMobile(context)
                                      ? 'Pedido'
                                      : "Nº do Pedido",
                                  textScaleFactor: textScale,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'HelveticaNeue',
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  "Data",
                                  textScaleFactor: textScale,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'HelveticaNeue',
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  Responsive.isMobile(context)
                                      ? 'Cliente'
                                      : "Nome do Cliente",
                                  textScaleFactor: textScale,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'HelveticaNeue',
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  Responsive.isMobile(context)
                                      ? 'Tel'
                                      : "Telefone",
                                  textScaleFactor: textScale,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'HelveticaNeue',
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  '',
                                  textScaleFactor: textScale,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'HelveticaNeue',
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: Responsive.isMobile(context)
                          ? size.height / 1.2
                          : size.height / 1.5,
                      width: size.width,
                      child: Scrollbar(
                        controller: _controller,
                        child: SingleChildScrollView(
                          controller: _controller,
                          scrollDirection: Axis.vertical,
                          child: Table(
                            columnWidths: {
                              0: FixedColumnWidth(
                                (Responsive.isMobile(context)
                                    ? size.width * 0.06
                                    : size.width * 0.0),
                              ),
                              1: FixedColumnWidth(
                                (Responsive.isMobile(context)
                                    ? size.width * 0.18
                                    : size.width * 0.0),
                              ),
                              2: FixedColumnWidth(
                                (Responsive.isMobile(context)
                                    ? size.width * 0.15
                                    : size.width * 0.0),
                              ),
                              3: FixedColumnWidth(
                                (size.width * 0.0),
                              ),
                              4: FixedColumnWidth(
                                (size.width * 0.0),
                              ),
                            },
                            children: List<TableRow>.generate(
                              controllerPedidosFaturados.faturados.length,
                              (index) {
                                return TableRow(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 0.5, color: Colors.grey))),
                                  children: [
                                    Container(
                                      padding: Responsive.isMobile(context)
                                          ? EdgeInsets.all(5)
                                          : EdgeInsets.all(18),
                                      child: Text(
                                        controllerPedidosFaturados
                                            .faturados[index]['id_pedido']
                                            .toString(),
                                        textScaleFactor: textScale,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Raleway',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: Responsive.isMobile(context)
                                          ? EdgeInsets.all(5)
                                          : EdgeInsets.all(18),
                                      child: Text(
                                        controllerPedidosFaturados
                                            .faturados[index]['data_pedido'],
                                        textScaleFactor: textScale,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontFamily: 'HelveticaNeue',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: Responsive.isMobile(context)
                                          ? EdgeInsets.all(5)
                                          : EdgeInsets.all(18),
                                      child: Text(
                                        controllerPedidosFaturados
                                            .faturados[index]['nome_cliente'],
                                        textScaleFactor: textScale,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Raleway',
                                        ),
                                      ),
                                    ),
                                    Container(
                                        child: Responsive.isDesktop(context) ||
                                                Responsive.isTablet(context)
                                            ? Container(
                                                padding:
                                                    Responsive.isMobile(context)
                                                        ? EdgeInsets.all(5)
                                                        : EdgeInsets.all(18),
                                                child: Text(
                                                  controllerPedidosFaturados
                                                          .faturados[index]
                                                      ['telefone'],
                                                  textScaleFactor: textScale,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Raleway',
                                                  ),
                                                ),
                                              )
                                            : IconButton(
                                                onPressed: () {
                                                  Get.defaultDialog(
                                                    title: 'Telefone',
                                                    content: TextButton(
                                                      onPressed: () {
                                                        Clipboard.setData(
                                                            ClipboardData(
                                                                text:
                                                                    "${controllerPedidosFaturados.faturados[index]['telefone']}"));
                                                        Get.snackbar('',
                                                            'Telefone copiado');
                                                      },
                                                      child: Text(
                                                        controllerPedidosFaturados
                                                                .faturados[
                                                            index]['telefone'],
                                                        textScaleFactor:
                                                            textScale,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'Raleway',
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                icon: Icon(Icons.phone))),
                                    Responsive(
                                      mobile: Container(),
                                      desktop:
                                          buildCardReimprimir(context, index),
                                      tablet:
                                          buildCardReimprimir(context, index),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        isAlwaysShown: true,
                        hoverThickness: 10.0,
                        thickness: 10.0,
                        showTrackOnHover: true,
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
   
   

  Container buildCardReimprimir(BuildContext context, int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      padding: EdgeInsets.all(18),
      child: ElevatedButton(
        onPressed: () => controllerPedidosFaturados.reimprimir(
            controllerPedidosFaturados.faturados[index]['id_pedido']),
        child: Text("Reimprimir"),
        style: ElevatedButton.styleFrom(
          primary: Color(0xfff58731),
        ),
      ),
    );
  }
}
