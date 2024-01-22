import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/models/CardsReservasModel.dart';
import 'package:proyecto_final/models/ReservaModel.dart';
import 'package:proyecto_final/models/UsuariosModel.dart';
import 'package:proyecto_final/responsive.dart';
import 'package:proyecto_final/theme/theme_constants.dart';
import 'reserva_info_card.dart';

// Vista donde se llamaran las cards superiores de conteo de reservas y las organiza que se adapten a todos los dispositivos

class Cards extends StatelessWidget {
  const Cards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Panel Usuario",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: const FileInfoCardGridView(),
          desktop: FileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUsuario(),
        builder: (context, AsyncSnapshot<List<UsuariosModel>> usuario) {
          if (usuario.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (usuario.data != null) {
            return FutureBuilder(
                future: getReservas(),
                builder: (context, AsyncSnapshot<List<ReservaModel>> reserva) {
                  if (reserva.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  int reservas = 0;
                  int reservaActiva = 0;
                  int reservaCancelada = 0;
                  int reservaFinalizada = 0;

                  for (var u = 0; u < usuario.data!.length; u++) {
                    if (FirebaseAuth.instance.currentUser!.email ==
                        usuario.data![u].correoElectronico) {
                      for (var r = 0; r < reserva.data!.length; r++) {
                        if (reserva.data![r].usuario == usuario.data![u].id) {
                          if (reserva.data![r].estado == "Activo") {
                            reservaActiva++;
                          } else if (reserva.data![r].estado == "Cancelado") {
                            reservaCancelada++;
                          } else if (reserva.data![r].estado == "Finalizado") {
                            reservaFinalizada++;
                          }

                          reservas++;
                        }
                      }
                    }
                  }

                  List ReservasInfoList = [
                    ReservaInfoModel(
                      title: "Mis Reservas",
                      svgSrc: "assets/icons/reserva.svg",
                      totalReservas: reservas.toString(),
                      color: primaryColor,
                      percentage: reservas,
                    ),
                    ReservaInfoModel(
                      title: "Reservas Activas",
                      svgSrc: "assets/icons/check.svg",
                      totalReservas: reservaActiva.toString(),
                      color: Colors.green,
                      percentage: reservaActiva,
                    ),
                    ReservaInfoModel(
                      title: "Reservas Canceladas",
                      svgSrc: "assets/icons/cancel.svg",
                      totalReservas: reservaCancelada.toString(),
                      color: Colors.red,
                      percentage: reservaCancelada,
                    ),
                    ReservaInfoModel(
                      title: "Reservas Finalizadas",
                      svgSrc: "assets/icons/finalizado.svg",
                      totalReservas: reservaFinalizada.toString(),
                      color: Colors.orange,
                      percentage: reservaFinalizada,
                    ),
                  ];
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: ReservasInfoList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: defaultPadding,
                      mainAxisSpacing: defaultPadding,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemBuilder: (context, index) =>
                        FileInfoCard(info: ReservasInfoList[index]),
                  );
                });
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
