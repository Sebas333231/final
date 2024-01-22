import 'package:flutter/material.dart';
import 'package:proyecto_final/models/ServicioModel.dart';
import 'package:proyecto_final/models/SitioModel.dart';
import 'package:proyecto_final/theme/theme_constants.dart';

class ServiciosDetails extends StatelessWidget {
  final SitioModel sitio;

  const ServiciosDetails({
    super.key,
    required this.sitio,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    List<ServicioModel> listaServicio = [];

    List<ServicioModel> listaServicio2 = [];

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder(
                      future: getServicio(),
                      builder: (context,
                          AsyncSnapshot<List<ServicioModel>> servicio) {
                        if (servicio.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        for (var s = 0; s < servicio.data!.length; s++) {
                          if (sitio.id == servicio.data![s].sitio) {
                            listaServicio.add(servicio.data![s]);
                          }
                        }

                        return ListView.builder(
                            itemCount: 6,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.network(
                                        listaServicio[index].icono,
                                        width: 50,
                                        height: 50,
                                      ),
                                      const SizedBox(
                                        width: defaultPadding,
                                      ),
                                      Text(
                                        listaServicio[index].nombre,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: defaultPadding,
                                  ),
                                ],
                              );
                            });
                      }),
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                FutureBuilder(
                    future: getServicio(),
                    builder:
                        (context, AsyncSnapshot<List<ServicioModel>> servicio) {
                      if (servicio.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      for (var s = 0; s < servicio.data!.length; s++) {
                        if (sitio.id == servicio.data![s].sitio) {
                          listaServicio2.add(servicio.data![s]);
                        }
                      }
                      return ElevatedButton(
                        onPressed: () {
                          _modalServicio(context, listaServicio2);
                        },
                        style: ButtonStyle(
                          backgroundColor: isDark
                              ? const MaterialStatePropertyAll(secondaryColor)
                              : const MaterialStatePropertyAll(Colors.white),
                          foregroundColor:
                              const MaterialStatePropertyAll(primaryColor),
                          padding: const MaterialStatePropertyAll(
                              EdgeInsets.all(20.0)),
                        ),
                        child: Text(
                            "Mostrar los ${listaServicio2.length} servicios"),
                      );
                    })
              ],
            ),
          ),
        ),
      ],
    );
  }
}

void _modalServicio(BuildContext context, List<ServicioModel> servicio) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 600,
            width: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                const SizedBox(
                  height: defaultPadding,
                ),
                Text(
                  "Lo que este lugar ofrece",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                Expanded(
                  child: SizedBox(
                    height: 495,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: servicio.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              const SizedBox(
                                height: defaultPadding,
                              ),
                              ListTile(
                                leading: Image.network(servicio[index].icono, width: 50, height: 50,),
                                title: Text(
                                  servicio[index].nombre,
                                  style: const TextStyle(color: primaryColor),
                                ),
                                subtitle: servicio[index]
                                            .descripcion
                                            .isNotEmpty ==
                                        true
                                    ? Text(servicio[index].descripcion,
                                        style:
                                            const TextStyle(color: Colors.grey))
                                    : Container(),
                              ),
                              const Divider(
                                height: 1,
                              ),
                              const SizedBox(
                                height: defaultPadding,
                              ),
                            ],
                          );
                        }),
                  ),
                ),
              ],
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
                    child: const Text("Cerrar"))
              ],
            )
          ],
        );
      });
}

class ServiciosSection extends StatelessWidget {
  final SitioModel sitio;

  const ServiciosSection({
    super.key,
    required this.sitio,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 60.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Lo que este lugar ofrece",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              ServiciosDetails(
                sitio: sitio,
              ),
              const SizedBox(
                height: defaultPadding,
              ),
            ]),
      ),
    );
  }
}
