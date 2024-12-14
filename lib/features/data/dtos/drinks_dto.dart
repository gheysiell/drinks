import 'package:drinks/features/domain/entities/drinks_entity.dart';

class DrinksDto {
  String name, description, urlImage;

  DrinksDto({
    required this.name,
    required this.description,
    required this.urlImage,
  });

  factory DrinksDto.fromMap(Map<String, dynamic> map) {
    return DrinksDto(
      name: map['strDrink'],
      description: map['strGlass'],
      urlImage: map['strDrinkThumb'],
    );
  }

  Drink toEntity() {
    return Drink(
      name: name,
      description: description,
      urlImage: urlImage,
    );
  }
}
