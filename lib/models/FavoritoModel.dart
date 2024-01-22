import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:universal_platform/universal_platform.dart';

class FavoritoModel {
  final int id;
  final int usuario;
  final int sitio;

  FavoritoModel({
    required this.id,
    required this.usuario,
    required this.sitio,
  });
}

List<FavoritoModel> favorito = [];

Future<List<FavoritoModel>> getFavorito() async {
  String url = "";

  if (UniversalPlatform.isAndroid) {
    url = "http://10.0.2.2:8000/api/Favoritos/";
  } else {
    url = "http://127.0.0.1:8000/api/Favoritos/";
  }

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    favorito.clear();

    // Decodificar la respuesta JSON a UTF-8
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Iterar a través de todos los usuarios en decodedData
    for (var favoritoData in decodedData) {
      // Construir el modelo de usuario para cada usuario en la lista
      favorito.add(FavoritoModel(
        id: favoritoData['id'] ?? 0,
        usuario: favoritoData['usuario'] ?? 0,
        sitio: favoritoData['sitio'] ?? 0,
      ));
    }

    return favorito;
  } else {
    // Manejar el fallo de la solicitud HTTP
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
