import 'package:admin_newpedido/model/tamanho.dart';
import 'package:admin_newpedido/model/tamanho_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TamanhoItem extends StatefulWidget {
  final Tamanho tamanho;

  const TamanhoItem(
    this.tamanho, {
    Key key,
  }) : super(key: key);

  @override
  State<TamanhoItem> createState() => _TamanhoItemState();
}

class _TamanhoItemState extends State<TamanhoItem> {
  final formKey = GlobalKey<FormState>();
  TextEditingController txt = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TamanhoList>(context);
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 51),
            child: Text(widget.tamanho.tamanho,
                style: GoogleFonts.actor(
                    fontSize: 24, fontWeight: FontWeight.w700)),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              width: size.width * 0.118,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 75,
                        child: Form(
                          key: formKey,
                          child: TextFormField(
                            controller: txt,
                            decoration: InputDecoration(labelText: 'Tam.'),
                            validator: (_text) {
                              final text = _text ?? '';

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
                              icon: Icon(Icons.edit, color: Colors.brown),
                              onPressed: () {
                                final isValid =
                                    formKey.currentState?.validate() ?? false;

                                if (!isValid) {
                                  return;
                                }

                                setState(() {
                                  loading = true;
                                });
                                provider
                                    .put(
                                        widget.tamanho.id,
                                        widget.tamanho.idTipoTamanho,
                                        txt.text.toString())
                                    .then((value) => setState(() {
                                          loading = false;
                                          txt = null;
                                        }));
                              }),
                    ],
                  ),
                  Container(
                    width: 35,
                    height: 35,
                    child: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red[800],
                        ),
                      onPressed: () => provider
                          .delete(widget.tamanho.id, widget.tamanho.idTipoTamanho)
                          .then((value) => null),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
