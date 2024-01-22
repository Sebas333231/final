import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:proyecto_final/HomePage/home_screens.dart';
import 'package:proyecto_final/identificacion/Identificaci%C3%B3nWeb.dart';
import 'package:proyecto_final/identificacion/reconocimiento_facial.dart';
import 'package:proyecto_final/loginRecuperacion/LoginRecuperacion.dart';
import 'package:proyecto_final/theme/theme_manager.dart';
import 'package:http/http.dart' as http;
import 'package:universal_platform/universal_platform.dart';

import '../prueba.dart';

// ignore: must_be_immutable
class Login extends StatefulWidget {
  final ThemeManager themeManager;
  late TabController tabController;
  Login({Key? key, required this.tabController, required this.themeManager})
      : super(key: key);

  @override
  State<Login> createState() => _LoginState(tabController: tabController);
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  late TabController tabController;
  _LoginState({required this.tabController});

  bool _isObscure = true;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future logIn() async {
    if (UniversalPlatform.isAndroid) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ReconocimientoFacial(
                themeManager: widget.themeManager,
                email: _emailController.text.trim(),
                contrasena: _passwordController.text.trim(),
              )));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => IdentificacionWeb(
                themeManager: widget.themeManager,
                email: _emailController.text.trim(),
                contrasena: _passwordController.text.trim(),
              )));
    }
  }

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                    PreferredSize(
                        preferredSize: const Size.fromHeight(30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                children: [
                                  TabBar(
                                    controller: tabController,
                                    isScrollable: true,
                                    labelColor: Colors.white,
                                    unselectedLabelColor: Colors.white,
                                    indicatorColor: Colors.white,
                                    labelStyle: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                    tabs: const [
                                      Tab(
                                        text: 'Sign in',
                                      ),
                                      Tab(
                                        text: 'Sign up',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                    /*
                    Las vistas tanto del registro como del inicio de sesion estan dentro de un expanded
                    porque me daba un error entonce la unica forma de que encontre de que funcionara fue con un exoanded
                    donde le di un tamaño con el flex
                    * */
                    Expanded(
                      flex: 5,
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          //Primera vista del tab que es el login
                          SingleChildScrollView(
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
                                      padding:
                                          EdgeInsets.only(left: 25, right: 30),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 2.0, right: 2.0),
                                      child: TextField(
                                        style: const TextStyle(
                                            color: Colors.black),
                                        controller: _emailController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          hintText: 'Email',
                                          hintStyle: const TextStyle(
                                              color: Colors.black),
                                          fillColor: Colors.grey[200],
                                          filled: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 2.0, right: 2.0),
                                      child: TextField(
                                        style: const TextStyle(
                                            color: Colors.black),
                                        controller: _passwordController,
                                        obscureText: _isObscure,
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                              icon: Icon(_isObscure
                                                  ? Icons.visibility_off
                                                  : Icons.visibility),
                                              onPressed: () {
                                                setState(() {
                                                  _isObscure = !_isObscure;
                                                });
                                              }),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          border: InputBorder.none,
                                          hintText: 'Password',
                                          hintStyle: const TextStyle(
                                              color: Colors.black),
                                          filled: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginRecuperacionPage(
                                                        themeManager:
                                                            widget.themeManager,
                                                      )));
                                        },
                                        child: const Text(
                                          '¿Olvido la contraseña?',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(left: 65),
                                  child: InkWell(
                                    onTap: () {
                                      logIn();
                                    },
                                    child: Container(
                                      width: 200,
                                      height: 50,
                                      padding: const EdgeInsets.all(15.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Iniciar Sesión',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(),
                                      child: Text(
                                        'Continuar con',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.black12,
                                                  offset: Offset(
                                                    3.0,
                                                    3.0,
                                                  ),
                                                  blurRadius: 4.0,
                                                  spreadRadius: 2.0,
                                                ),
                                              ],
                                              image: const DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/google.png'),
                                                  fit: BoxFit.cover)),
                                        ),
                                        const SizedBox(width: 20),
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.black12,
                                                  offset: Offset(
                                                    3.0,
                                                    3.0,
                                                  ),
                                                  blurRadius: 4.0,
                                                  spreadRadius: 2.0,
                                                ),
                                              ],
                                              image: const DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/faceb.png'),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 40)
                              ],
                            ),
                          ),
                          //El register se realizo en una clase diferente
                          Register(
                            themeManager: widget.themeManager,
                          )
                        ],
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
                    PreferredSize(
                        preferredSize: const Size.fromHeight(30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                children: [
                                  TabBar(
                                    controller: tabController,
                                    isScrollable: true,
                                    labelColor: Colors.white,
                                    unselectedLabelColor: Colors.white,
                                    indicatorColor: Colors.white,
                                    labelStyle: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                    tabs: const [
                                      Tab(
                                        text: 'Sign in',
                                      ),
                                      Tab(
                                        text: 'Sign up',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          SingleChildScrollView(
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
                                      padding:
                                          EdgeInsets.only(left: 25, right: 30),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Container(
                                    //height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 1.0, right: 1.0),
                                      child: TextField(
                                        style: const TextStyle(
                                            color: Colors.black),
                                        controller: _emailController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          labelStyle: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.black),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          hintText: 'Email',
                                          hintStyle: const TextStyle(
                                              color: Colors.black),
                                          fillColor: Colors.grey[200],
                                          filled: false,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Container(
                                    //height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 1.0, right: 1.0),
                                      child: TextField(
                                        style: const TextStyle(
                                            color: Colors.black),
                                        controller: _passwordController,
                                        obscureText: _isObscure,
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                              icon: Icon(
                                                  _isObscure
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  size: 17),
                                              onPressed: () {
                                                setState(() {
                                                  _isObscure = !_isObscure;
                                                });
                                              }),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          border: InputBorder.none,
                                          hintText: 'Password',
                                          hintStyle: const TextStyle(
                                              color: Colors.black),
                                          filled: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginRecuperacionPage(
                                                        themeManager:
                                                            widget.themeManager,
                                                      )));
                                        },
                                        child: const Text(
                                          '¿Olvido la contraseña?',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(left: 60),
                                  child: InkWell(
                                    onTap: () {
                                      logIn();
                                    },
                                    child: Container(
                                      width: 120,
                                      height: 45,
                                      padding: const EdgeInsets.all(13.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Iniciar Sesión',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(),
                                      child: Text(
                                        'Continuar con',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.black12,
                                                  offset: Offset(
                                                    3.0,
                                                    3.0,
                                                  ),
                                                  blurRadius: 4.0,
                                                  spreadRadius: 2.0,
                                                ),
                                              ],
                                              image: const DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/google.png'),
                                                  fit: BoxFit.cover)),
                                        ),
                                        const SizedBox(width: 20),
                                        Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.black12,
                                                  offset: Offset(
                                                    3.0,
                                                    3.0,
                                                  ),
                                                  blurRadius: 4.0,
                                                  spreadRadius: 2.0,
                                                ),
                                              ],
                                              image: const DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/faceb.png'),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 40)
                              ],
                            ),
                          ),
                          Register(
                            themeManager: widget.themeManager,
                          )
                        ],
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
                    PreferredSize(
                        preferredSize: const Size.fromHeight(30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                children: [
                                  TabBar(
                                    controller: tabController,
                                    isScrollable: true,
                                    labelColor: Colors.white,
                                    unselectedLabelColor: Colors.white,
                                    indicatorColor: Colors.white,
                                    labelStyle: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                    tabs: const [
                                      Tab(
                                        text: 'Sign in',
                                      ),
                                      Tab(
                                        text: 'Sign up',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                    Expanded(
                      flex: 5,
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          SingleChildScrollView(
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
                                      padding:
                                          EdgeInsets.only(left: 25, right: 30),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 2.0, right: 2.0),
                                      child: TextField(
                                        style: const TextStyle(
                                            color: Colors.black),
                                        controller: _emailController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          hintText: 'Email',
                                          hintStyle: const TextStyle(
                                              color: Colors.black),
                                          fillColor: Colors.grey[200],
                                          filled: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 2.0, right: 2.0),
                                      child: TextField(
                                        style: const TextStyle(
                                            color: Colors.black),
                                        controller: _passwordController,
                                        obscureText: _isObscure,
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                              icon: Icon(_isObscure
                                                  ? Icons.visibility_off
                                                  : Icons.visibility),
                                              onPressed: () {
                                                setState(() {
                                                  _isObscure = !_isObscure;
                                                });
                                              }),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          border: InputBorder.none,
                                          hintText: 'Password',
                                          hintStyle: const TextStyle(
                                              color: Colors.black),
                                          filled: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginRecuperacionPage(
                                                        themeManager:
                                                            widget.themeManager,
                                                      )));
                                        },
                                        child: const Text(
                                          '¿Olvido la contraseña?',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        logIn();
                                      },
                                      child: Container(
                                        width: 200,
                                        height: 50,
                                        padding: const EdgeInsets.all(15.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Iniciar Sesión',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(),
                                      child: Text(
                                        'Continuar con',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.black12,
                                                  offset: Offset(
                                                    3.0,
                                                    3.0,
                                                  ),
                                                  blurRadius: 4.0,
                                                  spreadRadius: 2.0,
                                                ),
                                              ],
                                              image: const DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/google.png'),
                                                  fit: BoxFit.cover)),
                                        ),
                                        const SizedBox(width: 20),
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.black12,
                                                  offset: Offset(
                                                    3.0,
                                                    3.0,
                                                  ),
                                                  blurRadius: 4.0,
                                                  spreadRadius: 2.0,
                                                ),
                                              ],
                                              image: const DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/faceb.png'),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 40)
                              ],
                            ),
                          ),
                          Register(
                            themeManager: widget.themeManager,
                          )
                        ],
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
                            PreferredSize(
                                preferredSize: const Size.fromHeight(30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        children: [
                                          TabBar(
                                            controller: tabController,
                                            isScrollable: true,
                                            labelColor: Colors.white,
                                            unselectedLabelColor: Colors.white,
                                            indicatorColor: Colors.white,
                                            labelStyle: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                            tabs: const [
                                              Tab(
                                                text: 'Sign in',
                                              ),
                                              Tab(
                                                text: 'Sign up',
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                            Expanded(
                              flex: 6,
                              child: TabBarView(
                                controller: tabController,
                                children: [
                                  SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 50),
                                        const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 25),
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
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 2.0, right: 2.0),
                                              child: TextField(
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                controller: _emailController,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                Colors.white),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                Colors.white),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  hintText: 'Email',
                                                  hintStyle: const TextStyle(
                                                      color: Colors.black),
                                                  fillColor: Colors.grey[200],
                                                  filled: true,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 2.0, right: 2.0),
                                              child: TextField(
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                controller: _passwordController,
                                                obscureText: _isObscure,
                                                decoration: InputDecoration(
                                                  suffixIcon: IconButton(
                                                      icon: Icon(_isObscure
                                                          ? Icons.visibility_off
                                                          : Icons.visibility),
                                                      onPressed: () {
                                                        setState(() {
                                                          _isObscure =
                                                              !_isObscure;
                                                        });
                                                      }),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                Colors.white),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                Colors.white),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  border: InputBorder.none,
                                                  hintText: 'Password',
                                                  hintStyle: const TextStyle(
                                                      color: Colors.black),
                                                  filled: true,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              LoginRecuperacionPage(
                                                                themeManager: widget
                                                                    .themeManager,
                                                              )));
                                                },
                                                child: const Text(
                                                  '¿Olvido la contraseña?',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30.0),
                                          child: InkWell(
                                            onTap: () {
                                              logIn();
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  'Iniciar Sesión',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(),
                                              child: Text(
                                                'Continuar con',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color: Colors.black12,
                                                          offset: Offset(
                                                            3.0,
                                                            3.0,
                                                          ),
                                                          blurRadius: 4.0,
                                                          spreadRadius: 2.0,
                                                        ),
                                                      ],
                                                      image: const DecorationImage(
                                                          image: AssetImage(
                                                              'assets/images/google.png'),
                                                          fit: BoxFit.cover)),
                                                ),
                                                const SizedBox(width: 20),
                                                Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color: Colors.black12,
                                                          offset: Offset(
                                                            3.0,
                                                            3.0,
                                                          ),
                                                          blurRadius: 4.0,
                                                          spreadRadius: 2.0,
                                                        ),
                                                      ],
                                                      image: const DecorationImage(
                                                          image: AssetImage(
                                                              'assets/images/faceb.png'),
                                                          fit: BoxFit.cover)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20)
                                      ],
                                    ),
                                  ),
                                  Register(
                                    themeManager: widget.themeManager,
                                  )
                                ],
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
                    PreferredSize(
                        preferredSize: const Size.fromHeight(30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                children: [
                                  TabBar(
                                    controller: tabController,
                                    isScrollable: true,
                                    labelColor: Colors.white,
                                    unselectedLabelColor: Colors.white,
                                    indicatorColor: Colors.white,
                                    labelStyle: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                    tabs: const [
                                      Tab(
                                        text: 'Sign in',
                                      ),
                                      Tab(
                                        text: 'Sign up',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                    Expanded(
                      flex: 5,
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          SingleChildScrollView(
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
                                      padding:
                                          EdgeInsets.only(left: 25, right: 30),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 2.0, right: 2.0),
                                      child: TextField(
                                        style: const TextStyle(
                                            color: Colors.black),
                                        controller: _emailController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          hintText: 'Email',
                                          hintStyle: const TextStyle(
                                              color: Colors.black),
                                          fillColor: Colors.grey[200],
                                          filled: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 2.0, right: 2.0),
                                      child: TextField(
                                        style: const TextStyle(
                                            color: Colors.black),
                                        controller: _passwordController,
                                        obscureText: _isObscure,
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                              icon: Icon(_isObscure
                                                  ? Icons.visibility_off
                                                  : Icons.visibility),
                                              onPressed: () {
                                                setState(() {
                                                  _isObscure = !_isObscure;
                                                });
                                              }),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          border: InputBorder.none,
                                          hintText: 'Password',
                                          hintStyle: const TextStyle(
                                              color: Colors.black),
                                          filled: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginRecuperacionPage(
                                                        themeManager:
                                                            widget.themeManager,
                                                      )));
                                        },
                                        child: const Text(
                                          '¿Olvido la contraseña?',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        logIn();
                                      },
                                      child: Container(
                                        width: 200,
                                        height: 50,
                                        padding: const EdgeInsets.all(15.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Iniciar Sesión',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(),
                                      child: Text(
                                        'Continuar con',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.black12,
                                                  offset: Offset(
                                                    3.0,
                                                    3.0,
                                                  ),
                                                  blurRadius: 4.0,
                                                  spreadRadius: 2.0,
                                                ),
                                              ],
                                              image: const DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/google.png'),
                                                  fit: BoxFit.cover)),
                                        ),
                                        const SizedBox(width: 20),
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.black12,
                                                  offset: Offset(
                                                    3.0,
                                                    3.0,
                                                  ),
                                                  blurRadius: 4.0,
                                                  spreadRadius: 2.0,
                                                ),
                                              ],
                                              image: const DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/faceb.png'),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 40)
                              ],
                            ),
                          ),
                          Register(
                            themeManager: widget.themeManager,
                          )
                        ],
                      ),
                    ),
                  ],
                )));
      }
    });
  }
}

//Clase del registro
class Register extends StatefulWidget {
  final ThemeManager themeManager;
  const Register({Key? key, required this.themeManager}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  PageController? controller; // controlador

  int currentIndex = 0; //inicializacion de la lista

  double porcentaje = 0.20; //porcentaje del circulo de progreso de las vistas

  List<Vistas> listaVistas = <Vistas>[];

  late bool validacionColor =
      true; //variable del color del circulo de progreso de las vistas

  //funcion void de las vistas que estan en la lista
  @override
  void initState() {
    // TODO: implement initState
    controller = PageController(initialPage: 0);
    super.initState();
    _vistasregister();
  }

  TextEditingController _nombreCompletoController = TextEditingController();
  TextEditingController _tipoDocumentoController = TextEditingController();
  TextEditingController _numeroDocumentoController = TextEditingController();
  TextEditingController _telefonoController = TextEditingController();
  TextEditingController _idiomaController = TextEditingController();
  TextEditingController _descripcionController = TextEditingController();
  TextEditingController _tipoBancoController = TextEditingController();
  TextEditingController _cuentaBancariaController = TextEditingController();
  TextEditingController _numeroDaviplataController = TextEditingController();
  TextEditingController _celularController = TextEditingController();
  TextEditingController _imagenController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _contrasenhaController = TextEditingController();
  TextEditingController _confirmacionContasenhaController =
      TextEditingController();

  //Esta variable es para la validacion de los formularios
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //Variable para establecer la cantidad de numeros que van en el textfield del numero de la  tajeta
  var cardMask = MaskTextInputFormatter(
      mask: "#### #### #### ####", filter: {"#": RegExp(r'[0-9]')});

  var documento = MaskTextInputFormatter(
      mask: "# ### ### ###", filter: {"#": RegExp(r'[0-9]')});

  var inputtelefono = MaskTextInputFormatter(
      mask: "### ### ####", filter: {"#": RegExp(r'[0-9]')});

  Future signIn() async {
    try {
      if (passwordConfirmed()) {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _contrasenhaController.text.trim(),
        );

        final respuesta = await addUserDetails(
          _nombreCompletoController.text.trim(),
          _tipoDocumentoController.text.trim(),
          _numeroDocumentoController.text.trim(),
          _emailController.text.trim(),
          _telefonoController.text.trim(),
          _celularController.text.trim(),
          _idiomaController.text.trim(),
          _imagenController.text.trim(),
          _descripcionController.text.trim(),
          _tipoBancoController.text.trim(),
          _cuentaBancariaController.text.trim(),
          _numeroDaviplataController.text.trim(),
        );

        if (userCredential.user != null && respuesta == 201) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => HomeScreenPage(
                    themeManager: widget.themeManager,
                  )));
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<int> addUserDetails(
    String nombreCompleto,
    String tipoDocumento,
    String numeroDocumento,
    String email,
    String telefono,
    String celular,
    String idioma,
    String imagen,
    String descripcion,
    String banco,
    String numCuenta,
    String daviplata,
  ) async {
    String url = "";

    if (UniversalPlatform.isAndroid) {
      url = "http://10.0.2.2:8000/api/Usuarios/";
    } else {
      url = "http://127.0.0.1:8000/api/Usuarios/";
    }

    final Map<String, String> dataHeader = {
      'Content-Type': 'application/json; charset-UTF=8',
    };

    final Map<String, dynamic> dataBody = {
      "nombreCompleto": nombreCompleto,
      "tipoDocumento": tipoDocumento,
      "numeroDocumento": numeroDocumento,
      "correoElectronico": email,
      "telefono": telefono,
      "telefonoCelular": celular,
      "idioma": idioma,
      "foto": imagen,
      "rolAdmin": false,
      "descripcion": descripcion,
      "banco": banco,
      "numeroCuenta": numCuenta,
      "daviplata": daviplata,
      "fechaRegistro": "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}",
    };

    int resultado = 0;

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: dataHeader,
        body: json.encode(dataBody),
      );

      setState(() {
        resultado = response.statusCode;
      });
    } catch (e) {
      print(e);
    }

    return resultado;
  }

  bool passwordConfirmed() {
    if (_contrasenhaController.text.trim() ==
        _confirmacionContasenhaController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nombreCompletoController.dispose();
    _tipoDocumentoController.dispose();
    _numeroDocumentoController.dispose();
    _emailController.dispose();
    _telefonoController.dispose();
    _celularController.dispose();
    _idiomaController.dispose();
    _imagenController.dispose();
    _descripcionController.dispose();
    _tipoBancoController.dispose();
    _cuentaBancariaController.dispose();
    _numeroDaviplataController.dispose();
    _contrasenhaController.dispose();
    _confirmacionContasenhaController.dispose();
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        flex: 6, //tamaño de la vista
        child: PageView.builder(
            controller: controller,
            itemCount: listaVistas.length, //recorre la longitud de la lista
            onPageChanged: (int index) {
              //condicional para el aumento del porcentaje del progreso en el circulo
              if (index >= currentIndex) {
                setState(() {
                  currentIndex = index;
                  porcentaje += 0.20;
                });
              } else {
                setState(() {
                  currentIndex = index;
                  porcentaje -= 0.20;
                });
              }
            },
            itemBuilder: (context, index) {
              return Container(
                child: listaVistas[index].vista1, //Llmado de las vistas
              );
            }),
      ),
      //Aqui va el boton
      Expanded(
          flex: 1,
          child: CupertinoButton(
              padding: EdgeInsets.zero,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 55,
                    width: 55,
                    child: CircularProgressIndicator(
                      value: porcentaje,
                      backgroundColor: Colors.grey,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(porcentaje <= 0.20
                              ? Colors.yellow
                              : porcentaje <= 0.60
                                  ? Colors.lightGreen
                                  : porcentaje > 0.60
                                      ? Colors.green
                                      : Colors.white),
                      //Aqui evalua el color del boton dependiendo el porcentaje
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor:
                        validacionColor ? Colors.white : Colors.green,
                    child: const Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  //condicional que evalua los textfield si esta correcto puede avanzar a la siguiente pagina
                  if (currentIndex == listaVistas.length - 1) {
                    //condiiconal de las vistas
                    validacionColor; //color
                    if (porcentaje == 1) {
                      //condicional que cuando llegue a 1 podra avanzar al homepage
                      signIn();
                    }
                  }
                  //animacion al pasar la pagina
                  controller!.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                }
              }))
    ]);
  }

  //Lista dentro de la funcion void
  void _vistasregister() {
    var lista = <Vistas>[
      //Primera vista
      Vistas(
        vista1: Form(
            key: formKey, //Variable para la validacion del formulario
            //Lo hice en una clase diferente
            child: Row(
              children: [
                Expanded(
                  child: Prueba2(
                      //Paso de parametros
                      nombreCompleto: _nombreCompletoController,
                      tipoDocumento: _tipoDocumentoController,
                      numeroDocumento: _numeroDocumentoController),
                ),
              ],
            )),
      ),
      //segunda vista
      Vistas(
          vista1: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Prueba(
                descripcion: _descripcionController,
                telefono: _telefonoController,
                idioma: _idiomaController,
              ),
            )
          ],
        ),
      )),
      //Tercera vista
      Vistas(
        vista1: Form(
            key: formKey,
            child: Expanded(
              child: Prueba3(
                  tipoBanco: _tipoBancoController,
                  cuentaBancaria: _cuentaBancariaController,
                  numeroDaviplata: _numeroDaviplataController),
            )),
      ),
      //Cuarta vista
      Vistas(
          vista1: Form(
        key: formKey,
        child: Expanded(
          child: Prueba5(
              celularController: _celularController,
              imagenController: _imagenController),
        ),
      )),
      //Quinta Vista
      Vistas(
          vista1: Form(
        key: formKey,
        child: Expanded(
            child: Prueba4(
                email: _emailController,
                contrasenha: _contrasenhaController,
                confirmacionContasenha: _confirmacionContasenhaController)),
      )),
    ];
    setState(() {
      listaVistas = lista;
    });
  }
}

class Vistas {
  Widget vista1;

  Vistas({required this.vista1});
}
