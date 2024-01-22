import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/FormularioSitio/sitio/pantallas.dart';
import 'package:proyecto_final/FormularioSitio/sitio/servicios/servicios_screen.dart';
import 'package:proyecto_final/HomePage/home_screens.dart';
import 'package:proyecto_final/models/UsuariosModel.dart';
import 'package:proyecto_final/theme/theme_manager.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:http/http.dart' as http;

class SitioForm extends StatefulWidget {
  final ThemeManager themeManager;

  const SitioForm({super.key, required this.themeManager});

  @override
  State<SitioForm> createState() => _SitioFormState();
}

class _SitioFormState extends State<SitioForm> {
  PageController? controller;
  int currentIndex = 0;

  List<Pantallas> listaPantallas = <Pantallas>[];

  @override
  void initState() {
    controller = PageController(initialPage: 0);
    super.initState();
    _pantallasSitio();
  }

  TextEditingController usuario = TextEditingController();
  TextEditingController categoria = TextEditingController();
  TextEditingController titulo = TextEditingController();
  TextEditingController numeroHuespedes = TextEditingController();
  TextEditingController numeroCamas = TextEditingController();
  TextEditingController numeroBanhos = TextEditingController();
  TextEditingController descripcionSitio = TextEditingController();
  TextEditingController valorNoche = TextEditingController();
  TextEditingController lugar = TextEditingController();
  TextEditingController descripcionLugar = TextEditingController();
  TextEditingController latitud = TextEditingController();
  TextEditingController longitud = TextEditingController();
  TextEditingController continente = TextEditingController();
  TextEditingController valorLimpieza = TextEditingController();
  TextEditingController politica = TextEditingController();
  TextEditingController habitaciones = TextEditingController();
  List<String> tituloHabitaciones = [];
  List<String> descripcionHabitaciones = [];
  List<String> imagenes = [];
  TextEditingController reglas = TextEditingController();
  TextEditingController seguridad = TextEditingController();
  List<String> nombreServicio = [];
  List<String> iconoServicio = [];
  List<String> descipcionServicio = [];

  GlobalKey<FormState> llave = GlobalKey<FormState>();

  String botonG = 'Guardar';

  void saveSite() async {
    List<UsuariosModel> usuariosLista = [];
    List<int> sitioLista = [];
    String url = "";
    String url1 = "";
    String url2 = "";
    String url3 = "";
    String url4 = "";
    String url5 = "";
    String url6 = "";
    int resultadoSitio = 0;
    int resultadoImagen = 0;
    int resultadoRegla = 0;
    int resultadoSeguridad = 0;
    int resultadoServicio = 0;

    if (UniversalPlatform.isAndroid) {
      url = "http://10.0.2.2:8000/api/Sitios/";
    } else {
      url = "http://127.0.0.1:8000/api/Sitios/";
    }

    if (UniversalPlatform.isAndroid) {
      url1 = "http://10.0.2.2:8000/api/Usuarios/";
    } else {
      url1 = "http://127.0.0.1:8000/api/Usuarios/";
    }

    if (UniversalPlatform.isAndroid) {
      url2 = "http://10.0.2.2:8000/api/Habitacion/";
    } else {
      url2 = "http://127.0.0.1:8000/api/Habitacion/";
    }

    if (UniversalPlatform.isAndroid) {
      url3 = "http://10.0.2.2:8000/api/Imagen/";
    } else {
      url3 = "http://127.0.0.1:8000/api/Imagen/";
    }

    if (UniversalPlatform.isAndroid) {
      url4 = "http://10.0.2.2:8000/api/Reglas/";
    } else {
      url4 = "http://127.0.0.1:8000/api/Reglas/";
    }

    if (UniversalPlatform.isAndroid) {
      url5 = "http://10.0.2.2:8000/api/Seguridad/";
    } else {
      url5 = "http://127.0.0.1:8000/api/Seguridad/";
    }

    if (UniversalPlatform.isAndroid) {
      url6 = "http://10.0.2.2:8000/api/Servicios/";
    } else {
      url6 = "http://127.0.0.1:8000/api/Servicios/";
    }

    final response1 = await http.get(Uri.parse(url1));

    if (response1.statusCode == 200) {
      usuariosLista.clear();

      // Decodificar la respuesta JSON
      String responseBodyUtf8 = utf8.decode(response1.bodyBytes);
      List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

      // Iterar a través de todos los usuarios en decodedData
      for (var userData in decodedData) {
        // Construir el modelo de usuario para cada usuario en la lista
        usuariosLista.add(UsuariosModel(
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

      for (var o in usuariosLista) {
        if (FirebaseAuth.instance.currentUser!.email == o.correoElectronico) {
          setState(() {
            usuario.text = o.id.toString();
          });
        }
      }
    } else {
      // Manejar el fallo de la solicitud HTTP
      throw Exception(
          'Fallo la solicitud HTTP con código ${response1.statusCode}');
    }

    int comision = (int.parse(valorNoche.text) * 0.20).toInt();

    final Map<String, String> dataHeader = {
      'Content-Type': 'application/json; charset-UTF=8',
    };

    final Map<String, dynamic> dataBody = {
      "usuario": usuario.text.trim(),
      "titulo": titulo.text.trim(),
      "numHuespedes": numeroHuespedes.text.trim(),
      "numCamas": numeroCamas.text.trim(),
      "numBanos": numeroBanhos.text.trim(),
      "descripcion": descripcionSitio.text.trim(),
      "valorNoche": valorNoche.text.trim(),
      "lugar": lugar.text.trim(),
      "desLugar": descripcionLugar.text.trim(),
      "latitud": latitud.text.trim(),
      "longitud": longitud.text.trim(),
      "continente": continente.text.trim(),
      "valorLimpieza": valorLimpieza.text.trim(),
      "comision": comision,
      "politica": politica.text.trim(),
      "categoria": categoria.text.trim(),
    };

    try {
      final responseSitio = await http.post(
        Uri.parse(url),
        headers: dataHeader,
        body: json.encode(dataBody),
      );

      setState(() {
        resultadoSitio = responseSitio.statusCode;
      });
    } catch (e) {
      print(e);
    }

    if (resultadoSitio == 201) {
      final responseSite = await http.get(Uri.parse(url));

      if (responseSite.statusCode == 200) {
        sitioLista.clear();

        String responseSiteUtf8 = utf8.decode(responseSite.bodyBytes);
        List<dynamic> siteData = jsonDecode(responseSiteUtf8);

        for (var item in siteData) {
          sitioLista.add(item['id'] ?? 0);
        }
      }

      final Map<String, String> dataHeaderRegla = {
        'Content-Type': 'application/json; charset-UTF=8',
      };

      final Map<String, dynamic> dataBodyRegla = {
        "descripcion": reglas.text.trim(),
        "sitio": sitioLista.last.toString(),
      };

      try {
        final responseRegla = await http.post(
          Uri.parse(url4),
          headers: dataHeaderRegla,
          body: json.encode(dataBodyRegla),
        );

        setState(() {
          resultadoRegla = responseRegla.statusCode;
        });
      } catch (e) {
        print(e);
      }

      final Map<String, String> dataHeaderSeguridad = {
        'Content-Type': 'application/json; charset-UTF=8',
      };

      final Map<String, dynamic> dataBodySeguridad = {
        "descripcion": seguridad.text.trim(),
        "sitio": sitioLista.last.toString(),
      };

      try {
        final responseSeguridad = await http.post(
          Uri.parse(url5),
          headers: dataHeaderSeguridad,
          body: json.encode(dataBodySeguridad),
        );

        setState(() {
          resultadoSeguridad = responseSeguridad.statusCode;
        });
      } catch (e) {
        print(e);
      }

      if (habitaciones.text == "true") {
        for (var h = 0; h < tituloHabitaciones.length; h++) {
          final Map<String, String> dataHeaderHabitacion = {
            'Content-Type': 'application/json; charset-UTF=8',
          };

          final Map<String, dynamic> dataBodyHabitacion = {
            "titulo": tituloHabitaciones[h],
            "descripcion": descripcionHabitaciones[h],
            "sitio": sitioLista.last.toString(),
          };

          try {
            await http.post(
              Uri.parse(url2),
              headers: dataHeaderHabitacion,
              body: json.encode(dataBodyHabitacion),
            );
          } catch (e) {
            print(e);
          }
        }
      }

      for (var r in imagenes) {
        final Map<String, String> dataHeaderImagen = {
          'Content-Type': 'application/json; charset-UTF=8',
        };

        final Map<String, dynamic> dataBodyImagen = {
          "direccion": r,
          "sitio": sitioLista.last.toString(),
        };

        try {
          final responseImagen = await http.post(
            Uri.parse(url3),
            headers: dataHeaderImagen,
            body: json.encode(dataBodyImagen),
          );

          setState(() {
            resultadoImagen = responseImagen.statusCode;
          });
        } catch (e) {
          print(e);
        }
      }

      for (var l = 0; l < nombreServicio.length; l++) {
        final Map<String, String> dataHeaderServicio = {
          'Content-Type': 'application/json; charset-UTF=8',
        };

        final Map<String, dynamic> dataBodyServicio = {
          "icono": iconoServicio[l],
          "nombre": nombreServicio[l],
          "descripcion": descipcionServicio[l],
          "sitio": sitioLista.last.toString(),
        };

        try {
          final responseServicio = await http.post(
            Uri.parse(url6),
            headers: dataHeaderServicio,
            body: json.encode(dataBodyServicio),
          );

          setState(() {
            resultadoServicio = responseServicio.statusCode;
          });
        } catch (e) {
          print(e);
        }
      }
    }

    if (resultadoSitio == 201 &&
        resultadoRegla == 201 &&
        resultadoSeguridad == 201 &&
        resultadoImagen == 201 &&
        resultadoServicio == 201) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => HomeScreenPage(
            themeManager: widget.themeManager,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    categoria.dispose();
    titulo.dispose();
    numeroHuespedes.dispose();
    numeroCamas.dispose();
    numeroBanhos.dispose();
    descripcionSitio.dispose();
    valorNoche.dispose();
    lugar.dispose();
    descripcionLugar.dispose();
    latitud.dispose();
    longitud.dispose();
    continente.dispose();
    valorLimpieza.dispose();
    politica.dispose();
    habitaciones.dispose();
    reglas.dispose();
    seguridad.dispose();
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, responsive) {
        if (responsive.maxWidth >= 1000) {
          return Scaffold(
              backgroundColor: Colors.black,
              body: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/fondo1.webp'),
                          fit: BoxFit.cover)),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      child: Center(
                        child: Container(
                          width: 500,
                          decoration: BoxDecoration(
                            color: const Color(0x2ADAD7D7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 6,
                                  child: PageView.builder(
                                      controller: controller,
                                      itemCount: listaPantallas.length,
                                      onPageChanged: (int index) {
                                        if (index >= currentIndex) {
                                          setState(() {
                                            currentIndex = index;
                                          });
                                        } else {
                                          setState(() {
                                            currentIndex = index;
                                          });
                                        }
                                      },
                                      itemBuilder: (context, index) {
                                        return SingleChildScrollView(
                                            child: Column(
                                          children: [
                                            listaPantallas[index].pantalla,
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ));
                                      })),
                              Expanded(
                                  flex: -1,
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Row(
                                              children: List.generate(
                                                  listaPantallas.length,
                                                  (index) =>
                                                      buildDot(index, context)),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              //if (llave.currentState!.validate()) {
                                              if (currentIndex ==
                                                  listaPantallas.length - 1) {
                                                setState(() {
                                                  botonG = "Cargando";
                                                });
                                                saveSite();
                                              }
                                              controller!.nextPage(
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.easeInOut);
                                              // }
                                            },
                                            child: Container(
                                              width: 90,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFAD974F),
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.white,
                                                    offset: Offset(
                                                      1.0,
                                                      1.0,
                                                    ),
                                                    blurRadius: 8.0,
                                                    spreadRadius: 2.0,
                                                  ), //BoxShadow
                                                ],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  currentIndex == 4
                                                      ? botonG
                                                      : 'Continuar',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white
                                                      //fontFamily: 'CedarvilleCursive'
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )))
                            ],
                          ),
                        ),
                      ))));
        } else if (responsive.maxWidth == 280) {
          return Scaffold(
              backgroundColor: Colors.black,
              body: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/fondo1.webp'),
                          fit: BoxFit.cover)),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Center(
                        child: Container(
                          width: 500,
                          decoration: BoxDecoration(
                            color: const Color(0x2ADAD7D7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 6,
                                  child: PageView.builder(
                                      controller: controller,
                                      itemCount: listaPantallas.length,
                                      onPageChanged: (int index) {
                                        if (index >= currentIndex) {
                                          setState(() {
                                            currentIndex = index;
                                          });
                                        } else {
                                          setState(() {
                                            currentIndex = index;
                                          });
                                        }
                                      },
                                      itemBuilder: (context, index) {
                                        return SingleChildScrollView(
                                            child: Column(
                                          children: [
                                            listaPantallas[index].pantalla,
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ));
                                      })),
                              Expanded(
                                  flex: -1,
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Row(
                                              children: List.generate(
                                                  listaPantallas.length,
                                                  (index) =>
                                                      buildDot(index, context)),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              //if (llave.currentState!.validate()) {
                                              if (currentIndex ==
                                                  listaPantallas.length - 1) {
                                                setState(() {
                                                  botonG = "Cargando";
                                                });
                                                saveSite();
                                              }
                                              controller!.nextPage(
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.easeInOut);
                                              // }
                                            },
                                            child: Container(
                                              width: 90,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFAD974F),
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.white,
                                                    offset: Offset(
                                                      1.0,
                                                      1.0,
                                                    ),
                                                    blurRadius: 8.0,
                                                    spreadRadius: 2.0,
                                                  ), //BoxShadow
                                                ],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  currentIndex == 4
                                                      ? botonG
                                                      : 'Continuar',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white
                                                      //fontFamily: 'CedarvilleCursive'
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )))
                            ],
                          ),
                        ),
                      ))));
        } else if (responsive.maxWidth >= 700 || responsive.maxWidth <= 999) {
          return Scaffold(
              backgroundColor: Colors.black,
              body: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/fondo1.webp'),
                          fit: BoxFit.cover)),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 50),
                      child: Center(
                        child: Container(
                          width: 600,
                          decoration: BoxDecoration(
                            color: const Color(0x2ADAD7D7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 6,
                                  child: PageView.builder(
                                      controller: controller,
                                      itemCount: listaPantallas.length,
                                      onPageChanged: (int index) {
                                        if (index >= currentIndex) {
                                          setState(() {
                                            currentIndex = index;
                                          });
                                        } else {
                                          setState(() {
                                            currentIndex = index;
                                          });
                                        }
                                      },
                                      itemBuilder: (context, index) {
                                        return SingleChildScrollView(
                                            child: Column(
                                          children: [
                                            listaPantallas[index].pantalla,
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ));
                                      })),
                              Expanded(
                                  flex: -1,
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Row(
                                              children: List.generate(
                                                  listaPantallas.length,
                                                  (index) =>
                                                      buildDot(index, context)),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              //if (llave.currentState!.validate()) {
                                              if (currentIndex ==
                                                  listaPantallas.length - 1) {
                                                setState(() {
                                                  botonG = "Cargando";
                                                });
                                                saveSite();
                                              }
                                              controller!.nextPage(
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.easeInOut);
                                              // }
                                            },
                                            child: Container(
                                              width: 90,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFAD974F),
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.white,
                                                    offset: Offset(
                                                      1.0,
                                                      1.0,
                                                    ),
                                                    blurRadius: 8.0,
                                                    spreadRadius: 2.0,
                                                  ), //BoxShadow
                                                ],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  currentIndex == 4
                                                      ? botonG
                                                      : 'Continuar',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white
                                                      //fontFamily: 'CedarvilleCursive'
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )))
                            ],
                          ),
                        ),
                      ))));
        } else {
          return Scaffold(
              backgroundColor: Colors.black,
              body: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/fondo1.webp'),
                          fit: BoxFit.cover)),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      child: Center(
                        child: Container(
                          width: 500,
                          decoration: BoxDecoration(
                            color: const Color(0x2ADAD7D7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 6,
                                  child: PageView.builder(
                                      controller: controller,
                                      itemCount: listaPantallas.length,
                                      onPageChanged: (int index) {
                                        if (index >= currentIndex) {
                                          setState(() {
                                            currentIndex = index;
                                          });
                                        } else {
                                          setState(() {
                                            currentIndex = index;
                                          });
                                        }
                                      },
                                      itemBuilder: (context, index) {
                                        return SingleChildScrollView(
                                            child: Column(
                                          children: [
                                            listaPantallas[index].pantalla,
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ));
                                      })),
                              Expanded(
                                  flex: -1,
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Row(
                                              children: List.generate(
                                                  listaPantallas.length,
                                                  (index) =>
                                                      buildDot(index, context)),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              //if (llave.currentState!.validate()) {
                                              if (currentIndex ==
                                                  listaPantallas.length - 1) {
                                                setState(() {
                                                  botonG = "Cargando";
                                                });
                                                saveSite();
                                              }
                                              controller!.nextPage(
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.easeInOut);
                                              // }
                                            },
                                            child: Container(
                                              width: 90,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFAD974F),
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.white,
                                                    offset: Offset(
                                                      1.0,
                                                      1.0,
                                                    ),
                                                    blurRadius: 8.0,
                                                    spreadRadius: 2.0,
                                                  ), //BoxShadow
                                                ],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  currentIndex == 4
                                                      ? botonG
                                                      : 'Continuar',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white
                                                      //fontFamily: 'CedarvilleCursive'
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )))
                            ],
                          ),
                        ),
                      ))));
        }
      },
    );
  }

  void _pantallasSitio() {
    var lista = <Pantallas>[
      Pantallas(
          pantalla: Form(
        key: llave,
        child: PantallaPageOne(
            categoriaController: categoria,
            titulo: titulo,
            numeroHuespedes: numeroHuespedes,
            numeroCamas: numeroCamas,
            numeroBanhos: numeroBanhos,
            descripcionSitio: descripcionSitio),
      )),
      Pantallas(
          pantalla: Form(
        key: llave,
        child: PantallaPageTwo(
            valorNoche: valorNoche,
            lugar: lugar,
            descripcionLugar: descripcionLugar,
            latitud: latitud,
            longitud: longitud,
            continenteController: continente),
      )),
      Pantallas(
          pantalla: Form(
        key: llave,
        child: PantallaPageThree(
            valorLimpieza: valorLimpieza,
            politica: politica,
            habitaciones: habitaciones,
            tituloHabitaciones: tituloHabitaciones,
            descripcionHabitaciones: descripcionHabitaciones,
            imagenes: imagenes),
      )),
      Pantallas(
          pantalla: Servicios(
        nombreServicio: nombreServicio,
        iconoServicio: iconoServicio,
        descipcionServicio: descipcionServicio,
      )),
      Pantallas(
          pantalla: Form(
        key: llave,
        child: PantallaPageFour(reglas: reglas, seguridad: seguridad),
      ))
      //Pantallas(pantalla: SelectedItemsView(selectedItems))
    ];

    setState(() {
      listaPantallas = lista;
    });
  }

  AnimatedContainer buildDot(int Index, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      height: 8,
      width: currentIndex == Index ? 24 : 8,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: currentIndex == Index ? Colors.grey : Colors.grey),
    );
  }
}

class Pantallas {
  Widget pantalla;

  Pantallas({required this.pantalla});
}
