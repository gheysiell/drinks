import 'package:drinks/features/domain/entities/drinks_entity.dart';
import 'package:drinks/features/domain/usecases/drinks_usecase.dart';
import 'package:flutter/material.dart';

class DrinksViewModel extends ChangeNotifier {
  List<Drink> drinks = [];
  DrinksUseCase drinksUseCase;

  DrinksViewModel({
    required this.drinksUseCase,
  });

  void setDrinks(List<Drink> value) {
    drinks = value;
    notifyListeners();
  }

  Future<void> getDrinks() async {
    List<Drink> drinks = await drinksUseCase.getDrinks();
    setDrinks(drinks);
  }
}
