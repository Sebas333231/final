import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/FormularioSitio/forms_provider.dart';
import 'package:proyecto_final/FormularioSitio/sitio/formulario_sitio.dart';
import 'package:proyecto_final/HomePage/home_screens.dart';
import 'package:proyecto_final/categories/screens/categoryPage.dart';
import 'package:proyecto_final/chat/homeChat.dart';
import 'package:proyecto_final/comentarios/screen/comentarioPage.dart';
import 'package:proyecto_final/loginActualizacionUsuario/actualizarDatos/LoginEditar.dart';
import 'package:proyecto_final/models/UsuariosModel.dart';
import 'package:proyecto_final/theme/theme_constants.dart';
import 'package:proyecto_final/theme/theme_manager.dart';

class SideMenu extends StatefulWidget {
  final ThemeManager themeManager;

  const SideMenu({
    Key? key,
    required this.themeManager,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      child: FutureBuilder(
          future: getUsuario(),
          builder: (context, AsyncSnapshot<List<UsuariosModel>> usuarioRol1) {
            if (usuarioRol1.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (usuarioRol1.data != null) {
              return ListView(
                children: [
                  DrawerHeader(
                    child: Image.asset(
                      "assets/images/logo2.png",
                    ),
                  ),
                  DrawerListTile(
                    title: "Home",
                    svgSrc: "assets/icons/home.svg",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HomeScreenPage(themeManager: widget.themeManager),
                        ),
                      );
                    },
                  ),
                  for (int index = 0; index < usuarioRol1.data!.length; index++)
                    if (FirebaseAuth.instance.currentUser!.email ==
                        usuarioRol1.data![index].correoElectronico)
                      DrawerListTile(
                        title: "Mi Perfil",
                        svgSrc: "assets/icons/persona.svg",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginEditarPage(
                                      themeManager: widget.themeManager,
                                      usuario: usuarioRol1.data![index],
                                    )),
                          );
                        },
                      ),
                  for (int index = 0; index < usuarioRol1.data!.length; index++)
                    if (FirebaseAuth.instance.currentUser!.email ==
                        usuarioRol1.data![index].correoElectronico)
                      if (usuarioRol1.data![index].rolAdmin != false)
                        DrawerListTile(
                          title: "Categorías",
                          svgSrc: "assets/icons/hotel.svg",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryPage(
                                        themeManager: widget.themeManager,
                                      )),
                            );
                          },
                        ),
                  DrawerListTile(
                    title: "Comentarios",
                    svgSrc: "assets/icons/comentarios.svg",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ComentarioPage(themeManager: widget.themeManager,)),
                      );
                    },
                  ),
                  DrawerListTile(
                    title: "Mis Chats",
                    svgSrc: "assets/icons/chat.svg",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const HomeChat(),
                        ),
                      );
                    },
                  ),
                  DrawerListTile(
                    title: "Nuevo Sitio",
                    svgSrc: "assets/icons/addsitio.svg",
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MultiProvider(
                                    providers: [
                                      ChangeNotifierProvider<FormsProvider>(
                                          create: (_) => FormsProvider())
                                    ],
                                    builder: (context, _) => SitioForm(
                                      themeManager: widget.themeManager,
                                    ),
                                  )));
                    },
                  ),
                  DrawerListTile(
                    title: isDark ? "Modo Claro" : "Modo Oscuro",
                    svgSrc: isDark
                        ? "assets/icons/Light.svg"
                        : "assets/icons/dark.svg",
                    press: () {
                      var newValue = ThemeMode.dark;

                      setState(() {
                        if (newValue == ThemeMode.dark) {
                          newValue = ThemeMode.light;
                          widget.themeManager.toggleTheme(
                              widget.themeManager.themeMode == newValue);
                        } else {
                          newValue = ThemeMode.dark;
                          widget.themeManager.toggleTheme(
                              widget.themeManager.themeMode == newValue);
                        }
                      });
                    },
                  ),
                  DrawerListTile(
                    title: "Cerrar Sesión",
                    svgSrc: "assets/icons/logout.svg",
                    press: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HomeScreenPage(themeManager: widget.themeManager),
                        ),
                      );
                    },
                  ),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: isDark
            ? const ColorFilter.mode(Colors.white54, BlendMode.srcIn)
            : const ColorFilter.mode(primaryColor, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: isDark
            ? const TextStyle(color: Colors.white54)
            : const TextStyle(color: primaryColor),
      ),
    );
  }
}
