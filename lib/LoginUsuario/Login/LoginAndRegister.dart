import 'package:flutter/material.dart';
import 'package:proyecto_final/LoginUsuario/Login/Clases.dart';
import 'package:proyecto_final/theme/theme_manager.dart';

class LoginPage extends StatefulWidget {

  final ThemeManager themeManager;

  const LoginPage({Key? key, required this.themeManager}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState(themeManager);
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {

  final ThemeManager themeManager;

  late TabController tabController;

  late int index;

  late bool imagen = true;

  //funcion void del tab
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {
        index = tabController.index;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  _LoginPageState(this.themeManager);

  @override
  Widget build(BuildContext context) {
    //Widget que almacena las diferentes vistas del responsive
    return LayoutBuilder(
        builder: (context, responsive){
          //primera vista del responsive
          if(responsive.maxWidth == 375){
            //Este condicional es para la imagen que dependiendo donde este ubicado en el tab asi mismo sera la imagen
            if(tabController.index == 1){
              imagen = true;
            }else{
              imagen = false;
            }
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
                    child: Login(tabController: tabController, themeManager: widget.themeManager,),
                  )
                )
            );
          }else if (responsive.maxWidth <= 300){
            if(tabController.index == 1){
              imagen = true;
            }else{
              imagen = false;
            }
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
                  child: Login(tabController: tabController,  themeManager: widget.themeManager,),
                )
              )
            );
          }else if(responsive.maxWidth <= 500){
            if(tabController.index == 1){
              imagen = true;
            }else{
              imagen = false;
            }
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
                    child: Login(tabController: tabController,  themeManager: widget.themeManager,),
                  )
                )
            );
          }else if(responsive.maxWidth >=1000){
            if(tabController.index == 1){
              imagen = true;
            }else{
              imagen = false;
            }
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
                  child: Login(tabController: tabController,  themeManager: widget.themeManager,),
                )
              )
            );
          } else{
            if(tabController.index == 1){
              imagen = true;
            }else{
              imagen = false;
            }
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
                    child: Login(tabController: tabController,  themeManager: widget.themeManager,),
                  )
                )
            );
          }
        }
    );
  }
}

