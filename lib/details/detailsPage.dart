import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/chatbotweb/chatBotWeb.dart';
import 'package:proyecto_final/details/components/comentarioDetails.dart';
import 'package:proyecto_final/details/components/iconsMobile.dart';
import 'package:proyecto_final/details/components/imageDetails.dart';
import 'package:proyecto_final/details/components/mapaDetails.dart';
import 'package:proyecto_final/details/components/searchBar.dart';
import 'package:proyecto_final/details/components/titleDetails.dart';
import 'package:proyecto_final/details/screens/InferiorDetails.dart';
import 'package:proyecto_final/details/screens/leftDetails.dart';
import 'package:proyecto_final/details/screens/rightDetails.dart';
import 'package:proyecto_final/models/SitioModel.dart';
import 'package:proyecto_final/models/UsuariosModel.dart';
import 'package:proyecto_final/responsive.dart';
import 'package:proyecto_final/theme/theme_constants.dart';
import 'package:proyecto_final/theme/theme_manager.dart';
import 'package:universal_platform/universal_platform.dart';

class DetailsPage extends StatefulWidget {
  final SitioModel sitio;

  final List<UsuariosModel> usuario;

  final ThemeManager themeManager;

  const DetailsPage({
    super.key,
    required this.sitio,
    required this.usuario,
    required this.themeManager,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  _DetailsPageState() {
    if (!UniversalPlatform.isWeb) {
      /// Init Alan Button with project key from Alan AI Studio
      AlanVoice.addButton(
          "257726fb1e303ccaf96867d4b3de54d42e956eca572e1d8b807a3e2338fdd0dc/stage",
          buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT);

      /// Handle commands from Alan AI Studio
      AlanVoice.onCommand.add((command) {
        debugPrint("got new command ${command.toString()}");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              children: [
                const SizedBox(
                  height: defaultPadding,
                ),
                SearchHeader(
                  themeManager: widget.themeManager,
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
                TitleDetails(
                  sitio: widget.sitio,
                  usuario: widget.usuario,
                  themeManager: widget.themeManager,
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                if (Responsive.isMobile(context) ||
                    Responsive.isTablet(context))
                  IconsMobile(
                    sitio: widget.sitio,
                    usuario: widget.usuario,
                    themeManager: widget.themeManager,
                  ),
                const SizedBox(
                  height: defaultPadding,
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        ImagesDetails(
                          sitio: widget.sitio,
                        ),
                      ],
                    )),
                ImageButton(
                  sitio: widget.sitio,
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                SafeArea(
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      LeftDetails(
                        sitio: widget.sitio,
                      ),
                      if (Responsive.isDesktop(context))
                        Expanded(
                            flex: 1,
                            child: RightDetails(
                              sitio: widget.sitio,
                              themeManager: widget.themeManager,
                            )),
                    ],
                  ),
                ),
                if (Responsive.isMobile(context) ||
                    Responsive.isTablet(context))
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: RightDetails(
                            sitio: widget.sitio,
                            themeManager: widget.themeManager,
                          )),
                    ],
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
                ComentarioDetails(
                  sitio: widget.sitio,
                  usuario: usuario,
                  themeManager: widget.themeManager,
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
                MapaDetails(sitio: widget.sitio),
                const SizedBox(
                  height: defaultPadding,
                ),
                const Divider(
                  height: 1,
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                InferiorDetails(
                  sitio: widget.sitio,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _getFloating(),
    );
  }

  _getFloating() {
    if (UniversalPlatform.isWeb) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatBotWeb()),
          );
        },
        child: const Icon(Icons.support_agent),
      );
    } else if (UniversalPlatform.isWindows) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatBotWeb()),
          );
        },
        child: const Icon(Icons.support_agent),
      );
    } else {
      return null;
    }
  }
}
