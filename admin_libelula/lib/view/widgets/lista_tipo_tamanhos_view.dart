
import 'package:admin_newpedido/model/tipo_tamanho.dart';
import 'package:admin_newpedido/model/tipo_tamanho_list.dart';
import 'package:admin_newpedido/view/widgets/tipo_tamanho_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaTipoTamanhosView extends StatelessWidget {

  const ListaTipoTamanhosView( {Key key }) : super(key: key);

   @override
   Widget build(BuildContext context) {
      final size = MediaQuery.of(context).size;
      final provider = Provider.of<TipoTamanhoList>(context);
      final List<TipoTamanho> tipoTamanhosCarregados = provider.items;

      return Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300, 
          borderRadius: BorderRadius.circular(25)
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: tipoTamanhosCarregados.length,
                  itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                    value: tipoTamanhosCarregados[i],
                    child: Container(
                      //margin: const EdgeInsets.symmetric(vertical: 15),
                      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                      height: size.height * 0.12, 
                      child: TipoTamanhoItem(tipoTamanhosCarregados[i])
                    ), 
                    )
                  ),
              ),
            ),
          ],
        ), 
      );
  }
}