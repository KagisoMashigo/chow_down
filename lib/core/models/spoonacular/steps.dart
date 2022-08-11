// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/ingredients.dart';
import 'equipment.dart';

class Step {
  int number;
  String step;
  List<Ingredient> ingredients;
  List<Equipment> equipment;

  Step({
    this.number,
    this.step,
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
        'ingredients': ingredients.map((e) => e.toJson()).toList(),
        'equipment': equipment.map((e) => e.toJson()).toList(),
      };
}
