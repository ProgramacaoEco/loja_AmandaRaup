// ignore_for_file: file_names
import 'package:loja_libelula/app/model/itens_pedido.dart';
import 'package:loja_libelula/utils/constants.dart';

import '../../database/database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardResumo extends StatelessWidget {
  final ItensPedido itensPedido;
  const CardResumo(this.itensPedido, {Key? key}) : super(key: key);

  fontes(BuildContext context) {
    if (MediaQuery.of(context).size.height >= 800) {
      return 16.0;
    } else {
      return 15.0;
    }
  }

  Widget carregarImagem(String produtoImagem) {
    if (produtoImagem == '') {
      return Image.asset('lib/images/noImage.png', fit: BoxFit.cover);
    } else {
      try {
        return Image.network(
            //rotaIMAGE
            '${Constants.API_BASIC_ROUTE}/storage/app/$produtoImagem',
            fit: BoxFit.cover);
      } catch (error) {
        return Image.asset('lib/images/noImage.png', fit: BoxFit.cover);
      }
    }
  }

  Widget build(BuildContext context) {
    // String preco = valorUnidade.toString();
    return Container(
      margin: EdgeInsets.only(top: 3),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height >= 650
          ? MediaQuery.of(context).size.height * 0.18
          : MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Card(
        child: Flex(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          direction: Axis.horizontal,
          children: [
            // Container(
            //   width: MediaQuery.of(context).size.width / 3.2,
            //   height: MediaQuery.of(context).size.height / 8,
            //   child: carregarImagem(itensPedido.imagem),
            // ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      itensPedido.descricaoProduto,
                      style: GoogleFonts.nanumGothic(
                        fontWeight: FontWeight.w700,
                        fontSize:
                            MediaQuery.of(context).size.height >= 800 ? 17 : 16,
                      ),
                    ),
                    width: MediaQuery.of(context).size.width * 0.75,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Row(children: [
                      Container(
                        child: Row(
                          children: [
                            Text(
                              "Quantidade: ",
                              style: GoogleFonts.nanumGothic(
                                fontSize: fontes(context),
                              ),
                            ),
                            Text(
                              itensPedido.quantidade.toString(),
                              style: GoogleFonts.nanumGothic(
                                fontSize: fontes(context),
                              ),
                            )
                          ],
                        ),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Row(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            child: Row(children: [
                              Text(
                                "Tamanho: ",
                                style: GoogleFonts.nanumGothic(
                                  fontSize: fontes(context),
                                ),
                              ),
                              Text(
                                itensPedido.tamanho,
                                style: GoogleFonts.nanumGothic(
                                  fontSize: fontes(context),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        child: Text(
                          'Valor unitário: ',
                          style: GoogleFonts.nanumGothic(
                              fontSize:
                                  MediaQuery.of(context).size.height >= 800
                                      ? 19
                                      : 18),
                        ),
                        // width: MediaQuery.of(context).size.width / 2,
                      ),
                      Container(
                        child: Text(
                          "R\$${itensPedido.valor.toString().replaceAll(".", ",")}",
                          style: GoogleFonts.nanumGothic(
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                              fontSize:
                                  MediaQuery.of(context).size.height >= 800
                                      ? 19
                                      : 17),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
