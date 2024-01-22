import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/chat/Pages/CustomCard.dart';
import 'package:proyecto_final/models/UsuariosModel.dart';

class ChatPageU extends StatefulWidget {
  const ChatPageU({super.key});

  @override
  State<ChatPageU> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPageU> {
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

            return ListView.builder(
              itemCount: usuario.data!.length,
              itemBuilder: (context, index) => CustomCard(
                usuario: usuario.data![index],
                usuarioLogin: miusuario,
              ),
            );
          }),
    );
  }
}
