import "package:alan_voice/alan_voice.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:proyecto_final/chatbotweb/chatBotWeb.dart";
import "package:proyecto_final/comentarios/screen/comentarioCard.dart";
import "package:proyecto_final/comentarios/screen/comentarioCardSitio.dart";
import "package:proyecto_final/comentarios/screen/comentarioCardTodo.dart";
import "package:proyecto_final/comentarios/screen/headerComentario.dart";
import "package:proyecto_final/models/ComentarioModel.dart";
import "package:proyecto_final/models/UsuariosModel.dart";
import "package:proyecto_final/responsive.dart";
import "package:proyecto_final/theme/theme_constants.dart";
import "package:proyecto_final/theme/theme_manager.dart";
import "package:universal_platform/universal_platform.dart";

// Vista que contendra todos los componentes los cuales conformaran la vista de comentarios.

class ComentarioPage extends StatefulWidget {
  final ThemeManager themeManager;

  const ComentarioPage({super.key, required this.themeManager});

  @override
  State<ComentarioPage> createState() => _ComentarioPageState();
}

class _ComentarioPageState extends State<ComentarioPage> {
  _ComentarioPageState() {
    if (!UniversalPlatform.isWeb) {
      /// Init Alan Button with project key from Alan AI Studio
      AlanVoice.addButton(
          "257726fb1e303ccaf96867d4b3de54d42e956eca572e1d8b807a3e2338fdd0dc/stage",
          buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT);

      /// Handle commands from Alan AI Studio
      AlanVoice.onCommand.add((command) {
        debugPrint("got new command ${command.toString()}");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: getUsuario(),
            builder: (context, AsyncSnapshot<List<UsuariosModel>> usuarioRol2) {
              if (usuarioRol2.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  const SizedBox(height: defaultPadding),
                  const HeaderComentario(),
                  const SizedBox(height: defaultPadding),
                  Text(
                    "Comentarios",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 40),
                  ),
                  const SizedBox(height: defaultPadding),
                  Container(
                    padding: const EdgeInsets.all(defaultPadding),
                    decoration: BoxDecoration(
                      color: isDark ? secondaryColor : const Color(0xFFFF2F0F2),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mis Comentarios",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 20),
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        SizedBox(
                          height: 420,
                          width: 1300,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                //Gridview para escritorio
                                if (Responsive.isDesktop(context))
                                  FutureBuilder(
                                      future: getComentarios(),
                                      builder: (context,
                                          AsyncSnapshot<List<ComentarioModel>>
                                              comentario) {
                                        if (comentario.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }

                                        if (comentario.data != null) {
                                          return GridView(
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: Responsive
                                                            .isDesktop(context)
                                                        ? 3
                                                        : Responsive.isTablet(
                                                                context)
                                                            ? 2
                                                            : 1),
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            children: [
                                              for (int index2 = 0;
                                                  index2 <
                                                      comentario.data!.length;
                                                  index2++)
                                                for (int index = 0;
                                                    index <
                                                        usuarioRol2
                                                            .data!.length;
                                                    index++)
                                                  if (FirebaseAuth.instance
                                                          .currentUser!.email ==
                                                      usuarioRol2.data![index]
                                                          .correoElectronico)
                                                    if (comentario.data![index2]
                                                            .usuario ==
                                                        usuarioRol2
                                                            .data![index].id)
                                                      ComentarioCard(
                                                        comentario: comentario
                                                            .data![index2],
                                                        themeManager:
                                                            widget.themeManager,
                                                      )
                                            ],
                                          );
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Container(
                    padding: const EdgeInsets.all(defaultPadding),
                    decoration: BoxDecoration(
                      color: isDark ? secondaryColor : const Color(0xFFFF2F0F2),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Comentarios en mis sitios",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 20),
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        SizedBox(
                          height: 420,
                          width: 1300,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                //Gridview para escritorio
                                if (Responsive.isDesktop(context))
                                  FutureBuilder(
                                      future: getComentarios(),
                                      builder: (context,
                                          AsyncSnapshot<List<ComentarioModel>>
                                              comentario) {
                                        if (comentario.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }

                                        if (comentario.data != null) {
                                          return GridView(
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: Responsive
                                                            .isDesktop(context)
                                                        ? 3
                                                        : Responsive.isTablet(
                                                                context)
                                                            ? 2
                                                            : 1),
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            children: [
                                              for (int index2 = 0;
                                                  index2 <
                                                      comentario.data!.length;
                                                  index2++)
                                                for (int index = 0;
                                                    index <
                                                        usuarioRol2
                                                            .data!.length;
                                                    index++)
                                                  if (FirebaseAuth.instance
                                                          .currentUser!.email ==
                                                      usuarioRol2.data![index]
                                                          .correoElectronico)
                                                    if (comentario.data![index2]
                                                            .sitio.usuario ==
                                                        usuarioRol2
                                                            .data![index].id)
                                                      ComentarioCardSitio(
                                                        comentario: comentario
                                                            .data![index2],
                                                        themeManager:
                                                            widget.themeManager,
                                                      )
                                            ],
                                          );
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  for (int index = 0; index < usuarioRol2.data!.length; index++)
                    if (FirebaseAuth.instance.currentUser!.email ==
                        usuarioRol2.data![index].correoElectronico)
                      if (usuarioRol2.data![index].rolAdmin != false)
                        Container(
                          padding: const EdgeInsets.all(defaultPadding),
                          decoration: BoxDecoration(
                            color: isDark
                                ? secondaryColor
                                : const Color(0xFFFF2F0F2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Todos los comentarios",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontSize: 20),
                              ),
                              const SizedBox(
                                height: defaultPadding,
                              ),
                              SizedBox(
                                height: 420,
                                width: 1300,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      //GridView para escritorio
                                      if (Responsive.isDesktop(context))
                                        FutureBuilder(
                                            future: getComentarios(),
                                            builder: (context,
                                                AsyncSnapshot<
                                                        List<ComentarioModel>>
                                                    comentario) {
                                              if (comentario.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }

                                              if (comentario.data != null) {
                                                return GridView.builder(
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: Responsive
                                                                    .isDesktop(
                                                                        context)
                                                                ? 3
                                                                : Responsive.isTablet(
                                                                        context)
                                                                    ? 2
                                                                    : 1),
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount:
                                                        comentario.data!.length,
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return ComentarioCardTodo(
                                                        comentario: comentario
                                                            .data![index],
                                                        themeManager:
                                                            widget.themeManager,
                                                      );
                                                    });
                                              } else {
                                                return const CircularProgressIndicator();
                                              }
                                            }),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  for (int index = 0; index < usuarioRol2.data!.length; index++)
                    if (FirebaseAuth.instance.currentUser!.email ==
                        usuarioRol2.data![index].correoElectronico)
                      if (usuarioRol2.data![index].rolAdmin != false)
                        const SizedBox(height: defaultPadding),
                ],
              );
            }),
      ),
      floatingActionButton: _getFloating(),
    );
  }

  _getFloating() {
    if (UniversalPlatform.isWeb) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatBotWeb()),
          );
        },
        child: const Icon(Icons.support_agent),
      );
    } else if (UniversalPlatform.isWindows) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatBotWeb()),
          );
        },
        child: const Icon(Icons.support_agent),
      );
    } else {
      return null;
    }
  }
}
