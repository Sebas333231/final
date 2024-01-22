import 'package:flutter/material.dart';
import 'package:proyecto_final/details/components/reservationCard.dart';
import 'package:proyecto_final/models/SitioModel.dart';
import 'package:proyecto_final/theme/theme_manager.dart';

class RightDetails extends StatelessWidget {
  final SitioModel sitio;

  final ThemeManager themeManager;

  const RightDetails({
    Key? key,
    required this.sitio,
    required this.themeManager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ReservationCard(
            sitio: sitio,
            themeManager: themeManager,
          ),
        ],
      ),
    );
  }
}
