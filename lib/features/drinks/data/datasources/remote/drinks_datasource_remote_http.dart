import 'dart:convert';
import 'dart:developer';

import 'package:drinks/core/constants/contants.dart';
import 'package:drinks/features/drinks/data/dtos/drinks_dto.dart';
import 'package:http/http.dart' as http;

abstract class DrinksDataSourceRemoteHttp {
  Future<List<DrinksDto>> getDrinks();
}

class DrinksDataSourceRemoteHttpImpl extends DrinksDataSourceRemoteHttp {
  @override
  Future<List<DrinksDto>> getDrinks() async {
    final Uri url = Uri.parse('${Constants.urlApi}api/json/v1/1/search.php?f=a');

    try {
      final response = await http.get(url);

      List drinksResponse = json.decode(response.body)['drinks'];

      return drinksResponse.map((drink) => DrinksDto.fromMap(drink)).toList();
    } catch (e) {
      log('generic exception', error: e);
      return [];
    }
  }
}
