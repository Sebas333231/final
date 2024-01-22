import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:universal_platform/universal_platform.dart';

class CategoriaDevolucionModel {
  final int id;
  final String nombre;
  final String icono;
  final String imagen;

  const CategoriaDevolucionModel({
    required this.id,
    required this.nombre,
    required this.icono,
    required this.imagen,
  });
}

class SitioDevolucionModel {
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
  final CategoriaDevolucionModel categoria;

  const SitioDevolucionModel({
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

class ReservaDevolucionModel {
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
  final SitioDevolucionModel sitio;

  const ReservaDevolucionModel(
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

class DevolucionModel {
  final int id;
  final String fechaRadicado;
  final String fechaPago;
  final int valor;
  final String estado;
  final ReservaDevolucionModel reserva;

  const DevolucionModel(
      {required this.id,
      required this.fechaRadicado,
      required this.fechaPago,
      required this.valor,
      required this.estado,
      required this.reserva});

  String get valorFormatted {
    return NumberFormat.currency(
      symbol: '',
      locale: 'es_CO',
      decimalDigits: 0,
    ).format(valor);
  }
}

List<DevolucionModel> devoluciones = [];

Future<List<DevolucionModel>> getDevoluciones() async {
  String url = "";

  if (UniversalPlatform.isAndroid) {
    url = "http://10.0.2.2:8000/api/Devolucion/";
  } else {
    url = "http://127.0.0.1:8000/api/Devolucion/";
  }

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    devoluciones.clear();

    // Decodificar la respuesta JSON
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Iterar a través de todas las multas en decodedData
    for (var devolucionData in decodedData) {
      // Construir el modelo de multa para cada multa en la lista
      devoluciones.add(DevolucionModel(
        id: devolucionData['id'] ?? 0,
        fechaRadicado: devolucionData['fechaRadicado'] ?? "",
        fechaPago: devolucionData['fechaPago'] ?? "",
        valor: devolucionData['valor'] ?? 0,
        estado: devolucionData['estado'] ?? 0,
        reserva: ReservaDevolucionModel(
          id: devolucionData['reserva']['id'] ?? 0,
          usuario: devolucionData['reserva']['usuario'] ?? 0,
          fecha: devolucionData['reserva']['fecha'] ?? "",
          fechaEntrada: devolucionData['reserva']['fechaEntrada'] ?? "",
          fechaSalida: devolucionData['reserva']['fechaSalida'] ?? "",
          numHuespedes: devolucionData['reserva']['numHuespedes'] ?? 0,
          numAdultos: devolucionData['reserva']['numAdultos'] ?? 0,
          numNinos: devolucionData['reserva']['numNinos'] ?? 0,
          numBebes: devolucionData['reserva']['numBebes'] ?? 0,
          numMascotas: devolucionData['reserva']['numMascotas'] ?? 0,
          precioFinal: devolucionData['reserva']['precioFinal'] ?? 0,
          estado: devolucionData['reserva']['estado'] ?? "",
          comision: devolucionData['reserva']['comision'] ?? 0,
          gananciaAnfitrion:
              devolucionData['reserva']['gananciaAnfitrion'] ?? 0,
          sitio: SitioDevolucionModel(
            id: devolucionData['reserva']['sitio']['id'] ?? 0,
            usuario: devolucionData['reserva']['sitio']['usuario'] ?? 0,
            titulo: devolucionData['reserva']['sitio']['titulo'] ?? "",
            numHuespedes:
                devolucionData['reserva']['sitio']['numHuespedes'] ?? 0,
            numCamas: devolucionData['reserva']['sitio']['numCamas'] ?? 0,
            numBanos: devolucionData['reserva']['sitio']['numBanos'] ?? 0,
            descripcion:
                devolucionData['reserva']['sitio']['descripcion'] ?? "",
            valorNoche: devolucionData['reserva']['sitio']['valorNoche'] ?? 0,
            lugar: devolucionData['reserva']['sitio']['lugar'] ?? "",
            desLugar: devolucionData['reserva']['sitio']['desLugar'] ?? "",
            latitud: devolucionData['reserva']['sitio']['latitud'] ?? "",
            longitud: devolucionData['reserva']['sitio']['longitud'] ?? "",
            continente: devolucionData['reserva']['sitio']['continente'] ?? "",
            valorLimpieza:
                devolucionData['reserva']['sitio']['valorLimpieza'] ?? 0,
            comision: devolucionData['reserva']['sitio']['comision'] ?? 0,
            politica: devolucionData['reserva']['sitio']['politica'] ?? false,
            categoria: CategoriaDevolucionModel(
              id: devolucionData['reserva']['sitio']['categoria']['id'] ?? 0,
              nombre: devolucionData['reserva']['sitio']['categoria']
                      ['nombre'] ??
                  "",
              icono: devolucionData['reserva']['sitio']['categoria']['icono'] ??
                  "",
              imagen: devolucionData['reserva']['sitio']['categoria']
                      ['imagen'] ??
                  "",
            ),
          ),
        ),
      ));
    }

    return devoluciones;
  } else {
    // Manejar el fallo de la solicitud HTTP
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
