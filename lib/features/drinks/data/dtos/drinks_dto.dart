import 'package:drinks/features/drinks/domain/entities/drinks_entity.dart';

class DrinksDto {
  int id;
  String name, glass, category, urlImage;
  bool isAlcoholic;

  DrinksDto({
    required this.id,
    required this.name,
    required this.glass,
    required this.category,
    required this.urlImage,
    required this.isAlcoholic,
  });

  factory DrinksDto.fromMap(Map<String, dynamic> map) {
    return DrinksDto(
        id: int.parse(map['idDrink'] ?? '0'),
        name: map['strDrink'] ?? '',
        glass: map['strGlass'] ?? '',
        category: map['strCategory'] ?? '',
        urlImage: map['strDrinkThumb'] ?? '',
        isAlcoholic: map['strAlcoholic'] == 'Alcoholic' ? true : false);
  }

  Drink toEntity() {
    return Drink(
      id: id,
      name: name,
      glass: glass,
      category: category,
      urlImage: urlImage,
      isAlcoholic: isAlcoholic,
    );
  }
}
