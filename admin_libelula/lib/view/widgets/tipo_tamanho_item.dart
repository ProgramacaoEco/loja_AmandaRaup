import 'package:admin_newpedido/model/tamanho.dart';
import 'package:admin_newpedido/model/tamanho_list.dart';
import 'package:admin_newpedido/model/tipo_tamanho.dart';
import 'package:admin_newpedido/view/widgets/lista_tamanhos_view.dart';
import 'package:admin_newpedido/view/widgets/tamanho_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class TipoTamanhoItem extends StatefulWidget {
  final TipoTamanho tipoTamanho;

  const TipoTamanhoItem(
    this.tipoTamanho, {
    Key key,
  }) : super(key: key);

  @override
  State<TipoTamanhoItem> createState() => _TipoTamanhoItemState();
}

class _TipoTamanhoItemState extends State<TipoTamanhoItem> {


  @override
  Widget build(BuildContext context) {


    return 
    GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  widget.tipoTamanho.tipo,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Icon(Icons.arrow_drop_down_sharp),
              ),
            ],
          ),
        ),
        //  InkWell(
        //   highlightColor: Colors.transparent,
        //   splashColor: Colors.transparent,
        //   onTap: () {
        //     setState(() {
        //       isTapped = !isTapped;
        //     });
        //   },
        //   onHighlightChanged: (value) {
        //     setState(() {
        //       isExpanded = value;
        //     });
        //   },
        //   child: AnimatedContainer(
        //     duration: Duration(seconds: 1),
        //     curve: Curves.fastLinearToSlowEaseIn,
        //     height: isTapped
        //         ? isExpanded
        //             ? 65
        //             : 70
        //         : isExpanded
        //             ? sizeLength()
        //             : sizeLength(),
        //     width: isExpanded ? 385 : 390,
        //     decoration: BoxDecoration(
        //       color: Color(0xff6F12E8),
        //       borderRadius: BorderRadius.all(Radius.circular(20)),
        //       boxShadow: [
        //         BoxShadow(
        //           color: Color(0xff6F12E8).withOpacity(0.5),
        //           blurRadius: 20,
        //           offset: Offset(0, 10),
        //         ),
        //       ],
        //     ),
        //     padding: EdgeInsets.all(20),
        //     child: isTapped
        //         ? Column(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             children: [
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Text(
        //                     '${widget.tipoTamanho.tipo}',
        //                     style: TextStyle(
        //                         color: Colors.white,
        //                         fontSize: 22,
        //                         fontWeight: FontWeight.w400),
        //                   ),
        //                   Icon(
        //                     isTapped
        //                         ? Icons.keyboard_arrow_down
        //                         : Icons.keyboard_arrow_up,
        //                     color: Colors.white,
        //                     size: 27,
        //                   ),
        //                 ],
        //               ),
        //             ],
        //           )
        //         : Column(
        //             children: [
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Text(
        //                     '${widget.tipoTamanho.tipo}',
        //                     style: TextStyle(
        //                         color: Colors.white,
        //                         fontSize: 22,
        //                         fontWeight: FontWeight.w400),
        //                   ),
        //                   Icon(
        //                     isTapped
        //                         ? Icons.keyboard_arrow_down
        //                         : Icons.keyboard_arrow_up,
        //                     color: Colors.white,
        //                     size: 27,
        //                   ),
        //                 ],
        //               ),
        //               SizedBox(
        //                 height: 20,
        //               ),
        //               Container(
        //                   child: isTapped
        //                       ? ListView.builder(
        //                           scrollDirection: Axis.vertical,
        //                           itemCount: tamanhosCarregados.length,
        //                           itemBuilder: (ctx, i) =>
        //                               ChangeNotifierProvider.value(
        //                                   value: tamanhosCarregados[i],
        //                                   child: Container(
        //                                     margin: const EdgeInsets.symmetric(
        //                                         vertical: 15, horizontal: 50),
        //                                     height: size.height * 0.005,
        //                                     child: TamanhoItem(
        //                                       tamanhosCarregados[i],
        //                                     ),
        //                                   )))
        //                       : Container()),
        //             ],
        //           ),
        //   ),
        //),
        onTap: () {
          Provider.of<TamanhoList>(context, listen: false)
              .index(widget.tipoTamanho.id)
              .then((value) {
            Get.toNamed('/menu/listaTamanhos');
          });
        }
        );
  }
}
