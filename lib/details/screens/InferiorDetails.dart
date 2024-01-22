import 'package:flutter/material.dart';
import 'package:proyecto_final/models/ReglaModel.dart';
import 'package:proyecto_final/models/SeguridadModel.dart';
import 'package:proyecto_final/models/SitioModel.dart';
import 'package:proyecto_final/responsive.dart';
import 'package:proyecto_final/theme/theme_constants.dart';

class InferiorDetails extends StatefulWidget {
  final SitioModel sitio;

  const InferiorDetails({
    super.key,
    required this.sitio,
  });

  @override
  State<InferiorDetails> createState() => _InferiorDetailsState();
}

class _InferiorDetailsState extends State<InferiorDetails> {
  double elevacion = 3;
  double elevacion2 = 3;
  double elevacion3 = 3;

  late ReglaModel reglaSitio;
  late SeguridadModel seguridadSitio;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          if (Responsive.isDesktop(context) || Responsive.isTablet(context))
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FutureBuilder(
                    future: getRegla(),
                    builder: (context, AsyncSnapshot<List<ReglaModel>> regla) {
                      if (regla.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      for (var x = 0; x < regla.data!.length; x++) {
                        if (widget.sitio.id == regla.data![x].sitio) {
                          reglaSitio = regla.data![x];
                        }
                      }

                      return InkWell(
                        onTap: () {
                          _modalRegla(context, reglaSitio);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              color: isDark ? secondaryColor : Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, elevacion),
                                ),
                              ]),
                          child: const Text(
                            "Reglas de la casa",
                            style: TextStyle(color: primaryColor),
                          ),
                        ),
                      );
                    }),
                FutureBuilder(
                    future: getSeguridad(),
                    builder: (context,
                        AsyncSnapshot<List<SeguridadModel>> seguridad) {
                      if (seguridad.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      for (var f = 0; f < seguridad.data!.length; f++) {
                        if (widget.sitio.id == seguridad.data![f].sitio) {
                          seguridadSitio = seguridad.data![f];
                        }
                      }

                      return InkWell(
                        onTap: () {
                          _modalSeguridad(context, seguridadSitio);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              color: isDark ? secondaryColor : Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, elevacion2),
                                ),
                              ]),
                          child: const Text(
                            "Seguridad y propiedad",
                            style: TextStyle(color: primaryColor),
                          ),
                        ),
                      );
                    }),
                InkWell(
                  onTap: () {
                    _modalPolitica(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        color: isDark ? secondaryColor : Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, elevacion3),
                          ),
                        ]),
                    child: const Text(
                      "Política de cancelación",
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                ),
              ],
            ),
          if (Responsive.isMobile(context))
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FutureBuilder(
                    future: getRegla(),
                    builder: (context, AsyncSnapshot<List<ReglaModel>> regla) {
                      if (regla.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      for (var x = 0; x < regla.data!.length; x++) {
                        if (widget.sitio.id == regla.data![x].sitio) {
                          reglaSitio = regla.data![x];
                        }
                      }

                      return InkWell(
                        onTap: () {
                          _modalRegla(context, reglaSitio);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              color: isDark ? secondaryColor : Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, elevacion),
                                ),
                              ]),
                          child: const Text(
                            "Reglas de la casa",
                            style: TextStyle(color: primaryColor),
                          ),
                        ),
                      );
                    }),
                const SizedBox(
                  height: defaultPadding,
                ),
                FutureBuilder(
                    future: getSeguridad(),
                    builder: (context,
                        AsyncSnapshot<List<SeguridadModel>> seguridad) {
                      if (seguridad.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      for (var f = 0; f < seguridad.data!.length; f++) {
                        if (widget.sitio.id == seguridad.data![f].sitio) {
                          seguridadSitio = seguridad.data![f];
                        }
                      }
                      return InkWell(
                        onTap: () {
                          _modalSeguridad(context, seguridadSitio);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              color: isDark ? secondaryColor : Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, elevacion2),
                                ),
                              ]),
                          child: const Text(
                            "Seguridad y propiedad",
                            style: TextStyle(color: primaryColor),
                          ),
                        ),
                      );
                    }),
                const SizedBox(
                  height: defaultPadding,
                ),
                InkWell(
                  onTap: () {
                    _modalPolitica(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        color: isDark ? secondaryColor : Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, elevacion3),
                          ),
                        ]),
                    child: const Text(
                      "Política de cancelación",
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

void _modalRegla(BuildContext context, ReglaModel regla) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 600,
            width: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                const SizedBox(
                  height: defaultPadding,
                ),
                Text(
                  "Reglas del sitio",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                Expanded(
                  child: SizedBox(
                    height: 495,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                        child: Text(
                      regla.descripcion,
                      style: const TextStyle(color: Colors.grey),
                    )),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cerrar"))
              ],
            )
          ],
        );
      });
}

void _modalSeguridad(BuildContext context, SeguridadModel seguridad) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 600,
            width: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                const SizedBox(
                  height: defaultPadding,
                ),
                Text(
                  "Seguridad y propiedad del sitio",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                Expanded(
                  child: SizedBox(
                    height: 495,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                        child: Text(
                      seguridad.descripcion,
                      style: const TextStyle(color: Colors.grey),
                    )),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cerrar"))
              ],
            )
          ],
        );
      });
}

void _modalPolitica(BuildContext context) {
  String texto = """
En StayAway, entendemos que las circunstancias pueden cambiar, y queremos asegurarnos de que tengas toda la información necesaria sobre nuestras políticas de cancelación para que puedas tomar decisiones informadas.

1. Flexibilidad para Ti:
Reconocemos que los planes pueden cambiar. Por eso, ofrecemos opciones flexibles de cancelación para adaptarnos a tus necesidades. Consulta nuestra sección de términos y condiciones para obtener detalles específicos sobre las políticas aplicables a tu reserva o compra.

2. Proceso Sencillo:
Queremos que el proceso de cancelación sea lo más sencillo posible. Encontrarás instrucciones claras sobre cómo cancelar tu reserva o servicio en nuestra plataforma. Si necesitas ayuda, nuestro equipo de soporte está disponible para guiarte a través del proceso.

3. Reembolsos Transparentes:
Nos comprometemos a ser transparentes en todo momento. Si estás elegible para un reembolso según nuestras políticas, te informaremos claramente sobre los plazos y el proceso. Trabajamos para procesar los reembolsos de manera oportuna para que puedas recibir el apoyo necesario.

4. Comunicación Abierta:
Valoramos la comunicación abierta. Si tienes alguna pregunta sobre nuestras políticas de cancelación o necesitas aclaraciones adicionales, no dudes en ponerte en contacto con nuestro equipo de atención al cliente. Estamos aquí para ayudarte.

5. Actualizaciones Periódicas:
Como parte de nuestro compromiso continuo contigo, revisamos y actualizamos nuestras políticas de cancelación de manera regular. Te recomendamos que consultes nuestras políticas antes de realizar cualquier reserva para estar al tanto de las últimas actualizaciones.

En StayAway, nos esforzamos por brindarte la mejor experiencia posible, incluso cuando las circunstancias cambian. Queremos que te sientas seguro al hacer negocios con nosotros y que tengas la confianza de que nuestras políticas de cancelación están diseñadas pensando en ti. ¡Gracias por confiar en nosotros!
""";

  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 600,
            width: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                const SizedBox(
                  height: defaultPadding,
                ),
                Text(
                  "Política de cancelación",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                Expanded(
                  child: SizedBox(
                    height: 495,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                        child: Text(
                      texto,
                      style: const TextStyle(color: Colors.grey),
                    )),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cerrar"))
              ],
            )
          ],
        );
      });
}
