import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:proyecto_final/LoginUsuario/Login/desplegables.dart';
import 'package:firebase_storage/firebase_storage.dart' as firabase_storage;
import 'package:proyecto_final/theme/theme_constants.dart';

// ignore: must_be_immutable
class Prueba extends StatefulWidget {
  TextEditingController descripcion = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController idioma = TextEditingController();
  Prueba(
      {Key? key,
      required this.descripcion,
      required this.telefono,
      required this.idioma})
      : super(key: key);

  @override
  State<Prueba> createState() => _PruebaState(
      descripcion: descripcion, telefono: telefono, idioma: idioma);
}

class _PruebaState extends State<Prueba> {
  TextEditingController descripcion = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController idioma = TextEditingController();
  _PruebaState(
      {required this.descripcion,
      required this.telefono,
      required this.idioma});

  bool addDescription = false;

  var inputtelefono = MaskTextInputFormatter(
      mask: "### ### ####", filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                    'Registrate',
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'DelaGothicOne',
                        color: Colors.white),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25, right: 30),
                  child: Text(
                    'Que esperas por registrate, no te detengas de disfrutar de las mejores vacaciones de tu vida!!',
                    style: TextStyle(fontSize: 12, color: Colors.white
                        //fontFamily: 'DelaGothicOne'
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    inputFormatters: [
                      inputtelefono
                    ], //LLamado de la variable que admite la cantidad de digitos que se pueden agregar a este textfield,
                    controller: telefono,
                    obscureText: false,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Telefono',
                      hintStyle: const TextStyle(color: Colors.black),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    //Este es el validador que me dice si el campo ya esta digitado o no
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Se requiere de un numero de telefono';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    controller: idioma,
                    obscureText: false,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Idioma',
                      hintStyle: const TextStyle(color: Colors.black),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    keyboardType: TextInputType.text,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Se requiere de este campo';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                    padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                    child: SwitchListTile(
                      title: const Text('¿Quieres agregar una descripcion?'),
                      value:
                          addDescription, //boolean para el accedo a una descripcion
                      onChanged: (bool? value) {
                        //cambio de estado de la boolean
                        setState(() {
                          if (value != null) {
                            addDescription = value;
                          }
                        });
                      },
                    )),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            //Si la varibale anterior es true aparece este campo para la descripcion
            if (addDescription)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: descripcion,
                      obscureText: false,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Descripcion',
                        hintStyle: const TextStyle(color: Colors.black),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                      keyboardType: TextInputType.text,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Se requiere de este campo';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 30)
          ]),
    );
  }
}

//Primera vista

// ignore: must_be_immutable
class Prueba2 extends StatefulWidget {
  TextEditingController nombreCompleto = TextEditingController();
  TextEditingController tipoDocumento = TextEditingController();
  TextEditingController numeroDocumento = TextEditingController();
  Prueba2(
      {Key? key,
      required this.nombreCompleto,
      required this.tipoDocumento,
      required this.numeroDocumento})
      : super(key: key);

  @override
  State<Prueba2> createState() => _Prueba2State(
      nombreCompleto: nombreCompleto,
      tipoDocumento: tipoDocumento,
      numeroDocumento: numeroDocumento);
}

class _Prueba2State extends State<Prueba2> {
  TextEditingController nombreCompleto = TextEditingController();
  TextEditingController tipoDocumento = TextEditingController();
  TextEditingController numeroDocumento = TextEditingController();
  _Prueba2State(
      {required this.nombreCompleto,
      required this.tipoDocumento,
      required this.numeroDocumento});

  String? cedula;

  bool addDescription = false;

  var documento = MaskTextInputFormatter(
      mask: "# ### ### ###", filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text(
                  'Registrate',
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'DelaGothicOne',
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25, right: 30),
                child: Text(
                  'Que esperas por registrate, no te detengas de disfrutar de las mejores vacaciones de tu vida!!',
                  style: TextStyle(fontSize: 12, color: Colors.white
                      //fontFamily: 'DelaGothicOne'
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                child: TextFormField(
                  style: const TextStyle(color: Colors.black),
                  controller: nombreCompleto,
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(
                      fontSize: 13,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Nombre Completo',
                    hintStyle: const TextStyle(color: Colors.black),
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Se requiere de este campo';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: const Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Tipo de Documento',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                items: options
                    .map((item) => DropdownMenuItem<String>(
                          value: item.valor,
                          child: Text(
                            item.titulo,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                value: cedula,
                onChanged: (String? value) {
                  setState(() {
                    cedula = value;
                    tipoDocumento.text = cedula!;
                  });
                  if (cedula == null || cedula!.isEmpty) {
                    return;
                  }
                },
                buttonStyleData: ButtonStyleData(
                  height: 50,
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.black26,
                    ),
                    color: Colors.white,
                  ),
                  elevation: 2,
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                  iconSize: 14,
                  iconEnabledColor: Colors.black,
                  iconDisabledColor: Colors.grey,
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white,
                  ),
                  offset: const Offset(-20, 0),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: const Radius.circular(40),
                    thickness: MaterialStateProperty.all<double>(6),
                    thumbVisibility: MaterialStateProperty.all<bool>(true),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                child: TextFormField(
                  style: const TextStyle(color: Colors.black),
                  inputFormatters: [documento],
                  controller: numeroDocumento,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    border: InputBorder.none,
                    hintText: 'Numero de Documento',
                    hintStyle: const TextStyle(color: Colors.black),
                    filled: true,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Se requiere de este campo';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

//Tercera vista
// ignore: must_be_immutable
class Prueba3 extends StatefulWidget {
  TextEditingController tipoBanco = TextEditingController();
  TextEditingController cuentaBancaria = TextEditingController();
  TextEditingController numeroDaviplata = TextEditingController();
  Prueba3(
      {Key? key,
      required this.tipoBanco,
      required this.cuentaBancaria,
      required this.numeroDaviplata})
      : super(key: key);

  @override
  State<Prueba3> createState() => _Prueba3State(
      tipoBanco: tipoBanco,
      cuentaBancaria: cuentaBancaria,
      numeroDaviplata: numeroDaviplata);
}

class _Prueba3State extends State<Prueba3> {
  _Prueba3State(
      {required this.tipoBanco,
      required this.cuentaBancaria,
      required this.numeroDaviplata});

  String? selectedValue;

  TextEditingController tipoBanco = TextEditingController();
  TextEditingController cuentaBancaria = TextEditingController();
  TextEditingController numeroDaviplata = TextEditingController();

  var inputtelefono = MaskTextInputFormatter(
      mask: "### ### ####", filter: {"#": RegExp(r'[0-9]')});

  var cardMask = MaskTextInputFormatter(
      mask: "#### #### #### ####", filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 50),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text(
                  'Registrate',
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'DelaGothicOne',
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25, right: 30),
                child: Text(
                  'Que esperas por registrate, no te detengas de disfrutar de las mejores vacaciones de tu vida!!',
                  style: TextStyle(fontSize: 12, color: Colors.white
                      //fontFamily: 'DelaGothicOne'
                      ),
                ),
              ),
              SizedBox(
                height: defaultPadding,
              ),
              Padding(
                padding: EdgeInsets.only(left: 25, right: 30),
                child: Text(
                  'A continuación, le pediremos sus datos bancarios, ya que al registrarse, se convertirá tanto en usuario como en anfitrión. Por lo tanto, le solicitamos que complete una de las opciones de pago en caso de que ofrezca un lugar para alquilar en esta aplicación. Esto nos permitirá realizar el pago correspondiente a sus ganancias.',
                  style: TextStyle(fontSize: 12, color: Colors.white
                      //fontFamily: 'DelaGothicOne'
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: const Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Banco',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                items: items
                    .map((item) => DropdownMenuItem<String>(
                          value: item.valor,
                          child: Text(
                            item.titulo,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                value: selectedValue,
                onChanged: (String? value) {
                  setState(() {
                    selectedValue = value;
                    tipoBanco.text = selectedValue!;
                  });

                  if (selectedValue == null || selectedValue!.isEmpty) {
                    return;
                  }
                },
                buttonStyleData: ButtonStyleData(
                  height: 50,
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.black26,
                    ),
                    color: Colors.white,
                  ),
                  elevation: 2,
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                  iconSize: 14,
                  iconEnabledColor: Colors.black,
                  iconDisabledColor: Colors.grey,
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white,
                  ),
                  offset: const Offset(-20, 0),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: const Radius.circular(40),
                    thickness: MaterialStateProperty.all<double>(6),
                    thumbVisibility: MaterialStateProperty.all<bool>(true),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                ),
              ),
            ),
          ),
          //Banco y Cuenta Bancaria
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                child: TextFormField(
                  style: const TextStyle(color: Colors.black),
                  inputFormatters: [cardMask],
                  controller: cuentaBancaria,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: '0000 0000 0000 0000',
                    hintStyle: const TextStyle(color: Colors.black),
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                child: TextFormField(
                  style: const TextStyle(color: Colors.black),
                  inputFormatters: [inputtelefono],
                  keyboardType: TextInputType.number,
                  controller: numeroDaviplata,
                  obscureText: false,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Numero de Daviplata',
                    hintStyle: const TextStyle(color: Colors.black),
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

//Cuarta vista

// ignore: must_be_immutable
class Prueba4 extends StatefulWidget {
  TextEditingController email = TextEditingController();
  TextEditingController contrasenha = TextEditingController();
  TextEditingController confirmacionContasenha = TextEditingController();
  Prueba4(
      {Key? key,
      required this.email,
      required this.contrasenha,
      required this.confirmacionContasenha})
      : super(key: key);

  @override
  State<Prueba4> createState() => _Prueba4State(
      email: email,
      contrasenha: contrasenha,
      confirmacionContasenha: confirmacionContasenha);
}

class _Prueba4State extends State<Prueba4> {
  TextEditingController email = TextEditingController();
  TextEditingController contrasenha = TextEditingController();
  TextEditingController confirmacionContasenha = TextEditingController();

  _Prueba4State(
      {required this.email,
      required this.contrasenha,
      required this.confirmacionContasenha});

  late bool _obscure = true;
  late bool _obscure2 = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 50),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text(
                  'Registrate',
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'DelaGothicOne',
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25, right: 30),
                child: Text(
                  'Que esperas por registrate, no te detengas de disfrutar de las mejores vacaciones de tu vida!!',
                  style: TextStyle(fontSize: 12, color: Colors.white
                      //fontFamily: 'DelaGothicOne'
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                child: TextFormField(
                  style: const TextStyle(color: Colors.black),
                  controller: email,
                  obscureText: false,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Email',
                    hintStyle: const TextStyle(color: Colors.black),
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Se requiere de este campo';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                child: TextFormField(
                  style: const TextStyle(color: Colors.black),
                  controller: contrasenha,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Contraseña',
                      hintStyle: const TextStyle(color: Colors.black),
                      fillColor: Colors.grey[200],
                      filled: true,
                      //prefixIcon: Icon(Icons.visibility_off),
                      suffixIcon: IconButton(
                        icon: Icon(
                            _obscure ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _obscure = !_obscure;
                          });
                        },
                      )),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Se requiere de este campo';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                child: TextFormField(
                  style: const TextStyle(color: Colors.black),
                  controller: confirmacionContasenha,
                  obscureText: _obscure2,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Confirmacion de Contraseña',
                      hintStyle: const TextStyle(color: Colors.black),
                      fillColor: Colors.grey[200],
                      filled: true,
                      suffixIcon: IconButton(
                        icon: Icon(_obscure2
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _obscure2 = !_obscure2;
                          });
                        },
                      )),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Se requiere de este campo';
                    }
                    if (confirmacionContasenha.text != contrasenha.text) {
                      return "Contraseña incorrecta";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class Prueba5 extends StatefulWidget {
  TextEditingController celularController = TextEditingController();
  TextEditingController imagenController = TextEditingController();

  Prueba5(
      {Key? key,
      required this.celularController,
      required this.imagenController})
      : super(key: key);

  @override
  State<Prueba5> createState() =>
      _Prueba5State(celularController: celularController);
}

class _Prueba5State extends State<Prueba5> {
  TextEditingController celularController = TextEditingController();

  _Prueba5State({required this.celularController});

  var inputtelefono = MaskTextInputFormatter(
      mask: "### ### ####", filter: {"#": RegExp(r'[0-9]')});

  String selectFile = '';
  Uint8List? selectedImagenInBytes;
  int imagenCounts = 0;
  List<Uint8List> pickedImagesBytes = [];
  String foto = '';
  String imageUrl = '';
  String botonImagen = 'Seleccionar foto de perfil';

  _selectFile(bool imagenFrom) async {
    FilePickerResult? fileResult = await FilePicker.platform.pickFiles();

    if (fileResult != null) {
      setState(() {
        selectFile = fileResult.files.first.name;
        selectedImagenInBytes = fileResult.files.first.bytes;
      });
    }
    final url = await _uploadFile();
    print(url);
    print(selectFile);
    setState(() {
      botonImagen = "Listo";
    });
  }

  Future<String> _uploadFile() async {
    String imageUrl = '';
    try {
      firabase_storage.UploadTask uploadTask;

      firabase_storage.Reference ref = firabase_storage.FirebaseStorage.instance
          .ref()
          .child('user')
          .child('/' + selectFile);

      final metadata =
          firabase_storage.SettableMetadata(contentType: 'image/jpeg');

      uploadTask = ref.putData(selectedImagenInBytes!, metadata);

      await uploadTask.whenComplete(() => null);
      imageUrl = await ref.getDownloadURL();
      setState(() {
        widget.imagenController.text = imageUrl;
      });
    } catch (e) {
      print(e);
    }
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 50),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text(
                  'Registrate',
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'DelaGothicOne',
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25, right: 30),
                child: Text(
                  'Que esperas por registrate, no te detengas de disfrutar de las mejores vacaciones de tu vida!!',
                  style: TextStyle(fontSize: 12, color: Colors.white
                      //fontFamily: 'DelaGothicOne'
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                child: TextFormField(
                  style: const TextStyle(color: Colors.black),
                  inputFormatters: [inputtelefono],
                  keyboardType: TextInputType.number,
                  controller: celularController,
                  obscureText: false,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Télefono Celular',
                    hintStyle: const TextStyle(color: Colors.black),
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Se requiere de este campo';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: selectFile.isEmpty
                  ? const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                        "assets/images/logo3.jpg",
                      ),
                    )
                  : CircleAvatar(
                      radius: 50,
                      backgroundImage: MemoryImage(selectedImagenInBytes!),
                    )),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () async {
              setState(() {
                botonImagen = "Cargando";
              });
              _selectFile(true);
            },
            child: Container(
              width: 300,
              height: 60,
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  botonImagen,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.only(left: 25, right: 30),
              child: Text(
                'Cuando seleccione su foto de perfil, por favor, espere un momento mientras se carga en nuestro servidor.',
                style: TextStyle(fontSize: 12, color: Colors.white
                    //fontFamily: 'DelaGothicOne'
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
