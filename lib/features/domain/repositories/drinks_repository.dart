import 'package:drinks/features/domain/entities/drinks_entity.dart';

abstract class DrinksRepository {
  Future<List<Drink>> getDrinks();
}
