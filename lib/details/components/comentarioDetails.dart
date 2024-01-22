import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/LoginUsuario/Login/LoginAndRegister.dart';
import 'package:proyecto_final/details/components/comentarioForm.dart';
import 'package:proyecto_final/models/ComentarioModel.dart';
import 'package:proyecto_final/models/SitioModel.dart';
import 'package:proyecto_final/models/UsuariosModel.dart';
import 'package:proyecto_final/responsive.dart';
import 'package:proyecto_final/theme/theme_constants.dart';
import 'package:proyecto_final/theme/theme_manager.dart';

class ComentarioDetails extends StatefulWidget {
  final SitioModel sitio;

  final List<UsuariosModel> usuario;

  final ThemeManager themeManager;

  const ComentarioDetails({
    super.key,
    required this.sitio,
    required this.usuario,
    required this.themeManager,
  });

  @override
  State<ComentarioDetails> createState() => _ComentarioDetailsState();
}

class _ComentarioDetailsState extends State<ComentarioDetails> {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return FutureBuilder(
        future: getComentarios(),
        builder: (context, AsyncSnapshot<List<ComentarioModel>> comentario) {
          if (comentario.connectionState == ConnectionState.waiting) {
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

          List<ComentarioModel> comentarioLista = [];

          for (var z = 0; z < comentario.data!.length; z++) {
            if (widget.sitio.id == comentario.data![z].sitio.id) {
              totalComentarios++;
              totalLimpieza += comentario.data![z].calLimpieza;
              totalComunicacion += comentario.data![z].calComunicacion;
              totalLlegada += comentario.data![z].calLlegada;
              totalFiabilidad += comentario.data![z].calFiabilidad;
              totalUbicacion += comentario.data![z].calUbicacion;
              totalPrecio += comentario.data![z].calPrecio;
              comentarioLista.add(comentario.data![z]);
            }
          }

          double avgLimpieza = totalLimpieza / totalComentarios;
          double avgComunicacion = totalComunicacion / totalComentarios;
          double avgLlegada = totalLlegada / totalComentarios;
          double avgFiabilidad = totalFiabilidad / totalComentarios;
          double avgUbicacion = totalUbicacion / totalComentarios;
          double avgPrecio = totalPrecio / totalComentarios;

          double avgTotal = (avgLimpieza +
                  avgComunicacion +
                  avgLlegada +
                  avgFiabilidad +
                  avgUbicacion +
                  avgPrecio) /
              6;

          return Column(
            children: [
              SizedBox(
                width: 500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Image.asset(
                          "assets/images/olivo1.png",
                          width: 100,
                          height: 200,
                        )),
                        Text(
                          "${avgTotal.isNaN ? 0.0 : avgTotal.toStringAsFixed(1)}",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontSize: 100, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                            child: Image.asset(
                          "assets/images/olivo2.png",
                          width: 100,
                          height: 200,
                        )),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              SizedBox(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Limpieza",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  "${avgLimpieza.isNaN ? 0.0 : avgLimpieza..toStringAsFixed(1)}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                const Icon(
                                  Icons.cleaning_services_outlined,
                                  color: primaryColor,
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 120,
                            width: 1.0,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Comunicación",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  "${avgComunicacion.isNaN ? 0.0 : avgComunicacion..toStringAsFixed(1)}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                const Icon(
                                  Icons.message_outlined,
                                  color: primaryColor,
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 120,
                            width: 1.0,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Llegada",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  "${avgLlegada.isNaN ? 0.0 : avgLlegada.toStringAsFixed(1)}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                const Icon(
                                  Icons.key_outlined,
                                  color: primaryColor,
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 120,
                            width: 1.0,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Fiabilidad",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  "${avgFiabilidad.isNaN ? 0.0 : avgFiabilidad.toStringAsFixed(1)}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                const Icon(
                                  Icons.check_circle_outline,
                                  color: primaryColor,
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 120,
                            width: 1.0,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Ubicación",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  "${avgUbicacion.isNaN ? 0.0 : avgUbicacion.toStringAsFixed(1)}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                const Icon(
                                  Icons.map_outlined,
                                  color: primaryColor,
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 120,
                            width: 1.0,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Precio",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  "${avgPrecio.isNaN ? 0.0 : avgPrecio.toStringAsFixed(1)}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                const Icon(
                                  Icons.monetization_on_outlined,
                                  color: primaryColor,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  height: comentarioLista.isEmpty ? 200 : 450,
                  child: comentarioLista.isEmpty
                      ? Center(
                          child: Text(
                            "No hay comentarios disponibles.",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        )
                      : GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      Responsive.isDesktop(context) ||
                                              Responsive.isTablet(context)
                                          ? 4
                                          : 1),
                          itemCount: comentarioLista.length,
                          itemBuilder: (context, index) {
                            for (var y = 0; y < widget.usuario.length; y++) {
                              if (comentarioLista[index].usuario ==
                                  widget.usuario[y].id) {
                                return Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Card(
                                    elevation: 4.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 50,
                                              child: InteractiveViewer(
                                                constrained: false,
                                                scaleEnabled: false,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50.0),
                                                        child: Image.network(
                                                          widget.usuario[y]
                                                                      .foto ==
                                                                  ""
                                                              ? "assets/images/foto.png"
                                                              : widget
                                                                  .usuario[y]
                                                                  .foto,
                                                          width: 40,
                                                          height: 40,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: defaultPadding,
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            widget.usuario[y]
                                                                .nombreCompleto,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleMedium!
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                          Text(
                                                            "Fecha de Registro: ${widget.usuario[y].fechaRegistro}",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleSmall!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .grey),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: defaultPadding,
                                            ),
                                            SizedBox(
                                              height: 20,
                                              child: InteractiveViewer(
                                                constrained: false,
                                                scaleEnabled: false,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children: [
                                                      AbsorbPointer(
                                                        absorbing: true,
                                                        child:
                                                            RatingBar.builder(
                                                          itemSize: 20,
                                                          initialRating: ((comentarioLista[index].calLimpieza +
                                                                  comentarioLista[
                                                                          index]
                                                                      .calComunicacion +
                                                                  comentarioLista[
                                                                          index]
                                                                      .calLlegada +
                                                                  comentarioLista[
                                                                          index]
                                                                      .calFiabilidad +
                                                                  comentarioLista[
                                                                          index]
                                                                      .calUbicacion +
                                                                  comentarioLista[
                                                                          index]
                                                                      .calPrecio) /
                                                              6),
                                                          minRating: 1,
                                                          direction:
                                                              Axis.horizontal,
                                                          allowHalfRating: true,
                                                          itemCount: 5,
                                                          itemPadding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      4.0),
                                                          itemBuilder:
                                                              (context, _) =>
                                                                  const Icon(
                                                            Icons.star,
                                                            color: primaryColor,
                                                          ),
                                                          onRatingUpdate:
                                                              (rating) {
                                                            print(rating);
                                                          },
                                                        ),
                                                      ),
                                                      const Text(
                                                        " - ",
                                                        style: TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                      Text(
                                                        comentarioLista[index]
                                                            .fecha,
                                                        style: const TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: defaultPadding,
                                            ),
                                            Text(
                                              comentarioLista[index]
                                                  .descripcion,
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }

                            return Container();
                          }),
                ),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              InkWell(
                onTap: () {
                  if (FirebaseAuth.instance.currentUser != null) {
                    for (var q = 0; q < widget.usuario.length; q++) {
                      if (FirebaseAuth.instance.currentUser!.email ==
                          widget.usuario[q].correoElectronico) {
                        fomularioComentario(context, widget.sitio,
                            widget.usuario[q].id, widget.themeManager);
                      }
                    }
                  } else {
                    _modalIniciarSesion(context, widget.themeManager);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: isDark ? secondaryColor : Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ]),
                  child: const Text(
                    "Añadir Comentario",
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ),
            ],
          );
        });
  }

  fomularioComentario(
      context, SitioModel sitio, int usuario, ThemeManager themeManager) {
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                padding: const EdgeInsets.all(15),
                height: 500,
                width: 400,
                child: SingleChildScrollView(
                    child: Comentario(
                  sitio: sitio,
                  usuario: usuario,
                  themeManager: themeManager,
                ))),
          ),
        );
      },
    );
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
