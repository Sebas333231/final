import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/chat/Pages/CustomCard.dart';
import 'package:proyecto_final/models/UsuariosModel.dart';

class ChatPageAm extends StatefulWidget {
  const ChatPageAm({
    super.key,
  });

  @override
  State<ChatPageAm> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPageAm> {
  List<UsuariosModel> administradores = [];

  late UsuariosModel miusuario;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
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
              if (usuario.data![u].rolAdmin != false &&
                  usuario.data![u].id != miusuario.id) {
                administradores.add(usuario.data![u]);
              }
            }

            return ListView.builder(
              itemCount: administradores.length,
              itemBuilder: (context, index) => CustomCard(
                usuario: administradores[index],
                usuarioLogin: miusuario,
              ),
            );
          }),
    );
  }
}
