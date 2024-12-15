import 'package:cached_network_image/cached_network_image.dart';
import 'package:drinks/core/functions.dart';
import 'package:drinks/features/drinks/presentation/viewmodels/drinks_viewmodel.dart';
import 'package:drinks/features/drinks_details/presentation/viewmodels/drinks_details_viewmodel.dart';
import 'package:drinks/features/drinks_details/presentation/views/drinks_details_view.dart';
import 'package:drinks/shared/palette.dart';
import 'package:drinks/shared/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrinksView extends StatefulWidget {
  const DrinksView({super.key});

  @override
  State<DrinksView> createState() {
    return DrinksViewState();
  }
}

class DrinksViewState extends State<DrinksView> {
  late DrinksViewModel drinksViewModel;
  late DrinksDetailsViewModel drinksDetailsViewModel;
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  final double appBarHeight = 100;
  bool initialized = false;

  @override
  void initState() {
    super.initState();

    searchFocusNode.addListener(() {
      drinksViewModel.setTextSearchControllerFocused(searchFocusNode.hasFocus);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!initialized) {
      drinksViewModel = context.watch<DrinksViewModel>();
      drinksDetailsViewModel = context.watch<DrinksDetailsViewModel>();

      Future.delayed(Duration.zero, () async {
        await drinksViewModel.getDrinks(searchController.text);
      });

      initialized = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight),
          child: AppBar(
            title: const Row(
              children: [
                Icon(
                  Icons.local_bar_rounded,
                  color: Palette.white,
                  size: 28,
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  'Drinks',
                  style: Styles.appBarTitle,
                ),
              ],
            ),
            backgroundColor: Palette.orange,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 10),
                  child: TextFormField(
                    controller: searchController,
                    focusNode: searchFocusNode,
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(
                      color: Palette.grayMedium,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 8,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Palette.orange,
                        size: 26,
                      ),
                      suffixIcon: searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.close_rounded,
                                color: Palette.grayMedium,
                                size: 26,
                              ),
                              onPressed: () async {
                                searchController.clear();
                                searchFocusNode.unfocus();
                                await drinksViewModel.getDrinks('');
                              },
                            )
                          : null,
                      label: searchController.text.isEmpty && !drinksViewModel.textSearchControllerFocused
                          ? const Text(
                              'Pesquisar',
                              style: TextStyle(
                                color: Palette.grayMedium,
                                fontWeight: FontWeight.w400,
                                fontSize: 17,
                              ),
                            )
                          : null,
                      fillColor: Palette.white,
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Palette.white,
                          width: 2,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Palette.white,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Palette.white,
                          width: 2,
                        ),
                      ),
                    ),
                    onFieldSubmitted: (String value) async {
                      searchFocusNode.unfocus();
                      await drinksViewModel.getDrinks(value);
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          child: drinksViewModel.isLoading
              ? const CircularProgressIndicator(
                  color: Palette.orange,
                )
              : RefreshIndicator(
                  color: Palette.orange,
                  onRefresh: () async {
                    await drinksViewModel.getDrinks(searchController.text);
                  },
                  child: drinksViewModel.drinks.isEmpty && !drinksViewModel.isLoading
                      ? SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Container(
                            height: MediaQuery.of(context).size.height -
                                (MediaQuery.of(context).padding.top + appBarHeight),
                            alignment: Alignment.center,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Spacer(),
                                Icon(
                                  Icons.local_bar_rounded,
                                  color: Palette.orange,
                                  size: 50,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Nenhum drink encontrado.',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Palette.grayMedium,
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: drinksViewModel.drinks.length,
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                          ),
                          itemBuilder: (BuildContext context, int index) => ListTile(
                            title: Text(
                              drinksViewModel.drinks[index].name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Palette.grayMedium,
                              ),
                            ),
                            subtitle: Text(
                              drinksViewModel.drinks[index].category,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Palette.grayMedium,
                              ),
                            ),
                            leading: SizedBox(
                              height: double.infinity,
                              width: 55,
                              child: TextButton(
                                onPressed: () {
                                  Functions.showNetworkImage(
                                    context,
                                    drinksViewModel.drinks[index].urlImage,
                                  );
                                },
                                style: const ButtonStyle(
                                  padding: MaterialStatePropertyAll(EdgeInsets.zero),
                                  foregroundColor: MaterialStatePropertyAll(Colors.orange),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: drinksViewModel.drinks[index].urlImage,
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
                            ),
                            onTap: () {
                              drinksDetailsViewModel.setDrink(drinksViewModel.drinks[index]);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DrinksDetailsView(),
                                ),
                              );
                            },
                          ),
                        ),
                ),
        ),
      ),
    );
  }
}
