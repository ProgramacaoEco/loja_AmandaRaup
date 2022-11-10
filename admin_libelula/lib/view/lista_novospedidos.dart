import 'package:admin_newpedido/controller/pedidos_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Pedidos extends StatelessWidget {
  ScrollController _controller = ScrollController();
  final controller = Get.put(
    ControllerPedidos(),
  );

  var appbar = AppBar(
    
    title:  Text('Pedidos', style: TextStyle(color: Color(0xFF6c5b54))),
    elevation: 0,
    backgroundColor: Color(0xFFe2ddda),
    leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.arrow_back, color: Color(0xFF6c5b54))
      ),
  );

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appbar,
      body:
          //CustomScrollView(
          // scrollDirection: Axis.vertical,
          // slivers: [
          // SliverFillRemaining(
          //   hasScrollBody: true,
          //child:
          Container(
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
        child: Container(
          height: size.height * 0.85,
          width: size.width * 90,
          child: Scrollbar(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: FutureBuilder(
                future: Future.delayed(
                  Duration(seconds: 2),
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.connectionState == ConnectionState.none) {
                    return Center(
                      widthFactor: 32,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                    );
                  } else {
                    return Container(
                        margin: EdgeInsets.all(15),
                        child: Wrap(
                          children: controller.pedidos,
                          direction: Axis.horizontal,
                        ),
                    );
                  }
                },
              ),
              controller: _controller,
            ),
            controller: _controller,
            isAlwaysShown: true,
            //showTrackOnHover: true,
            hoverThickness: 20.0,
            thickness: 10.0,
          ),
        ),
      ),
      //  ),
      //  ],
      // ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
