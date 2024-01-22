import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/dashboard/screens/dashboard/components/cards.dart';
import 'package:proyecto_final/dashboard/screens/dashboard/components/reserva_anfitrion/misPagosRecibidos.dart';
import 'package:proyecto_final/dashboard/screens/dashboard/components/reserva_anfitrion/misSitios.dart';
import 'package:proyecto_final/dashboard/screens/dashboard/components/reserva_anfitrion/reserva_activa_anf.dart';
import 'package:proyecto_final/dashboard/screens/dashboard/components/reserva_anfitrion/reserva_cancelada_anf.dart';
import 'package:proyecto_final/dashboard/screens/dashboard/components/reserva_anfitrion/reserva_finalizada_anf.dart';
import 'package:proyecto_final/dashboard/screens/dashboard/components/reserva_todo/Sitios.dart';
import 'package:proyecto_final/dashboard/screens/dashboard/components/reserva_todo/listaUsuarios_todo.dart';
import 'package:proyecto_final/dashboard/screens/dashboard/components/reserva_todo/reserva_activa_todo.dart';
import 'package:proyecto_final/dashboard/screens/dashboard/components/reserva_todo/reserva_cancelada_todo.dart';
import 'package:proyecto_final/dashboard/screens/dashboard/components/reserva_todo/reserva_finalizada_todo.dart';
import 'package:proyecto_final/dashboard/screens/dashboard/components/reserva_todo/totalDevolucionesUsuario.dart';
import 'package:proyecto_final/dashboard/screens/dashboard/components/reserva_todo/totalMultas.dart';
import 'package:proyecto_final/dashboard/screens/dashboard/components/reserva_todo/totalPagosAnfitrion.dart';
import 'package:proyecto_final/dashboard/screens/dashboard/components/reserva_todo/totalPagosUsuario.dart';
import 'package:proyecto_final/dashboard/screens/dashboard/components/reserva_usuario/misDevoluciones.dart';
import 'package:proyecto_final/dashboard/screens/dashboard/components/reserva_usuario/misMultas.dart';
import 'package:proyecto_final/dashboard/screens/dashboard/components/reserva_usuario/misPagos.dart';
import 'package:proyecto_final/dashboard/screens/dashboard/components/reserva_usuario/reserva_cancelada_usu.dart';
import 'package:proyecto_final/dashboard/screens/dashboard/components/reserva_usuario/reserva_finalizada_usu.dart';
import 'package:proyecto_final/dashboard/screens/dashboard/components/visitado_details.dart';
import 'package:proyecto_final/models/ReservaModel.dart';
import 'package:proyecto_final/models/SitioVisitadoModel.dart';
import 'package:proyecto_final/models/UsuariosModel.dart';
import 'package:proyecto_final/responsive.dart';
import 'package:proyecto_final/theme/theme_constants.dart';
import 'package:proyecto_final/theme/theme_manager.dart';
import 'components/header.dart';

import 'components/reserva_usuario/reserva_activa_usu.dart';
import 'components/favorito_details.dart';

// Vista donde se llaman todos los componentes del dashboard y tambien direcciona estos componentes para que
// tengan diferentes comportamientos al momento de adaptarlos a diferentes dispositivos

class DashboardScreen extends StatelessWidget {
  final ThemeManager themeManager;

  const DashboardScreen({super.key, required this.themeManager});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const Header(),
            const SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      FutureBuilder(
                          future: getUsuario(),
                          builder: (context,
                              AsyncSnapshot<List<UsuariosModel>> usuarioRol) {
                            if (usuarioRol.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return SizedBox(
                              height: 1340,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    const Cards(),
                                    const SizedBox(height: defaultPadding),
                                    ReservaActivaU(themeManager: themeManager,),
                                    const SizedBox(height: defaultPadding),
                                    const ReservaCanceladaU(),
                                    const SizedBox(height: defaultPadding),
                                    FutureBuilder(
                                        future: getReservas(),
                                        builder: (context,
                                            AsyncSnapshot<List<ReservaModel>>
                                                reserva) {
                                          if (reserva.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                          return ReservaFinalizadaU(
                                            reservas: reserva.data!,
                                          );
                                        }),
                                    const SizedBox(height: defaultPadding),
                                    const Pagos(),
                                    const SizedBox(height: defaultPadding),
                                    const Devoluciones(),
                                    const SizedBox(height: defaultPadding),
                                    const Multas(),
                                    const SizedBox(height: defaultPadding),
                                    const Divider(
                                      height: 1,
                                    ),
                                    const SizedBox(height: defaultPadding),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Panel Anfitrión",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: defaultPadding),
                                    MisSitios(
                                      themeManager: themeManager,
                                    ),
                                    const SizedBox(height: defaultPadding),
                                    const PagosAnf(),
                                    const SizedBox(height: defaultPadding),
                                    const ReservaActivaA(),
                                    const SizedBox(height: defaultPadding),
                                    const ReservaCanceladaA(),
                                    const SizedBox(height: defaultPadding),
                                    FutureBuilder(
                                        future: getReservas(),
                                        builder: (context,
                                            AsyncSnapshot<List<ReservaModel>>
                                                reserva) {
                                          if (reserva.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                          return ReservaFinalizadaA(
                                            reservas: reserva.data!,
                                          );
                                        }),
                                    const SizedBox(height: defaultPadding),
                                    for (int index = 0;
                                        index < usuarioRol.data!.length;
                                        index++)
                                      if (FirebaseAuth
                                              .instance.currentUser!.email ==
                                          usuarioRol
                                              .data![index].correoElectronico)
                                        if (usuarioRol.data![index].rolAdmin !=
                                            false)
                                          const Divider(
                                            height: 1,
                                          ),
                                    for (int index = 0;
                                        index < usuarioRol.data!.length;
                                        index++)
                                      if (FirebaseAuth
                                              .instance.currentUser!.email ==
                                          usuarioRol
                                              .data![index].correoElectronico)
                                        if (usuarioRol.data![index].rolAdmin !=
                                            false)
                                          const SizedBox(
                                              height: defaultPadding),
                                    for (int index = 0;
                                        index < usuarioRol.data!.length;
                                        index++)
                                      if (FirebaseAuth
                                              .instance.currentUser!.email ==
                                          usuarioRol
                                              .data![index].correoElectronico)
                                        if (usuarioRol.data![index].rolAdmin !=
                                            false)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Panel Administrador",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                            ],
                                          ),
                                    for (int index = 0;
                                        index < usuarioRol.data!.length;
                                        index++)
                                      if (FirebaseAuth
                                              .instance.currentUser!.email ==
                                          usuarioRol
                                              .data![index].correoElectronico)
                                        if (usuarioRol.data![index].rolAdmin !=
                                            false)
                                          const SizedBox(
                                              height: defaultPadding),
                                    for (int index = 0;
                                        index < usuarioRol.data!.length;
                                        index++)
                                      if (FirebaseAuth
                                              .instance.currentUser!.email ==
                                          usuarioRol
                                              .data![index].correoElectronico)
                                        if (usuarioRol.data![index].rolAdmin !=
                                            false)
                                          Sitios(
                                            themeManager: themeManager,
                                          ),
                                    for (int index = 0;
                                        index < usuarioRol.data!.length;
                                        index++)
                                      if (FirebaseAuth
                                              .instance.currentUser!.email ==
                                          usuarioRol
                                              .data![index].correoElectronico)
                                        if (usuarioRol.data![index].rolAdmin !=
                                            false)
                                          const SizedBox(
                                              height: defaultPadding),
                                    for (int index = 0;
                                        index < usuarioRol.data!.length;
                                        index++)
                                      if (FirebaseAuth
                                              .instance.currentUser!.email ==
                                          usuarioRol
                                              .data![index].correoElectronico)
                                        if (usuarioRol.data![index].rolAdmin !=
                                            false)
                                          const PagosTotal(),
                                    for (int index = 0;
                                        index < usuarioRol.data!.length;
                                        index++)
                                      if (FirebaseAuth
                                              .instance.currentUser!.email ==
                                          usuarioRol
                                              .data![index].correoElectronico)
                                        if (usuarioRol.data![index].rolAdmin !=
                                            false)
                                          const SizedBox(
                                              height: defaultPadding),
                                    for (int index = 0;
                                        index < usuarioRol.data!.length;
                                        index++)
                                      if (FirebaseAuth
                                              .instance.currentUser!.email ==
                                          usuarioRol
                                              .data![index].correoElectronico)
                                        if (usuarioRol.data![index].rolAdmin !=
                                            false)
                                          DevolucionesTotal(
                                            themeManager: themeManager,
                                          ),
                                    for (int index = 0;
                                        index < usuarioRol.data!.length;
                                        index++)
                                      if (FirebaseAuth
                                              .instance.currentUser!.email ==
                                          usuarioRol
                                              .data![index].correoElectronico)
                                        if (usuarioRol.data![index].rolAdmin !=
                                            false)
                                          const SizedBox(
                                              height: defaultPadding),
                                    for (int index = 0;
                                        index < usuarioRol.data!.length;
                                        index++)
                                      if (FirebaseAuth
                                              .instance.currentUser!.email ==
                                          usuarioRol
                                              .data![index].correoElectronico)
                                        if (usuarioRol.data![index].rolAdmin !=
                                            false)
                                          PagosTotalAnf(
                                            themeManager: themeManager,
                                          ),
                                    for (int index = 0;
                                        index < usuarioRol.data!.length;
                                        index++)
                                      if (FirebaseAuth
                                              .instance.currentUser!.email ==
                                          usuarioRol
                                              .data![index].correoElectronico)
                                        if (usuarioRol.data![index].rolAdmin !=
                                            false)
                                          const SizedBox(
                                              height: defaultPadding),
                                    for (int index = 0;
                                        index < usuarioRol.data!.length;
                                        index++)
                                      if (FirebaseAuth
                                              .instance.currentUser!.email ==
                                          usuarioRol
                                              .data![index].correoElectronico)
                                        if (usuarioRol.data![index].rolAdmin !=
                                            false)
                                          const MultasTotal(),
                                    for (int index = 0;
                                        index < usuarioRol.data!.length;
                                        index++)
                                      if (FirebaseAuth
                                              .instance.currentUser!.email ==
                                          usuarioRol
                                              .data![index].correoElectronico)
                                        if (usuarioRol.data![index].rolAdmin !=
                                            false)
                                          const SizedBox(
                                              height: defaultPadding),
                                    for (int index = 0;
                                        index < usuarioRol.data!.length;
                                        index++)
                                      if (FirebaseAuth
                                              .instance.currentUser!.email ==
                                          usuarioRol
                                              .data![index].correoElectronico)
                                        if (usuarioRol.data![index].rolAdmin !=
                                            false)
                                          ListaUsuario(
                                            themeManager: themeManager,
                                          ),
                                    for (int index = 0;
                                        index < usuarioRol.data!.length;
                                        index++)
                                      if (FirebaseAuth
                                              .instance.currentUser!.email ==
                                          usuarioRol
                                              .data![index].correoElectronico)
                                        if (usuarioRol.data![index].rolAdmin !=
                                            false)
                                          const SizedBox(
                                              height: defaultPadding),
                                    for (int index = 0;
                                        index < usuarioRol.data!.length;
                                        index++)
                                      if (FirebaseAuth
                                              .instance.currentUser!.email ==
                                          usuarioRol
                                              .data![index].correoElectronico)
                                        if (usuarioRol.data![index].rolAdmin !=
                                            false)
                                          const ReservaActivaT(),
                                    for (int index = 0;
                                        index < usuarioRol.data!.length;
                                        index++)
                                      if (FirebaseAuth
                                              .instance.currentUser!.email ==
                                          usuarioRol
                                              .data![index].correoElectronico)
                                        if (usuarioRol.data![index].rolAdmin !=
                                            false)
                                          const SizedBox(
                                              height: defaultPadding),
                                    for (int index = 0;
                                        index < usuarioRol.data!.length;
                                        index++)
                                      if (FirebaseAuth
                                              .instance.currentUser!.email ==
                                          usuarioRol
                                              .data![index].correoElectronico)
                                        if (usuarioRol.data![index].rolAdmin !=
                                            false)
                                          const ReservaCanceladaT(),
                                    for (int index = 0;
                                        index < usuarioRol.data!.length;
                                        index++)
                                      if (FirebaseAuth
                                              .instance.currentUser!.email ==
                                          usuarioRol
                                              .data![index].correoElectronico)
                                        if (usuarioRol.data![index].rolAdmin !=
                                            false)
                                          const SizedBox(
                                              height: defaultPadding),
                                    for (int index = 0;
                                        index < usuarioRol.data!.length;
                                        index++)
                                      if (FirebaseAuth
                                              .instance.currentUser!.email ==
                                          usuarioRol
                                              .data![index].correoElectronico)
                                        if (usuarioRol.data![index].rolAdmin !=
                                            false)
                                          FutureBuilder(
                                              future: getReservas(),
                                              builder: (context,
                                                  AsyncSnapshot<
                                                          List<ReservaModel>>
                                                      reserva) {
                                                if (reserva.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                                                return ReservaFinalizadaT(
                                                  reservas: reserva.data!,
                                                );
                                              }),
                                  ],
                                ),
                              ),
                            );
                          }),
                      if (Responsive.isMobile(context))
                        const SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context))
                        Column(
                          children: [
                            FavoritoDetails(
                              themeManager: themeManager,
                            ),
                            const SizedBox(height: defaultPadding),
                            FutureBuilder(
                                future: getUsuario(),
                                builder: (context,
                                    AsyncSnapshot<List<UsuariosModel>>
                                        usuarios) {
                                  if (usuarios.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return FutureBuilder(
                                      future: getSitioVisitado(),
                                      builder: (context,
                                          AsyncSnapshot<
                                                  List<SitioVisitadoModel>>
                                              sitioVisitados) {
                                        if (sitioVisitados.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        return VisitadoDetails(
                                          themeManager: themeManager,
                                          listasitios: sitioVisitados.data!,
                                          listausuarios: usuarios.data!,
                                        );
                                      });
                                }),
                          ],
                        ),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  const SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we don't want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        FavoritoDetails(
                          themeManager: themeManager,
                        ),
                        const SizedBox(height: defaultPadding),
                        FutureBuilder(
                            future: getUsuario(),
                            builder: (context,
                                AsyncSnapshot<List<UsuariosModel>> usuarios) {
                              if (usuarios.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return FutureBuilder(
                                  future: getSitioVisitado(),
                                  builder: (context,
                                      AsyncSnapshot<List<SitioVisitadoModel>>
                                          sitioVisitados) {
                                    if (sitioVisitados.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    return VisitadoDetails(
                                      themeManager: themeManager,
                                      listasitios: sitioVisitados.data!,
                                      listausuarios: usuarios.data!,
                                    );
                                  });
                            }),
                      ],
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
