import 'package:flutter/material.dart';
import 'package:proyecto_final/models/CategoriaModel.dart';
import 'package:proyecto_final/models/SitioModel.dart';
import 'package:proyecto_final/models/UsuariosModel.dart';
import 'package:proyecto_final/responsive.dart';
import 'package:proyecto_final/theme/theme_constants.dart';
import 'package:proyecto_final/theme/theme_manager.dart';
import '../explore/components/search_app_bar.dart';
import '../../card.dart';

class ExploreScreen extends StatefulWidget {
  final ThemeManager themeManager;

  const ExploreScreen({super.key, required this.themeManager});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            SearchComponent(
              themeManager: widget.themeManager,
            ),
            BodyHome(
              themeManager: widget.themeManager,
            ),
          ],
        ),
      ),
    );
  }
}

class BodyHome extends StatelessWidget {
  final ThemeManager themeManager;

  const BodyHome({
    super.key,
    required this.themeManager,
  });


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCategoria(),
        builder:
            (context, AsyncSnapshot<List<CategoriaModel>> categoriaHeader) {
          if (categoriaHeader.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (categoriaHeader.data != null) {
            return DefaultTabController(
              length: categoriaHeader.data!.length,
              child: Expanded(
                child: Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: TabBar(
                        indicatorColor: primaryColor,
                        isScrollable: true,
                        tabs: [
                          for (int index = 0;
                              index < categoriaHeader.data!.length;
                              index++)
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, bottom: 4, top: 4),
                              child: Column(
                                children: [
                                  Image.network(
                                    categoriaHeader.data![index].icono,
                                    width: 24,
                                    height: 24,
                                  ),
                                  Text(
                                    categoriaHeader.data![index].nombre,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: primaryColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          for (int index = 0;
                              index < categoriaHeader.data!.length;
                              index++)
                            Container(
                              padding: const EdgeInsets.all(15),
                              child: FutureBuilder(
                                  future: getUsuario(),
                                  builder: (context,
                                      AsyncSnapshot<List<UsuariosModel>>
                                          usuario) {
                                    if (usuario.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
            
                                    return FutureBuilder(
                                        future: getSitios(),
                                        builder: (context,
                                            AsyncSnapshot<List<SitioModel>>
                                                sitio) {
                                          if (sitio.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child: CircularProgressIndicator(),
                                            );
                                          }
                                          return GridView(
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              // esto cambia a medida que el tamaño de la  pantalla cambia.
                                              crossAxisCount: Responsive.isMobile(
                                                      context)
                                                  ? 1
                                                  : Responsive.isTablet(context)
                                                      ? 3
                                                      : 4,
                                              childAspectRatio: 0.83,
                                            ),
                                            children: [
                                              for (int index2 = 0;
                                                  index2 < sitio.data!.length;
                                                  index2++)
                                                if (categoriaHeader
                                                        .data![index].nombre ==
                                                    sitio.data![index2].categoria
                                                        .nombre)
                                                  CardSite(
                                                    sitio: sitio.data![index2],
                                                    usuario: usuario.data!,
                                                    themeManager: themeManager,
                                                  ),
                                            ],
                                          );
                                        });
                                  }),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
