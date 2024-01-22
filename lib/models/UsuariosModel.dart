import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:universal_platform/universal_platform.dart';

class UsuariosModel {
  final int id;
  final String nombreCompleto;
  final String tipoDocumento;
  final String numeroDocumento;
  final String correoElectronico;
  final String telefono;
  final String telefonoCelular;
  final String idioma;
  final String foto;
  final bool rolAdmin;
  final String descripcion;
  final String banco;
  final String numeroCuenta;
  final String daviplata;
  final String fechaRegistro;

  const UsuariosModel({
    required this.id,
    required this.nombreCompleto,
    required this.tipoDocumento,
    required this.numeroDocumento,
    required this.correoElectronico,
    required this.telefono,
    required this.telefonoCelular,
    required this.idioma,
    required this.foto,
    required this.rolAdmin,
    required this.descripcion,
    required this.banco,
    required this.numeroCuenta,
    required this.daviplata,
    required this.fechaRegistro,
  });
}

List<UsuariosModel> usuario = [];

Future<List<UsuariosModel>> getUsuario() async {
  String url = "";

  if (UniversalPlatform.isAndroid) {
    url = "http://10.0.2.2:8000/api/Usuarios/";
  } else {
    url = "http://127.0.0.1:8000/api/Usuarios/";
  }
  
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    usuario.clear();

    // Decodificar la respuesta JSON
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Iterar a través de todos los usuarios en decodedData
    for (var userData in decodedData) {
      // Construir el modelo de usuario para cada usuario en la lista
      usuario.add(UsuariosModel(
        id: userData['id'] ?? 0,
        nombreCompleto: userData['nombreCompleto'] ?? "",
        tipoDocumento: userData['tipoDocumento'] ?? "",
        numeroDocumento: userData['numeroDocumento'] ?? "",
        correoElectronico: userData['correoElectronico'] ?? "",
        telefono: userData['telefono'] ?? "",
        telefonoCelular: userData['telefonoCelular'] ?? "",
        idioma: userData['idioma'] ?? "",
        foto: userData['foto'] ?? "",
        rolAdmin: userData['rolAdmin'] ?? false,
        descripcion: userData['descripcion'] ?? "",
        banco: userData['banco'] ?? "",
        numeroCuenta: userData['numeroCuenta'] ?? "",
        daviplata: userData['daviplata'] ?? "",
        fechaRegistro: userData['fechaRegistro'] ?? "",
      ));
    }

    return usuario;
  } else {
    // Manejar el fallo de la solicitud HTTP
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
