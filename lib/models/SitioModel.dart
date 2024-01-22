import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:universal_platform/universal_platform.dart';
import 'package:intl/intl.dart';

class CategoriaSitioModel {
  final int id;
  final String nombre;
  final String icono;
  final String imagen;

  const CategoriaSitioModel({
    required this.id,
    required this.nombre,
    required this.icono,
    required this.imagen,
  });
}

class SitioModel {
  final int id;
  final int usuario;
  final String titulo;
  final int numHuespedes;
  final int numCamas;
  final int numBanos;
  final String descripcion;
  final int valorNoche;
  final String lugar;
  final String desLugar;
  final String latitud;
  final String longitud;
  final String continente;
  final int valorLimpieza;
  final int comision;
  final bool politica;
  final CategoriaSitioModel categoria;

  const SitioModel({
    required this.id,
    required this.usuario,
    required this.titulo,
    required this.numHuespedes,
    required this.numCamas,
    required this.numBanos,
    required this.descripcion,
    required this.valorNoche,
    required this.lugar,
    required this.desLugar,
    required this.latitud,
    required this.longitud,
    required this.continente,
    required this.valorLimpieza,
    required this.comision,
    required this.politica,
    required this.categoria,
  });

  String get valorNocheFormatted {
    return NumberFormat.currency(
      symbol: '',
      locale: 'es_CO',
      decimalDigits: 0,
    ).format(valorNoche);
  }

  String get comisionFormatted {
    return NumberFormat.currency(
      symbol: '',
      locale: 'es_CO',
      decimalDigits: 0,
    ).format(comision);
  }

  String get valorLimpiezaFormatted {
    return NumberFormat.currency(
      symbol: '',
      locale: 'es_CO',
      decimalDigits: 0,
    ).format(valorLimpieza);
  }
}

List<SitioModel> sitio = [];

Future<List<SitioModel>> getSitios() async {
  String url = "";

  if (UniversalPlatform.isAndroid) {
    url = "http://10.0.2.2:8000/api/Sitios/";
  } else {
    url = "http://127.0.0.1:8000/api/Sitios/";
  }

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    sitio.clear();

    // Decodificar la respuesta JSON
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Iterar a través de todos los sitios en decodedData
    for (var sitioData in decodedData) {
      // Construir el modelo de sitio para cada sitio en la lista
      sitio.add(SitioModel(
        id: sitioData['id'] ?? 0,
        usuario: sitioData['usuario'] ?? 0,
        titulo: sitioData['titulo'] ?? "",
        numHuespedes: sitioData['numHuespedes'] ?? 0,
        numCamas: sitioData['numCamas'] ?? 0,
        numBanos: sitioData['numBanos'] ?? 0,
        descripcion: sitioData['descripcion'] ?? "",
        valorNoche: sitioData['valorNoche'] ?? 0,
        lugar: sitioData['lugar'] ?? "",
        desLugar: sitioData['desLugar'] ?? "",
        latitud: sitioData['latitud'] ?? "",
        longitud: sitioData['longitud'] ?? "",
        continente: sitioData['continente'] ?? "",
        valorLimpieza: sitioData['valorLimpieza'] ?? 0,
        comision: sitioData['comision'] ?? 0,
        politica: sitioData['politica'] ?? false,
        categoria: CategoriaSitioModel(
          id: sitioData['categoria']['id'] ?? 0,
          nombre: sitioData['categoria']['nombre'] ?? "",
          icono: sitioData['categoria']['icono'] ?? "",
          imagen: sitioData['categoria']['imagen'] ?? "",
        ),
      ));
    }

    return sitio;
  } else {
    // Manejar el fallo de la solicitud HTTP
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
