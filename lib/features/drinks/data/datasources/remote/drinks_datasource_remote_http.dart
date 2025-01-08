import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:drinks/core/constants.dart';
import 'package:drinks/core/enums.dart';
import 'package:drinks/features/drinks/data/dtos/drinks_dto.dart';
import 'package:drinks/features/drinks/data/dtos/drinks_response_dto.dart';
import 'package:http/http.dart' as http;

abstract class DrinksDataSourceRemoteHttp {
  Future<DrinkResponseDto> getDrinks(String search);
}

class DrinksDataSourceRemoteHttpImpl extends DrinksDataSourceRemoteHttp {
  @override
  Future<DrinkResponseDto> getDrinks(String search) async {
    if (search == '') search = '%';
    final Uri url = Uri.parse('${Constants.urlApi}api/json/v1/1/search.php?s=$search');
    final DrinkResponseDto drinkResponseDto = DrinkResponseDto(
      drinksDto: [],
      responseStatus: ResponseStatus.success,
    );

    try {
      final response = await http.get(url).timeout(Constants.timeoutDurationRemoteHttp);

      if (response.statusCode != 200) throw Exception();

      if (json.decode(response.body)['drinks'] is List) {
        List drinks = json.decode(response.body)['drinks'];
        drinkResponseDto.drinksDto = drinks.map((drink) => DrinkDto.fromMap(drink)).toList();
      }
    } on TimeoutException {
      log('${Constants.timeoutDurationRemoteHttp} DrinksDataSourceRemoteHttpImpl.getDrinks');
      drinkResponseDto.responseStatus = ResponseStatus.timeout;
    } catch (e) {
      log('${Constants.genericExceptionMessage} DrinksDataSourceRemoteHttpImpl.getDrinks', error: e);
      drinkResponseDto.responseStatus = ResponseStatus.error;
    }

    return drinkResponseDto;
  }
}
