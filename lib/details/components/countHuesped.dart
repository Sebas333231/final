import 'package:flutter/material.dart';
import 'package:proyecto_final/details/components/showHuesped.dart';

// ignore: must_be_immutable
class CountHuesped extends StatefulWidget {
  TextEditingController numAdultosController;

  TextEditingController numNinosController;

  TextEditingController numBebesController;

  TextEditingController numMascotasController;

  TextEditingController total;

  CountHuesped({
    super.key,
    required this.numAdultosController,
    required this.numNinosController,
    required this.numBebesController,
    required this.numMascotasController,
    required this.total,
  });

  @override
  State<CountHuesped> createState() => _CountHuespedState();
}

class _CountHuespedState extends State<CountHuesped> {
  final layerLink = LayerLink();

  OverlayEntry? entry;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    entry = OverlayEntry(
        builder: (context) => Positioned(
            width: size.width,
            child: CompositedTransformFollower(
                link: layerLink,
                showWhenUnlinked: false,
                offset: Offset(0, size.height + 8),
                child: ShowHuesped(
                  entry: entry,
                  numAdultosController: widget.numAdultosController,
                  numNinosController: widget.numNinosController,
                  numBebesController: widget.numBebesController,
                  numMascotasController: widget.numMascotasController,
                  total: widget.total,
                  updateTotalCallback: () {
                    // Llama a setState aquí para que se actualice el UI
                    setState(() {});
                  },
                ))));

    overlay.insert(entry!);
  }

  void hideOverlay() {
    entry?.remove();
    entry = null;
  }

  @override
  Widget build(BuildContext context) => CompositedTransformTarget(
        link: layerLink,
        child: InkWell(
          onTap: () {
            showOverlay();
          },
          onDoubleTap: () {
            hideOverlay();
          },
          child: Container(
            padding: const EdgeInsets.only(
              left: 10,
              bottom: 10,
              top: 10,
            ),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
                border: Border(
                    top: BorderSide(
                        style: BorderStyle.solid, color: Colors.grey),
                    bottom: BorderSide(
                        style: BorderStyle.solid, color: Colors.grey),
                    right: BorderSide(
                        style: BorderStyle.solid, color: Colors.grey),
                    left: BorderSide(
                        style: BorderStyle.solid, color: Colors.grey))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Huéspedes"),
                    Text("${widget.total.text} huésped")
                  ],
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      );
}
