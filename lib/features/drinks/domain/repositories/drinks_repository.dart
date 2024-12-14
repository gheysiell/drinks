import 'package:drinks/features/drinks/domain/entities/drinks_entity.dart';

abstract class DrinksRepository {
  Future<List<Drink>> getDrinks();
}
