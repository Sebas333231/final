import 'package:flutter/material.dart';
import 'package:proyecto_final/dashboard/screens/dashboard/components/reserva_todo/Sitio.dart';
import 'package:proyecto_final/models/SitioModel.dart';
import 'package:proyecto_final/models/UsuariosModel.dart';
import 'package:proyecto_final/theme/theme_constants.dart';
import 'package:proyecto_final/theme/theme_manager.dart';

// Contenedor el cual encapsula la vista previa de todos los sitios que hay en el aplicativo

class Sitios extends StatelessWidget {

  final ThemeManager themeManager;

  const Sitios({
    Key? key, required this.themeManager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: isDark ? secondaryColor : const Color(0xFFFF2F0F2),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Todos los sitios",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: 550,
            width: 400,
            child: FutureBuilder(
                future: getUsuario(),
                builder: (context, AsyncSnapshot<List<UsuariosModel>> usuario) {
                  if (usuario.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return FutureBuilder(
                      future: getSitios(),
                      builder:
                          (context, AsyncSnapshot<List<SitioModel>> sitio) {
                        if (sitio.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (sitio.data != null) {
                          return SingleChildScrollView(
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: sitio.data!.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return SitioCard(
                                    sitio: sitio.data![index],
                                    favorito: false,
                                    usuario: usuario.data!,
                                    themeManager: themeManager,
                                  );
                                }),
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      });
                }),
          ),
        ],
      ),
    );
  }
}
