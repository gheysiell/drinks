import 'package:drinks/features/domain/entities/drinks_entity.dart';
import 'package:drinks/features/domain/repositories/drinks_repository.dart';

class DrinksUseCase {
  DrinksRepository drinksRepository;

  DrinksUseCase({
    required this.drinksRepository,
  });

  Future<List<Drink>> getDrinks() async {
    return await drinksRepository.getDrinks();
  }
}
