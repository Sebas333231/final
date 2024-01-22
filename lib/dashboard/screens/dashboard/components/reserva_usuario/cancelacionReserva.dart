import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proyecto_final/HomePage/home_screens.dart';
import 'package:proyecto_final/models/ReservaModel.dart';
import 'package:proyecto_final/theme/theme_constants.dart';
import 'package:proyecto_final/theme/theme_manager.dart';
import 'package:http/http.dart' as http;
import 'package:universal_platform/universal_platform.dart';

class CancelacionReserva extends StatefulWidget {
  final ReservaModel reserva;

  final ThemeManager themeManager;

  const CancelacionReserva(
      {super.key, required this.reserva, required this.themeManager});

  @override
  State<CancelacionReserva> createState() => _CancelacionReservaState();
}

class _CancelacionReservaState extends State<CancelacionReserva> {
  cancelarReservaOportuna(
      ReservaModel reserva, ThemeManager themeManager) async {
    String url = "";

    String url2 = "";

    if (UniversalPlatform.isAndroid) {
      url = "http://10.0.2.2:8000/api/Devolucion/";
    } else {
      url = "http://127.0.0.1:8000/api/Devolucion/";
    }

    if (UniversalPlatform.isAndroid) {
      url2 = "http://10.0.2.2:8000/api/Reservas/";
    } else {
      url2 = "http://127.0.0.1:8000/api/Reservas/";
    }

    final Map<String, String> dataHeader = {
      'Content-Type': 'application/json; charset-UTF=8',
    };

    final Map<String, dynamic> dataBody = {
      "fechaRadicado":
          "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}",
      "fechaPago": null,
      "valor": reserva.precioFinal,
      "estado": "Pendiente",
      "reserva": reserva.id
    };

    final Map<String, String> dataHeader2 = {
      'Content-Type': 'application/json; charset-UTF=8',
    };

    final Map<String, dynamic> dataBody2 = {
      "usuario": reserva.usuario,
      "fecha": reserva.fecha,
      "fechaEntrada": reserva.fechaEntrada,
      "fechaSalida": reserva.fechaSalida,
      "numHuespedes": reserva.numHuespedes,
      "numAdultos": reserva.numAdultos,
      "numNinos": reserva.numNinos,
      "numBebes": reserva.numBebes,
      "numMascotas": reserva.numMascotas,
      "precioFinal": reserva.precioFinal,
      "estado": "Cancelado",
      "comision": reserva.comision,
      "gananciaAnfitrion": reserva.gananciaAnfitrion,
      "sitio": reserva.sitio.id,
    };

    var respuesta = await http.post(
      Uri.parse(url),
      headers: dataHeader,
      body: json.encode(dataBody),
    );

    var respuesta2 = await http.put(
      Uri.parse(url2 + reserva.id.toString() + "/"),
      headers: dataHeader2,
      body: json.encode(dataBody2),
    );

    if (respuesta.statusCode == 201 && respuesta2.statusCode == 200) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => HomeScreenPage(
            themeManager: themeManager,
          ),
        ),
      );
    }
  }

  cancelarReserva(ReservaModel reserva, ThemeManager themeManager) async {
    String url = "";

    String url2 = "";

    String url3 = "";

    if (UniversalPlatform.isAndroid) {
      url = "http://10.0.2.2:8000/api/Devolucion/";
    } else {
      url = "http://127.0.0.1:8000/api/Devolucion/";
    }

    if (UniversalPlatform.isAndroid) {
      url2 = "http://10.0.2.2:8000/api/Reservas/";
    } else {
      url2 = "http://127.0.0.1:8000/api/Reservas/";
    }

    if (UniversalPlatform.isAndroid) {
      url3 = "http://10.0.2.2:8000/api/Multas/";
    } else {
      url3 = "http://127.0.0.1:8000/api/Multas/";
    }

    final Map<String, String> dataHeader = {
      'Content-Type': 'application/json; charset-UTF=8',
    };

    final Map<String, dynamic> dataBody = {
      "fechaRadicado":
          "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}",
      "fechaPago": null,
      "valor": (reserva.precioFinal - (reserva.precioFinal * 0.2)).toInt(),
      "estado": "Pendiente",
      "reserva": reserva.id,
    };

    final Map<String, String> dataHeader3 = {
      'Content-Type': 'application/json; charset-UTF=8',
    };

    final Map<String, dynamic> dataBody3 = {
      "fecha":
          "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}",
      "valor": (reserva.precioFinal * 0.2).toInt(),
      "valorDevolucion":
          (reserva.precioFinal - (reserva.precioFinal * 0.2)).toInt(),
      "reserva": reserva.id,
    };

    final Map<String, String> dataHeader2 = {
      'Content-Type': 'application/json; charset-UTF=8',
    };

    final Map<String, dynamic> dataBody2 = {
      "usuario": reserva.usuario,
      "fecha": reserva.fecha,
      "fechaEntrada": reserva.fechaEntrada,
      "fechaSalida": reserva.fechaSalida,
      "numHuespedes": reserva.numHuespedes,
      "numAdultos": reserva.numAdultos,
      "numNinos": reserva.numNinos,
      "numBebes": reserva.numBebes,
      "numMascotas": reserva.numMascotas,
      "precioFinal": reserva.precioFinal,
      "estado": "Cancelado",
      "comision": reserva.comision,
      "gananciaAnfitrion": reserva.gananciaAnfitrion,
      "sitio": reserva.sitio.id,
    };

    var respuesta = await http.post(
      Uri.parse(url),
      headers: dataHeader,
      body: json.encode(dataBody),
    );

    var respuesta3 = await http.post(
      Uri.parse(url3),
      headers: dataHeader3,
      body: json.encode(dataBody3),
    );

    var respuesta2 = await http.put(
      Uri.parse(url2 + reserva.id.toString() + "/"),
      headers: dataHeader2,
      body: json.encode(dataBody2),
    );

    if (respuesta.statusCode == 201 &&
        respuesta2.statusCode == 200 &&
        respuesta3.statusCode == 201) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => HomeScreenPage(
            themeManager: themeManager,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "¿Quiere cancelar esta reserva?",
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: 250,
        width: 400,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: defaultPadding,
              ),
              const Center(
                child: Text(
                  "Si decide cancelar esta reserva, es posible que se aplique una multa si la cancelación se realiza después de 48 horas. ¿Esta seguro de hacer esta operación?",
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Image.asset(
                "assets/images/logo.png",
                width: 150,
                height: 150,
              )
            ],
          ),
        ),
      ),
      actions: [
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Volver")),
            ElevatedButton(
                onPressed: () async {
                  if (DateTime.now()
                          .difference(DateTime.parse(widget.reserva.fecha))
                          .inDays >=
                      2) {
                    cancelarReserva(widget.reserva, widget.themeManager);
                  } else {
                    cancelarReservaOportuna(
                        widget.reserva, widget.themeManager);
                  }
                },
                child: const Text("Cancelar")),
          ],
        ),
      ],
    );
  }
}
