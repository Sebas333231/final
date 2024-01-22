import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:universal_platform/universal_platform.dart';

class CategoriaPagoAModel {
  final int id;
  final String nombre;
  final String icono;
  final String imagen;

  const CategoriaPagoAModel({
    required this.id,
    required this.nombre,
    required this.icono,
    required this.imagen,
  });
}

class SitioPagoAModel {
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
  final CategoriaPagoAModel categoria;

  const SitioPagoAModel({
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

class ReservaPagoAModel {
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
  final SitioPagoAModel sitio;

  const ReservaPagoAModel(
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

class PagoAnfitrionModel {
  final int id;
  final String fechaRadicado;
  final String fechaPago;
  final String medioPago;
  final String estado;
  final ReservaPagoAModel reserva;

  const PagoAnfitrionModel(
      {required this.id,
      required this.fechaRadicado,
      required this.fechaPago,
      required this.medioPago,
      required this.estado,
      required this.reserva});
}

List<PagoAnfitrionModel> pagosAnfitrion = [];

Future<List<PagoAnfitrionModel>> getPagosAnfitrion() async {
  String url = "";

  if (UniversalPlatform.isAndroid) {
    url = "http://10.0.2.2:8000/api/PagoAnfitrion/";
  } else {
    url = "http://127.0.0.1:8000/api/PagoAnfitrion/";
  }

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    pagosAnfitrion.clear();

    // Decodificar la respuesta JSON
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Iterar a través de todos los pagos en decodedData
    for (var pagoData in decodedData) {
      // Construir el modelo de pago para cada pago en la lista
      pagosAnfitrion.add(PagoAnfitrionModel(
        id: pagoData['id'] ?? 0,
        fechaRadicado: pagoData['fechaRadicado'] ?? "",
        fechaPago: pagoData['fechaPago'] ?? "",
        medioPago: pagoData['medioPago'] ?? "",
        estado: pagoData['estado'] ?? "",
        reserva: ReservaPagoAModel(
          id: pagoData['reserva']['id'] ?? 0,
          usuario: pagoData['reserva']['usuario'] ?? 0,
          fecha: pagoData['reserva']['fecha'] ?? "",
          fechaEntrada: pagoData['reserva']['fechaEntrada'] ?? "",
          fechaSalida: pagoData['reserva']['fechaSalida'] ?? "",
          numHuespedes: pagoData['reserva']['numHuespedes'] ?? 0,
          numAdultos: pagoData['reserva']['numAdultos'] ?? 0,
          numNinos: pagoData['reserva']['numNinos'] ?? 0,
          numBebes: pagoData['reserva']['numBebes'] ?? 0,
          numMascotas: pagoData['reserva']['numMascotas'] ?? 0,
          precioFinal: pagoData['reserva']['precioFinal'] ?? 0,
          estado: pagoData['reserva']['estado'] ?? "",
          comision: pagoData['reserva']['comision'] ?? 0,
          gananciaAnfitrion: pagoData['reserva']['gananciaAnfitrion'] ?? 0,
          sitio: SitioPagoAModel(
            id: pagoData['reserva']['sitio']['id'] ?? 0,
            usuario: pagoData['reserva']['sitio']['usuario'] ?? 0,
            titulo: pagoData['reserva']['sitio']['titulo'] ?? "",
            numHuespedes: pagoData['reserva']['sitio']['numHuespedes'] ?? 0,
            numCamas: pagoData['reserva']['sitio']['numCamas'] ?? 0,
            numBanos: pagoData['reserva']['sitio']['numBanos'] ?? 0,
            descripcion: pagoData['reserva']['sitio']['descripcion'] ?? "",
            valorNoche: pagoData['reserva']['sitio']['valorNoche'] ?? 0,
            lugar: pagoData['reserva']['sitio']['lugar'] ?? "",
            desLugar: pagoData['reserva']['sitio']['desLugar'] ?? "",
            latitud: pagoData['reserva']['sitio']['latitud'] ?? "",
            longitud: pagoData['reserva']['sitio']['longitud'] ?? "",
            continente: pagoData['reserva']['sitio']['continente'] ?? "",
            valorLimpieza: pagoData['reserva']['sitio']['valorLimpieza'] ?? 0,
            comision: pagoData['reserva']['sitio']['comision'] ?? 0,
            politica: pagoData['reserva']['sitio']['politica'] ?? false,
            categoria: CategoriaPagoAModel(
              id: pagoData['reserva']['sitio']['categoria']['id'] ?? 0,
              nombre: pagoData['reserva']['sitio']['categoria']['nombre'] ?? "",
              icono: pagoData['reserva']['sitio']['categoria']['icono'] ?? "",
              imagen: pagoData['reserva']['sitio']['categoria']['imagen'] ?? "",
            ),
          ),
        ),
      ));
    }

    return pagosAnfitrion;
  } else {
    // Manejar el fallo de la solicitud HTTP
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
