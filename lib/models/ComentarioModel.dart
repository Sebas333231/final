import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:universal_platform/universal_platform.dart';

class CategoriaComentarioModel {
  final int id;
  final String nombre;
  final String icono;
  final String imagen;

  const CategoriaComentarioModel({
    required this.id,
    required this.nombre,
    required this.icono,
    required this.imagen,
  });
}

class SitioComentarioModel {
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
  final CategoriaComentarioModel categoria;

  const SitioComentarioModel({
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
}

class ComentarioModel {
  final int id;
  final int usuario;
  final String fecha;
  final double calLimpieza;
  final String desLimpieza;
  final double calComunicacion;
  final String desComunicacion;
  final double calLlegada;
  final String desLlegada;
  final double calFiabilidad;
  final String desFiabilidad;
  final double calUbicacion;
  final String desUbicacion;
  final double calPrecio;
  final String desPrecio;
  final String descripcion;
  final SitioComentarioModel sitio;

  const ComentarioModel(
      {required this.id,
      required this.usuario,
      required this.fecha,
      required this.calLimpieza,
      required this.desLimpieza,
      required this.calComunicacion,
      required this.desComunicacion,
      required this.calLlegada,
      required this.desLlegada,
      required this.calFiabilidad,
      required this.desFiabilidad,
      required this.calUbicacion,
      required this.desUbicacion,
      required this.calPrecio,
      required this.desPrecio,
      required this.descripcion,
      required this.sitio});
}

List<ComentarioModel> comentario = [];

Future<List<ComentarioModel>> getComentarios() async {
  String url = "";

  if (UniversalPlatform.isAndroid) {
    url = "http://10.0.2.2:8000/api/Comentarios/";
  } else {
    url = "http://127.0.0.1:8000/api/Comentarios/";
  }

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    comentario.clear();

    // Decodificar la respuesta JSON
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Iterar a través de todos los comentarios en decodedData
    for (var comentarioData in decodedData) {
      // Construir el modelo de comentario para cada comentario en la lista
      comentario.add(ComentarioModel(
        id: comentarioData['id'] ?? 0,
        usuario: comentarioData['usuario'] ?? 0,
        fecha: comentarioData['fecha'] ?? "",
        calLimpieza: comentarioData['calLimpieza'] ?? 0.0,
        desLimpieza: comentarioData['desLimpieza'] ?? "",
        calComunicacion: comentarioData['calComunicacion'] ?? 0.0,
        desComunicacion: comentarioData['desComunicacion'] ?? "",
        calLlegada: comentarioData['calLlegada'] ?? 0.0,
        desLlegada: comentarioData['desLlegada'] ?? "",
        calFiabilidad: comentarioData['calFiabilidad'] ?? 0.0,
        desFiabilidad: comentarioData['desFiabilidad'] ?? "",
        calUbicacion: comentarioData['calUbicacion'] ?? 0.0,
        desUbicacion: comentarioData['desUbicacion'] ?? "",
        calPrecio: comentarioData['calPrecio'] ?? 0.0,
        desPrecio: comentarioData['desPrecio'] ?? "",
        descripcion: comentarioData['descripcion'] ?? "",
        sitio: SitioComentarioModel(
          id: comentarioData['sitio']['id'] ?? 0,
          usuario: comentarioData['sitio']['usuario'] ?? 0,
          titulo: comentarioData['sitio']['titulo'] ?? "",
          numHuespedes: comentarioData['sitio']['numHuespedes'] ?? 0,
          numCamas: comentarioData['sitio']['numCamas'] ?? 0,
          numBanos: comentarioData['sitio']['numBanos'] ?? 0,
          descripcion: comentarioData['sitio']['descripcion'] ?? "",
          valorNoche: comentarioData['sitio']['valorNoche'] ?? 0,
          lugar: comentarioData['sitio']['lugar'] ?? "",
          desLugar: comentarioData['sitio']['desLugar'] ?? "",
          latitud: comentarioData['sitio']['latitud'] ?? "",
          longitud: comentarioData['sitio']['longitud'] ?? "",
          continente: comentarioData['sitio']['continente'] ?? "",
          valorLimpieza: comentarioData['sitio']['valorLimpieza'] ?? 0,
          comision: comentarioData['sitio']['comision'] ?? 0,
          politica: comentarioData['sitio']['politica'] ?? false,
          categoria: CategoriaComentarioModel(
            id: comentarioData['sitio']['categoria']['id'] ?? 0,
            nombre: comentarioData['sitio']['categoria']['nombre'] ?? "",
            icono: comentarioData['sitio']['categoria']['icono'] ?? "",
            imagen: comentarioData['sitio']['categoria']['imagen'] ?? "",
          ),
        ),
      ));
    }

    return comentario;
  } else {
    // Manejar el fallo de la solicitud HTTP
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
