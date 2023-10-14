// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/ingredients.dart';
import 'package:json_annotation/json_annotation.dart';
import 'equipment.dart';

part 'steps.g.dart';

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

  factory Step.fromJson(Map<String, dynamic> json) => _$StepFromJson(json);

  Map<String, dynamic> toJson() => _$StepToJson(this);
}
