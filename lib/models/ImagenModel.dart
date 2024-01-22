import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:universal_platform/universal_platform.dart';

class ImagenModel {
  final int id;
  final String direccion;
  final int sitio;

  ImagenModel(
      {required this.id,
      required this.direccion,
      required this.sitio});
}

List<ImagenModel> imagen = [];

Future<List<ImagenModel>> getImagen() async {
  String url = "";

  if (UniversalPlatform.isAndroid) {
    url = "http://10.0.2.2:8000/api/Imagen/";
  } else {
    url = "http://127.0.0.1:8000/api/Imagen/";
  }

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    imagen.clear();

    // Decodificar la respuesta JSON a UTF-8
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Iterar a través de todos los usuarios en decodedData
    for (var imagenData in decodedData) {
      // Construir el modelo de usuario para cada usuario en la lista
      imagen.add(ImagenModel(
        id: imagenData['id'] ?? 0,
        direccion: imagenData['direccion'] ?? "",
        sitio: imagenData['sitio'] ?? "",
      ));
    }

    return imagen;
  } else {
    // Manejar el fallo de la solicitud HTTP
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
