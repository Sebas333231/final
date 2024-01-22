import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:universal_platform/universal_platform.dart';

class ReglaModel {
  final int id;
  final String descripcion;
  final int sitio;

  ReglaModel(
      {required this.id, required this.descripcion, required this.sitio});
}

List<ReglaModel> regla = [];

Future<List<ReglaModel>> getRegla() async {
  String url = "";

  if (UniversalPlatform.isAndroid) {
    url = "http://10.0.2.2:8000/api/Reglas/";
  } else {
    url = "http://127.0.0.1:8000/api/Reglas/";
  }

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    regla.clear();

    // Decodificar la respuesta JSON a UTF-8
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Iterar a través de todos los usuarios en decodedData
    for (var reglaData in decodedData) {
      // Construir el modelo de usuario para cada usuario en la lista
      regla.add(ReglaModel(
        id: reglaData['id'] ?? 0,
        descripcion: reglaData['descripcion'] ?? "",
        sitio: reglaData['sitio'] ?? "",
      ));
    }

    return regla;
  } else {
    // Manejar el fallo de la solicitud HTTP
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
