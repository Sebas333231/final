import "package:alan_voice/alan_voice.dart";
import "package:flutter/material.dart";
import "package:proyecto_final/categories/screens/categoryCard.dart";
import "package:proyecto_final/categories/screens/headerCategory.dart";
import "package:proyecto_final/categoryForm/formulario_categoria.dart";
import "package:proyecto_final/chatbotweb/chatBotWeb.dart";
import "package:proyecto_final/models/CategoriaModel.dart";
import "package:proyecto_final/theme/theme_constants.dart";
import "package:universal_platform/universal_platform.dart";
import 'package:proyecto_final/theme/theme_manager.dart';

// Vista que contendra todos los componentes los cuales conformaran la vista de categorías.

class CategoryPage extends StatefulWidget {
  final ThemeManager themeManager;
  const CategoryPage({super.key, required this.themeManager});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  _CategoryPageState() {
    if (!UniversalPlatform.isWeb) {
      /// Init Alan Button with project key from Alan AI Studio
      AlanVoice.addButton(
          "257726fb1e303ccaf96867d4b3de54d42e956eca572e1d8b807a3e2338fdd0dc/stage",
          buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT);

      /// Handle commands from Alan AI Studio
      AlanVoice.onCommand.add((command) {
        debugPrint("got new command ${command.toString()}");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: defaultPadding),
            const HeaderCategory(),
            const SizedBox(height: defaultPadding),
            Text(
              "Categorías",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 40),
            ),
            const SizedBox(height: defaultPadding),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CategoriaForm(
                      themeManager: widget.themeManager,
                    ),
                  ),
                );
              },
              child: const Text("Añadir Categoría"),
            ),
            const SizedBox(height: defaultPadding),
            Column(
              children: [
                FutureBuilder(
                    future: getCategoria(),
                    builder: (context,
                        AsyncSnapshot<List<CategoriaModel>> categoriaList) {
                      if (categoriaList.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (categoriaList.data != null) {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: categoriaList.data!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return CategoryCard(
                                categoria: categoriaList.data![index],
                                themeManager: widget.themeManager,
                              );
                            });
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: _getFloating(),
    );
  }

  _getFloating() {
    if (UniversalPlatform.isWeb) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatBotWeb()),
          );
        },
        child: const Icon(Icons.support_agent),
      );
    } else if (UniversalPlatform.isWindows) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatBotWeb()),
          );
        },
        child: const Icon(Icons.support_agent),
      );
    } else {
      return null;
    }
  }
}
