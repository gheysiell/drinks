import 'package:drinks/features/drinks/domain/entities/drinks_ingredient_entity.dart';

class DrinkIngredientDto {
  String description, measure;

  DrinkIngredientDto({
    required this.description,
    required this.measure,
  });

  DrinkIngredient toEntity() {
    return DrinkIngredient(
      description: description,
      measure: measure,
    );
  }
}
