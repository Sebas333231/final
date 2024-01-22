import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/card.dart';
import 'package:proyecto_final/models/SitioModel.dart';
import 'package:proyecto_final/models/SitioVisitadoModel.dart';
import 'package:proyecto_final/models/UsuariosModel.dart';
import 'package:proyecto_final/theme/theme_constants.dart';
import 'package:proyecto_final/theme/theme_manager.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:http/http.dart' as http;

// Contenedor el cual almacenara las cards de los sitios favoritos del usuario

class VisitadoDetails extends StatefulWidget {
  final ThemeManager themeManager;

  final List<SitioVisitadoModel> listasitios;

  final List<UsuariosModel> listausuarios;

  const VisitadoDetails({
    Key? key,
    required this.themeManager,
    required this.listasitios,
    required this.listausuarios,
  }) : super(key: key);

  @override
  State<VisitadoDetails> createState() => _VisitadoDetailsState();
}

class _VisitadoDetailsState extends State<VisitadoDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (var u = 0; u < widget.listausuarios.length; u++) {
      for (var x = 0; x < widget.listasitios.length; x++) {
        if (FirebaseAuth.instance.currentUser!.email ==
            widget.listausuarios[u].correoElectronico) {
          if (widget.listasitios[x].usuario == widget.listausuarios[u].id) {
            if (DateTime.now()
                    .difference(
                        DateTime.parse(widget.listasitios[x].fechaVista))
                    .inDays >=
                2) {
              eliminarVista(widget.listasitios[x].id);
            }
          }
        }
      }
    }
  }

  eliminarVista(int id) async {
    String url = "";

    if (UniversalPlatform.isAndroid) {
      url = "http://10.0.2.2:8000/api/SitioVisitado/";
    } else {
      url = "http://127.0.0.1:8000/api/SitioVisitado/";
    }

    await http.delete(Uri.parse(url + id.toString() + "/"));
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: isDark ? secondaryColor : const Color(0xFFFF2F0F2),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: SizedBox(
        height: 625,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sitios Visitados",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: defaultPadding),
              FutureBuilder(
                  future: getSitioVisitado(),
                  builder: (context,
                      AsyncSnapshot<List<SitioVisitadoModel>> sitioVisitado) {
                    if (sitioVisitado.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (sitioVisitado.data != null) {
                      return FutureBuilder(
                          future: getUsuario(),
                          builder: (context,
                              AsyncSnapshot<List<UsuariosModel>> usuario) {
                            if (usuario.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return FutureBuilder(
                                future: getSitios(),
                                builder: (context,
                                    AsyncSnapshot<List<SitioModel>> sitio) {
                                  if (sitio.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  return GridView(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 1,
                                            childAspectRatio: 0.83),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    children: [
                                      for (var f = 0;
                                          f < sitioVisitado.data!.length;
                                          f++)
                                        for (var u = 0;
                                            u < usuario.data!.length;
                                            u++)
                                          for (var s = 0;
                                              s < sitio.data!.length;
                                              s++)
                                            if (FirebaseAuth.instance
                                                    .currentUser!.email ==
                                                usuario
                                                    .data![u].correoElectronico)
                                              if ((sitioVisitado
                                                          .data![f].sitio ==
                                                      sitio.data![s].id) &&
                                                  (sitioVisitado
                                                          .data![f].usuario ==
                                                      usuario.data![u].id))
                                                CardSite(
                                                    sitio: sitio.data![s],
                                                    usuario: usuario.data!,
                                                    themeManager:
                                                        widget.themeManager),
                                    ],
                                  );
                                });
                          });
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
