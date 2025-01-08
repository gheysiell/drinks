import 'package:drinks/features/drinks/domain/entities/drinks_ingredient_entity.dart';

class Drink {
  int id;
  String name, glass, category, urlImage, intructions;
  bool isAlcoholic;
  List<DrinkIngredient> drinkIngredients;

  Drink({
    required this.id,
    required this.name,
    required this.glass,
    required this.category,
    required this.urlImage,
    required this.isAlcoholic,
    required this.intructions,
    required this.drinkIngredients,
  });
}
