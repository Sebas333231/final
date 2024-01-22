import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:universal_platform/universal_platform.dart';

class ServicioModel {
  final int id;
  final String icono;
  final String nombre;
  final String descripcion;
  final int sitio;

  ServicioModel(
      {required this.id,
      required this.icono,
      required this.nombre,
      required this.descripcion,
      required this.sitio});
}

List<ServicioModel> servicio = [];

Future<List<ServicioModel>> getServicio() async {
  String url = "";

  if (UniversalPlatform.isAndroid) {
    url = "http://10.0.2.2:8000/api/Servicios/";
  } else {
    url = "http://127.0.0.1:8000/api/Servicios/";
  }

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    servicio.clear();

    // Decodificar la respuesta JSON a UTF-8
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Iterar a través de todos los usuarios en decodedData
    for (var servicioData in decodedData) {
      // Construir el modelo de usuario para cada usuario en la lista
      servicio.add(ServicioModel(
          id: servicioData['id'] ?? 0,
          icono: servicioData['icono'] ?? 0,
          nombre: servicioData['nombre'] ?? 0,
          descripcion: servicioData['descripcion'] ?? 0,
          sitio: servicioData['sitio'] ?? 0));
    }

    return servicio;
  } else {
    // Manejar el fallo de la solicitud HTTP
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
