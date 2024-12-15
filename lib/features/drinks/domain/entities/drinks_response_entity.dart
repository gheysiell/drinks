import 'package:drinks/core/enums.dart';
import 'package:drinks/features/drinks/domain/entities/drinks_entity.dart';

class DrinkResponse {
  List<Drink> drinks;
  ResponseStatus responseStatus;

  DrinkResponse({
    required this.drinks,
    required this.responseStatus,
  });
}
