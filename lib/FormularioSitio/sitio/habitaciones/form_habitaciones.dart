import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/FormularioSitio/forms_provider.dart';
import 'package:proyecto_final/theme/theme_constants.dart';

class Example extends StatefulWidget {
  final List<String> tituloHabitaciones;
  final List<String> descripcionHabitaciones;

  Example(
      {Key? key,
      required this.tituloHabitaciones,
      required this.descripcionHabitaciones})
      : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  @override
  Widget build(BuildContext context) {
    List<TextEditingController> titleControllers =
        context.watch<FormsProvider>().controller;
    List<TextEditingController> descriptionControllers =
        context.watch<FormsProvider>().controller2;

    return Scaffold(
      body: ListView(
        children: [
          for (int index = 0; index < titleControllers.length; index++)
            Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 2.0, right: 2.0),
                              child: TextFormField(
                                controller: titleControllers[index],
                                obscureText: false,
                                style: const TextStyle(color: Colors.black),
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  labelStyle: const TextStyle(fontSize: 13),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: 'Titulo',
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
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 2.0, right: 2.0),
                              child: TextFormField(
                                maxLines: 5,
                                controller: descriptionControllers[index],
                                obscureText: false,
                                style: const TextStyle(color: Colors.black),
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  labelStyle: const TextStyle(fontSize: 13),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: 'Descripcion',
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
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        context
                            .read<FormsProvider>()
                            .deleteControllers(index: index);
                        context
                            .read<FormsProvider>()
                            .deleteControllers2(index: index);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              ],
            ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              context.read<FormsProvider>().createControllers();
              context.read<FormsProvider>().createControllers2();
            },
            child: const Text('Agregar Habitación'),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                widget.tituloHabitaciones.addAll(titleControllers
                    .map((controller) => controller.text)
                    .toList());
                widget.descripcionHabitaciones.addAll(descriptionControllers
                    .map((controller) => controller.text)
                    .toList());
              });
              Navigator.pop(context);
            },
            child: const Text("Guardar Habitaciones"),
          ),
        ],
      ),
    );
  }
}
