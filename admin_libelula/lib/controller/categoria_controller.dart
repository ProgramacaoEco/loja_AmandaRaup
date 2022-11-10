import 'dart:typed_data';
import 'package:admin_newpedido/data/constants.dart';
import 'package:get/get.dart' as x;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class CategoriaController extends x.GetxController {
  var selectedImage = Uint8List(0).obs;

  var categorias = [].obs;

  Future<void> getImage(String type) async {
    final pickedFile =
        await ImagePickerWeb.getImage(outputType: ImageType.bytes);

    if (pickedFile != null) {
      selectedImage.value = pickedFile;
    } else {
      print("No image selected.");
    }
  }

  Future<void> atualizarImagem(var idCategoria, var context) async {
    x.Get.snackbar('', 'Atualizando imagem...');
    if (idCategoria == null) {
      x.Get.snackbar('', 'Selecione uma categoria');
    } else {
    
        var prefs = await SharedPreferences.getInstance();
        var token = prefs.getString('token');

        var formData = FormData.fromMap({
          "idCategoria": idCategoria,
          "image": MultipartFile.fromBytes(selectedImage.value,
              contentType: MediaType('image', 'png'), filename: "categoria.png")
        });

        try {
          print('entrou no try');
          await Dio()
              .post('${Constants.BASE_URL}editarCategoria',
                  data: formData, options: Options(headers: {'token': token}))
              .then((value) {
                print(value.statusCode);
            if (value.statusCode == 200 || value.statusCode == 201) {
              
              x.Get.back();
              x.Get.back();
              x.Get.back();
              x.Get.snackbar('', 'Imagem atualizada com sucesso');
              limparValores(); 
            }
          });
        } catch (e) {
          print(e);
        }
    }
  }

  void salvar(String nomeCategoria, var context) async {
    x.Get.snackbar('', "Salvando...");
    if (nomeCategoria.length == 0 ||
        nomeCategoria == null ||
        nomeCategoria.length < 0) {
      x.Get.snackbar('', 'Preencha uma descrição para a categoria');
    } else {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');

      var formData = FormData.fromMap({
        "nome_categoria": nomeCategoria,
        "image": MultipartFile.fromBytes(selectedImage.value,
            contentType: MediaType('image', 'png'), filename: "categoria.png")
      });

      try {
        await Dio()
            .post('${Constants.BASE_URL}cadastrarCategoria',
                data: formData, options: Options(headers: {'token': token}))
            .then((value) {
          if (value.statusCode == 200 || value.statusCode == 201) {
            x.Get.back();
            x.Get.back();
            x.Get.snackbar('', 'Categoria cadastrada com sucesso');
            limparValores();
          }
        });
      } catch (error) {
        if (error.toString().contains('403')) {
          x.Get.snackbar('', 'Categoria já cadastrada');
        } else {
          x.Get.snackbar('', 'Ocorreu um erro',
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      }
    }
  }

  listarCategorias() async {
    categorias.clear();
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    await Dio()
        .get('${Constants.BASE_URL}listarCategorias',
            options: Options(headers: {'token': token}))
        .then((value) {
      if (value.statusCode == 200 || value.statusCode == 201) {
        for (var i = 0; i < value.data.length; i++) {
          categorias.add(value.data[i]);
        }
      }
    });
  }

  inativarCategorias(var idCategoria) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    try {
      await Dio().put('${Constants.BASE_URL}inativarCategoria',
          options: Options(headers: {'token': token}),
          data: {'id_categoria': idCategoria}).then((value) {
        if (value.statusCode == 200 || value.statusCode == 201) {
          categorias
              .removeWhere((element) => element['id_categoria'] == idCategoria);
          x.Get.back();
          x.Get.snackbar('', 'Categoria inativada com sucesso');
        }
      });
    } catch (erro) {
      x.Get.snackbar('', 'Ocorreu um erro');
    }
  }

  void limparValores() {
    selectedImage = Uint8List(0).obs;
  }
}
