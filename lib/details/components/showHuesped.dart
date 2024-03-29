import 'package:flutter/material.dart';
import 'package:proyecto_final/responsive.dart';
import 'package:proyecto_final/theme/theme_constants.dart';

// ignore: must_be_immutable
class ShowHuesped extends StatefulWidget {
  final OverlayEntry? entry;
  TextEditingController numAdultosController;

  TextEditingController numNinosController;

  TextEditingController numBebesController;

  TextEditingController numMascotasController;

  TextEditingController total;

  final VoidCallback updateTotalCallback;

  ShowHuesped({
    super.key,
    required this.entry,
    required this.numAdultosController,
    required this.numNinosController,
    required this.numBebesController,
    required this.numMascotasController,
    required this.total, required this.updateTotalCallback,
  });

  @override
  State<ShowHuesped> createState() => _ShowHuespedState();
}

class _ShowHuespedState extends State<ShowHuesped> {
  void hideOverlay() {
    widget.entry?.remove();
  }

  _ShowHuespedState();

  var numAdultos = 1;

  var numNinos = 0;

  var numBebes = 0;

  var numMascotas = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: defaultPadding,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Adultos",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Edad 13 años o más",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.grey),
                        )
                      ],
                    ),
                    if (Responsive.isDesktop(context) ||
                        Responsive.isTablet(context))
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(58),
                            child: Container(
                              color: primaryColor,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (numAdultos <= 0) {
                                      numAdultos = 0;
                                      widget.numAdultosController.text =
                                          numAdultos.toString();
                                    } else {
                                      numAdultos--;
                                      widget.numAdultosController.text =
                                          numAdultos.toString();
                                    }
                                  });
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: defaultPadding,
                          ),
                          Text(numAdultos.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey)),
                          const SizedBox(
                            width: defaultPadding,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(58),
                            child: Container(
                              color: primaryColor,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    numAdultos++;
                                    widget.numAdultosController.text =
                                        numAdultos.toString();
                                  });
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                if (Responsive.isMobile(context))
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(58),
                        child: Container(
                          color: primaryColor,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                if (numAdultos <= 0) {
                                  numAdultos = 0;
                                  widget.numAdultosController.text =
                                      numAdultos.toString();
                                } else {
                                  numAdultos--;
                                  widget.numAdultosController.text =
                                      numAdultos.toString();
                                }
                              });
                            },
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(primaryColor)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: defaultPadding,
                      ),
                      Text(numAdultos.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                      const SizedBox(
                        width: defaultPadding,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(58),
                        child: Container(
                          color: primaryColor,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                numAdultos++;
                                widget.numAdultosController.text =
                                    numAdultos.toString();
                              });
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Niños",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "De 2 a 12 años",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.grey),
                        )
                      ],
                    ),
                    if (Responsive.isDesktop(context) ||
                        Responsive.isTablet(context))
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(58),
                            child: Container(
                              color: primaryColor,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (numNinos <= 0) {
                                      numNinos = 0;
                                      widget.numNinosController.text =
                                          numNinos.toString();
                                    } else {
                                      numNinos--;
                                      widget.numNinosController.text =
                                          numNinos.toString();
                                    }
                                  });
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: defaultPadding,
                          ),
                          Text(numNinos.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey)),
                          const SizedBox(
                            width: defaultPadding,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(58),
                            child: Container(
                              color: primaryColor,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    numNinos++;
                                    widget.numNinosController.text =
                                        numNinos.toString();
                                  });
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                if (Responsive.isMobile(context))
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(58),
                        child: Container(
                          color: primaryColor,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                if (numNinos <= 0) {
                                  numNinos = 0;
                                  widget.numNinosController.text =
                                      numNinos.toString();
                                } else {
                                  numNinos--;
                                  widget.numNinosController.text =
                                      numNinos.toString();
                                }
                              });
                            },
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: defaultPadding,
                      ),
                      Text(numNinos.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                      const SizedBox(
                        width: defaultPadding,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(58),
                        child: Container(
                          color: primaryColor,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                numNinos++;
                                widget.numNinosController.text =
                                    numNinos.toString();
                              });
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bebés",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Menos de 2 años",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.grey),
                        )
                      ],
                    ),
                    if (Responsive.isDesktop(context) ||
                        Responsive.isTablet(context))
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(58),
                            child: Container(
                              color: primaryColor,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (numBebes <= 0) {
                                      numBebes = 0;
                                      widget.numBebesController.text =
                                          numBebes.toString();
                                    } else {
                                      numBebes--;
                                      widget.numBebesController.text =
                                          numBebes.toString();
                                    }
                                  });
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: defaultPadding,
                          ),
                          Text(numBebes.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey)),
                          const SizedBox(
                            width: defaultPadding,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(58),
                            child: Container(
                              color: primaryColor,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    numBebes++;
                                    widget.numBebesController.text =
                                        numBebes.toString();
                                  });
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                if (Responsive.isMobile(context))
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(58),
                        child: Container(
                          color: primaryColor,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                if (numBebes <= 0) {
                                  numBebes = 0;
                                  widget.numBebesController.text =
                                      numBebes.toString();
                                } else {
                                  numBebes--;
                                  widget.numBebesController.text =
                                      numBebes.toString();
                                }
                              });
                            },
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: defaultPadding,
                      ),
                      Text(numBebes.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                      const SizedBox(
                        width: defaultPadding,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(58),
                        child: Container(
                          color: primaryColor,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                numBebes++;
                                widget.numBebesController.text =
                                    numBebes.toString();
                              });
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mascotas",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.grey),
                        )
                      ],
                    ),
                    if (Responsive.isDesktop(context) ||
                        Responsive.isTablet(context))
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(58),
                            child: Container(
                              color: primaryColor,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (numMascotas <= 0) {
                                      numMascotas = 0;
                                      widget.numMascotasController.text =
                                          numMascotas.toString();
                                    } else {
                                      numMascotas--;
                                      widget.numMascotasController.text =
                                          numMascotas.toString();
                                    }
                                  });
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: defaultPadding,
                          ),
                          Text(numMascotas.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey)),
                          const SizedBox(
                            width: defaultPadding,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(58),
                            child: Container(
                              color: primaryColor,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    numMascotas++;
                                    widget.numMascotasController.text =
                                        numMascotas.toString();
                                  });
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                if (Responsive.isMobile(context))
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(58),
                        child: Container(
                          color: primaryColor,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                if (numMascotas <= 0) {
                                  numMascotas = 0;
                                  widget.numMascotasController.text =
                                      numMascotas.toString();
                                } else {
                                  numMascotas--;
                                  widget.numMascotasController.text =
                                      numMascotas.toString();
                                }
                              });
                            },
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: defaultPadding,
                      ),
                      Text(numMascotas.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                      const SizedBox(
                        width: defaultPadding,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(58),
                        child: Container(
                          color: primaryColor,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                numMascotas++;
                                widget.numMascotasController.text =
                                    numMascotas.toString();
                              });
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            const Divider(
              height: 1,
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Center(
                child: TextButton(
                    onPressed: () {
                      setState(() {
                        widget.total.text =
                            (numAdultos + numNinos + numBebes + numMascotas)
                                .toString();
                      });
                      widget.updateTotalCallback();
                      hideOverlay();
                    },
                    child: Text(
                      "Guardar",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ))),
            const SizedBox(
              height: defaultPadding,
            ),
          ],
        ),
      ),
    );
  }
}
