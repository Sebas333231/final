import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:proyecto_final/HomePage/home_screens.dart';
import 'package:proyecto_final/models/DevolucionModel.dart';
import 'package:proyecto_final/theme/theme_constants.dart';
import 'package:proyecto_final/theme/theme_manager.dart';
import 'package:http/http.dart' as http;
import 'package:universal_platform/universal_platform.dart';

class ActualizarDevoluciones extends StatefulWidget {
  final DevolucionModel devolucionModel;

  final ThemeManager themeManager;

  const ActualizarDevoluciones(
      {super.key, required this.devolucionModel, required this.themeManager});

  @override
  State<ActualizarDevoluciones> createState() => _RolUsuarioState();
}

class _RolUsuarioState extends State<ActualizarDevoluciones> {
  List devo = [
    ActualizarDevo("Pendiente", false),
    ActualizarDevo("Finalizado", true),
  ];

  late TextEditingController estadoDevolu =
      TextEditingController(text: widget.devolucionModel.estado);

  late TextEditingController fechaDevolu =
      TextEditingController(text: widget.devolucionModel.fechaPago);

  String? estadoDevo;

  Future updateDevoluciones() async {
    if (estadoDevolu.text == "Finalizado") {
      fechaDevolu.text =
          "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}";
    }

    try {
      final respuesta = await addActulizarDevoluciones(
          widget.devolucionModel.fechaRadicado,
          fechaDevolu.text.trim(),
          widget.devolucionModel.valor.toString(),
          widget.devolucionModel.reserva.id.toString(),
          estadoDevolu.text.trim());

      if (respuesta == 200) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomeScreenPage(
                  themeManager: widget.themeManager,
                )));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<int> addActulizarDevoluciones(
    String fechaRadicado,
    String fechaPago,
    String valor,
    String reserva,
    String estadoController,
  ) async {
    String url = "";

    if (UniversalPlatform.isAndroid) {
      url = "http://10.0.2.2:8000/api/Devolucion/";
    } else {
      url = "http://127.0.0.1:8000/api/Devolucion/";
    }

    final Map<String, String> dataHeader = {
      'Content-Type': 'application/json; charset-UTF=8',
    };

    final Map<String, dynamic> dataBody = {
      "fechaRadicado": fechaRadicado,
      "fechaPago": estadoDevolu.text == "Finalizado" ? fechaPago : null,
      "valor": valor,
      "estado": estadoController,
      "reserva": reserva,
    };

    int resultado = 0;

    try {
      final response = await http.put(
        Uri.parse(url + widget.devolucionModel.id.toString() + "/"),
        headers: dataHeader,
        body: json.encode(dataBody),
      );

      setState(() {
        resultado = response.statusCode;
      });
    } catch (e) {
      print(e);
    }

    return resultado;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    estadoDevolu.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Actualizacion de las Devoluciones",
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
              Image.asset(
                "assets/images/logo.png",
                width: 150,
                height: 150,
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Estado: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: devo
                        .map((item) => DropdownMenuItem<String>(
                              value: item.titulo,
                              child: Text(
                                item.titulo,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: estadoDevolu.text,
                    onChanged: (String? value) {
                      setState(() {
                        estadoDevo = value;
                        estadoDevolu.text = estadoDevo!;
                      });
                      if (estadoDevo == null || estadoDevo!.isEmpty) {
                        return;
                      }
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 50,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.black26,
                        ),
                        color: Colors.white,
                      ),
                      elevation: 2,
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                      ),
                      iconSize: 14,
                      iconEnabledColor: Colors.black,
                      iconDisabledColor: Colors.grey,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white,
                      ),
                      offset: const Offset(-20, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all<double>(6),
                        thumbVisibility: MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                    ),
                  ),
                ),
              ),
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
                child: const Text("Cancelar")),
            ElevatedButton(
                onPressed: () {
                  updateDevoluciones();
                },
                child: const Text("Guardar")),
          ],
        ),
      ],
    );
  }
}

class ActualizarDevo {
  final String? titulo;
  final bool valor;

  ActualizarDevo(this.titulo, this.valor);
}
