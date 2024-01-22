import 'package:flutter/material.dart';
import 'package:proyecto_final/details/components/habitacionCard.dart';
import 'package:proyecto_final/models/HabitacionModel.dart';
import 'package:proyecto_final/models/SitioModel.dart';
import 'package:proyecto_final/theme/theme_constants.dart';

class HabitacionDetails extends StatefulWidget {
  final SitioModel sitio;

  const HabitacionDetails({super.key, required this.sitio});

  @override
  State<HabitacionDetails> createState() => _HabitacionDetailsState();
}

class _HabitacionDetailsState extends State<HabitacionDetails> {
  List<HabitacionModel> listaHabitaciones = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "¿Dónde vas a dormir?",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
              future: getHabitacion(),
              builder:
                  (context, AsyncSnapshot<List<HabitacionModel>> habitacion) {
                if (habitacion.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                for (var h = 0; h < habitacion.data!.length; h++) {
                  if (widget.sitio.id == habitacion.data![h].sitio) {
                    listaHabitaciones.add(habitacion.data![h]);
                  }
                }

                return InteractiveViewer(
                  constrained: false,
                  scaleEnabled: false,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: listaHabitaciones.map((habitacion) {
                      return HabitacionCard(habitacion: habitacion);
                    }).toList()),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
