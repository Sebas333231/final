import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:universal_platform/universal_platform.dart';

class CategoriaReservaModel {
  final int id;
  final String nombre;
  final String icono;
  final String imagen;

  const CategoriaReservaModel({
    required this.id,
    required this.nombre,
    required this.icono,
    required this.imagen,
  });
}

class SitioReservaModel {
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
  final CategoriaReservaModel categoria;

  const SitioReservaModel({
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

class ReservaModel {
  final int id;
  final int usuario;
  final String fecha;
  final String fechaEntrada;
  final String fechaSalida;
  final int numHuespedes;
  final int numAdultos;
  final int numNinos;
  final int numBebes;
  final int numMascotas;
  final int precioFinal;
  final String estado;
  final int comision;
  final int gananciaAnfitrion;
  final SitioReservaModel sitio;

  const ReservaModel(
      {required this.id,
      required this.usuario,
      required this.fecha,
      required this.fechaEntrada,
      required this.fechaSalida,
      required this.numHuespedes,
      required this.numAdultos,
      required this.numNinos,
      required this.numBebes,
      required this.numMascotas,
      required this.precioFinal,
      required this.estado,
      required this.comision,
      required this.gananciaAnfitrion,
      required this.sitio});

  String get precioFinalFormatted {
    return NumberFormat.currency(
      symbol: '',
      locale: 'es_CO',
      decimalDigits: 0,
    ).format(precioFinal);
  }

  String get comisionFormatted {
    return NumberFormat.currency(
      symbol: '',
      locale: 'es_CO',
      decimalDigits: 0,
    ).format(comision);
  }

  String get gananciaAnfitrionFormatted {
    return NumberFormat.currency(
      symbol: '',
      locale: 'es_CO',
      decimalDigits: 0,
    ).format(gananciaAnfitrion);
  }
}

List<ReservaModel> reserva = [];

Future<List<ReservaModel>> getReservas() async {
  String url = "";

  if (UniversalPlatform.isAndroid) {
    url = "http://10.0.2.2:8000/api/Reservas/";
  } else {
    url = "http://127.0.0.1:8000/api/Reservas/";
  }

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    reserva.clear();

    // Decodificar la respuesta JSON
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Iterar a través de todas las reservas en decodedData
    for (var reservaData in decodedData) {
      // Construir el modelo de reserva para cada reserva en la lista
      reserva.add(ReservaModel(
        id: reservaData['id'] ?? 0,
        usuario: reservaData['usuario'] ?? 0,
        fecha: reservaData['fecha'] ?? "",
        fechaEntrada: reservaData['fechaEntrada'] ?? "",
        fechaSalida: reservaData['fechaSalida'] ?? "",
        numHuespedes: reservaData['numHuespedes'] ?? 0,
        numAdultos: reservaData['numAdultos'] ?? 0,
        numNinos: reservaData['numNinos'] ?? 0,
        numBebes: reservaData['numBebes'] ?? 0,
        numMascotas: reservaData['numMascotas'] ?? 0,
        precioFinal: reservaData['precioFinal'] ?? 0,
        estado: reservaData['estado'] ?? "",
        comision: reservaData['comision'] ?? 0,
        gananciaAnfitrion: reservaData['gananciaAnfitrion'] ?? 0,
        sitio: SitioReservaModel(
          id: reservaData['sitio']['id'] ?? 0,
          usuario: reservaData['sitio']['usuario'] ?? 0,
          titulo: reservaData['sitio']['titulo'] ?? "",
          numHuespedes: reservaData['sitio']['numHuespedes'] ?? 0,
          numCamas: reservaData['sitio']['numCamas'] ?? 0,
          numBanos: reservaData['sitio']['numBanos'] ?? 0,
          descripcion: reservaData['sitio']['descripcion'] ?? "",
          valorNoche: reservaData['sitio']['valorNoche'] ?? 0,
          lugar: reservaData['sitio']['lugar'] ?? "",
          desLugar: reservaData['sitio']['desLugar'] ?? "",
          latitud: reservaData['sitio']['latitud'] ?? "",
          longitud: reservaData['sitio']['longitud'] ?? "",
          continente: reservaData['sitio']['continente'] ?? "",
          valorLimpieza: reservaData['sitio']['valorLimpieza'] ?? 0,
          comision: reservaData['sitio']['comision'] ?? 0,
          politica: reservaData['sitio']['politica'] ?? false,
          categoria: CategoriaReservaModel(
            id: reservaData['sitio']['categoria']['id'] ?? 0,
            nombre: reservaData['sitio']['categoria']['nombre'] ?? "",
            icono: reservaData['sitio']['categoria']['icono'] ?? "",
            imagen: reservaData['sitio']['categoria']['imagen'] ?? "",
          ),
        ),
      ));
    }

    return reserva;
  } else {
    // Manejar el fallo de la solicitud HTTP
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
