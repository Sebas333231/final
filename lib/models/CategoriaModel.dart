import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:universal_platform/universal_platform.dart';

class CategoriaModel {
  final int id;
  final String nombre;
  final String icono;
  final String imagen;

  CategoriaModel({
    required this.id,
    required this.nombre,
    required this.icono,
    required this.imagen,
  });
}

List<CategoriaModel> categoria = [];

Future<List<CategoriaModel>> getCategoria() async {
  String url = "";

  if (UniversalPlatform.isAndroid) {
    url = "http://10.0.2.2:8000/api/Categorias/";
  } else {
    url = "http://127.0.0.1:8000/api/Categorias/";
  }

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    categoria.clear();

    // Decodificar la respuesta JSON a UTF-8
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Iterar a través de todos los usuarios en decodedData
    for (var categoriaData in decodedData) {
      // Construir el modelo de usuario para cada usuario en la lista
      categoria.add(CategoriaModel(
        id: categoriaData['id'] ?? 0,
        nombre: categoriaData['nombre'] ?? "",
        icono: categoriaData['icono'] ?? "",
        imagen: categoriaData['imagen'] ?? "",
      ));
    }

    return categoria;
  } else {
    // Manejar el fallo de la solicitud HTTP
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
