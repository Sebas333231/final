import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/HomePage/home_screens.dart';
import 'package:proyecto_final/LoginUsuario/Login/LoginAndRegister.dart';
import 'package:proyecto_final/details/detailsPage.dart';
import 'package:proyecto_final/models/ComentarioModel.dart';
import 'package:proyecto_final/models/FavoritoModel.dart';
import 'package:proyecto_final/models/ImagenModel.dart';
import 'package:proyecto_final/models/ReservaModel.dart';
import 'package:proyecto_final/models/SitioModel.dart';
import 'package:proyecto_final/models/SitioVisitadoModel.dart';
import 'package:proyecto_final/models/UsuariosModel.dart';
import 'package:proyecto_final/theme/theme_constants.dart';
import 'package:proyecto_final/theme/theme_manager.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart' as firabase_storage;

// diseño de la card de vista previa de todos los sitios del anfitrion

class SitioAnfCard extends StatefulWidget {
  final SitioModel sitio;
  final List<UsuariosModel> usuario;
  final bool favorito;
  final ThemeManager themeManager;

  const SitioAnfCard({
    Key? key,
    required this.sitio,
    required this.favorito,
    required this.usuario,
    required this.themeManager,
  }) : super(key: key);

  @override
  State<SitioAnfCard> createState() => _SitioAnfCardState();
}

class _SitioAnfCardState extends State<SitioAnfCard> {
  late bool isFavorite = false;

  PageController? controller;
  int currentIndex = 0;

  @override
  void initState() {
    controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

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

  registerSitioVisitado(int sitio, int usuario) async {
    String url = "";

    if (UniversalPlatform.isAndroid) {
      url = "http://10.0.2.2:8000/api/SitioVisitado/";
    } else {
      url = "http://127.0.0.1:8000/api/SitioVisitado/";
    }

    final Map<String, String> dataHeader = {
      'Content-Type': 'application/json; charset-UTF=8',
    };

    final Map<String, dynamic> dataBody = {
      "fechaVista":
          "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}",
      "sitio": sitio,
      "usuario": usuario,
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

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    List<String> listaImagen = [];

    late FavoritoModel favoritos;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AspectRatio(
          aspectRatio: 0.83,
          child: FutureBuilder(
              future: getSitioVisitado(),
              builder: (context,
                  AsyncSnapshot<List<SitioVisitadoModel>> sitioVisitado) {
                if (sitioVisitado.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return FutureBuilder(
                    future: getFavorito(),
                    builder:
                        (context, AsyncSnapshot<List<FavoritoModel>> favorito) {
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
                                (favorito.data![f].usuario ==
                                    widget.usuario[uf].id)) {
                              favoritos = favorito.data![f];
                              isFavorite = true;
                            }
                          }
                        }
                      }

                      return FutureBuilder(
                          future: getComentarios(),
                          builder: (context,
                              AsyncSnapshot<List<ComentarioModel>> comentario) {
                            if (comentario.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            int totalComentarios = 0;
                            double totalLimpieza = 0.0;
                            double totalComunicacion = 0.0;
                            double totalLlegada = 0.0;
                            double totalFiabilidad = 0.0;
                            double totalUbicacion = 0.0;
                            double totalPrecio = 0.0;

                            for (var z = 0; z < comentario.data!.length; z++) {
                              if (widget.sitio.id ==
                                  comentario.data![z].sitio.id) {
                                totalComentarios++;
                                totalLimpieza +=
                                    comentario.data![z].calLimpieza;
                                totalComunicacion +=
                                    comentario.data![z].calComunicacion;
                                totalLlegada += comentario.data![z].calLlegada;
                                totalFiabilidad +=
                                    comentario.data![z].calFiabilidad;
                                totalUbicacion +=
                                    comentario.data![z].calUbicacion;
                                totalPrecio += comentario.data![z].calPrecio;
                              }
                            }

                            double avgLimpieza =
                                totalLimpieza / totalComentarios;
                            double avgComunicacion =
                                totalComunicacion / totalComentarios;
                            double avgLlegada = totalLlegada / totalComentarios;
                            double avgFiabilidad =
                                totalFiabilidad / totalComentarios;
                            double avgUbicacion =
                                totalUbicacion / totalComentarios;
                            double avgPrecio = totalPrecio / totalComentarios;

                            double avgTotal = (avgLimpieza +
                                    avgComunicacion +
                                    avgLlegada +
                                    avgFiabilidad +
                                    avgUbicacion +
                                    avgPrecio) /
                                6;

                            return FutureBuilder(
                                future: getImagen(),
                                builder: (context,
                                    AsyncSnapshot<List<ImagenModel>> imagen) {
                                  if (imagen.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  for (var h = 0;
                                      h < imagen.data!.length;
                                      h++) {
                                    if (widget.sitio.id ==
                                        imagen.data![h].sitio) {
                                      listaImagen
                                          .add(imagen.data![h].direccion);
                                    }
                                  }

                                  return InkWell(
                                    onTap: () {
                                      if (FirebaseAuth.instance.currentUser !=
                                          null) {
                                        for (var u = 0;
                                            u < widget.usuario.length;
                                            u++) {
                                          if (FirebaseAuth.instance.currentUser!
                                                  .email ==
                                              widget.usuario[u]
                                                  .correoElectronico) {
                                            if (sitioVisitado.data == null ||
                                                sitioVisitado.data!.isEmpty) {
                                              // Si sitioVisitado.data es nulo o está vacío, registra la visita una sola vez
                                              registerSitioVisitado(
                                                  widget.sitio.id,
                                                  widget.usuario[u].id);
                                            } else {
                                              // Si sitioVisitado.data tiene elementos, verifica si el usuario ya ha visitado el sitio
                                              bool usuarioHaVisitadoSitio =
                                                  sitioVisitado.data!
                                                      .any((registro) {
                                                return (registro.sitio ==
                                                        widget.sitio.id) &&
                                                    (registro.usuario ==
                                                        widget.usuario[u].id);
                                              });

                                              // Si el usuario no ha visitado el sitio, registra la visita
                                              if (!usuarioHaVisitadoSitio) {
                                                registerSitioVisitado(
                                                    widget.sitio.id,
                                                    widget.usuario[u].id);
                                              }
                                            }
                                          }
                                        }
                                      }

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (builder) => DetailsPage(
                                                    sitio: widget.sitio,
                                                    usuario: usuario,
                                                    themeManager:
                                                        widget.themeManager,
                                                  )));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: isDark
                                            ? secondaryColor
                                            : const Color(0xFFFF2F0F2),
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: primaryColor.withOpacity(1),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: const Offset(0, 0),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Stack(
                                              children: [
                                                PageView.builder(
                                                    controller: controller,
                                                    itemCount: 3,
                                                    onPageChanged: (int index) {
                                                      if (index >=
                                                          currentIndex) {
                                                        setState(() {
                                                          currentIndex = index;
                                                        });
                                                      } else {
                                                        setState(() {
                                                          currentIndex = index;
                                                        });
                                                      }
                                                    },
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          height: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .height,
                                                          decoration:
                                                              BoxDecoration(
                                                                  image:
                                                                      DecorationImage(
                                                                          image:
                                                                              NetworkImage(
                                                                            listaImagen[index],
                                                                          ),
                                                                          fit: BoxFit
                                                                              .cover),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15)),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child: Stack(
                                                                  children: [
                                                                    Positioned(
                                                                      top: 10,
                                                                      right: 5,
                                                                      child:
                                                                          IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          isFavorite
                                                                              ? Icons.favorite
                                                                              : Icons.favorite_border,
                                                                          color: isFavorite
                                                                              ? primaryColor
                                                                              : Colors.white,
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          if (FirebaseAuth.instance.currentUser !=
                                                                              null) {
                                                                            if (isFavorite ==
                                                                                true) {
                                                                              deleteFavorito(favoritos.id);
                                                                              setState(() {
                                                                                isFavorite = false;
                                                                              });
                                                                            } else if (isFavorite ==
                                                                                false) {
                                                                              for (var us = 0; us < widget.usuario.length; us++) {
                                                                                if (FirebaseAuth.instance.currentUser!.email == widget.usuario[us].correoElectronico) {
                                                                                  registerFavorito(widget.sitio.id, widget.usuario[us].id);
                                                                                  setState(() {
                                                                                    isFavorite = true;
                                                                                  });
                                                                                }
                                                                              }
                                                                            }
                                                                          } else {
                                                                            _modalIniciarSesion(context,
                                                                                widget.themeManager);
                                                                          }
                                                                        },
                                                                        iconSize:
                                                                            25.0,
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                      top: 10,
                                                                      left: 5,
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          const Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                Colors.white,
                                                                            size:
                                                                                17,
                                                                          ),
                                                                          const SizedBox(
                                                                              width: 4),
                                                                          Text(
                                                                            "${avgTotal.isNaN ? 0.0 : avgTotal.toStringAsFixed(1)}",
                                                                            style: const TextStyle(
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.normal,
                                                                                color: Colors.white),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(bottom: 10),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: List.generate(3, (index) => buildDot(index, context)),
                                                                            ))
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ));
                                                    }),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              top: 15),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              widget
                                                                  .sitio.lugar,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10, top: 2),
                                                    child: Text(
                                                      widget.sitio.titulo,
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20, left: 10),
                                                    child: Text(
                                                      "Categoría: ${widget.sitio.categoria.nombre}",
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 2, left: 10),
                                                    child: Text(
                                                      "Huespedes: ${widget.sitio.numHuespedes}",
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 2, left: 10),
                                                    child: Text(
                                                      " \$  ${widget.sitio.valorNocheFormatted} Noche",
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          });
                    });
              }),
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        FutureBuilder(
            future: getImagen(),
            builder: (context, AsyncSnapshot<List<ImagenModel>> imagen) {
              if (imagen.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return FutureBuilder(
                  future: getReservas(),
                  builder:
                      (context, AsyncSnapshot<List<ReservaModel>> reserva) {
                    if (reserva.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: primaryColor,
                                offset: Offset(
                                  2.0,
                                  2.0,
                                ),
                                blurRadius: 3.0,
                                spreadRadius: 1.0,
                              ), //BoxShadow
                              BoxShadow(
                                color: primaryColor,
                                offset: Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ), //BoxShadow
                            ],
                            color: isDark ? secondaryColor : Colors.white,
                          ),
                          child: IconButton(
                              onPressed: () {
                                bool reservaSitio = false;

                                for (var x = 0; x < reserva.data!.length; x++) {
                                  if (reserva.data![x].estado == "Activo" &&
                                      reserva.data![x].sitio.id ==
                                          widget.sitio.id) {
                                    setState(() {
                                      reservaSitio = true;
                                    });
                                  }
                                }

                                if (reservaSitio) {
                                  _modalSitioActivo(context);
                                } else {
                                  _modalBorrarSitio(context, widget.sitio,
                                      imagen.data!, widget.themeManager);
                                }
                              },
                              icon: const Icon(Icons.delete,
                                  size: 25, color: primaryColor)),
                        ),
                      ],
                    );
                  });
            }),
        const SizedBox(
          height: defaultPadding,
        )
      ],
    );
  }

  AnimatedContainer buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      height: 8,
      width: currentIndex == index ? 14 : 8,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: currentIndex == index ? Colors.white : Colors.grey),
    );
  }

  void _modalSitioActivo(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "¿Hay reservas activas de este sitio?",
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
                        "Existen reservas activas vinculadas a este sitio; será necesario esperar a que estas finalicen o se cancelen.",
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
                      child: const Text("Aceptar")),
                ],
              ),
            ],
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

  void _modalBorrarSitio(BuildContext context, SitioModel sitio,
      List<ImagenModel> imagen, ThemeManager themeManager) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "¿Quiere eliminar este sitio?",
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
                        "Si elimina este sitio no hay marcha atras. ¿Esta seguro de hacer esta operación?",
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
                        bool borrarImagen = true;

                        for (var i = 0; i < imagen.length; i++) {
                          if (imagen[i].sitio == sitio.id) {
                            firabase_storage.Reference storageReference =
                                firabase_storage.FirebaseStorage.instance
                                    .refFromURL(imagen[i].direccion);

                            try {
                              await storageReference.delete();
                            } catch (e) {
                              print("Error al eliminar imagen: $e");
                              setState(() {
                                borrarImagen = false;
                              });
                              break; // Si hay un error, sal del bucle
                            }
                          }
                        }

                        if (borrarImagen == true) {
                          String url = "";

                          if (UniversalPlatform.isAndroid) {
                            url = "http://10.0.2.2:8000/api/Sitios/";
                          } else {
                            url = "http://127.0.0.1:8000/api/Sitios/";
                          }

                          final response = await http.delete(
                              Uri.parse(url + sitio.id.toString() + "/"));

                          if (response.statusCode == 204) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => HomeScreenPage(
                                  themeManager: themeManager,
                                ),
                              ),
                            );
                          }
                        }
                      },
                      child: const Text("Eliminar")),
                ],
              ),
            ],
          );
        });
  }
}
