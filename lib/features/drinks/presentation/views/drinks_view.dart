import 'package:drinks/features/drinks/presentation/viewmodels/drinks_viewmodel.dart';
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
  bool initialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!initialized) {
      drinksViewModel = context.watch<DrinksViewModel>();

      Future.delayed(Duration.zero, () async {
        await drinksViewModel.getDrinks();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Drinks',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: SizedBox(
        child: RefreshIndicator(
          onRefresh: () async {
            await drinksViewModel.getDrinks();
          },
          child: ListView.builder(
            itemCount: drinksViewModel.drinks.length,
            itemBuilder: (BuildContext context, int index) => ListTile(
              title: Text(
                drinksViewModel.drinks[index].name,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                drinksViewModel.drinks[index].description,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading: Image.network(
                drinksViewModel.drinks[index].urlImage,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
