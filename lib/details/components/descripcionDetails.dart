import 'package:flutter/material.dart';
import 'package:proyecto_final/models/SitioModel.dart';
import 'package:proyecto_final/theme/theme_constants.dart';

class DescripcionDetails extends StatefulWidget {
  final SitioModel sitio;

  const DescripcionDetails({
    super.key,
    required this.sitio,
  });

  @override
  State<DescripcionDetails> createState() => _DescripcionDetailsState();
}

class _DescripcionDetailsState extends State<DescripcionDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          widget.sitio.descripcion,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        TextButton(
            onPressed: () {
              _modalDescripcion(context, widget.sitio);
            },
            child: Text(
              "Mostar Más >",
              style: Theme.of(context).textTheme.titleMedium,
            ))
      ],
    );
  }
}

void _modalDescripcion(BuildContext context, SitioModel sitio) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 600,
            width: MediaQuery.of(context).size.height,
            child: ListView(
              children: [
                const SizedBox(
                  height: defaultPadding,
                ),
                Text(
                  "Acerca de este espacio",
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                Expanded(
                    child: Text(
                  sitio.descripcion,
                  style: const TextStyle(color: Colors.grey),
                )),
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
