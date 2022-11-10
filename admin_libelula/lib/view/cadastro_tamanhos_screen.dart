import 'package:admin_newpedido/model/tamanho_list.dart';
import 'package:admin_newpedido/model/tipo_tamanho_list.dart';
import 'package:admin_newpedido/view/widgets/lista_tamanhos_view.dart';
import 'package:admin_newpedido/view/widgets/lista_tipo_tamanhos_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CadastroTamanhosScreen extends StatefulWidget {
  const CadastroTamanhosScreen({Key key}) : super(key: key);

  @override
  State<CadastroTamanhosScreen> createState() => _CadastroTamanhosScreenState();
}

class _CadastroTamanhosScreenState extends State<CadastroTamanhosScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<TipoTamanhoList>(context, listen: false).index().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
              title: Text('gerenciar tamanhos', style: TextStyle(color: Color(0xFF6c5b54))),
        elevation: 0,
        backgroundColor: Color(0xFFe2ddda),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Color(0xFF6c5b54))),
        ),
        body: CustomScrollView(scrollDirection: Axis.vertical, slivers: [
          SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                  child: Stack(children: [
                Container(
                  margin: GetPlatform.isAndroid
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
                      )
                    ],
                  ),
                  child: Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: size.height * 0.9,
                                width: size.width * 0.6,
                                child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: _isLoading
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : const ListaTipoTamanhosView()),
                              ),
                            ]),
                      ),
                    ),
                  ),
                )
              ])))
        ]));
  }
}
