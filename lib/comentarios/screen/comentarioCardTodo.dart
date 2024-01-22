import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:proyecto_final/HomePage/home_screens.dart';
import 'package:proyecto_final/models/ComentarioModel.dart';
import 'package:proyecto_final/models/UsuariosModel.dart';
import 'package:proyecto_final/theme/theme_constants.dart';
import 'package:proyecto_final/theme/theme_manager.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:http/http.dart' as http;

// diseño de la Card animada donde va a estar la información de cada comentario del usuario que inició sesión

class ComentarioCardTodo extends StatefulWidget {
  final ComentarioModel comentario;

  final ThemeManager themeManager;

  const ComentarioCardTodo(
      {super.key, required this.comentario, required this.themeManager});

  @override
  State<ComentarioCardTodo> createState() => _ComentarioCardTodoState();
}

class _ComentarioCardTodoState extends State<ComentarioCardTodo> {
  bool isBack = true;
  double angle = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _flip() {
      setState(() {
        angle = (angle + pi) % (2 * pi);
      });
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        onTap: _flip,
        child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: angle),
            duration: const Duration(seconds: 1),
            builder: (BuildContext context, double val, __) {
              //here we will change the isBack val so we can change the content of the card
              if (val >= (pi / 2)) {
                isBack = false;
              } else {
                isBack = true;
              }
              return (Transform(
                //let's make the card flip by it's center
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(val),
                child: SizedBox(
                    width: 309,
                    height: 474,
                    child: isBack
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: const DecorationImage(
                                image: AssetImage("assets/images/back.png"),
                              ),
                            ),
                          ) //if it's back we will display here
                        : Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..rotateY(
                                  pi), // it will flip horizontally the container
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: const DecorationImage(
                                  image: AssetImage("assets/images/face.png"),
                                ),
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: 190,
                                  height: 350,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        const SizedBox(height: defaultPadding),
                                        Center(
                                          child: FutureBuilder(
                                              future: getUsuario(),
                                              builder: (context,
                                                  AsyncSnapshot<
                                                          List<UsuariosModel>>
                                                      usuario) {
                                                if (usuario.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }

                                                for (var u = 0;
                                                    u < usuario.data!.length;
                                                    u++) {
                                                  if (widget
                                                          .comentario.usuario ==
                                                      usuario.data![u].id) {
                                                    return Column(
                                                      children: [
                                                        ClipRRect(
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            50)),
                                                            child:
                                                                Image.network(
                                                              usuario.data![u]
                                                                          .foto ==
                                                                      ""
                                                                  ? "assets/images/foto.png"
                                                                  : usuario
                                                                      .data![u]
                                                                      .foto,
                                                              width: 50,
                                                              height: 50,
                                                            )),
                                                        const SizedBox(
                                                          height:
                                                              defaultPadding,
                                                        ),
                                                        Text(
                                                          usuario.data![u]
                                                              .nombreCompleto,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleSmall!
                                                                  .copyWith(
                                                                    color:
                                                                        primaryColor,
                                                                  ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ],
                                                    );
                                                  }
                                                }

                                                return Container();
                                              }),
                                        ),
                                        const SizedBox(height: defaultPadding),
                                        Text(
                                          "Sitio: ${widget.comentario.sitio.titulo}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: primaryColor),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: defaultPadding),
                                        const Text(
                                          "Limpieza",
                                          style: TextStyle(color: primaryColor),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(
                                          height: defaultPadding,
                                        ),
                                        AbsorbPointer(
                                          absorbing: true,
                                          child: RatingBar.builder(
                                            itemSize: 20,
                                            initialRating:
                                                widget.comentario.calLimpieza,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 4.0),
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: primaryColor,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: defaultPadding),
                                        Text(
                                          widget.comentario.desLimpieza,
                                          style: const TextStyle(
                                              color: Colors.grey),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: defaultPadding),
                                        const Text(
                                          "Comunicación",
                                          style: TextStyle(color: primaryColor),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(
                                          height: defaultPadding,
                                        ),
                                        AbsorbPointer(
                                          absorbing: true,
                                          child: RatingBar.builder(
                                            itemSize: 20,
                                            initialRating: widget
                                                .comentario.calComunicacion,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 4.0),
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: primaryColor,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: defaultPadding),
                                        Text(
                                          widget.comentario.desComunicacion,
                                          style: const TextStyle(
                                              color: Colors.grey),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: defaultPadding),
                                        const Text(
                                          "Llegada",
                                          style: TextStyle(color: primaryColor),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(
                                          height: defaultPadding,
                                        ),
                                        AbsorbPointer(
                                          absorbing: true,
                                          child: RatingBar.builder(
                                            itemSize: 20,
                                            initialRating:
                                                widget.comentario.calLlegada,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 4.0),
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: primaryColor,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: defaultPadding),
                                        Text(
                                          widget.comentario.desLlegada,
                                          style: const TextStyle(
                                              color: Colors.grey),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: defaultPadding),
                                        const Text(
                                          "Fiabilidad",
                                          style: TextStyle(color: primaryColor),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(
                                          height: defaultPadding,
                                        ),
                                        AbsorbPointer(
                                          absorbing: true,
                                          child: RatingBar.builder(
                                            itemSize: 20,
                                            initialRating:
                                                widget.comentario.calFiabilidad,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 4.0),
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: primaryColor,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: defaultPadding),
                                        Text(
                                          widget.comentario.desFiabilidad,
                                          style: const TextStyle(
                                              color: Colors.grey),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: defaultPadding),
                                        const Text(
                                          "Ubicación",
                                          style: TextStyle(color: primaryColor),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(
                                          height: defaultPadding,
                                        ),
                                        AbsorbPointer(
                                          absorbing: true,
                                          child: RatingBar.builder(
                                            itemSize: 20,
                                            initialRating:
                                                widget.comentario.calUbicacion,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 4.0),
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: primaryColor,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: defaultPadding),
                                        Text(
                                          widget.comentario.desUbicacion,
                                          style: const TextStyle(
                                              color: Colors.grey),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: defaultPadding),
                                        const Text(
                                          "Precio",
                                          style: TextStyle(color: primaryColor),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(
                                          height: defaultPadding,
                                        ),
                                        AbsorbPointer(
                                          absorbing: true,
                                          child: RatingBar.builder(
                                            itemSize: 20,
                                            initialRating:
                                                widget.comentario.calPrecio,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 4.0),
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: primaryColor,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: defaultPadding),
                                        Text(
                                          widget.comentario.desPrecio,
                                          style: const TextStyle(
                                              color: Colors.grey),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: defaultPadding),
                                        Text(
                                          "Comentario",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: primaryColor),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: defaultPadding),
                                        Text(
                                          widget.comentario.descripcion,
                                          style: const TextStyle(
                                              color: Colors.grey),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(
                                          height: defaultPadding,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
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
                                                color: Colors.white,
                                              ),
                                              child: IconButton(
                                                  onPressed: () {
                                                    _modalEliminarComentario(
                                                        context,
                                                        widget.themeManager,
                                                        widget.comentario);
                                                  },
                                                  icon: const Icon(Icons.delete,
                                                      size: 25,
                                                      color: Colors.black)),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: defaultPadding,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ) //else we will display it here,
                    ),
              ));
            }),
      ),
    );
  }

  void _modalEliminarComentario(BuildContext context, ThemeManager themeManager,
      ComentarioModel comentario) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "¿Quiere eliminar este comentario?",
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
                        "Si elimina este comentario no hay marcha atras. ¿Esta seguro de hacer esta operación?.",
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
                        String url = "";

                        if (UniversalPlatform.isAndroid) {
                          url = "http://10.0.2.2:8000/api/Comentarios/";
                        } else {
                          url = "http://127.0.0.1:8000/api/Comentarios/";
                        }

                        final response = await http.delete(
                            Uri.parse(url + comentario.id.toString() + "/"));

                        if (response.statusCode == 204) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => HomeScreenPage(
                                themeManager: themeManager,
                              ),
                            ),
                          );
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
