import 'package:drinks/features/drinks/domain/entities/drinks_entity.dart';
import 'package:drinks/features/drinks/domain/repositories/drinks_repository.dart';

class DrinksUseCase {
  DrinksRepository drinksRepository;

  DrinksUseCase({
    required this.drinksRepository,
  });

  Future<List<Drink>> getDrinks() async {
    return await drinksRepository.getDrinks();
  }
}
