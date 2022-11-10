import 'dart:convert';
import 'dart:typed_data';
import 'package:admin_newpedido/data/constants.dart';
import 'package:admin_newpedido/view/menu.dart';
import 'package:get/get.dart' as x;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProdutosController extends x.GetxController {
  void onInit() {
    listarCategorias();
    listarTamanho();
    // listarTamanhoEscala();
    // listarTamanhoMedida();
    listarProdutos(" ");
    super.onInit();
  }

  var selectedImage1 = Uint8List(0).obs;
  var selectedImage2 = Uint8List(0).obs;
  var selectedImage3 = Uint8List(0).obs;

  var dpSelecaoCategoria = ''.obs;
  var dpSelecaoTamanho = [].obs;

  var dpSelecaoTamanhoEdit = [];

  var produtos = [].obs;

  var urlCadastroProduto =
      Uri.https("api.hom.lojaonline.eco.br", "/cadastrarProduto");
  var urlListarCategorias =
      Uri.https("api.hom.lojaonline.eco.br", "/public/api/listarCategorias");
  var urlListarTamanhoNumerico = Uri.https(
      'api.hom.lojaonline.eco.br', "/public/api/listarTamanhoNumerico");
  var urlListarTamanhoEscala = Uri.https(
      'api.hom.lojaonline.eco.br', "/public/api/listarTamanhoComposto");
  var urlListarTamanhoMedida =
      Uri.https('api.hom.lojaonline.eco.br', "/public/api/listarTamanhoMedida");

  var listaCategorias = <DropdownMenuItem>[].obs;
  var listaTamanho = <MultiSelectItem>[].obs;
  var listaTamanhoEscala = <MultiSelectItem>[].obs;
  var listaTamanhoMedida = <MultiSelectItem>[].obs;

  var _produtoDestaqueAtivo = Colors.green;
  var _produtoDestaqueInativo = Color(0);
  var isProdutoDestaque = false.obs;
  var produtoDestaqueColor = 0.obs;
  var produtoDestaque = 0;

  var isTamanhoPreenchido = true.obs;
  var isTamanhoEscalaPreenchido = true.obs;
  var isTamanhoMedidaPreenchido = true.obs;

  var idProdutoEdit;
  var codigoBarrasEdit;
  var descricaoProdutoEdit;
  var avistaEdit;
  var aprazoEdit;
  var parcelaEdit;

  var aprazoTeste;

  var produtoDestaqueEdit = 0;
  var _produtoDestaqueAtivoEdit = Colors.green;
  var _produtoDestaqueInativoEdit = Color(0);
  var isProdutoDestaqueEdit = false.obs;
  var produtoDestaqueColorEdit = 0.obs;

  List files = [];
  List files1 = [];
  List files2 = [];
  List files3 = [];

  void getImage1() async {
    final pickedFile1 =
        await ImagePickerWeb.getImage(outputType: ImageType.bytes);

    if (pickedFile1 != null) {
      selectedImage1.value = pickedFile1;
      files1.add(MultipartFile.fromBytes(selectedImage1.value,
          contentType: MediaType('image', 'jpg'), filename: '1.jpg'));
    } else {
      print("No image selected");
    }
  }

  void getImage2() async {
    final pickedFile2 =
        await ImagePickerWeb.getImage(outputType: ImageType.bytes);

    if (pickedFile2 != null) {
      selectedImage2.value = pickedFile2;
      files2.add(MultipartFile.fromBytes(selectedImage2.value,
          contentType: MediaType('image', 'jpg'), filename: '2.jpg'));
    } else {
      print("No image selected");
    }
  }

  void getImage3() async {
    final pickedFile3 =
        await ImagePickerWeb.getImage(outputType: ImageType.bytes);

    if (pickedFile3 != null) {
      selectedImage3.value = pickedFile3;
      files3.add(MultipartFile.fromBytes(selectedImage3.value,
          contentType: MediaType('image', 'jpg'), filename: '3.jpg'));
    } else {
      print("No image selected");
    }
  }

  void limparImagens() {
    selectedImage1.value = null;
    selectedImage1.value = Uint8List(0);
    selectedImage2.value = null;
    selectedImage2.value = Uint8List(0);
    selectedImage3.value = null;
    selectedImage3.value = Uint8List(0);
    files.clear();
  }

  void salvar(
    var codigoBarras,
    var descricaoProduto,
    var avista,
    var aprazo,
    var parcela,
  ) async {
    var num = avista.replaceAll(".", "");
    var corte = num.replaceAll(",", ".");
    var valorAvista = double.parse(corte);
    // if (dpSelecaoTamanho.isEmpty) {
    //   x.Get.snackbar('', 'Preencha apenas um tamanho');
    // } else {
    x.Get.snackbar('', "Salvando...");
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var nVezes; 
    var numVezes;

    List tamanhos = ['P', 'PP'];
    List quantidade = ['1', '2'];
    List dados = [files1, files2, files3];

    await Dio() 
      .get("${Constants.BASE_URL}getVezes",
        options: Options(headers: {
                "token": token,
                "content-type": "application/json"
              })
       ).then((value) {
        if(value.statusCode == 200 || value.statusCode == 201) {
          var data = value.data; 
            for(var d in data) {
              if(d['isActivy'] == 1) {
                nVezes = d['numero_vezes'];
                numVezes = nVezes.split('x'); 

              }
            }
        }
       });
    var valueSplited = valorAvista/int.parse(numVezes[0]);
    
    var productData = jsonEncode({
      "codigoProduto": codigoBarras,
      "descricaoProduto": descricaoProduto,
      "nome_categoria": dpSelecaoCategoria.value,
      "valor": valorAvista,
      "destaque": produtoDestaque.toString(),
      "tamanhos": dpSelecaoTamanho,
      // "quantidade": quantidade,
      "descricao_pagamento":
          "Em até ${nVezes} de R\$${valueSplited.toStringAsFixed(2).replaceAll('.', ',')}"
    });

    var imageData = FormData.fromMap({"images": dados});

    try {
      await Dio()
          .post("${Constants.BASE_URL}cadastrarProduto",
              data: productData,
              options: Options(headers: {
                "token": token,
                "content-type": "application/json"
              }))
          .then((var response) async {
        if (response.statusCode == 201 || response.statusCode == 200) {
          print('dentro do if'); 
          var responseProduto = response.data; 
          print(responseProduto); 
          var id_produto = responseProduto['id_produto']; 
          print(id_produto); 

          await Dio()
              .post("${Constants.BASE_URL}cadastrarImagens/$id_produto",
                  data: imageData,
                  options: Options(headers: {
                    "token": token,
                    "content-type": "application/json"
                  }))
              .then((var response) async {
            if (response.statusCode == 201 || response.statusCode == 200) {
              limparValores();
              print('Imagem e produto cadastrado com sucesso'); 
            }

          });
          limparValores();

          x.Get.toNamed('/menu/cadastroProdutos');
          limparValores();
          x.Get.snackbar('', 'Produto cadastrado com sucesso');
        }
      });
    } catch (error) {
        if(error.toString().contains("422")){
          x.Get.snackbar('', 'por favor, informe uma categoria',
          backgroundColor: Colors.yellow[900], colorText: Colors.white);
        }
      else if (error.toString().contains("405")) {
        x.Get.snackbar('', 'Produto já cadastrado');
        limparValores();
        x.Get.toNamed('/menu/cadastroProdutos');
        limparValores();
      } else if (error.toString().contains("400")) {
        x.Get.snackbar('', 'Preencha os campos corretamente!',
            backgroundColor: Colors.orange, colorText: Colors.white);
      } else {
        x.Get.snackbar('', 'Ocorreu um erro',
            backgroundColor: Colors.red, colorText: Colors.white);
        limparValores();
      }
    }
    // }
  }

  listarCategorias() async {
    listaCategorias.clear();
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response = await Dio().get("${Constants.BASE_URL}listarCategorias",
        options: Options(headers: {"token": token}));
    var dados = response.data;

    for (var i = 0; i < dados.length; i++) {
      listaCategorias.add(DropdownMenuItem(
        child: Text(dados[i]["nome_categoria"]),
        value: dados[i]["nome_categoria"],
      ));
    }
  }

  listarTamanho() async {
    listaTamanho.clear();
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    await Dio()
        .get("${Constants.BASE_URL}listarTamanhos",
            options: Options(headers: {"token": token}))
        .then((response) {
      var dados = response.data;

      for (var i = 0; i < dados.length; i++) {
        listaTamanho
            .add(MultiSelectItem(dados[i]["tamanho"], dados[i]["tamanho"]));
      }
    });
  }

  listarProdutos(var descricaoProduto) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    await Dio().post("${Constants.BASE_URL}listarProdutosLike",
        options: Options(headers: {"token": token}),
        data: {"descricaoProduto": descricaoProduto}).then((response) {
      var dados = response.data;

      produtos.clear();

      for (var i = 0; i < dados.length; i++) {
        produtos.add(dados[i]);
      }
    });
  }

  inativarProdutos(var idProduto) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    await Dio().put("${Constants.BASE_URL}inativarProduto",
        options: Options(headers: {"token": token}),
        data: {'id_produto': idProduto}).then((response) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        x.Get.back();
        x.Get.snackbar('', 'Produto inativado com sucesso');
        produtos.removeWhere((element) => element['id_produto'] == idProduto);
      } else {
        x.Get.snackbar('', 'Ocorreu um erro');
      }
    });
  }

  editarProdutos(
    int index,
    var idProduto,
  ) async {
    if (dpSelecaoTamanho.isNotEmpty) {
      x.Get.snackbar('', 'Preencha apenas um tamanho');
    } else {
      if (codigoBarrasEdit == null) {
        codigoBarrasEdit = produtos[index]['codigoProduto'];
      }
      if (descricaoProdutoEdit == null) {
        descricaoProdutoEdit = produtos[index]['descricaoProduto'];
      }
      if (avistaEdit == null) {
        avistaEdit = produtos[index]['valor'];
      }
      if (parcelaEdit == null || aprazoEdit == null) {
        x.Get.snackbar('',
            'Por favor verifique se os campos de vezes e Até estão prenchidos:');
      }

      x.Get.snackbar('', "Salvando...");
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");

      try {
        await Dio()
            .post("${Constants.BASE_URL}editarProduto",
                data: {
                  "tamanho": dpSelecaoTamanhoEdit.isNotEmpty
                      ? dpSelecaoTamanhoEdit
                      : [],
                  "id_produto": idProduto,
                  "codigoProduto": codigoBarrasEdit,
                  "descricaoProduto": descricaoProdutoEdit,
                  "nome_categoria": dpSelecaoCategoria.value,
                  "valor": double.parse(avistaEdit),
                  "destaque": produtoDestaqueEdit.toString(),
                  "descricao_pagamento":
                      "Em até ${parcelaEdit}X de R\$${aprazoEdit} ou à vista com 10% de desconto",
                },
                options: Options(headers: {"token": token}))
            .then((var response) {
          if (response.statusCode == 201 || response.statusCode == 200) {
            x.Get.offNamedUntil('/menu', (menu) => false);
            x.Get.snackbar('', 'Produto editado com sucesso');
          }
        });
      } catch (error) {
        x.Get.snackbar('', 'Ocorreu um erro',
            backgroundColor: Colors.red, colorText: Colors.white);
        limparValores();
      }
    }
  }

  ativarProdutoDestaque() {
    isProdutoDestaque.value = !isProdutoDestaque.value;

    if (isProdutoDestaque.value) {
      produtoDestaqueColor.value = _produtoDestaqueAtivo.value;
      produtoDestaque = 1;
    } else {
      produtoDestaqueColor.value = _produtoDestaqueInativo.value;
      produtoDestaque = 0;
    }
  }

  ativarProdutoDestaqueEdit() {
    isProdutoDestaqueEdit.value = !isProdutoDestaqueEdit.value;
    if (isProdutoDestaqueEdit.value) {
      produtoDestaqueColorEdit.value = _produtoDestaqueAtivoEdit.value;
      produtoDestaqueEdit = 1;
    } else {
      produtoDestaqueColorEdit.value = _produtoDestaqueInativoEdit.value;
      produtoDestaqueEdit = 0;
    }
  }

  cadastrarNovoTamanho(var tamanho, var context) async {
    x.Get.snackbar('', "Salvando...");
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      await Dio().post("${Constants.BASE_URL}cadastrarTamanho",
          options: Options(headers: {"token": token}),
          data: {"tamanho": tamanho}).then((response) {
        listaTamanho.clear();
        listarTamanho();
        x.Get.back();
        x.Get.back();
        x.Get.snackbar('', 'Tamanho cadastrado com sucesso');
      });
    } catch (error) {
      if (error.toString().contains("401")) {
        x.Get.snackbar('', 'Tamanho já cadastrado');
      } else {
        x.Get.snackbar('', 'Ocorreu um erro',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    }
  }

  limparValores() {
    files1.clear();
    files2.clear();
    files3.clear();

    selectedImage1 = Uint8List(0).obs;
    selectedImage2 = Uint8List(0).obs;
    selectedImage3 = Uint8List(0).obs;

    dpSelecaoCategoria = ''.obs;
    dpSelecaoTamanho = [].obs;

    dpSelecaoTamanho = [].obs;

    _produtoDestaqueAtivo = Colors.green;
    _produtoDestaqueInativo = Color(0);
    isProdutoDestaque = false.obs;
    produtoDestaqueColor = 0.obs;
    produtoDestaque = 0;

    isTamanhoPreenchido = true.obs;
    isTamanhoEscalaPreenchido = true.obs;
    isTamanhoMedidaPreenchido = true.obs;
  }
}
