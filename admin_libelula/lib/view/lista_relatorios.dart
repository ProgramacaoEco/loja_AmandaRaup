import 'package:admin_newpedido/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Relatorios extends StatelessWidget {
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double textScale = MediaQuery.of(context).textScaleFactor;

    var appbar = AppBar(
          title: Text('Relatórios', style: TextStyle(color: Color(0xFF6c5b54))),
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
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.black45,
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ]),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Container(
                  width: Responsive.isMobile(context)
                      ? size.width / 2
                      : size.width / 6,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Pedidos faturados", textScaleFactor: textScale,),
                    style:
                        ElevatedButton.styleFrom(primary: Colors.yellow[600]),
                  ),
                ),
              ),
              Container(
                width: Responsive.isMobile(context) ? size.width / 2 : size.width / 6,
                child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Pedidos cancelados", textScaleFactor: textScale,),
                    style: ElevatedButton.styleFrom(primary: Colors.red)),
              )
            ],
          ))),
    );
  }
}
