import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:universal_platform/universal_platform.dart';

class CategoriaMultaModel {
  final int id;
  final String nombre;
  final String icono;
  final String imagen;

  const CategoriaMultaModel({
    required this.id,
    required this.nombre,
    required this.icono,
    required this.imagen,
  });
}

class SitioMultaModel {
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
  final CategoriaMultaModel categoria;

  const SitioMultaModel({
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

class ReservaMultaModel {
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
  final SitioMultaModel sitio;

  const ReservaMultaModel(
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
}

class MultaModel {
  final int id;
  final String fecha;
  final int valor;
  final int valorDevolucion;
  final ReservaMultaModel reserva;

  const MultaModel(
      {required this.id,
      required this.fecha,
      required this.valor,
      required this.valorDevolucion,
      required this.reserva});

  String get valorFormatted {
    return NumberFormat.currency(
      symbol: '',
      locale: 'es_CO',
      decimalDigits: 0,
    ).format(valor);
  }

  String get valorDevolucionFormatted {
    return NumberFormat.currency(
      symbol: '',
      locale: 'es_CO',
      decimalDigits: 0,
    ).format(valorDevolucion);
  }
}

List<MultaModel> multas = [];

Future<List<MultaModel>> getMultas() async {
  String url = "";

  if (UniversalPlatform.isAndroid) {
    url = "http://10.0.2.2:8000/api/Multas/";
  } else {
    url = "http://127.0.0.1:8000/api/Multas/";
  }

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    multas.clear();

    // Decodificar la respuesta JSON
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Iterar a través de todas las multas en decodedData
    for (var multaData in decodedData) {
      // Construir el modelo de multa para cada multa en la lista
      multas.add(MultaModel(
        id: multaData['id'] ?? 0,
        fecha: multaData['fecha'] ?? "",
        valor: multaData['valor'] ?? 0,
        valorDevolucion: multaData['valorDevolucion'] ?? 0,
        reserva: ReservaMultaModel(
          id: multaData['reserva']['id'] ?? 0,
          usuario: multaData['reserva']['usuario'] ?? 0,
          fecha: multaData['reserva']['fecha'] ?? "",
          fechaEntrada: multaData['reserva']['fechaEntrada'] ?? "",
          fechaSalida: multaData['reserva']['fechaSalida'] ?? "",
          numHuespedes: multaData['reserva']['numHuespedes'] ?? 0,
          numAdultos: multaData['reserva']['numAdultos'] ?? 0,
          numNinos: multaData['reserva']['numNinos'] ?? 0,
          numBebes: multaData['reserva']['numBebes'] ?? 0,
          numMascotas: multaData['reserva']['numMascotas'] ?? 0,
          precioFinal: multaData['reserva']['precioFinal'] ?? 0,
          estado: multaData['reserva']['estado'] ?? "",
          comision: multaData['reserva']['comision'] ?? 0,
          gananciaAnfitrion: multaData['reserva']['gananciaAnfitrion'] ?? 0,
          sitio: SitioMultaModel(
            id: multaData['reserva']['sitio']['id'] ?? 0,
            usuario: multaData['reserva']['sitio']['usuario'] ?? 0,
            titulo: multaData['reserva']['sitio']['titulo'] ?? "",
            numHuespedes: multaData['reserva']['sitio']['numHuespedes'] ?? 0,
            numCamas: multaData['reserva']['sitio']['numCamas'] ?? 0,
            numBanos: multaData['reserva']['sitio']['numBanos'] ?? 0,
            descripcion: multaData['reserva']['sitio']['descripcion'] ?? "",
            valorNoche: multaData['reserva']['sitio']['valorNoche'] ?? 0,
            lugar: multaData['reserva']['sitio']['lugar'] ?? "",
            desLugar: multaData['reserva']['sitio']['desLugar'] ?? "",
            latitud: multaData['reserva']['sitio']['latitud'] ?? "",
            longitud: multaData['reserva']['sitio']['longitud'] ?? "",
            continente: multaData['reserva']['sitio']['continente'] ?? "",
            valorLimpieza: multaData['reserva']['sitio']['valorLimpieza'] ?? 0,
            comision: multaData['reserva']['sitio']['comision'] ?? 0,
            politica: multaData['reserva']['sitio']['politica'] ?? false,
            categoria: CategoriaMultaModel(
              id: multaData['reserva']['sitio']['categoria']['id'] ?? 0,
              nombre:
                  multaData['reserva']['sitio']['categoria']['nombre'] ?? "",
              icono: multaData['reserva']['sitio']['categoria']['icono'] ?? "",
              imagen:
                  multaData['reserva']['sitio']['categoria']['imagen'] ?? "",
            ),
          ),
        ),
      ));
    }

    return multas;
  } else {
    // Manejar el fallo de la solicitud HTTP
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
