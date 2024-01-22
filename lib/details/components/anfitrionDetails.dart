import 'package:flutter/material.dart';
import 'package:proyecto_final/models/HabitacionModel.dart';
import 'package:proyecto_final/models/SitioModel.dart';
import 'package:proyecto_final/models/UsuariosModel.dart';
import 'package:proyecto_final/responsive.dart';
import 'package:proyecto_final/theme/theme_constants.dart';

class AnfitrionDetails extends StatelessWidget {
  final SitioModel sitio;

  const AnfitrionDetails({
    super.key,
    required this.sitio,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    List<int> listaHabitacion = [];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${sitio.titulo}, ${sitio.lugar}",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          FutureBuilder(
              future: getHabitacion(),
              builder:
                  (context, AsyncSnapshot<List<HabitacionModel>> habitacion) {
                if (habitacion.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                for (var h = 0; h < habitacion.data!.length; h++) {
                  if (sitio.id == habitacion.data![h].sitio) {
                    listaHabitacion.add(habitacion.data![h].id);
                  }
                }
                return Row(
                  children: [
                    Text("${sitio.numHuespedes} huespedes"),
                    const Text(" - "),
                    Text("${listaHabitacion.length} habitaciones"),
                    const Text(" - "),
                    Text("${sitio.numCamas} camas"),
                    const Text(" - "),
                    Text("${sitio.numBanos} baño"),
                  ],
                );
              }),
          const SizedBox(
            height: defaultPadding,
          ),
          FutureBuilder(
              future: getUsuario(),
              builder: (context, AsyncSnapshot<List<UsuariosModel>> usuario) {
                if (usuario.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (usuario.data != null) {
                  for (var k = 0; k < usuario.data!.length; k++) {
                    if (sitio.usuario == usuario.data![k].id) {
                      return Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.network(
                              usuario.data![k].foto == ""
                                  ? "assets/images/foto.png"
                                  : usuario.data![k].foto,
                              width: 50,
                              height: 50,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(
                            width: defaultPadding,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                usuario.data![k].nombreCompleto,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                "Se registró el: ${usuario.data![k].fechaRegistro}",
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          )
                        ],
                      );
                    }
                  }
                } else {
                  return Container();
                }

                return Container();
              }),
          const SizedBox(
            height: defaultPadding,
          ),
          FutureBuilder(
              future: getUsuario(),
              builder: (context, AsyncSnapshot<List<UsuariosModel>> usuario) {
                if (usuario.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (usuario.data != null) {
                  for (var k = 0; k < usuario.data!.length; k++) {
                    if (sitio.usuario == usuario.data![k].id) {
                      return ElevatedButton(
                        onPressed: () {
                          _modalAnfitrion(context, usuario.data![k]);
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
                        child: const Text("Ver Información"),
                      );
                    }
                  }
                }

                return Container();
              }),
          const SizedBox(
            height: defaultPadding,
          ),
        ],
      ),
    );
  }
}

void _modalAnfitrion(BuildContext context, UsuariosModel usuario) {
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
                  "Información del Anfitrión",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                Expanded(
                  child: SizedBox(
                    height: 495,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  Responsive.isMobile(context) ? 50.0 : 100.0),
                              child: Image.network(
                                usuario.foto == ""
                                    ? "assets/images/foto.png"
                                    : usuario.foto,
                                width: Responsive.isMobile(context) ? 100 : 200,
                                height:
                                    Responsive.isMobile(context) ? 100 : 200,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(
                              width: defaultPadding,
                            ),
                            if (Responsive.isDesktop(context) ||
                                Responsive.isTablet(context))
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 350,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Anfitrión: ${usuario.nombreCompleto}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(fontSize: 30),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "Se registró el: ${usuario.fechaRegistro}",
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  ),
                                ],
                              ),
                          ],
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        if (Responsive.isMobile(context))
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Anfitrión: ${usuario.nombreCompleto}",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                "Se registró el: ${usuario.fechaRegistro}",
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        Text(
                          usuario.descripcion,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        const Divider(
                          height: 1,
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        Text("Contactos",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 30)),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        if (Responsive.isDesktop(context) ||
                            Responsive.isTablet(context))
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Teléfono Fijo",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                usuario.telefono.toString(),
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        if (Responsive.isMobile(context))
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Teléfono Fijo",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                usuario.telefono.toString(),
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        if (Responsive.isDesktop(context) ||
                            Responsive.isTablet(context))
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Teléfono Celular",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                usuario.telefonoCelular.toString(),
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        if (Responsive.isMobile(context))
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Teléfono Celular",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                usuario.telefonoCelular.toString(),
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        if (Responsive.isDesktop(context) ||
                            Responsive.isTablet(context))
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Correo",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                usuario.correoElectronico,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        if (Responsive.isMobile(context))
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Correo",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                usuario.correoElectronico,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                      ],
                    )),
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
