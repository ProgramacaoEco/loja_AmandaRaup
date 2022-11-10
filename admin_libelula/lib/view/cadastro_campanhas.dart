import 'dart:typed_data';
import 'package:admin_newpedido/responsive.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:get/get.dart';
import '../controller/campanha_controller.dart';

class CadastroCamapanhas extends StatelessWidget {
  var appbar = AppBar(
    title: Text('Cadastro de Campanhas', style: TextStyle(color: Color(0xFF6c5b54))),
    elevation: 0,
    backgroundColor: Color(0xFFe2ddda),
    leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.arrow_back, color: Color(0xFF6c5b54))),
  );

  Widget build(BuildContext context) {
    final CampanhaController controller = Get.put(CampanhaController());
    var image1;
    var image2;
    var image3;
    var image4;

    List<Widget> imagens = [image1, image2, image3, image4];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appbar,
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              child: Stack(
                children: [
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
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 2.5),
                                      child: Container(
                                        child: SizedBox(
                                          width: Responsive.isMobile(context)
                                              ? context.width / 3
                                              : context.width / 7.5,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              controller.getImage1();
                                              imagens[0] = Obx(() =>
                                                  Image.memory(
                                                      Uint8List.fromList(
                                                          controller
                                                              .selectedImage1
                                                              .value)));
                                            },
                                            child: Text("Inserir imagem 1"),
                                            style: ElevatedButton.styleFrom(
                                                primary: Color(0xfff58731)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 2.5),
                                      child: Container(
                                        child: SizedBox(
                                          width: Responsive.isMobile(context)
                                              ? context.width / 3
                                              : context.width / 7.5,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              controller.getImage2();
                                              imagens[1] = Obx(() =>
                                                  Image.memory(
                                                      Uint8List.fromList(
                                                          controller
                                                              .selectedImage2
                                                              .value)));
                                            },
                                            child: Text("Inserir imagem 2"),
                                            style: ElevatedButton.styleFrom(
                                                primary: Color(0xfff58731)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 2.5),
                                    child: Container(
                                      child: SizedBox(
                                        width: Responsive.isMobile(context)
                                            ? context.width / 3
                                            : context.width / 7.5,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            controller.getImage3();
                                            imagens[2] = Obx(() => Image.memory(
                                                Uint8List.fromList(controller
                                                    .selectedImage3.value)));
                                          },
                                          child: Text("Inserir imagem 3"),
                                          style: ElevatedButton.styleFrom(
                                              primary: Color(0xfff58731)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 2.5),
                                    child: Container(
                                      child: SizedBox(
                                        width: Responsive.isMobile(context)
                                            ? context.width / 3
                                            : context.width / 7.5,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            controller.getImage4();
                                            imagens[3] = Obx(() => Image.memory(
                                                Uint8List.fromList(controller
                                                    .selectedImage4.value)));
                                          },
                                          child: Text("Inserir imagem 4"),
                                          style: ElevatedButton.styleFrom(
                                              primary: Color(0xfff58731)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Obx(
                                  () => controller.selectedImage1.value
                                                  .lengthInBytes ==
                                              0 &&
                                          controller.selectedImage2.value
                                                  .lengthInBytes ==
                                              0 &&
                                          controller.selectedImage3.value
                                                  .lengthInBytes ==
                                              0 &&
                                          controller.selectedImage4.value
                                                  .lengthInBytes ==
                                              0
                                      ? Center(
                                          child: Text("Selecione as imagens"))
                                      : CarouselSlider(
                                          items: imagens,
                                          options: CarouselOptions(
                                            height: Responsive.isMobile(context)
                                                ? 150
                                                : 250,
                                            aspectRatio:
                                                Responsive.isMobile(context)
                                                    ? 4 / 3
                                                    : 16 / 9,
                                            viewportFraction:
                                                Responsive.isMobile(context)
                                                    ? 0.8
                                                    : 0.4,
                                            initialPage: 0,
                                            enableInfiniteScroll: true,
                                            reverse: false,
                                            autoPlay: true,
                                            autoPlayInterval:
                                                Duration(seconds: 3),
                                            autoPlayAnimationDuration:
                                                Duration(milliseconds: 800),
                                            autoPlayCurve: Curves.fastOutSlowIn,
                                            enlargeCenterPage: true,
                                            scrollDirection: Axis.horizontal,
                                          ),
                                        ),
                                ),
                              ),
                              Padding(
                                padding: Responsive.isMobile(context)
                                    ? EdgeInsets.only(bottom: 2)
                                    : EdgeInsets.only(bottom: 5),
                                child: SizedBox(
                                  width: Responsive.isMobile(context) ||
                                          Responsive.isTablet(context)
                                      ? context.width / 2
                                      : context.width / 5.5,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await controller.salvar(context);
                                      controller.limparImagens();
                                      controller.limparValores();
                                    },
                                    child: Text("Salvar"),
                                    style: ElevatedButton.styleFrom(
                                        primary: Color(0xff38377b)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: Responsive.isMobile(context)
                                    ? EdgeInsets.only(bottom: 2)
                                    : EdgeInsets.only(bottom: 5),
                                child: SizedBox(
                                  width: Responsive.isMobile(context)
                                      ? context.width / 2
                                      : context.width / 5.5,
                                  child: ElevatedButton(
                                      onPressed: () =>
                                          controller.limparImagens(),
                                      child: Text(
                                        "Remover imagens do carrosel",
                                        textAlign: TextAlign.center,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.red)),
                                ),
                              ),
                              Padding(
                                padding: Responsive.isMobile(context)
                                    ? EdgeInsets.only(bottom: 5)
                                    : EdgeInsets.only(bottom: 30),
                                child: SizedBox(
                                  width: Responsive.isMobile(context)
                                      ? context.width / 2
                                      : context.width / 5.5,
                                  child: ElevatedButton(
                                    onPressed: () => controller.deletar(),
                                    child: Text(
                                      "Remover imagens",
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.red),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
