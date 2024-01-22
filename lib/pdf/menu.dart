import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';


Future<void> saveAsFile(
    final BuildContext context,
    final LayoutCallback build,
    final PdfPageFormat pageFormat
    )async{
  final bytes = await build(pageFormat);

  final appDocDir = await getApplicationDocumentsDirectory();
  final appDocPath = appDocDir.path;
  final file = File("$appDocPath/document.pdf");
  print('save as File ${file.path}...');
  await file.writeAsBytes(bytes);
  await OpenFile.open(file.path);
}


void showPrintedToast(final BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
        content:
        Text(
          'Document printed successfully'
        )
    )
  );
}

void showSharedToast(final BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
        content:
        Text(
          'Document shared successfully'
        )
    )
  );
}

