import 'package:admin_newpedido/data/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  testWidgets('locaisentrega controller ...', (tester) async {
    await Dio()
        .get('${Constants.BASE_URL}listarCategorias')
        .then((value) {
          print(value.statusCode);
    });
  });
}