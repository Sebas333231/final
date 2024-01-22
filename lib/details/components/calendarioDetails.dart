import 'package:flutter/material.dart';
import 'package:proyecto_final/models/ReservaModel.dart';
import 'package:proyecto_final/models/SitioModel.dart';
import 'package:proyecto_final/theme/theme_constants.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarioDetails extends StatefulWidget {
  final SitioModel sitio;

  const CalendarioDetails({
    Key? key,
    required this.sitio,
  }) : super(key: key);

  @override
  State<CalendarioDetails> createState() => _CalendarioDetailsState();
}

class _CalendarioDetailsState extends State<CalendarioDetails> {
  List<ReservaModel> reservaActiva = [];
  DateTime today = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  bool _isDayDisabled(DateTime day) {
    return day.isAfter(DateTime.now());
  }

  bool _isDayInRange(DateTime day) {
    // Verifica si el día está en el rango de reservas activas
    return reservaActiva.any((reserva) =>
        day.isAfter(DateTime.parse(reserva.fechaEntrada)
            .subtract(const Duration(days: 1))) &&
        day.isBefore(DateTime.parse(reserva.fechaSalida)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Disponibilidad",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        FutureBuilder(
          future: getReservas(),
          builder: (context, AsyncSnapshot<List<ReservaModel>> reserva) {
            if (reserva.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            for (var r = 0; r < reserva.data!.length; r++) {
              if (widget.sitio.id == reserva.data![r].sitio.id) {
                if (reserva.data![r].estado == "Activo") {
                  reservaActiva.add(reserva.data![r]);
                }
              }
            }

            return TableCalendar(
              locale: 'en_US',
              rowHeight: 43,
              calendarStyle: const CalendarStyle(
                rangeHighlightColor: primaryColor,
                todayDecoration:
                    BoxDecoration(color: primaryColor, shape: BoxShape.circle),
                selectedDecoration:
                    BoxDecoration(color: primaryColor, shape: BoxShape.circle),
              ),
              headerStyle: const HeaderStyle(
                  formatButtonVisible: false, titleCentered: true),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) {
                return isSameDay(day, today) || _isDayInRange(day);
              },
              focusedDay: today,
              firstDay: DateTime.utc(1910, 01, 01),
              lastDay: DateTime.utc(2100, 01, 01),
              onDaySelected: _onDaySelected,
              enabledDayPredicate: _isDayDisabled,
            );
          },
        )
      ],
    );
  }
}
