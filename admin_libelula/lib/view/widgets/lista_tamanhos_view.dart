import 'package:admin_newpedido/model/decoration_textfield.dart';
import 'package:admin_newpedido/model/tamanho.dart';
import 'package:admin_newpedido/model/tamanho_list.dart';
import 'package:admin_newpedido/view/widgets/tamanho_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaTamanhosView extends StatefulWidget {
  ListaTamanhosView({Key key}) : super(key: key);

  @override
  State<ListaTamanhosView> createState() => _ListaTamanhosViewState();
}

class _ListaTamanhosViewState extends State<ListaTamanhosView> {
  TextEditingController _tamanho = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<TamanhoList>(context);
    final List<Tamanho> tamanhosCarregados = provider.items;
    var idTipo; 

    for(var i = 0; i < 1; i++) {
      idTipo = provider.items[i].idTipoTamanho;
    }

    return 
    loading ? 
    Center(child: CircularProgressIndicator(),)
    : Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade300, borderRadius: BorderRadius.circular(25)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 8, right: 8, top: 10),
            child: SizedBox(
              height: size.height * 0.15,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width * 0.4,
                      child: Form(
                        key: formKey,
                        child: TextFormField(
                          controller: _tamanho,
                          decoration: InputDecoration(
                            labelText: 'Inserir Tamanho',
                            labelStyle: TextStyle(fontSize: 24),
                          ),
                          validator: (_txt) {
                            final text = _txt ?? '';

                            if (text.trim().isEmpty) {
                              return 'Insira um tamanho!';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    loading
                    ? CircularProgressIndicator()
                    : IconButton(
                      icon: Icon(Icons.add),
                      iconSize: 28,
                      onPressed: () {
                        final isValid = 
                          formKey.currentState?.validate() ?? false; 

                          if (!isValid) { 
                            return;
                          }

                          setState(() {
                            loading = true;
                          });

                          provider.store(idTipo, _tamanho.text).then((value) => setState((){
                            loading = false;
                          }));
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: Text('Tamanho'),
                ),
                Container(
                  width: size.width * 0.1,
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Editar'),
                      Text('Excluir'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: provider.itemsCount,
                  itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                      value: provider.items[i],
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 50),
                        height: size.height * 0.12,
                        child: TamanhoItem(
                          provider.items[i],
                        ),
                      ))),
            ),
          ),
        ],
      ),
    );
  }
}
