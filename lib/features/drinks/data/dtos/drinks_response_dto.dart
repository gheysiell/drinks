import 'package:drinks/core/enums.dart';
import 'package:drinks/features/drinks/data/dtos/drinks_dto.dart';
import 'package:drinks/features/drinks/domain/entities/drinks_response_entity.dart';

class DrinkResponseDto {
  List<DrinksDto> drinksDto;
  ResponseStatus responseStatus;

  DrinkResponseDto({
    required this.drinksDto,
    required this.responseStatus,
  });

  DrinkResponse toEntity() {
    return DrinkResponse(
      drinks: drinksDto.map((drinkDto) => drinkDto.toEntity()).toList(),
      responseStatus: responseStatus,
    );
  }
}
