import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/LoginUsuario/Login/LoginAndRegister.dart';
import 'package:proyecto_final/models/FavoritoModel.dart';
import 'package:proyecto_final/models/SitioModel.dart';
import 'package:proyecto_final/models/UsuariosModel.dart';
import 'package:proyecto_final/theme/theme_constants.dart';
import 'package:proyecto_final/theme/theme_manager.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class IconsMobile extends StatefulWidget {
  final SitioModel sitio;

  final List<UsuariosModel> usuario;

  final ThemeManager themeManager;

  const IconsMobile({
    super.key,
    required this.sitio,
    required this.usuario,
    required this.themeManager,
  });

  @override
  State<IconsMobile> createState() => _IconsMobileState();
}

class _IconsMobileState extends State<IconsMobile> {
  late bool isFavorite = false;

  TextEditingController telefono = TextEditingController();

  registerFavorito(int sitio, int usuario) async {
    String url = "";

    if (UniversalPlatform.isAndroid) {
      url = "http://10.0.2.2:8000/api/Favoritos/";
    } else {
      url = "http://127.0.0.1:8000/api/Favoritos/";
    }

    final Map<String, String> dataHeader = {
      'Content-Type': 'application/json; charset-UTF=8',
    };

    final Map<String, dynamic> dataBody = {
      "usuario": usuario,
      "sitio": sitio,
    };

    try {
      await http.post(
        Uri.parse(url),
        headers: dataHeader,
        body: json.encode(dataBody),
      );
    } catch (e) {
      print(e);
    }
  }

  deleteFavorito(int id) async {
    String url = "";

    if (UniversalPlatform.isAndroid) {
      url = "http://10.0.2.2:8000/api/Favoritos/";
    } else {
      url = "http://127.0.0.1:8000/api/Favoritos/";
    }

    await http.delete(Uri.parse(url + id.toString() + "/"));
  }

  @override
  Widget build(BuildContext context) {
    late FavoritoModel favoritos;

    return FutureBuilder(
        future: getFavorito(),
        builder: (context, AsyncSnapshot<List<FavoritoModel>> favorito) {
          if (favorito.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          for (var uf = 0; uf < widget.usuario.length; uf++) {
            for (var f = 0; f < favorito.data!.length; f++) {
              if (FirebaseAuth.instance.currentUser!.email ==
                  widget.usuario[uf].correoElectronico) {
                if ((favorito.data![f].sitio == widget.sitio.id) &&
                    (favorito.data![f].usuario == widget.usuario[uf].id)) {
                  favoritos = favorito.data![f];
                  isFavorite = true;
                }
              }
            }
          }

          return Container(
            padding: const EdgeInsets.only(left: 60, right: 60),
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _modalCompartir(context, widget.sitio, telefono);
                    },
                    icon: const Icon(
                      Icons.share_outlined,
                      color: primaryColor,
                    ),
                  ),
                  const Text("Compartir"),
                  const SizedBox(
                    width: defaultPadding,
                  ),
                  IconButton(
                    onPressed: () async {
                      if (FirebaseAuth.instance.currentUser != null) {
                        if (isFavorite == true) {
                          deleteFavorito(favoritos.id);
                          setState(() {
                            isFavorite = false;
                          });
                        } else if (isFavorite == false) {
                          for (var us = 0; us < widget.usuario.length; us++) {
                            if (FirebaseAuth.instance.currentUser!.email ==
                                widget.usuario[us].correoElectronico) {
                              registerFavorito(
                                  widget.sitio.id, widget.usuario[us].id);
                              setState(() {
                                isFavorite = true;
                              });
                            }
                          }
                        }
                      } else {
                        _modalIniciarSesion(context, widget.themeManager);
                      }
                    },
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? primaryColor : primaryColor,
                    ),
                  ),
                  const Text("Favoritos"),
                ],
              ),
            ),
          );
        });
  }

  void _modalIniciarSesion(BuildContext context, ThemeManager themeManager) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "¿Quiere realizar esta acción?",
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
                        "Para llevar a cabo esta acción, es necesario iniciar sesión primero.",
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
                      child: const Text("Cancelar")),
                  ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                LoginPage(themeManager: themeManager),
                          ),
                        );
                      },
                      child: const Text("Iniciar Sesión")),
                ],
              ),
            ],
          );
        });
  }
}

void _modalCompartir(
    BuildContext context, SitioModel sitio, TextEditingController telefono) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "¿Quieres compartir informacion acerca del sitio?",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            height: 200,
            width: 350,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  const Center(
                    child: Text(
                      "A continuacion puedes digitar el numero de whatsapp de la persona a la cual usted desea compartir la informacion del sito.",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.black),
                          controller: telefono,
                          obscureText: false,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: 'Ingrese el numero de telefono',
                            hintStyle: const TextStyle(color: Colors.black),
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                          keyboardType: TextInputType.text,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Se requiere de este campo';
                            }
                            return null;
                          },
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
                    onPressed: () async {
                      //creación variables Firebase
                      String pedido = "";

                      pedido = "${pedido} El sitio se llama ${sitio.titulo}" +
                          "\n  tiene una excelente ubicacion en ${sitio.lugar} " +
                          "\n tiene una capacidad de ${sitio.numHuespedes} huespedes y su precio es muy accesible con un costo de ${sitio.valorNocheFormatted} la noche. ¡Que esperas para reservarlo!";
                      // vincular whatsapp

                      String celular_2 = telefono.text;
                      String mensaje = pedido;
                      String url = "https://wa.me/${celular_2}?text=${mensaje}";
                      final Uri _url = Uri.parse(url);

                      await launchUrl(_url);
                      log(pedido);
                    },
                    child: const Text("Enviar")),
              ],
            ),
          ],
        );
      });
}
