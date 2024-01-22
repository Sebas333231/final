import 'package:flutter/material.dart';
import 'package:proyecto_final/identificacion/IdentificacionClases.dart';
import 'package:proyecto_final/theme/theme_manager.dart';

// ignore: must_be_immutable
class IdentificacionWeb extends StatefulWidget {

  final ThemeManager themeManager;

  final String email;
  final String contrasena;

  IdentificacionWeb({Key? key, required this.themeManager, required this.email, required this.contrasena}) : super(key: key);

  @override
  State<IdentificacionWeb> createState() => _IdentificacionWebState(themeManager);
}

class _IdentificacionWebState extends State<IdentificacionWeb> with SingleTickerProviderStateMixin {

  final ThemeManager themeManager;

  late int index;

  late bool imagen = true;

  //funcion void del tab
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _IdentificacionWebState(this.themeManager);

  @override
  Widget build(BuildContext context) {
    //Widget que almacena las diferentes vistas del responsive
    return LayoutBuilder(
        builder: (context, responsive){
          //primera vista del responsive
          if(responsive.maxWidth == 375){
            //Este condicional es para la imagen que dependiendo donde este ubicado en el tab asi mismo sera la imagen
            return Scaffold(
                body: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      color: Color(0x73606060),
                      image: DecorationImage(
                          image: AssetImage(
                              //imagen ? '../images/imagen6.jpg' : '../images/imagen7.jpg',
                              'assets/images/imagen5.jpg'
                          ),
                          fit: BoxFit.cover
                      )
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                        color: Color(0x27000000)
                    ),
                    child: IdentificacionClases(themeManager: widget.themeManager, email: widget.email, contrasena: widget.contrasena,),
                  )
                )
            );
          }else if (responsive.maxWidth <= 300){
            return Scaffold(
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            //imagen ? '../images/imagen4.jpg' : '../images/imagen5.jpg'
                            'assets/images/imagen5.jpg'
                        ),
                        fit: BoxFit.cover
                    )
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      color: Color(0x27000000)
                  ),
                  child: IdentificacionClases(themeManager: widget.themeManager, email: widget.email, contrasena: widget.contrasena,),
                )
              )
            );
          }else if(responsive.maxWidth <= 500){
            return Scaffold(
                body: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              //imagen ? '../images/imagen4.jpg' : '../images/imagen5.jpg'
                              'assets/images/imagen5.jpg'
                          ),
                          fit: BoxFit.cover
                      )
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      color: Color(0x27000000)
                    ),
                    child: IdentificacionClases(themeManager: widget.themeManager, email: widget.email, contrasena: widget.contrasena,),
                  )
                )
            );
          }else if(responsive.maxWidth >=1000){
            return Scaffold(
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      //imagen ? '../images/imagen8.jpg' : '../images/imagen7.jpg'
                        'assets/images/imagen5.jpg'
                    ),
                    fit: BoxFit.cover
                  )
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      color: Color(0x27000000)
                  ),
                  child: IdentificacionClases(themeManager: widget.themeManager, email: widget.email, contrasena: widget.contrasena,),
                )
              )
            );
          } else{
            return Scaffold(
                body: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              //imagen ? '../images/imagen4.jpg' : '../images/imagen5.jpg'
                              'assets/images/imagen5.jpg'
                          ),
                          fit: BoxFit.cover
                      )
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                        color: Color(0x27000000)
                    ),
                    child: IdentificacionClases(themeManager: widget.themeManager, email: widget.email, contrasena: widget.contrasena,),
                  )
                )
            );
          }
        }
    );
  }
}

