import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/LoginUsuario/Login/LoginAndRegister.dart';
import 'package:proyecto_final/controllers/MenuAppController.dart';
import 'package:proyecto_final/dashboard/screens/main/main_screen.dart';
import 'package:proyecto_final/models/UsuariosModel.dart';
import 'package:proyecto_final/responsive.dart';
import 'package:proyecto_final/theme/theme_constants.dart';
import 'package:proyecto_final/theme/theme_manager.dart';

class SearchComponent extends StatefulWidget {
  final ThemeManager themeManager;

  const SearchComponent({super.key, required this.themeManager});

  @override
  State<SearchComponent> createState() => _SearchComponentState();
}

class _SearchComponentState extends State<SearchComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Responsive.isMobile(context)
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Image(
                        image: AssetImage('assets/images/logo.png'),
                        width: 120,
                        height: 80,
                      ),
                      Row(
                        children: [
                          ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              child: Container(
                                  color: primaryColor,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.search,
                                        color: Colors.white,
                                      )))),
                          const SizedBox(
                            width: defaultPadding,
                          ),
                          InkWell(
                              onTap: () {
                                if (FirebaseAuth.instance.currentUser != null) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MultiProvider(
                                      providers: [
                                        ChangeNotifierProvider(
                                          create: (context) =>
                                              MenuAppController(),
                                        ),
                                      ],
                                      child: MainScreenTodo(
                                          themeManager: widget.themeManager),
                                    ),
                                  ));
                                } else {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => LoginPage(
                                            themeManager: widget.themeManager,
                                          )));
                                }
                              },
                              child: const ProfileCard()),
                          const SizedBox(
                            width: defaultPadding,
                          ),
                          InkWell(
                            onTap: () {
                              var newValue = ThemeMode.dark;

                              setState(() {
                                if (newValue == ThemeMode.dark) {
                                  newValue = ThemeMode.light;
                                  widget.themeManager.toggleTheme(
                                      widget.themeManager.themeMode ==
                                          newValue);
                                } else {
                                  newValue = ThemeMode.dark;
                                  widget.themeManager.toggleTheme(
                                      widget.themeManager.themeMode ==
                                          newValue);
                                }
                              });
                            },
                            child: const ThemeCard(),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Image(
                      image: AssetImage('assets/images/logo.png'),
                      width: 120,
                      height: 80,
                    ),
                    Row(
                      children: [
                        ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            child: Container(
                                color: primaryColor,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    )))),
                        const SizedBox(
                          width: defaultPadding,
                        ),
                        InkWell(
                            onTap: () {
                              if (FirebaseAuth.instance.currentUser != null) {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MultiProvider(
                                    providers: [
                                      ChangeNotifierProvider(
                                        create: (context) =>
                                            MenuAppController(),
                                      ),
                                    ],
                                    child: MainScreenTodo(
                                        themeManager: widget.themeManager),
                                  ),
                                ));
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LoginPage(
                                          themeManager: widget.themeManager,
                                        )));
                              }
                            },
                            child: const ProfileCard()),
                        const SizedBox(
                          width: defaultPadding,
                        ),
                        InkWell(
                          onTap: () {
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
                          child: const ThemeCard(),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(left: defaultPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: isDark ? secondaryColor : const Color(0xFFFF2F0F2),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: FirebaseAuth.instance.currentUser == null
          ? Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    width: 38,
                    height: 38,
                    color: primaryColor,
                    child: const Icon(
                      Icons.login,
                      color: Colors.white,
                    ),
                  ),
                ),
                if (!Responsive.isMobile(context))
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                    child: Text("Iniciar Sesión"),
                  ),
              ],
            )
          : FutureBuilder(
              future: getUsuario(),
              builder: (context,
                  AsyncSnapshot<List<UsuariosModel>> usuarioEncabezado) {
                if (usuarioEncabezado.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (usuarioEncabezado.data != null) {
                  return Row(
                    children: [
                      for (int index = 0;
                          index < usuarioEncabezado.data!.length;
                          index++)
                        if (FirebaseAuth.instance.currentUser!.email ==
                            usuarioEncabezado.data![index].correoElectronico)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              usuarioEncabezado.data![index].foto == ""
                                  ? "assets/images/foto.png"
                                  : usuarioEncabezado.data![index].foto,
                              height: 38,
                            ),
                          ),
                      for (int index = 0;
                          index < usuarioEncabezado.data!.length;
                          index++)
                        if (FirebaseAuth.instance.currentUser!.email ==
                            usuarioEncabezado.data![index].correoElectronico)
                          if (!Responsive.isMobile(context))
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultPadding / 2),
                              child: Text(usuarioEncabezado
                                  .data![index].nombreCompleto),
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

class ThemeCard extends StatelessWidget {
  const ThemeCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: isDark ? secondaryColor : const Color(0xFFFF2F0F2),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          width: 38,
          height: 38,
          color: primaryColor,
          child: isDark
              ? SvgPicture.asset(
                  "assets/icons/Light.svg",
                  color: Colors.white,
                )
              : SvgPicture.asset(
                  "assets/icons/dark.svg",
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}
