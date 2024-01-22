import 'package:flutter/material.dart';
import 'package:proyecto_final/loginActualizacionUsuario/actualizarContrasena/ClasesContrasena.dart';
import 'package:proyecto_final/theme/theme_manager.dart';

class LoginContrasenaPage extends StatefulWidget {
  final String? contrasena;

  final ThemeManager themeManager;

  const LoginContrasenaPage(
      {Key? key, required this.themeManager, required this.contrasena})
      : super(key: key);

  @override
  State<LoginContrasenaPage> createState() =>
      _LoginContrasenaPageState(themeManager);
}

class _LoginContrasenaPageState extends State<LoginContrasenaPage>
    with SingleTickerProviderStateMixin {
  final ThemeManager themeManager;

  late int index;

  late bool imagen = true;

  @override
  void dispose() {
    super.dispose();
  }

  _LoginContrasenaPageState(this.themeManager);

  @override
  Widget build(BuildContext context) {
    //Widget que almacena las diferentes vistas del responsive
    return LayoutBuilder(builder: (context, responsive) {
      //primera vista del responsive
      if (responsive.maxWidth == 375) {
        return Scaffold(
            body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    color: Color(0x73606060),
                    image: DecorationImage(image: AssetImage(
                        //imagen ? '../images/imagen6.jpg' : '../images/imagen7.jpg',
                        'assets/images/imagen5.jpg'), fit: BoxFit.cover)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(color: Color(0x27000000)),
                  child: LoginContrasena(
                    themeManager: widget.themeManager,
                    contrasena: widget.contrasena,
                  ),
                )));
      } else if (responsive.maxWidth <= 300) {
        return Scaffold(
            body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage(
                        //imagen ? '../images/imagen4.jpg' : '../images/imagen5.jpg'
                        'assets/images/imagen5.jpg'), fit: BoxFit.cover)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(color: Color(0x27000000)),
                  child: LoginContrasena(
                    themeManager: widget.themeManager,
                    contrasena: widget.contrasena,
                  ),
                )));
      } else if (responsive.maxWidth <= 500) {
        return Scaffold(
            body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage(
                        //imagen ? '../images/imagen4.jpg' : '../images/imagen5.jpg'
                        'assets/images/imagen5.jpg'), fit: BoxFit.cover)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(color: Color(0x27000000)),
                  child: LoginContrasena(
                    themeManager: widget.themeManager,
                    contrasena: widget.contrasena,
                  ),
                )));
      } else if (responsive.maxWidth >= 1000) {
        return Scaffold(
            body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage(
                        //imagen ? '../images/imagen8.jpg' : '../images/imagen7.jpg'
                        'assets/images/imagen5.jpg'), fit: BoxFit.cover)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(color: Color(0x27000000)),
                  child: LoginContrasena(
                    themeManager: widget.themeManager,
                    contrasena: widget.contrasena,
                  ),
                )));
      } else {
        return Scaffold(
            body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage(
                        //imagen ? '../images/imagen4.jpg' : '../images/imagen5.jpg'
                        'assets/images/imagen5.jpg'), fit: BoxFit.cover)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(color: Color(0x27000000)),
                  child: LoginContrasena(
                    themeManager: widget.themeManager,
                    contrasena: widget.contrasena,
                  ),
                )));
      }
    });
  }
}
