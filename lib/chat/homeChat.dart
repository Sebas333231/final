import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/chat/Pages/chatPageA.dart';
import 'package:proyecto_final/chat/Pages/chatPageAm.dart';
import 'package:proyecto_final/chat/Pages/chatPageMu.dart';
import 'package:proyecto_final/chat/Pages/chatPageU.dart';
import 'package:proyecto_final/models/UsuariosModel.dart';
import 'package:proyecto_final/theme/theme_constants.dart';

class HomeChat extends StatefulWidget {
  const HomeChat({super.key});

  @override
  State<HomeChat> createState() => _HomeChatState();
}

class _HomeChatState extends State<HomeChat> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    int numTabs = 3;

    return FutureBuilder(
        future: getUsuario(),
        builder: (context, AsyncSnapshot<List<UsuariosModel>> usuario) {
          if (usuario.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          for (int index = 0; index < usuario.data!.length; index++) {
            if (FirebaseAuth.instance.currentUser!.email ==
                usuario.data![index].correoElectronico) {
              if (usuario.data![index].rolAdmin != false) {
                numTabs = 4;
              }
            }
          }

          return DefaultTabController(
            length: numTabs,
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: primaryColor,
                    )),
                backgroundColor: isDark ? secondaryColor : Colors.white,
                title: const Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 50,
                  height: 50,
                ),
                centerTitle: true,
                bottom: TabBar(
                  unselectedLabelColor: Colors.grey,
                  labelColor: primaryColor,
                  indicatorColor: primaryColor,
                  tabs: [
                    const Tab(
                      text: "Administradores",
                    ),
                    const Tab(
                      text: "Anfitriones",
                    ),
                    const Tab(
                      text: "Mis Huespedes",
                    ),
                    for (int index = 0; index < usuario.data!.length; index++)
                      if (FirebaseAuth.instance.currentUser!.email ==
                          usuario.data![index].correoElectronico)
                        if (usuario.data![index].rolAdmin != false)
                          const Tab(
                            text: "Usuarios",
                          ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  const ChatPageAm(),
                  const ChatPageA(),
                  const ChatPageMu(),
                  for (int index = 0; index < usuario.data!.length; index++)
                    if (FirebaseAuth.instance.currentUser!.email ==
                        usuario.data![index].correoElectronico)
                      if (usuario.data![index].rolAdmin != false)
                        const ChatPageU(),
                ],
              ),
            ),
          );
        });
  }
}
