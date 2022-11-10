import 'package:admin_newpedido/data/constants.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:get/get.dart' as x;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CampanhaController extends x.GetxController {
  var selectedImage1 = Uint8List(0).obs;
  var selectedImage2 = Uint8List(0).obs;
  var selectedImage3 = Uint8List(0).obs;
  var selectedImage4 = Uint8List(0).obs;

  List files1 = [];
  List files2 = [];
  List files3 = [];
  List files4 = [];

  void getImage1() async {
    final pickedFile1 =
        await ImagePickerWeb.getImage(outputType: ImageType.bytes);

    if (pickedFile1 != null) {
      selectedImage1.value = pickedFile1;
      files1.add(MultipartFile.fromBytes(selectedImage1.value,
          contentType: MediaType('image', 'png'), filename: 'campanha1.png'));
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
          contentType: MediaType('image', 'png'), filename: 'campanha2.png'));
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
          contentType: MediaType('image', 'png'), filename: 'campanha3.png'));
    } else {
      print("No image selected");
    }
  }

  void getImage4() async {
    final pickedFile4 =
        await ImagePickerWeb.getImage(outputType: ImageType.bytes);

    if (pickedFile4 != null) {
      selectedImage4.value = pickedFile4;
      files4.add(MultipartFile.fromBytes(selectedImage4.value,
          contentType: MediaType('image', 'png'), filename: 'campanha4.png'));
    } else {
      print("No image selected");
    }
  }

  void salvar(var context) async {
    x.Get.snackbar('', "Salvando...");
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    List dados = [files1, files2, files3, files4];

    var formData = FormData.fromMap({"images": dados});

    try {
      await Dio()
          .post('${Constants.BASE_URL}cadastrarCampanha',
              data: formData, 
              options: Options(headers: {
                'token': token, 
                "content-type": "application/json"
                }))
          .then((value) => {
                print(value.statusCode),
                if (value.statusCode == 200 || value.statusCode == 201)
                  {
                    x.Get.back(),
                    x.Get.snackbar('', 'Campanhas cadastradas com sucesso'),
                  }
              });
    } on DioError catch (e, s) {
      print(s);
      print(e);
      x.Get.snackbar('', 'Ocorreu um erro',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void limparImagens() {
    selectedImage1.value = null;
    selectedImage1.value = Uint8List(0);
    selectedImage2.value = null;
    selectedImage2.value = Uint8List(0);
    selectedImage3.value = null;
    selectedImage3.value = Uint8List(0);
    selectedImage4.value = null;
    selectedImage4.value = Uint8List(0);
    //files.clear();
  }

  void deletar() async {
    x.Get.snackbar('', "Salvando...");
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var deletar = {"images": "deletar"};

    try {
      await Dio()
          .post('${Constants.BASE_URL}cadastrarCampanha',
              data: deletar, options: Options(headers: {'token': token}))
          .then((value) => {
                if (value.statusCode == 200 || value.statusCode == 201)
                  {
                    x.Get.back(),
                    x.Get.back(),
                    x.Get.snackbar('', 'Campanhas deletadas com sucesso')
                  }
              });
    } catch (error) {
      x.Get.snackbar('', 'Ocorreu um erro',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  limparValores() {
    selectedImage1 = Uint8List(0).obs;
    selectedImage2 = Uint8List(0).obs;
    selectedImage3 = Uint8List(0).obs;
    selectedImage4 = Uint8List(0).obs;
  }
}
