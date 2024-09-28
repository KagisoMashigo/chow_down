// 📦 Package imports:
import 'package:json_annotation/json_annotation.dart';

// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/ingredients.dart';
import 'equipment.dart';

part 'steps.g.dart';

@JsonSerializable(explicitToJson: true)
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

  factory Step.fromJson(Map<String, dynamic> json) => _$StepFromJson(json);

  Map<String, dynamic> toJson() => _$StepToJson(this);

  Step copyWith({
    int? number,
    String? step,
    List<Ingredient>? ingredients,
    List<Equipment>? equipment,
  }) {
    return Step(
      number: number ?? this.number,
      step: step ?? this.step,
      ingredients: ingredients ?? this.ingredients,
      equipment: equipment ?? this.equipment,
    );
  }
}
