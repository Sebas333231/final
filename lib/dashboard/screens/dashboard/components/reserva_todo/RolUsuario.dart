import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:proyecto_final/HomePage/home_screens.dart';
import 'package:proyecto_final/models/UsuariosModel.dart';
import 'package:proyecto_final/theme/theme_constants.dart';
import 'package:proyecto_final/theme/theme_manager.dart';
import 'package:http/http.dart' as http;
import 'package:universal_platform/universal_platform.dart';

class RolUsuario extends StatefulWidget {
  final UsuariosModel usuario;

  final ThemeManager themeManager;

  const RolUsuario(
      {super.key, required this.usuario, required this.themeManager});

  @override
  State<RolUsuario> createState() => _RolUsuarioState();
}

class _RolUsuarioState extends State<RolUsuario> {
  List roles = [
    Roles("Usuario", false),
    Roles("Administrador", true),
  ];

  late TextEditingController rolElegido =
      TextEditingController(text: widget.usuario.rolAdmin.toString());

  String? rolValor;

  Future updateUser() async {
    try {
      final respuesta = await addUserEditDetails(
        widget.usuario.nombreCompleto,
        widget.usuario.tipoDocumento,
        widget.usuario.numeroDocumento,
        widget.usuario.correoElectronico,
        widget.usuario.telefono,
        widget.usuario.telefonoCelular,
        widget.usuario.idioma,
        widget.usuario.foto,
        widget.usuario.descripcion,
        widget.usuario.banco,
        widget.usuario.numeroCuenta,
        widget.usuario.daviplata,
        widget.usuario.fechaRegistro,
        rolElegido.text.trim(),
      );

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

  Future<int> addUserEditDetails(
    String nombreCompleto,
    String tipoDocumento,
    String numeroDocumento,
    String email,
    String telefono,
    String celular,
    String idioma,
    String imagen,
    String descripcion,
    String banco,
    String numCuenta,
    String daviplata,
    String fecha,
    String rol,
  ) async {
    String url = "";

    if (UniversalPlatform.isAndroid) {
      url = "http://10.0.2.2:8000/api/Usuarios/";
    } else {
      url = "http://127.0.0.1:8000/api/Usuarios/";
    }

    final Map<String, String> dataHeader = {
      'Content-Type': 'application/json; charset-UTF=8',
    };

    final Map<String, dynamic> dataBody = {
      "nombreCompleto": nombreCompleto,
      "tipoDocumento": tipoDocumento,
      "numeroDocumento": numeroDocumento,
      "correoElectronico": email,
      "telefono": telefono,
      "telefonoCelular": celular,
      "idioma": idioma,
      "foto": imagen,
      "rolAdmin": rol,
      "descripcion": descripcion,
      "banco": banco,
      "numeroCuenta": numCuenta,
      "daviplata": daviplata,
      "fechaRegistro": fecha,
    };

    int resultado = 0;

    try {
      final response = await http.put(
        Uri.parse(url + widget.usuario.id.toString() + "/"),
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
    rolElegido.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Cambio de rol en el aplicativo",
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
                            'Rol',
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
                    items: roles
                        .map((item) => DropdownMenuItem<String>(
                              value: item.valor.toString(),
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
                    value: rolElegido.text,
                    onChanged: (String? value) {
                      setState(() {
                        rolValor = value;
                        rolElegido.text = rolValor!;
                      });
                      if (rolValor == null || rolValor!.isEmpty) {
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
                  updateUser();
                },
                child: const Text("Guardar")),
          ],
        ),
      ],
    );
  }
}

class Roles {
  final String? titulo;
  final bool valor;

  Roles(this.titulo, this.valor);
}
