import 'package:cached_network_image/cached_network_image.dart';
import 'package:drinks/shared/functions.dart';
import 'package:drinks/features/drinks_details/presentation/viewmodels/drinks_details_viewmodel.dart';
import 'package:drinks/shared/palette.dart';
import 'package:drinks/shared/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrinksDetailsView extends StatefulWidget {
  const DrinksDetailsView({super.key});

  @override
  State<DrinksDetailsView> createState() {
    return DrinksDetailsViewState();
  }
}

class DrinksDetailsViewState extends State<DrinksDetailsView> {
  late DrinksDetailsViewModel drinksDetailsViewModel;
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController glassController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController alcoholicController = TextEditingController();
  List<TextEditingController> textControllers = [];
  List<String> textTitles = [
    'ID',
    'Nome',
    'Copo',
    'Categoria',
    'Alcólico',
  ];
  bool initialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!initialized) {
      drinksDetailsViewModel = context.watch<DrinksDetailsViewModel>();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        idController.text = drinksDetailsViewModel.drink!.id.toString();
        nameController.text = drinksDetailsViewModel.drink!.name;
        glassController.text = drinksDetailsViewModel.drink!.glass;
        categoryController.text = drinksDetailsViewModel.drink!.category;
        alcoholicController.text = drinksDetailsViewModel.drink!.isAlcoholic ? 'Sim' : 'Não';
      });

      textControllers = [
        idController,
        nameController,
        glassController,
        categoryController,
        alcoholicController,
      ];

      initialized = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Drink',
          style: Styles.appBarTitle,
        ),
        backgroundColor: Palette.orange,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            tooltip: 'Voltar',
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Palette.white,
              size: 30,
            )),
      ),
      body: ListView.builder(
        itemCount: textControllers.length + 1,
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        itemBuilder: (BuildContext context, int index) {
          int indexTextsFormFields = index - 1;

          return index == 0
              ? Container(
                  height: 160,
                  width: 160,
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      Functions.showNetworkImage(
                        context,
                        drinksDetailsViewModel.drink!.urlImage,
                      );
                    },
                    style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.zero),
                      foregroundColor: MaterialStatePropertyAll(Palette.orange),
                      fixedSize: MaterialStatePropertyAll(Size(160, 160)),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: drinksDetailsViewModel.drink!.urlImage,
                      placeholder: (context, url) {
                        return Container(
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(
                            backgroundColor: Palette.white,
                            color: Palette.orange,
                            strokeWidth: 3,
                          ),
                        );
                      },
                      errorWidget: (context, url, error) => const Icon(
                        Icons.local_bar_rounded,
                        color: Palette.orange,
                        size: 30,
                      ),
                    ),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: TextFormField(
                    controller: textControllers[indexTextsFormFields],
                    readOnly: true,
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(
                      color: Palette.grayMedium,
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                      label: Text(
                        textTitles[indexTextsFormFields],
                        style: const TextStyle(
                          color: Palette.grayMedium,
                          fontWeight: FontWeight.w400,
                          fontSize: 19,
                        ),
                      ),
                      fillColor: Palette.orangeSoft,
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Palette.orange,
                          width: 2,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Palette.orange,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Palette.orange,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
