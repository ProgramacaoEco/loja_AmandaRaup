// ignore_for_file: file_names
import 'package:carousel_slider/carousel_slider.dart'
    show CarouselOptions, CarouselSlider, CenterPageEnlargeStrategy;
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/colors.dart';

Cores cor = Cores();

class Cardsredesocial extends StatefulWidget {
  const Cardsredesocial({Key? key}) : super(key: key);

  @override
  _CardsredesocialState createState() => _CardsredesocialState();
}

class _CardsredesocialState extends State<Cardsredesocial> {
  fontes(BuildContext context) {
    if (MediaQuery.of(context).size.height >= 650) {
      return 16.0;
    } else {
      return 12.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      buttonSize: MediaQuery.of(context).size.height >= 650
          ? Size(45, 45)
          : Size(35, 35),
      //animatedIconTheme: IconThemeData(size: 100),
      backgroundColor: Color(cor.tema),
      label: Text(
                  'Redes Sociais', 
                   style: TextStyle(
                      color: Color(0xFF6c5c54)
                    )
                  ),
      visible: true,
      curve: Curves.bounceIn,
      children: [
        // Botão Contatos
        SpeedDialChild(
          child: const Icon(Icons.phone, color: Colors.white),
          backgroundColor: Colors.green,
          onTap: () async {
            //Whats
            try {
              await launch('https://api.whatsapp.com/send?phone=51980392188');
            } catch (error) {
              print(error);
            }
          },
          label: 'WhatsApp',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: fontes(context)),
          labelBackgroundColor: Colors.green,
        ),

        // FAB 2
        SpeedDialChild(
            child: const Icon(
              Icons.facebook,
              color: Colors.white,
            ),
            backgroundColor: Colors.blue,
            onTap: () async {
              //Face
              try {
                await launch('https://www.facebook.com/LibelulaPresentesEDecoracao');
              } catch (error) {
                print(error);
              }
            },
            label: 'Facebook',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: fontes(context)),
            labelBackgroundColor: Colors.blue),

        SpeedDialChild(
            child: Image.asset('lib/app/images/ig.png'),
            backgroundColor: Colors.pink.shade600,
            onTap: () async {
              //Insta
              try {
                await launch('https://www.instagram.com/libelulalpd/');
              } catch (error) {
                print(error);
              }
            },
            label: 'Instagram',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: fontes(context)),
            labelBackgroundColor: Colors.pink.shade600)
      ],
    );
  }
}
