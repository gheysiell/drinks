import 'package:drinks/features/drinks/data/dtos/drinks_ingredient_dto.dart';
import 'package:drinks/features/drinks/domain/entities/drinks_entity.dart';
import 'package:drinks/utils/format_functions.dart';

class DrinkDto {
  int id;
  String name, glass, category, urlImage, instructions;
  bool isAlcoholic;
  List<DrinkIngredientDto> drinkIngredientsDto;

  DrinkDto({
    required this.id,
    required this.name,
    required this.glass,
    required this.category,
    required this.urlImage,
    required this.isAlcoholic,
    required this.instructions,
    required this.drinkIngredientsDto,
  });

  factory DrinkDto.fromMap(Map<String, dynamic> map, {bool isFromLocal = false}) {
    String ingredientDescriptionIndexName = 'strIngredient';
    String ingredientMeasureIndexName = 'strMeasure';
    List<DrinkIngredientDto> drinkIngredientsDto = [];

    for (int i = 0; i < 15; i++) {
      String ingredientDescriptionIndexNameFormatted = ('$ingredientDescriptionIndexName${(i + 1)}');
      String ingredientMeasureIndexNameFormatted = ('$ingredientMeasureIndexName${i + 1}');

      if (map[ingredientDescriptionIndexNameFormatted] == null || map[ingredientMeasureIndexNameFormatted] == null) {
        break;
      }

      String ingredientDescriptionFormatted = map[ingredientDescriptionIndexNameFormatted];
      String ingredientMeasureFormatted = map[ingredientMeasureIndexNameFormatted];

      drinkIngredientsDto.add(
        DrinkIngredientDto(
          description: ingredientDescriptionFormatted,
          measure: ingredientMeasureFormatted,
        ),
      );
    }

    DrinkDto drinkDto = DrinkDto(
      id: FormatFunctions.safeParseInt(map['idDrink']),
      name: FormatFunctions.safeParseString(map['strDrink']),
      glass: FormatFunctions.safeParseString(map['strGlass']),
      category: FormatFunctions.safeParseString(map['strCategory']),
      urlImage: FormatFunctions.safeParseString(map['strDrinkThumb']),
      isAlcoholic: FormatFunctions.safeParseString(map['strAlcoholic']) == 'Alcoholic' ? true : false,
      instructions: FormatFunctions.safeParseString(map['strInstructions']),
      drinkIngredientsDto: drinkIngredientsDto,
    );

    return drinkDto;
  }

  Drink toEntity() {
    return Drink(
      id: id,
      name: name,
      glass: glass,
      category: category,
      urlImage: urlImage,
      isAlcoholic: isAlcoholic,
      intructions: instructions,
      drinkIngredients: drinkIngredientsDto.map((drinkEngredient) => drinkEngredient.toEntity()).toList(),
    );
  }
}
