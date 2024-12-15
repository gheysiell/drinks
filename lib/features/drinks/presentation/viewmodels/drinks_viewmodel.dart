import 'package:drinks/core/enums.dart';
import 'package:drinks/core/functions.dart';
import 'package:drinks/features/drinks/domain/entities/drinks_entity.dart';
import 'package:drinks/features/drinks/domain/entities/drinks_response_entity.dart';
import 'package:drinks/features/drinks/domain/usecases/drinks_usecase.dart';
import 'package:flutter/material.dart';

class DrinksViewModel extends ChangeNotifier {
  List<Drink> drinks = [];
  DrinksUseCase drinksUseCase;
  bool isLoading = false;
  bool textSearchControllerFocused = false;

  DrinksViewModel({
    required this.drinksUseCase,
  });

  void setDrinks(List<Drink> value) {
    drinks = value;
    notifyListeners();
  }

  void setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void setTextSearchControllerFocused(bool value) {
    textSearchControllerFocused = value;
    notifyListeners();
  }

  Future<void> getDrinks(String search) async {
    if (search.isEmpty) search = '%';

    setIsLoading(true);

    DrinkResponse drinkResponse = await drinksUseCase.getDrinks(search);

    setIsLoading(false);

    if (drinkResponse.responseStatus != ResponseStatus.success) {
      Functions.showMessageResponseStatus(
        drinkResponse.responseStatus,
        'buscar',
        'os',
        'drinks',
      );
    }

    setDrinks(drinkResponse.drinks);
  }
}
