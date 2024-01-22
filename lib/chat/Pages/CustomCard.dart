import 'package:flutter/material.dart';
import 'package:proyecto_final/chat/group/group_page.dart';
import 'package:proyecto_final/models/UsuariosModel.dart';
import 'package:proyecto_final/theme/theme_constants.dart';

class CustomCard extends StatelessWidget {
  final UsuariosModel usuario;
  final UsuariosModel usuarioLogin;
  const CustomCard({
    super.key,
    required this.usuario,
    required this.usuarioLogin,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GroupPage(
                      name: usuarioLogin.nombreCompleto,
                      userId: usuarioLogin.id.toString(),
                      usuario: usuario,
                      usuarioLogin: usuarioLogin,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ListTile(
              leading: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: Image.network(
                  usuario.foto == "" ? "assets/images/foto.png" : usuario.foto,
                  width: 37,
                  height: 37,
                ),
              ),
              title: Text(
                usuario.nombreCompleto,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
