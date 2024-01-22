import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:proyecto_final/models/UsuariosModel.dart';
import 'package:proyecto_final/pdf/url_text.dart';
import '../models/ReservaModel.dart';
import 'menu.dart';

class PdfPageScreen extends StatefulWidget {
  String reserva;
  String nombreCompleto;
  String telefono;
  String tipodocumento;
  String numeroDocumento;
  String estado;
  String lugar;

  PdfPageScreen(
      {Key? key,
      required this.reserva,
      required this.nombreCompleto,
      required this.telefono,
      required this.tipodocumento,
      required this.numeroDocumento,
        required this.estado, required this.lugar
      })
      : super(key: key);

  @override
  State<PdfPageScreen> createState() => _PdfPageScreenState(
      reserva: reserva,
      nombreCompleto: nombreCompleto,
      telefono: telefono,
      tipodocumento: tipodocumento,
      numeroDocumento: numeroDocumento,
     estado: estado,
    lugar: lugar
  );
}

class _PdfPageScreenState extends State<PdfPageScreen> {
  String reserva;
  String nombreCompleto;
  String telefono;
  String tipodocumento;
  String numeroDocumento;
  String estado;
  String lugar;
  _PdfPageScreenState(
      {required this.reserva,
      required this.nombreCompleto,
      required this.telefono,
      required this.tipodocumento,
      required this.numeroDocumento, required this.estado, required this.lugar});

  PrintingInfo? printingInfo;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final info = await Printing.info();
    setState(() {
      printingInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    pw.RichText.debug = true;
    final actions = <PdfPreviewAction>[
      if (!kIsWeb)
        const PdfPreviewAction(
          icon: Icon(
            Icons.save,
            color: Colors.green,
          ),
          onPressed: saveAsFile,
        ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Factura de la compra'),
        backgroundColor: Colors.green,
      ),
      body: PdfPreview(
        maxPageWidth: 700,
        actions: actions,
        onPrinted: showPrintedToast,
        onShared: showSharedToast,
        build: generatePdf,
      ),
    );
  }

  Future<Uint8List> generatePdf(final PdfPageFormat format) async {
    UsuariosModel usuarios;
    final doc = pw.Document(
      title: 'Flutter School',
    );
    final logoImage = pw.MemoryImage(
        (await rootBundle.load('../assets/images/logo.png'))
            .buffer
            .asUint8List());
    doc.addPage(
      pw.MultiPage(
        header: (final context) => pw.Image(
          alignment: pw.Alignment.topLeft,
          logoImage,
          fit: pw.BoxFit.contain,
          width: 70,
        ),
        build: (final context) => [
          pw.Container(
            padding: const pw.EdgeInsets.only(left: 10, bottom: 20),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Padding(padding: const pw.EdgeInsets.only(top: 60)),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Nombre del sitio:  ${lugar}',
                              style: pw.TextStyle(fontSize: 13)),
                          pw.Text('Nombre del cliente: ${nombreCompleto}',
                              style: pw.TextStyle(fontSize: 13)),
                          pw.Text('Telefono: ${telefono}',
                              style: pw.TextStyle(fontSize: 13)),
                          pw.Text(
                              'Documento: ${tipodocumento} ${numeroDocumento}',
                              style: pw.TextStyle(fontSize: 13)),
                          // pw.Text('Estado de la reserva: ${estado}',
                          //     style: pw.TextStyle(fontSize: 13)),
                        ]),
                    pw.SizedBox(width: 20),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Informacion de STAYAWAY',
                            style: pw.TextStyle(fontSize: 13)),
                        UrlText('STAYAWAY', 'telefono: 888-888-444',
                            style: TextStyle(fontSize: 13)),
                        UrlText('stayaway8455@gmail.com', 'STAYAWAY',
                            style: TextStyle(fontSize: 13)),
                      ],
                    ),
                    pw.SizedBox(width: 40),
                    pw.Padding(padding: pw.EdgeInsets.zero),
                  ],
                ),
              ],
            ),
          ),
          pw.Center(
            child: pw.Text(
              'Informacion de tu reserva',
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                fontSize: 30,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.only(top: 40, left: 140),
            child: pw.BarcodeWidget(
              data: reserva,
              width: 210,
              height: 210,
              barcode: pw.Barcode.qrCode(),
              drawText: false,
            ),
          ),
          pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                // pw.Padding(
                //   padding: pw.EdgeInsets.only(top: 50, left: 50),
                //   child: pw.Text(
                //     '¡Gracias por la compra!',
                //     style: pw.TextStyle(
                //         fontSize: 35,
                //         fontWeight: pw.FontWeight.bold
                //     ),
                //   ),
                // ),
                pw.Padding(
                  padding:
                      const pw.EdgeInsets.only(left: 165, top: 60),
                  child: pw.Text(
                    '¡STAYAWAY!',
                    style: pw.TextStyle(
                        fontSize: 25, fontWeight: pw.FontWeight.bold),
                  ),
                ),
              ]),
        ],
      ),
    );
    return doc.save();
  }
}
