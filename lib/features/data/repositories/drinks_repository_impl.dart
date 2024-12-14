import 'package:drinks/features/data/dtos/drinks_dto.dart';
import 'package:drinks/features/data/datasources/remote/drinks_datasource_remote_http.dart';
import 'package:drinks/features/domain/entities/drinks_entity.dart';
import 'package:drinks/features/domain/repositories/drinks_repository.dart';

class DrinksRepositoryImpl implements DrinksRepository {
  DrinksDataSourceRemoteHttp drinksDataSourceRemoteHttp;

  DrinksRepositoryImpl({
    required this.drinksDataSourceRemoteHttp,
  });

  @override
  Future<List<Drink>> getDrinks() async {
    List<DrinksDto> drinksDto = await drinksDataSourceRemoteHttp.getDrinks();
    return drinksDto.map((drinkDto) => drinkDto.toEntity()).toList();
  }
}
