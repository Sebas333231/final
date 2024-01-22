import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:universal_platform/universal_platform.dart';

class SitioVisitadoModel {
  final int id;
  final String fechaVista;
  final int sitio;
  final int usuario;

  SitioVisitadoModel({
    required this.id,
    required this.fechaVista,
    required this.sitio,
    required this.usuario,
  });
}

List<SitioVisitadoModel> sitioVisitado = [];

Future<List<SitioVisitadoModel>> getSitioVisitado() async {
  String url = "";

  if (UniversalPlatform.isAndroid) {
    url = "http://10.0.2.2:8000/api/SitioVisitado/";
  } else {
    url = "http://127.0.0.1:8000/api/SitioVisitado/";
  }

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    sitioVisitado.clear();

    // Decodificar la respuesta JSON a UTF-8
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Iterar a través de todos los usuarios en decodedData
    for (var sitioVisitadoData in decodedData) {
      // Construir el modelo de usuario para cada usuario en la lista
      sitioVisitado.add(SitioVisitadoModel(
        id: sitioVisitadoData['id'] ?? 0,
        fechaVista: sitioVisitadoData['fechaVista'] ?? "",
        sitio: sitioVisitadoData['sitio'] ?? 0,
        usuario: sitioVisitadoData['usuario'] ?? 0,
      ));
    }

    return sitioVisitado;
  } else {
    // Manejar el fallo de la solicitud HTTP
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
