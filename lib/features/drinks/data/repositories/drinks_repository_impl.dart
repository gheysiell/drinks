import 'package:drinks/core/enums.dart';
import 'package:drinks/utils/functions.dart';
import 'package:drinks/features/drinks/data/datasources/remote/drinks_datasource_remote_http.dart';
import 'package:drinks/features/drinks/data/dtos/drinks_response_dto.dart';
import 'package:drinks/features/drinks/domain/entities/drinks_response_entity.dart';
import 'package:drinks/features/drinks/domain/repositories/drinks_repository.dart';

class DrinksRepositoryImpl implements DrinksRepository {
  DrinksDataSourceRemoteHttp drinksDataSourceRemoteHttp;

  DrinksRepositoryImpl({
    required this.drinksDataSourceRemoteHttp,
  });

  @override
  Future<DrinkResponse> getDrinks(String search) async {
    if (!await Functions.checkConn()) {
      return DrinkResponse(
        drinks: [],
        responseStatus: ResponseStatus.noConnection,
      );
    }

    DrinkResponseDto drinkResponseDto = await drinksDataSourceRemoteHttp.getDrinks(search);

    return drinkResponseDto.toEntity();
  }
}
