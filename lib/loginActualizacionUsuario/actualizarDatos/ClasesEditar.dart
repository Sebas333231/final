import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:proyecto_final/HomePage/home_screens.dart';
import 'package:proyecto_final/loginActualizacionUsuario/actualizarDatos/pruebaEditar.dart';
import 'package:proyecto_final/models/UsuariosModel.dart';
import 'package:proyecto_final/theme/theme_manager.dart';
import 'package:http/http.dart' as http;
import 'package:universal_platform/universal_platform.dart';

// ignore: must_be_immutable
class LoginEditar extends StatefulWidget {
  final UsuariosModel usuario;
  final ThemeManager themeManager;
  LoginEditar({Key? key, required this.themeManager, required this.usuario})
      : super(key: key);

  @override
  State<LoginEditar> createState() => _LoginEditarState();
}

class _LoginEditarState extends State<LoginEditar>
    with SingleTickerProviderStateMixin {
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
                    Expanded(
                      flex: 5,
                      child: RegisterEditar(
                        themeManager: widget.themeManager,
                        usuario: widget.usuario,
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
                      child: RegisterEditar(
                        themeManager: widget.themeManager,
                        usuario: widget.usuario,
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
                        child: RegisterEditar(
                          themeManager: widget.themeManager,
                          usuario: widget.usuario,
                        )),
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
                                child: RegisterEditar(
                                  themeManager: widget.themeManager,
                                  usuario: widget.usuario,
                                )),
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
                        child: RegisterEditar(
                          themeManager: widget.themeManager,
                          usuario: widget.usuario,
                        )),
                  ],
                )));
      }
    });
  }
}

//Clase del registro
class RegisterEditar extends StatefulWidget {
  final UsuariosModel usuario;
  final ThemeManager themeManager;
  const RegisterEditar(
      {Key? key, required this.themeManager, required this.usuario})
      : super(key: key);

  @override
  State<RegisterEditar> createState() => _RegisterEditarState();
}

class _RegisterEditarState extends State<RegisterEditar> {
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
    _vistasregister(widget.themeManager);
  }

  late TextEditingController _nombreCompletoController =
      TextEditingController(text: widget.usuario.nombreCompleto);
  late TextEditingController _tipoDocumentoController =
      TextEditingController(text: widget.usuario.tipoDocumento);
  late TextEditingController _numeroDocumentoController =
      TextEditingController(text: widget.usuario.numeroDocumento);
  late TextEditingController _telefonoController =
      TextEditingController(text: widget.usuario.telefono);
  late TextEditingController _idiomaController =
      TextEditingController(text: widget.usuario.idioma);
  late TextEditingController _descripcionController =
      TextEditingController(text: widget.usuario.descripcion);
  late TextEditingController _tipoBancoController =
      TextEditingController(text: widget.usuario.banco);
  late TextEditingController _cuentaBancariaController =
      TextEditingController(text: widget.usuario.numeroCuenta);
  late TextEditingController _numeroDaviplataController =
      TextEditingController(text: widget.usuario.daviplata);
  late TextEditingController _celularController =
      TextEditingController(text: widget.usuario.telefonoCelular);
  late TextEditingController _imagenController =
      TextEditingController(text: widget.usuario.foto);
  late TextEditingController _emailController =
      TextEditingController(text: widget.usuario.correoElectronico);
  late TextEditingController _fechaController =
      TextEditingController(text: widget.usuario.fechaRegistro);
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

  Future updateUser() async {
    try {
      final respuesta = await addUserEditDetails(
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
        _fechaController.text.trim(),
      );

      if (respuesta == 200) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomeScreenPage(
                  themeManager: widget.themeManager,
                )));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<int> addUserEditDetails(
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
    String fecha,
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
      "fechaRegistro": fecha,
    };

    int resultado = 0;

    try {
      final response = await http.put(
        Uri.parse(url + widget.usuario.id.toString() + "/"),
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

  @override
  void dispose() {
    // TODO: implement dispose
    _nombreCompletoController.dispose();
    _tipoDocumentoController.dispose();
    _numeroDocumentoController.dispose();
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
    _fechaController.dispose();
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
                      updateUser();
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
  void _vistasregister(ThemeManager thememanager) {
    var lista = <Vistas>[
      //Primera vista
      Vistas(
        vista1: Form(
            key: formKey, //Variable para la validacion del formulario
            //Lo hice en una clase diferente
            child: Row(
              children: [
                Expanded(
                  child: PruebaEditar2(
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
              child: PruebaEditar(
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
              child: PruebaEditar3(
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
          child: PruebaEditar5(
              celularController: _celularController,
              imagenController: _imagenController),
        ),
      )),
      //Quinta Vista
      Vistas(
          vista1: Form(
        key: formKey,
        child: Expanded(
            child: PruebaEditar4(
                themeManager: thememanager,
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
