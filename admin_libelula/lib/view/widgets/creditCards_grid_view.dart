// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CreditCardsGridView extends StatelessWidget {
  const CreditCardsGridView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, 
        children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.only(right: 5),
                    child: const Image(
                        image: AssetImage('images/bandeiras/mastercard.png'),
                        height: 35)),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: const Image(
                        image: AssetImage('images/bandeiras/visa.jpg'),
                        height: 32)),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: const Image(
                        image: AssetImage('images/bandeiras/elo.png'),
                        height: 60)),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: const Image(
                        image: AssetImage('images/bandeiras/amex.png'),
                        height: 43)),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: const Image(
                        image: AssetImage('images/bandeiras/hipercard.jpg'),
                        height: 35)),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: const Image(
                        image: AssetImage('images/bandeiras/hiper.png'),
                        height: 35)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: const Image(
                        image: AssetImage('images/bandeiras/jcb.png'),
                        height: 35)),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: const Image(
                        image: AssetImage('images/bandeiras/discover.png'),
                        height: 35)),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: const Image(
                        image: AssetImage('images/bandeiras/diners.jpg'),
                        height: 35)),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: const Image(
                        image: AssetImage('images/bandeiras/banescard.png'),
                        height: 35)),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: const Image(
                        image: AssetImage('images/bandeiras/aura.png'),
                        height: 35)),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}
