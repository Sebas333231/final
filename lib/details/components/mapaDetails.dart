import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:proyecto_final/models/SitioModel.dart';
import 'package:proyecto_final/theme/theme_constants.dart';

class MapaDetails extends StatelessWidget {

  final SitioModel sitio;

  const MapaDetails({
    super.key, required this.sitio,
  });

  @override
  Widget build(BuildContext context) {

    double latitud = double.parse(sitio.latitud);

    double longitud = double.parse(sitio.longitud);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "A dónde irás",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 600,
            child: OpenStreetMapSearchAndPick(
                center: LatLong(longitud, latitud),
                buttonColor: primaryColor,
                buttonText: 'Buscar Ubicación',
                locationPinIconColor: primaryColor,
                locationPinText: "Ubicación",
                locationPinTextStyle: const TextStyle(color: primaryColor),
                onPicked: (pickedData) {}),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          SizedBox(
            height: 300,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sitio.lugar,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Text(
                    sitio.desLugar,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
