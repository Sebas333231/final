import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FormsProvider with ChangeNotifier {
  FormsProvider() {
    createControllers();
    createControllers2();
  }

  final List<TextEditingController> _controllers = <TextEditingController>[];

  List<TextEditingController> get controller => _controllers;

  Future<void> createControllers() async {
    _controllers.add(TextEditingController());
    notifyListeners();
  }

  Future<void> deleteControllers({required int index}) async {
    if (index < _controllers.length) {
      _controllers.removeAt(index);
      notifyListeners();
    }
  }

  // Descripción

  final List<TextEditingController> _controllers2 = <TextEditingController>[];

  List<TextEditingController> get controller2 => _controllers2;

  Future<void> createControllers2() async {
    _controllers2.add(TextEditingController());
    notifyListeners();
  }

  Future<void> deleteControllers2({required int index}) async {
    if (index < _controllers2.length) {
      _controllers2.removeAt(index);
      notifyListeners();
    }
  }
}
