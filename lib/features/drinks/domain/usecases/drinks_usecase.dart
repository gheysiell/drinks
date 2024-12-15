import 'package:drinks/features/drinks/domain/entities/drinks_response_entity.dart';
import 'package:drinks/features/drinks/domain/repositories/drinks_repository.dart';

class DrinksUseCase {
  DrinksRepository drinksRepository;

  DrinksUseCase({
    required this.drinksRepository,
  });

  Future<DrinkResponse> getDrinks(String search) async {
    return await drinksRepository.getDrinks(search);
  }
}
