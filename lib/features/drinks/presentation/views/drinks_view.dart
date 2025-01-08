import 'package:cached_network_image/cached_network_image.dart';
import 'package:drinks/shared/input_styles.dart';
import 'package:drinks/utils/functions.dart';
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
  final ScrollController scrollController = ScrollController();
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

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await drinksViewModel.getDrinks(searchController.text);
      });

      scrollController.addListener(() {
        if (searchFocusNode.hasFocus) searchFocusNode.unfocus();
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
            title: const Text(
              'Drinks',
              style: Styles.appBarTitle,
            ),
            leading: const Row(
              children: [
                SizedBox(
                  width: 14,
                ),
                Icon(
                  Icons.local_bar_rounded,
                  color: Palette.white,
                  size: 30,
                )
              ],
            ),
            titleSpacing: 4,
            backgroundColor: Palette.primary,
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
                        color: Palette.primary,
                        size: 26,
                      ),
                      suffixIcon: searchController.text.isNotEmpty && drinksViewModel.isSearching
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
                      enabledBorder: InputStyles.outlinedInputBorder,
                      border: InputStyles.outlinedInputBorder,
                      focusedBorder: InputStyles.outlinedInputBorder,
                    ),
                    onFieldSubmitted: (String value) async {
                      searchFocusNode.unfocus();
                      await drinksViewModel.getDrinks(value);
                    },
                  ),
                ),
              ),
            ),
            elevation: 6,
            shadowColor: Colors.black,
          ),
        ),
        backgroundColor: Palette.white,
        body: drinksViewModel.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Palette.primary,
                ),
              )
            : RefreshIndicator(
                color: Palette.primary,
                onRefresh: () async {
                  await drinksViewModel.getDrinks(searchController.text);
                },
                child: drinksViewModel.drinks.isEmpty && !drinksViewModel.isLoading
                    ? SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Container(
                          height:
                              MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + appBarHeight),
                          alignment: Alignment.center,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(),
                              Icon(
                                Icons.local_bar_rounded,
                                color: Palette.primary,
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
                          vertical: 8,
                        ),
                        physics: const AlwaysScrollableScrollPhysics(),
                        controller: scrollController,
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
                            width: 60,
                            child: TextButton(
                              onPressed: () {
                                Functions.showNetworkImage(
                                  context,
                                  drinksViewModel.drinks[index].urlImage,
                                );
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                foregroundColor: Palette.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: drinksViewModel.drinks[index].urlImage,
                                imageBuilder: (context, imageProvider) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image(image: imageProvider),
                                  );
                                },
                                placeholder: (context, url) {
                                  return Container(
                                    alignment: Alignment.center,
                                    child: const CircularProgressIndicator(
                                      backgroundColor: Palette.white,
                                      color: Palette.primary,
                                      strokeWidth: 3,
                                    ),
                                  );
                                },
                                errorWidget: (context, url, error) => const Icon(
                                  Icons.local_bar_rounded,
                                  color: Palette.primary,
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
    );
  }
}
