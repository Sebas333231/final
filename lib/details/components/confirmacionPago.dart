import 'package:flutter/material.dart';
import 'package:proyecto_final/models/SitioModel.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../dashboard/screens/dashboard/components/reserva_anfitrion/misPagosRecibidos.dart';


class ConfirmacionPago extends StatefulWidget {
  SitioModel sitioModel;
  String fechaEntrada;
  String fechaSalida;
  String totalHuespedes;
  int valorDias;
  int valorTotal;
  int totalNoches;
  ConfirmacionPago({super.key, required this.sitioModel, required this.fechaEntrada, required this.fechaSalida, required this.totalHuespedes, required this.totalNoches, required this.valorDias, required this.valorTotal});

  @override
  State<ConfirmacionPago> createState() => _ConfirmacionPagoState(sitioModel: sitioModel, fechaEntrada: fechaEntrada, fechaSalida: fechaSalida, totalHuespedes: totalHuespedes, totalNoches: totalNoches, valorDias: valorDias, valorTotal: valorTotal);
}

class _ConfirmacionPagoState extends State<ConfirmacionPago> {
  SitioModel sitioModel;
  String fechaEntrada;
  String fechaSalida;
  String totalHuespedes;
  int valorDias;
  int valorTotal;
  int totalNoches;
  _ConfirmacionPagoState({required this.sitioModel, required this.fechaEntrada, required this.fechaSalida, required this.totalHuespedes, required this.totalNoches, required this.valorDias, required this.valorTotal});




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
            'Informacion de la reservacion'
        ),
        // actions: [
        //   IconButton(
        //       onPressed: (){
        //
        //       },
        //       icon: const Icon(Icons.check, size: 20, color: Color(0xFFAD974F),)
        //   )
        // ],
      ),
        body: LayoutBuilder(
            builder: (context, responsive){
              if(responsive.maxWidth <= 900){
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 30),
                          child: Text(
                            'A continuacion observara la informacion del sitio el cual usted esta ordenando antes de hacer el pago',
                            style: TextStyle(
                                fontSize: 25,
                              color: Colors.black
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsets.only(right: 50),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Nombre del sitio',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        color: Colors.black
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      widget.sitioModel.titulo,
                                      style: const TextStyle(
                                          fontSize: 17,
                                        color: Colors.grey
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Ubicación',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        color: Colors.black
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      widget.sitioModel.lugar,
                                      style: const TextStyle(
                                          fontSize: 17,
                                        color: Colors.grey
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsets.only(right: 50),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Fecha de llegada',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        color: Colors.black
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      fechaEntrada,
                                      style: const TextStyle(
                                          fontSize: 17,
                                        color: Colors.grey
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsets.only(left: 50),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Fecha de salida',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        color: Colors.black
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      fechaSalida,
                                      style: const TextStyle(
                                          fontSize: 17,
                                        color: Colors.grey
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'Huesped',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            color: Colors.black
                          ),
                        ),
                        Text(
                          totalHuespedes + " Huesped",
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 17
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Divider(
                          color: Color(0xFFAD974F),
                        ),
                        const Text(
                          'Costo total',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            color: Colors.black
                          ),
                        ),
                        Text(
                            'COP ${valorFormatted(valorTotal)}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 17
                          ),
                        ),
                        const SizedBox(height: 50),
                        Center(
                          child: QrImageView(
                            data: 'Codigo qr',
                            version: QrVersions.auto,
                            size: 350.0,
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child: Text(
                            'En este momento su reserva se encuentra en estado pendiente, si desea '
                                'que se active por favor haga el pago a traves del codigo qr anterior, despues '
                                'de esto su reservs sera activada',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 30)
                      ],
                    ),
                  ),
                );
              }else {
                return Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 30),
                              child: Text(
                                'A continuacion observara la informacion del sitio el cual usted esta ordenando antes de hacer el pago',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black
                                ),
                              ),
                            ),
                            const SizedBox(height: 50),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 50),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Nombre del sitio',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          widget.sitioModel.titulo,
                                          style: const TextStyle(
                                              fontSize: 17,
                                              color: Colors.grey
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 50),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Ubicación',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          widget.sitioModel.lugar,
                                          style: const TextStyle(
                                              fontSize: 17,
                                              color: Colors.grey
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 50),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Fecha de llegada',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          fechaEntrada,
                                          style: const TextStyle(
                                              fontSize: 17,
                                              color: Colors.grey
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 50),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Fecha de salida',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          fechaSalida,
                                          style: const TextStyle(
                                              fontSize: 17,
                                              color: Colors.grey
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            const Text(
                              'Huesped',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                              ),
                            ),
                            Text(
                              totalHuespedes + " Huesped",
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17
                              ),
                            ),
                            const SizedBox(height: 30),
                            const Divider(
                              color: Color(0xFFAD974F),
                            ),
                            const Text(
                              'Costo total',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                              ),
                            ),
                            Text(
                              'COP ${valorFormatted(valorTotal)}',
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17
                              ),
                            ),
                            const SizedBox(height: 30)
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: QrImageView(
                              data: 'Codigo qr',
                              version: QrVersions.auto,
                              size: 350.0,
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            child: Text(
                              'En este momento su reserva se encuentra en estado pendiente, si desea '
                                  'que se active por favor haga el pago a traves del codigo qr anterior, despues '
                                  'de esto su reservs sera activada',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 30)
                        ],
                      ),
                    )
                  ],
                );
              }
            }
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción a realizar cuando se presiona el botón flotante
        },
        child: const Icon(Icons.check, color: Color(0xFFAD974F),), // Icono del botón flotante
      ),
    );
  }
}
