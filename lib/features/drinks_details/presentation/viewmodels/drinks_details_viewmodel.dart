import 'package:drinks/features/drinks/domain/entities/drinks_entity.dart';
import 'package:flutter/material.dart';

class DrinksDetailsViewModel extends ChangeNotifier {
  Drink? drink;

  void setDrink(Drink value) {
    drink = value;
    notifyListeners();
  }
}
