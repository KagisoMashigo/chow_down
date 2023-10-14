// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/ingredients.dart';
import 'package:json_annotation/json_annotation.dart';
import 'equipment.dart';

@JsonSerializable()
class Step {
  final int number;
  final String step;
  final List<Ingredient>? ingredients;
  final List<Equipment>? equipment;

  Step({
    required this.number,
    required this.step,
    this.ingredients,
    this.equipment,
  });

  factory Step.fromJson(json) => Step(
        number: json['number'] as int,
        step: json['step'] as String,
        ingredients: (json['ingredients'] as List<dynamic>)
            .map((e) => Ingredient.fromJson(e))
            .toList(),
        equipment: (json['equipment'] as List<dynamic>)
            .map((e) => Equipment.fromJson(e))
            .toList(),
      );

  toJson() => {
        'number': number,
        'step': step,
        'ingredients': ingredients?.map((e) => e.toJson()).toList(),
        'equipment': equipment?.map((e) => e.toJson()).toList(),
      };
}
