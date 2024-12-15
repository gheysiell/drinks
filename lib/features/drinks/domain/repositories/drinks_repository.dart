import 'package:drinks/features/drinks/domain/entities/drinks_response_entity.dart';

abstract class DrinksRepository {
  Future<DrinkResponse> getDrinks(String search);
}
