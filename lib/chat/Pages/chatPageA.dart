import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/chat/Pages/CustomCard.dart';
import 'package:proyecto_final/models/ReservaModel.dart';
import 'package:proyecto_final/models/UsuariosModel.dart';

class ChatPageA extends StatefulWidget {
  const ChatPageA({super.key});

  @override
  State<ChatPageA> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPageA> {
  List<UsuariosModel> misAnfitriones = [];

  late UsuariosModel miusuario;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getReservas(),
          builder: (context, AsyncSnapshot<List<ReservaModel>> reserva) {
            if (reserva.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return FutureBuilder(
                future: getUsuario(),
                builder: (context, AsyncSnapshot<List<UsuariosModel>> usuario) {
                  if (usuario.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  for (var s = 0; s < usuario.data!.length; s++) {
                    if (FirebaseAuth.instance.currentUser!.email ==
                        usuario.data![s].correoElectronico) {
                      miusuario = usuario.data![s];
                    }
                  }

                  for (var u = 0; u < usuario.data!.length; u++) {
                    for (var r = 0; r < reserva.data!.length; r++) {
                      if (reserva.data![r].estado == "Activo") {
                        if (reserva.data![r].sitio.usuario ==
                                usuario.data![u].id &&
                            reserva.data![r].usuario == miusuario.id) {
                          misAnfitriones.add(usuario.data![u]);
                        }
                      }
                    }
                  }

                  return ListView.builder(
                    itemCount: misAnfitriones.length,
                    itemBuilder: (context, index) => CustomCard(
                      usuario: misAnfitriones[index],
                      usuarioLogin: miusuario,
                    ),
                  );
                });
          }),
    );
  }
}
