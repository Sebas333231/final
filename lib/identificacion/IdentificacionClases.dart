import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/HomePage/home_screens.dart';
import 'package:proyecto_final/theme/theme_constants.dart';
import 'package:proyecto_final/theme/theme_manager.dart';
import 'package:speech_to_text/speech_to_text.dart';

// ignore: must_be_immutable
class IdentificacionClases extends StatefulWidget {
  final ThemeManager themeManager;
  final String email;
  final String contrasena;
  IdentificacionClases(
      {Key? key,
      required this.themeManager,
      required this.email,
      required this.contrasena})
      : super(key: key);

  @override
  State<IdentificacionClases> createState() => _IdentificacionClasesState();
}

class _IdentificacionClasesState extends State<IdentificacionClases>
    with SingleTickerProviderStateMixin {
  _IdentificacionClasesState();

  SpeechToText speechToText = SpeechToText();

  var text = "Hello";
  var valor = "";
  var isListening = false;

  Future logInV() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: widget.email,
        password: widget.contrasena,
      );

      if (userCredential.user != null) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomeScreenPage(
                  themeManager: widget.themeManager,
                )));
      }
    } catch (e) {
      print(e);
      showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: const Text('StayAway'),
              content: Text('Error al verificar credenciales.'),
              actions: <Widget>[
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: const Text('Cerrar'),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomeScreenPage(
                                  themeManager: widget.themeManager,
                                )));
                      },
                    ),
                  ],
                ),
              ],
            );
          });
    }
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, responsive) {
      //Aqui al igual ya es responsive atravez de los condicionales
      if (responsive.maxWidth == 375) {
        return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 23.0, vertical: 27.0),
            child: Container(
                decoration: BoxDecoration(
                    color: const Color(0x20D2D2D2),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    /*
                    Las vistas tanto del registro como del inicio de sesion estan dentro de un expanded
                    porque me daba un error entonce la unica forma de que encontre de que funcionara fue con un exoanded
                    donde le di un tamaño con el flex
                    * */
                    Expanded(
                      flex: 5,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 50),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 25),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        fontSize: 33,
                                        fontFamily: 'DelaGothicOne',
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 25, right: 30),
                                  child: Text(
                                    'Viaja con Estilo, Destinos de Ensueño a Tu Alcance',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white
                                        //fontFamily: 'DelaGothicOne'
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Column(
                                children: [
                                  const Center(
                                    child: Text(
                                      "Diga la siguiente palabra:",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: defaultPadding,
                                  ),
                                  const SizedBox(
                                    height: defaultPadding,
                                  ),
                                  Center(
                                    child: Text(
                                      text,
                                      style: const TextStyle(
                                          fontSize: 60, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Center(
                                child: Text(
                                  valor,
                                  style: const TextStyle(
                                      fontSize: 60, color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(left: 65),
                              child: Center(
                                child: AvatarGlow(
                                  animate: isListening,
                                  duration: const Duration(milliseconds: 2000),
                                  glowColor: Colors.white,
                                  repeat: true,
                                  repeatPauseDuration:
                                      const Duration(milliseconds: 100),
                                  showTwoGlows: true,
                                  endRadius: 75.0,
                                  child: GestureDetector(
                                    onTapDown: (details) async {
                                      if (!isListening) {
                                        var available =
                                            await speechToText.initialize();
                                        if (available) {
                                          isListening = true;
                                          speechToText.listen(
                                              onResult: (result) {
                                            setState(() {
                                              valor = result.recognizedWords;
                                            });
                                          });
                                        }
                                      }
                                    },
                                    onTapUp: (details) {
                                      setState(() {
                                        isListening = false;
                                      });
                                      speechToText.stop();
                                      if (text == valor) {
                                        logInV();
                                      }
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 35,
                                      child: Icon(
                                        isListening
                                            ? Icons.mic
                                            : Icons.mic_none,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )));
      } else if (responsive.maxWidth <= 300) {
        return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
            child: Container(
                decoration: BoxDecoration(
                  color: //Colors.black,
                      const Color(0x20D2D2D2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 50),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 25),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: 'DelaGothicOne',
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 25, right: 30),
                                  child: Text(
                                    'Viaja con Estilo, Destinos de Ensueño a Tu Alcance',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white
                                        //fontFamily: 'DelaGothicOne'
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Column(
                                children: [
                                  const Center(
                                    child: Text(
                                      "Diga la siguiente palabra:",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: defaultPadding,
                                  ),
                                  Center(
                                    child: Text(
                                      text,
                                      style: const TextStyle(
                                          fontSize: 60, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Center(
                                  child: Text(
                                    valor,
                                    style: const TextStyle(
                                        fontSize: 60, color: Colors.white),
                                  ),
                                )),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(left: 60),
                              child: Center(
                                child: AvatarGlow(
                                  animate: isListening,
                                  duration: const Duration(milliseconds: 2000),
                                  glowColor: Colors.white,
                                  repeat: true,
                                  repeatPauseDuration:
                                      const Duration(milliseconds: 100),
                                  showTwoGlows: true,
                                  endRadius: 75.0,
                                  child: GestureDetector(
                                    onTapDown: (details) async {
                                      if (!isListening) {
                                        var available =
                                            await speechToText.initialize();
                                        if (available) {
                                          isListening = true;
                                          speechToText.listen(
                                              onResult: (result) {
                                            setState(() {
                                              valor = result.recognizedWords;
                                            });
                                          });
                                        }
                                      }
                                    },
                                    onTapUp: (details) {
                                      setState(() {
                                        isListening = false;
                                      });
                                      speechToText.stop();
                                      if (text == valor) {
                                        logInV();
                                      }
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 35,
                                      child: Icon(
                                        isListening
                                            ? Icons.mic
                                            : Icons.mic_none,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )));
      } else if (responsive.maxWidth <= 500) {
        return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 23.0, vertical: 27.0),
            child: Container(
                decoration: BoxDecoration(
                    color: const Color(0x20D2D2D2),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 50),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 25),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        fontSize: 33,
                                        fontFamily: 'DelaGothicOne',
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 25, right: 30),
                                  child: Text(
                                    'Viaja con Estilo, Destinos de Ensueño a Tu Alcance',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white
                                        //fontFamily: 'DelaGothicOne'
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Column(
                                children: [
                                  const Center(
                                    child: Text(
                                      "Diga la siguiente palabra:",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: defaultPadding,
                                  ),
                                  Center(
                                    child: Text(
                                      text,
                                      style: const TextStyle(
                                          fontSize: 60, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Center(
                                  child: Text(
                                    valor,
                                    style: const TextStyle(
                                        fontSize: 60, color: Colors.white),
                                  ),
                                )),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: AvatarGlow(
                                    animate: isListening,
                                    duration:
                                        const Duration(milliseconds: 2000),
                                    glowColor: Colors.white,
                                    repeat: true,
                                    repeatPauseDuration:
                                        const Duration(milliseconds: 100),
                                    showTwoGlows: true,
                                    endRadius: 75.0,
                                    child: GestureDetector(
                                      onTapDown: (details) async {
                                        if (!isListening) {
                                          var available =
                                              await speechToText.initialize();
                                          if (available) {
                                            isListening = true;
                                            speechToText.listen(
                                                onResult: (result) {
                                              setState(() {
                                                valor = result.recognizedWords;
                                              });
                                            });
                                          }
                                        }
                                      },
                                      onTapUp: (details) {
                                        setState(() {
                                          isListening = false;
                                        });
                                        speechToText.stop();
                                        if (text == valor) {
                                          logInV();
                                        }
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 35,
                                        child: Icon(
                                          isListening
                                              ? Icons.mic
                                              : Icons.mic_none,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )));
      } else if (responsive.maxWidth >= 1000) {
        return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 23.0, vertical: 30.0),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.width,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'StayAway',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 100,
                              fontFamily: 'CroissantOne'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 40),
                          child: Text(
                            "Descubre destinos inexplorados, "
                            "vive experiencias únicas y crea recuerdos que "
                            "durarán toda la vida. ¡Únete a la comunidad viajera "
                            "y haz realidad tus sueños de viaje!",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontFamily: 'CroissantOne'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 40),
                Expanded(
                    flex: 3,
                    child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0x20D2D2D2),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 6,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 50),
                                    const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 25),
                                          child: Text(
                                            'Login',
                                            style: TextStyle(
                                                fontSize: 35,
                                                fontFamily: 'DelaGothicOne',
                                                color: Colors.white),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 25, right: 30),
                                          child: Text(
                                            'Viaja con Estilo, Destinos de Ensueño a Tu Alcance',
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.white
                                                //fontFamily: 'DelaGothicOne'
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25.0),
                                      child: Column(
                                        children: [
                                          const Center(
                                            child: Text(
                                              "Diga la siguiente palabra:",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: defaultPadding,
                                          ),
                                          Center(
                                            child: Text(
                                              text,
                                              style: const TextStyle(
                                                  fontSize: 60,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25.0),
                                        child: Center(
                                          child: Text(
                                            valor,
                                            style: const TextStyle(
                                                fontSize: 60,
                                                color: Colors.white),
                                          ),
                                        )),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0),
                                      child: Center(
                                        child: AvatarGlow(
                                          animate: isListening,
                                          duration: const Duration(
                                              milliseconds: 2000),
                                          glowColor: Colors.white,
                                          repeat: true,
                                          repeatPauseDuration:
                                              const Duration(milliseconds: 100),
                                          showTwoGlows: true,
                                          endRadius: 75.0,
                                          child: GestureDetector(
                                            onTapDown: (details) async {
                                              if (!isListening) {
                                                var available =
                                                    await speechToText
                                                        .initialize();
                                                if (available) {
                                                  isListening = true;
                                                  speechToText.listen(
                                                      onResult: (result) {
                                                    setState(() {
                                                      valor = result
                                                          .recognizedWords;
                                                    });
                                                  });
                                                }
                                              }
                                            },
                                            onTapUp: (details) {
                                              setState(() {
                                                isListening = false;
                                              });
                                              speechToText.stop();
                                              if (text == valor) {
                                                logInV();
                                              }
                                            },
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 35,
                                              child: Icon(
                                                isListening
                                                    ? Icons.mic
                                                    : Icons.mic_none,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )))
              ],
            ));
      } else {
        return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 23.0, vertical: 27.0),
            child: Container(
                decoration: BoxDecoration(
                    color: const Color(0x20D2D2D2),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 50),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 25),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        fontSize: 33,
                                        fontFamily: 'DelaGothicOne',
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 25, right: 30),
                                  child: Text(
                                    'Viaja con Estilo, Destinos de Ensueño a Tu Alcance',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white
                                        //fontFamily: 'DelaGothicOne'
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Column(
                                children: [
                                  const Center(
                                    child: Text(
                                      "Diga la siguiente palabra:",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: defaultPadding,
                                  ),
                                  Center(
                                    child: Text(
                                      text,
                                      style: const TextStyle(
                                          fontSize: 60, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Center(
                                  child: Text(
                                    valor,
                                    style: const TextStyle(
                                        fontSize: 60, color: Colors.black),
                                  ),
                                )),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: AvatarGlow(
                                    animate: isListening,
                                    duration:
                                        const Duration(milliseconds: 2000),
                                    glowColor: Colors.white,
                                    repeat: true,
                                    repeatPauseDuration:
                                        const Duration(milliseconds: 100),
                                    showTwoGlows: true,
                                    endRadius: 75.0,
                                    child: GestureDetector(
                                      onTapDown: (details) async {
                                        if (!isListening) {
                                          var available =
                                              await speechToText.initialize();
                                          if (available) {
                                            isListening = true;
                                            speechToText.listen(
                                                onResult: (result) {
                                              setState(() {
                                                valor = result.recognizedWords;
                                              });
                                            });
                                          }
                                        }
                                      },
                                      onTapUp: (details) {
                                        setState(() {
                                          isListening = false;
                                        });
                                        speechToText.stop();
                                        if (text == valor) {
                                          logInV();
                                        }
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 35,
                                        child: Icon(
                                          isListening
                                              ? Icons.mic
                                              : Icons.mic_none,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )));
      }
    });
  }
}
