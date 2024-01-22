import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:universal_platform/universal_platform.dart';

class HabitacionModel {
  final int id;
  final String titulo;
  final String descripcion;
  final int sitio;

  HabitacionModel(
      {required this.id,
      required this.titulo,
      required this.descripcion,
      required this.sitio});
}

List<HabitacionModel> habitacion = [];

Future<List<HabitacionModel>> getHabitacion() async {
  String url = "";

  if (UniversalPlatform.isAndroid) {
    url = "http://10.0.2.2:8000/api/Habitacion/";
  } else {
    url = "http://127.0.0.1:8000/api/Habitacion/";
  }

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    habitacion.clear();

    // Decodificar la respuesta JSON a UTF-8
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Iterar a través de todos los usuarios en decodedData
    for (var habitacionData in decodedData) {
      // Construir el modelo de usuario para cada usuario en la lista
      habitacion.add(HabitacionModel(
        id: habitacionData['id'] ?? 0,
        titulo: habitacionData['titulo'] ?? "",
        descripcion: habitacionData['descripcion'] ?? "",
        sitio: habitacionData['sitio'] ?? "",
      ));
    }

    return habitacion;
  } else {
    // Manejar el fallo de la solicitud HTTP
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
