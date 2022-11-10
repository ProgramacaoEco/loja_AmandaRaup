import 'package:admin_newpedido/controller/pedidos_controller.dart';
import 'package:admin_newpedido/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Pedido extends StatelessWidget {
  ScrollController _controller = ScrollController();
  final controllerPedidos = Get.find<ControllerPedidos>();

  var numeroPedido;
  var dataPedido;
  var nomeCliente;
  var cpf;
  var telefone;
  var logradouro;
  var cep;
  var complemento;
  var uf;
  var bairro;
  var cidade;
  var status;
  var produtos;
  var quantidades;
  var valores;
  var codigoBarras;
  var tamanhos;
  var somaTotal;
  var formaPagamento;
  var numeroVezes;

  var recebido;

  Pedido(
      {this.numeroPedido,
      this.dataPedido,
      this.nomeCliente,
      this.cpf,
      this.telefone,
      this.uf,
      this.complemento,
      this.cep,
      this.logradouro,
      this.bairro,
      this.cidade,
      this.status,
      this.produtos,
      this.tamanhos,
      this.quantidades,
      this.valores,
      this.codigoBarras,
      this.somaTotal,
      this.formaPagamento,
      this.numeroVezes});

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width / 2.5,
      height: size.height / 1.3,
      child: Card(
        elevation: 10,
        child: Container(
          height: size.height,
          margin: EdgeInsets.all(7),
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          "Nº Pedido: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Get.height < 800 ? 10 : 12),
                        ),
                        Text(
                          this.numeroPedido.toString(),
                          style:
                              TextStyle(fontSize: Get.height < 800 ? 10 : 12),
                        )
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          "Status pedido: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Get.height < 800 ? 10 : 12),
                        ),
                        Text(this.status,
                            style:
                                TextStyle(fontSize: Get.height < 800 ? 10 : 12))
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text("Data: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Get.height < 800 ? 10 : 12)),
                        Text(this.dataPedido,
                            style:
                                TextStyle(fontSize: Get.height < 800 ? 10 : 12))
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text("Cliente: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Get.height < 800 ? 10 : 12)),
                        Text(this.nomeCliente,
                            style:
                                TextStyle(fontSize: Get.height < 800 ? 10 : 12))
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text("CPF/CNPJ: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Get.height < 800 ? 10 : 12)),
                        Text(this.cpf,
                            style:
                                TextStyle(fontSize: Get.height < 800 ? 10 : 12))
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text("Telefone: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Get.height < 800 ? 10 : 12)),
                        Text(this.telefone,
                            style:
                                TextStyle(fontSize: Get.height < 800 ? 10 : 12))
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text("Entrega: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Get.height < 800 ? 10 : 12)),
                        this.bairro == 'retirada'
                            ? Text("Retirada na loja",
                                style: TextStyle(
                                    fontSize: Get.height < 800 ? 10 : 12))
                            : Text(
                                "$uf - $cidade - $cep  - $bairro - $logradouro - $complemento",
                                style: TextStyle(
                                    fontSize: Get.height < 800
                                        ? 10
                                        : 12)) //*${this.cidade}*//")
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text("Pagamento: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Get.height < 800 ? 10 : 12)),
                        Text("${this.formaPagamento} - ${this.numeroVezes}",
                            style:
                                TextStyle(fontSize: Get.height < 800 ? 10 : 12))
                      ],
                    ),
                  )
                ],
              ),
              Divider(),
              //SizedBox(height: size.height / 55),
              Column(
                children: [
                  Container(
                    width: size.width / 1,
                    height: size.height / 2.8,
                    child: Card(
                      elevation: 10,
                      child: Container(
                        width: Responsive.isMobile(context)
                            ? size.width / 1
                            : size.width / 3,
                        height: Responsive.isMobile(context)
                            ? size.height / 2
                            : size.height / 2.4,
                        child: Column(
                          children: [
                            Container(
                              child: Table(
                                columnWidths: {
                                  0: FixedColumnWidth(
                                      (Responsive.isMobile(context)
                                          ? size.width / 1.95
                                          : size.width / 6)),
                                  1: FixedColumnWidth(
                                      (Responsive.isMobile(context)
                                          ? size.width / 0.001
                                          : size.width / 14.5)),
                                  2: FixedColumnWidth(
                                      (Responsive.isMobile(context)
                                          ? size.width / 0.001
                                          : size.width / 14.5)),
                                },
                                children: [
                                  Responsive.isTablet(context) ||
                                          Responsive.isDesktop(context)
                                      ? TableRow(children: [
                                          buildContainerProdTable(),
                                          buildContainerQtdTable(),
                                          buildContainerValorTable(),
                                          buildContainerCodTable(),
                                        ])
                                      : TableRow(
                                          children: [
                                            buildContainerProdTable(),
                                            Container(
                                              padding: EdgeInsets.all(18),
                                              child: Text(
                                                "Dados",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'HelveticaNeue',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                            Container(
                              height: size.height / 4.4,
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
                                              ? size.width / 2.2
                                              : size.width / 6.3)),
                                      1: FixedColumnWidth(
                                          (Responsive.isMobile(context)
                                              ? size.width / 4.5
                                              : size.width / 15)),
                                      2: FixedColumnWidth(
                                          (Responsive.isMobile(context)
                                              ? size.width / 4.3
                                              : size.width / 11.5)),
                                    },
                                    children: Responsive.isDesktop(context) ||
                                            Responsive.isTablet(context)
                                        ? List<TableRow>.generate(
                                            produtos.length, (index) {
                                            return TableRow(
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            width: 0.5,
                                                            color:
                                                                Colors.grey))),
                                                children: [
                                                  buildContainerDataProduto(
                                                      index),
                                                  buildContainerDataQnt(index),
                                                  buildContainerDataValores(
                                                      index),
                                                  buildContainerDataCodigoBarras(
                                                      index)
                                                ]);
                                          })
                                        : List<TableRow>.generate(
                                            produtos.length,
                                            (index) {
                                              return TableRow(
                                                children: [
                                                  buildContainerDataProduto(
                                                      index),
                                                  IconButton(
                                                    onPressed: () {
                                                      Get.defaultDialog(
                                                        title: 'Detalhes',
                                                        content: TextButton(
                                                          onPressed: () {
                                                            Clipboard.setData(
                                                              ClipboardData(
                                                                  text: 'Codigo: ${this.codigoBarras[index]}\n' +
                                                                      'Produto: ${this.produtos[index]}\n' +
                                                                      'Tamanho: ${this.tamanhos[index]}\n' +
                                                                      'Quantidade: ${this.quantidades[index]}\n' +
                                                                      'Valor Total: ${this.valores[index].replaceAll(".", ",")}\n' +
                                                                      'Codigo: ${this.codigoBarras[index]}'),
                                                            );
                                                            Get.snackbar('',
                                                                'Pedido copiado');
                                                          },
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                      'Cod: ${this.codigoBarras[index]}\n'
                                                                      'Produto: ${this.produtos[index]}\n'
                                                                      'Tamanho: ${this.tamanhos[index]}\n'
                                                                      'Qtd: ${this.quantidades[index]}\n'
                                                                      "Total: R\$${this.valores[index].replaceAll(".", ",")}\n",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start),
                                                                  Text(
                                                                    'Clique no texto para copiar',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: Colors
                                                                            .grey),
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    icon: Icon(Icons.receipt),
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: Get.height < 800 ? 15 : 8),
                child: Text(
                    "Valor total do pedido: R\$${this.somaTotal.replaceAll(".", ",")}"),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: Get.height < 800 ? 15 : 8),
                  child: Get.height < 800
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                buildButtonFaturarFaturado(size, context),
                                SizedBox(width: size.width / 100),
                                buildButtonImprimir(size),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                width: Get.height < 800 ? size.width / 8 : size.width / 4,
                                ), 
                                SizedBox(width: size.width / 100),
                                buildButtonCancelar(size, context),
                              ],
                            )
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            buildVButtonReceberRecebido(size, context),
                            SizedBox(height: 10),
                            buildButtonImprimir(size),
                            SizedBox(height: 10),
                            buildButtonFaturarFaturado(size, context),
                            SizedBox(height: 10),
                            buildButtonCancelar(size, context),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildButtonCancelar(Size size, BuildContext context) {
    return Container(
      width: Get.height < 800 ? size.width / 8 : size.width / 4,
      child: ElevatedButton(
        onPressed: this.status == 'faturado'
            ? null
            : () {
                controllerPedidos.cancelar(context, this.numeroPedido);
                // Get.offAllNamed('/menu');
                // Get.toNamed('/menu/pedidos');
              },
        child: Text("Cancelar",
            style: TextStyle(fontSize: Get.height < 800 ? 10 : 12)),
        style: ElevatedButton.styleFrom(primary: Colors.red),
      ),
    );
  }

  Padding buildButtonFaturarFaturado(Size size, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Container(
          width: Get.height < 800 ? size.width / 8 : size.width / 4,
          child: ElevatedButton(
              onPressed: this.status == 'pendente' || this.status == 'faturado'
                  ? null
                  : () {
                      controllerPedidos.faturar(context, this.numeroPedido);
                      // Get.offAllNamed('/menu');
                      // Get.toNamed('/menu/pedidos');
                    },
              child: this.status == 'faturado'
                  ? Text("Faturado",
                      style: TextStyle(fontSize: Get.height < 800 ? 10 : 12))
                  : Text("Faturar",
                      style: TextStyle(fontSize: Get.height < 800 ? 10 : 12)),
              style: ElevatedButton.styleFrom(primary: Colors.yellow[600]))),
    );
  }

  Padding buildButtonImprimir(Size size) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        width: Get.height < 800 ? size.width / 8 : size.width / 4,
        child: ElevatedButton(
          onPressed: () => controllerPedidos.imprimir(
              this.produtos,
              this.quantidades,
              this.codigoBarras,
              this.valores,
              this.tamanhos,
              this.numeroPedido,
              this.status,
              this.dataPedido,
              this.nomeCliente,
              this.cpf,
              this.telefone,
              this.uf,
              this.bairro,
              this.cidade,
              this.logradouro,
              this.complemento,
              this.cep,
              this.formaPagamento,
              this.numeroVezes,
              this.somaTotal
              ),
          child: Text("Imprimir",
              style: TextStyle(fontSize: Get.height < 800 ? 10 : 12)),
          style: ElevatedButton.styleFrom(
            primary: Color(0xfff58731),
          ),
        ),
      ),
    );
  }

  Padding buildVButtonReceberRecebido(Size size, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
          width: Get.height < 800 ? size.width / 8 : size.width / 4,
          child: ElevatedButton(
              onPressed: this.status == 'recebido'
                  ? null
                  : () {
                      controllerPedidos.receber(context, this.numeroPedido);
                    },
              child: this.status == 'recebido'
                  ? Text("Recebido",
                      style: TextStyle(fontSize: Get.height < 800 ? 10 : 12))
                  : Text("Receber",
                      style: TextStyle(fontSize: Get.height < 800 ? 10 : 12)),
              style: ElevatedButton.styleFrom(primary: Color(0xff38377b)))),
    );
  }

  Container buildContainerDataCodigoBarras(int index) {
    var codBar = this.codigoBarras[index];

    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 10, top: 10),
      child: Text(
        '${codBar}',
        style: TextStyle(
          fontSize: Get.height < 800 ? 10 : 12,
          color: Colors.black,
          fontFamily: 'Raleway',
        ),
      ),
    );
  }

  Container buildContainerDataValores(int index) {
    var valor = this.valores[index];

    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 18, top: 10),
      child: Text(
        "R\$${valor.replaceAll(".", ",")}",
        style: TextStyle(
          fontSize: Get.height < 800 ? 10 : 12,
          color: Colors.black,
          fontFamily: 'Raleway',
        ),
      ),
    );
  }

  Container buildContainerDataQnt(int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 30, top: 10),
      child: Text(
        this.quantidades[index],
        style: TextStyle(
          fontSize: Get.height < 800 ? 10 : 12,
          color: Colors.black,
          fontFamily: 'HelveticaNeue',
        ),
      ),
    );
  }

  Container buildContainerDataProduto(int index) {
    var prod = this.produtos[index];

    return Container(
      margin: EdgeInsets.only(left: 20, top: 10, bottom: 20),
      child: Text(
        " ${prod.toString()} \n ${this.tamanhos[index]}",
        style: TextStyle(
          fontSize: Get.height < 800 ? 10 : 13,
          color: Colors.black,
          fontFamily: 'Raleway',
        ),
      ),
    );
  }

  Container buildContainerCodTable() {
    return Container(
      padding: EdgeInsets.all(18),
      child: Text(
        "Cod",
        style: TextStyle(
          fontSize: Get.height < 800 ? 10 : 13,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: 'HelveticaNeue',
        ),
      ),
    );
  }

  Container buildContainerValorTable() {
    return Container(
      padding: EdgeInsets.all(18),
      child: Text(
        "Valor",
        style: TextStyle(
          fontSize: Get.height < 800 ? 10 : 13,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: 'HelveticaNeue',
        ),
      ),
    );
  }

  Container buildContainerQtdTable() {
    return Container(
      padding: EdgeInsets.all(18),
      child: Text(
        "Qtd",
        style: TextStyle(
          fontSize: Get.height < 800 ? 10 : 13,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: 'HelveticaNeue',
        ),
      ),
    );
  }

  Container buildContainerProdTable() {
    return Container(
      padding: EdgeInsets.all(18),
      child: Text(
        "Produto",
        style: TextStyle(
          fontSize: Get.height < 800 ? 10 : 13,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: 'HelveticaNeue',
        ),
      ),
    );
  }
}
