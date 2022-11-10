import 'package:admin_newpedido/controller/login_controller.dart';
import 'package:admin_newpedido/model/decoration_textfield.dart';
import 'package:admin_newpedido/model/tamanho_list.dart';
import 'package:admin_newpedido/model/tipo_tamanho_list.dart';
import 'package:admin_newpedido/responsive.dart';
import 'package:admin_newpedido/view/cadastro_campanhas.dart';
import 'package:admin_newpedido/view/cadastro_categorias.dart';
import 'package:admin_newpedido/view/cadastro_formapagamento.dart';
import 'package:admin_newpedido/view/cadastro_produtos.dart';
import 'package:admin_newpedido/view/cadastro_tamanhos_screen.dart';
import 'package:admin_newpedido/view/cadastro_usuario.dart';
import 'package:admin_newpedido/view/lista_novospedidos.dart';
import 'package:admin_newpedido/view/lista_pedidosfaturados.dart';
import 'package:admin_newpedido/view/lista_relatorios.dart';
import 'package:admin_newpedido/view/listagem_tamanhos_screen.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import './view/cadastro_locaisentrega.dart';
import 'package:admin_newpedido/view/menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TamanhoList()), 
        ChangeNotifierProvider(create: (context) => TipoTamanhoList())
      ], 
      child: GetMaterialApp(
        title: 'Eu to podendo',
        initialRoute: "/principal",
        home: Principal(),
        
        getPages: [
          GetPage(
              name: "/principal",
              page: () => Principal(),
              title: 'Eu to podendo',
              transition: Transition.fadeIn),
          GetPage(
              name: "/menu",
              page: () => Menu(),
              title: 'Eu to podendo',
              transition: Transition.fadeIn),
          GetPage(
              name: "/menu/cadastroProdutos",
              page: () => CadastroProdutos(),
              title: 'Eu to podendo',
              transition: Transition.fadeIn),
          GetPage(
              name: "/menu/tamanhos",
              page: () => CadastroTamanhosScreen(),
              title: 'Eu to podendo',
              transition: Transition.fadeIn),
          GetPage(
              name: "/menu/listaTamanhos",
              page: () => ListagemTamanhosScreen(),
              title: 'Eu to podendo',
              transition: Transition.fadeIn),
          GetPage(
              name: "/menu/cadastroCampanhas",
              page: () => CadastroCamapanhas(),
              title: 'Eu to podendo',
              transition: Transition.fadeIn),
          GetPage(
              name: "/menu/cadastroCategorias",
              page: () => CadastroCategorias(),
              title: 'Eu to podend',
              transition: Transition.fadeIn),
          GetPage(
              name: "/menu/cadastroFormaPagamento",
              page: () => CadastroFormaPagamento(),
              title: 'Eu to podendo',
              transition: Transition.fadeIn),
          GetPage(
              name: "/menu/cadastroUsuarios",
              page: () => CadastroUsuarios(),
              title: 'Eu to podendo',
              transition: Transition.fadeIn),
          GetPage(
              name: "/menu/controleEstoque",
              page: () => ControleEstoque(),
              title: 'Eu to podendo',
              transition: Transition.fadeIn),
          GetPage(
              name: "/menu/pedidos",
              page: () => Pedidos(),
              title: 'Eu to podendo',
              transition: Transition.fadeIn),
          GetPage(
              name: "/menu/pedidosFaturados",
              page: () => PedidosFaturados(),
              title: 'Eu to podendo',
              transition: Transition.fadeIn),
          GetPage(
              name: '/menu/relatorios',
              page: () => Relatorios(),
              title: 'Eu to podendo',
              transition: Transition.fadeIn)
        ],
      ),
    ),
  );
}

class Principal extends StatelessWidget {
  final LoginController auth = Get.put(
    LoginController(),
  );
  TextStyle estilo = GoogleFonts.openSans(
      color: Colors.deepOrange, fontSize: 60, fontWeight: FontWeight.w100);
  TextStyle estilo2 = GoogleFonts.openSans(
      color: Colors.deepOrange, fontSize: 40, fontWeight: FontWeight.w100);
  TextEditingController login = TextEditingController();
  TextEditingController senha = TextEditingController();

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    auth.ableToPass();

    if (Theme.of(context).platform == TargetPlatform.android) {
      return Container(
        child: WebView(
          initialUrl: '',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      );
    } else {
      return Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                buildGradientBackground(size),
                Center(
                  child: Responsive(
                    mobile: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: buildContainerPage(context),
                    ),
                    desktop: buildContainerPage(context),
                  ),
                ),
              ],
            );
          },
        ),
      );
    }
  }

  Row buildGradientBackground(Size size) {
    return Row(
      children: [
        Container(
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [          
                Color(0xFFe2ddda),
                Color(0xFFe2ddda),
              ],
            ),
          ),
        ),
        
      ],
    );
  }

  // Container da pagina de login que é responsivo de acordo com a tela
  Container buildContainerPage(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 700,
        maxHeight: 400,
        minWidth: 250,
        minHeight: 200,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Se for mobile o size é 120 e se for desktop 150
            Responsive(
              mobile: Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                  height: Get.height / 5,
                    child: 
                  Image.asset(
                    '../../images/appstore.png',
                    height: 120,
                    width: 120,
                  ),
              ),
              desktop: Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                  height: Get.height / 5,
                    child:
                  Image.asset(
                    '../../images/appstore.png', 
                    height: 150,
                    width: 150
                  ),
              ),
            ),
            
            Container(
              margin: EdgeInsets.only(bottom: 40),
              child: Column(
                children: [
                  buildLoginInput(context),
                  buildPasswordInput(context),
                ],
              ),
            ),
            buildButtonLogar(context),
          ],
        ),
      ),
    );
  }

  Container buildLoginInput(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 300),
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: TextFormField(
        cursorColor: Colors.blue,
        decoration: Decor(labelText: "Usuário", isDense: true),
        controller: login,
        style: TextStyle(color: Colors.blue),
      ),
    );
  }

  // Input de password
  Container buildPasswordInput(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 300),
      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        cursorColor: Colors.blue,
        obscureText: true,
        decoration: Decor(labelText: "Senha", isDense: true),
        controller: senha,
        style: TextStyle(color: Colors.blue),
      ),
    );
  }

// Botão  de login para logar
  Container buildButtonLogar(BuildContext context) {
    double textScale = MediaQuery.of(context).textScaleFactor;
    return Container(
      constraints: BoxConstraints(maxWidth: 120, minWidth: 80),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 20),
        child: ElevatedButton(
          onPressed: () {
            auth.login(login.text, senha.text, context);
          },
          child: Text(
            "Logar",
            textScaleFactor: textScale,
            overflow: TextOverflow.fade,
            style: new TextStyle(fontSize: 14),
          ),
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF005EFF),
          ),
        ),
      ),
    );
  }
}
