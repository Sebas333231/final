import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_final/dashboard/screens/dashboard/components/reserva_todo/actualiarPagosAnfi.dart';
import 'package:proyecto_final/models/PagoAnfitrionModel.dart';
import 'package:proyecto_final/models/UsuariosModel.dart';
import 'package:proyecto_final/pdf/pdf_screen.dart';
import 'package:proyecto_final/responsive.dart';
import 'package:proyecto_final/theme/theme_constants.dart';
import 'package:proyecto_final/theme/theme_manager.dart';

// Tabla de los pagos pendientes o realizados a los anfitriones

class PagosTotalAnf extends StatelessWidget {
  final ThemeManager themeManager;
  const PagosTotalAnf({
    Key? key,
    required this.themeManager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: isDark ? secondaryColor : const Color(0xFFFF2F0F2),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Todos los pagos hechos a anfitriones",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          FutureBuilder(
              future: getPagosAnfitrion(),
              builder:
                  (context, AsyncSnapshot<List<PagoAnfitrionModel>> pagoAnfi) {
                if (pagoAnfi.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (pagoAnfi.data != null) {
                  return SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: InteractiveViewer(
                      constrained: false,
                      scaleEnabled: false,
                      child: DataTable(
                        columnSpacing: defaultPadding,
                        // minWidth: 600,
                        columns: const [
                          DataColumn(
                            label: Text("Sitio"),
                          ),
                          DataColumn(
                            label: Text("Usuario"),
                          ),
                          DataColumn(
                            label: Text("Fecha Radicado"),
                          ),
                          DataColumn(
                            label: Text("Estado"),
                          ),
                          DataColumn(
                            label: Text(""),
                          ),
                          DataColumn(
                            label: Text(""),
                          ),
                          DataColumn(
                            label: Text(""),
                          ),
                        ],
                        rows: List.generate(
                          pagoAnfi.data!.length,
                          (index) => PagosDataRow(
                              pagoAnfi.data![index], context, themeManager),
                        ),
                      ),
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ],
      ),
    );
  }
}

DataRow PagosDataRow(PagoAnfitrionModel PagosInfo, BuildContext context,
    ThemeManager themeManager) {
  bool isDark = Theme.of(context).brightness == Brightness.dark;

  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            SvgPicture.asset(
              "assets/icons/pagos.svg",
              height: 30,
              width: 30,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(PagosInfo.reserva.sitio.titulo),
            ),
          ],
        ),
      ),
      DataCell(FutureBuilder(
          future: getUsuario(),
          builder: (context, AsyncSnapshot<List<UsuariosModel>> usuario1) {
            if (usuario1.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            String nombreUsuario = "";

            for (var v = 0; v < usuario1.data!.length; v++) {
              if (PagosInfo.reserva.usuario == usuario1.data![v].id) {
                nombreUsuario = usuario1.data![v].nombreCompleto;
              }
            }

            return Text(nombreUsuario);
          })),
      DataCell(Text(PagosInfo.fechaPago)),
      DataCell(Text(PagosInfo.estado)),
      DataCell(ElevatedButton(
        onPressed: () {
          _modalPagosRecibidos(context, PagosInfo);
        },
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(primaryColor)),
        child: const Text("Ver"),
      )),
      DataCell(ElevatedButton(
        onPressed: () {
          _modalActualizarPagosAnf(context, PagosInfo, themeManager);
        },
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(primaryColor)),
        child: const Text("Actualizar Estado"),
      )),
      DataCell(FutureBuilder(
          future: getUsuario(),
          builder: (context, AsyncSnapshot<List<UsuariosModel>> usuario1) {
            if (usuario1.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            String nombreCompleto = "";
            String telefono = "";
            String tipodocumento = "";
            String numeroDocumento = "";
            String estado = "";
            String lugar = "";
            for (var v = 0; v < usuario1.data!.length; v++) {
              if (PagosInfo.reserva.usuario == usuario1.data![v].id) {

                nombreCompleto = usuario1.data![v].nombreCompleto;
                telefono = usuario1.data![v].telefono;
                tipodocumento = usuario1.data![v].tipoDocumento;
                numeroDocumento = usuario1.data![v].numeroDocumento;
                estado = PagosInfo.estado;
                lugar = PagosInfo.reserva.sitio.titulo;
              }
            }
            return IconButton(
                onPressed: () {
                  String pedido = "";
                  pedido = "${pedido} Usted hizo una pago de una reserva con la siguiente informacion: " +
                      "\n Nombre del sitio: ${PagosInfo.reserva.sitio.titulo}" +
                      "\n Ubicacion: ${PagosInfo.reserva.sitio.lugar} " +
                      "\n Fecha de Entrada: ${PagosInfo.reserva.fechaEntrada} " +
                      "\n Fecha de Salida: ${PagosInfo.reserva.fechaSalida} " +
                      "\n Medio de pago: ${PagosInfo.medioPago}" +
                      "\n Fecha de pago: ${PagosInfo.fechaPago}"
                          "\n Total de Huespedes: ${PagosInfo.reserva.numHuespedes} " +
                      "\n Total precio de la estadia: ${PagosInfo.reserva.precioFinal}";

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PdfPageScreen(
                        reserva: pedido,
                        nombreCompleto: nombreCompleto,
                        telefono: telefono,
                        tipodocumento: tipodocumento,
                        numeroDocumento: numeroDocumento,
                        estado: estado,
                        lugar: lugar,
                      )
                  )
                  );
                },
                icon: SvgPicture.asset(
                  "assets/icons/pdf.svg",
                  color: isDark ? Colors.white : primaryColor,
                  width: 20,
                  height: 20,
                ));
          })),
    ],
  );
}

void _modalPagosRecibidos(BuildContext context, PagoAnfitrionModel pago) {
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
                Image.network(
                  "assets/images/logo.png",
                  width: 100,
                  height: 100,
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30, left: 30),
                    child: SizedBox(
                      height: 495,
                      width: MediaQuery.of(context).size.width,
                      child: GridView.count(
                        crossAxisCount: Responsive.isMobile(context) ? 1 : 3,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Sitio",
                                  style: Theme.of(context).textTheme.titleLarge,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                Text(
                                  pago.reserva.sitio.titulo,
                                  style: const TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Nombre Completo",
                                  style: Theme.of(context).textTheme.titleLarge,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                FutureBuilder(
                                    future: getUsuario(),
                                    builder: (context,
                                        AsyncSnapshot<List<UsuariosModel>>
                                            usuario) {
                                      if (usuario.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      String nombreUsuario = "";

                                      for (var v = 0;
                                          v < usuario.data!.length;
                                          v++) {
                                        if (pago.reserva.usuario ==
                                            usuario.data![v].id) {
                                          nombreUsuario =
                                              usuario.data![v].nombreCompleto;
                                        }
                                      }
                                      return Text(
                                        nombreUsuario,
                                        style:
                                            const TextStyle(color: Colors.grey),
                                        textAlign: TextAlign.center,
                                      );
                                    }),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Fecha de pago",
                                  style: Theme.of(context).textTheme.titleLarge,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                Text(
                                  pago.fechaPago,
                                  style: const TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Fecha del radicado",
                                  style: Theme.of(context).textTheme.titleLarge,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                Text(
                                  pago.fechaRadicado,
                                  style: const TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Medio de Pago",
                                  style: Theme.of(context).textTheme.titleLarge,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                Text(
                                  pago.medioPago,
                                  style: const TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Estado de pago",
                                  style: Theme.of(context).textTheme.titleLarge,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                Text(
                                  pago.estado,
                                  style: const TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Fecha de entrada",
                                  style: Theme.of(context).textTheme.titleLarge,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                Text(
                                  pago.reserva.fechaEntrada,
                                  style: const TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Fecha de salida",
                                  style: Theme.of(context).textTheme.titleLarge,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                Text(
                                  pago.reserva.fechaSalida,
                                  style: const TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Numero de huespedes",
                                  style: Theme.of(context).textTheme.titleLarge,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                Text(
                                  pago.reserva.numHuespedes.toString(),
                                  style: const TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Número de Bebes",
                                  style: Theme.of(context).textTheme.titleLarge,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                Text(
                                  pago.reserva.numBebes.toString(),
                                  style: const TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Número de Mascotas",
                                  style: Theme.of(context).textTheme.titleLarge,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                Text(
                                  pago.reserva.numMascotas.toString(),
                                  style: const TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Valor Reserva",
                                  style: Theme.of(context).textTheme.titleLarge,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                Text(
                                  "\$ ${valorFormatted(pago.reserva.precioFinal)} COP",
                                  style: const TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Valor Ganancia",
                                  style: Theme.of(context).textTheme.titleLarge,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                Text(
                                  "\$ ${valorFormatted(pago.reserva.gananciaAnfitrion)} COP",
                                  style: const TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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

String valorFormatted(int valor) {
  return NumberFormat.currency(
    symbol: '',
    locale: 'es_CO',
    decimalDigits: 0,
  ).format(valor);
}

void _modalActualizarPagosAnf(
    BuildContext context, PagoAnfitrionModel pago, ThemeManager themeManager) {
  showDialog(
      context: context,
      builder: (context) {
        return ActualizarPagosAnfitrion(
            PagosInfo: pago, themeManager: themeManager);
      });
}
