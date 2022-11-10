import 'dart:js';

import 'package:admin_newpedido/controller/login_controller.dart';
import 'package:admin_newpedido/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class CustomAppbar extends StatelessWidget {

   CustomAppbar({ key }) : super(key: key);
    final auth = Get.find<LoginController>();


   @override
  AppBar buildAppBar(Size _size, BuildContext context) {
    double textScale = MediaQuery.of(context).textScaleFactor;
    return AppBar(
      automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFe2ddda),
              ],
            ),
          ),
        ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 15, top: 10, bottom: 10),
          width: Responsive.isMobile(context)
              ? _size.width * 0.2
              : _size.width / 10, // Padrao / 10
          height: MediaQuery.of(context).size.height,
          child: ElevatedButton(
            onPressed: () {
              auth.deslogar();
            },
            child: Text(
              "Sair",
              textScaleFactor: textScale,
            ),
            style: ElevatedButton.styleFrom(primary: Color(0xFFe2ddda),),
          ),
        ),
      ],
      title: Center(
        child: Text("Lise Modas"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}