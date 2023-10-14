// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/steps.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AnalyzedInstruction {
  final String name;
  final List<Step> steps;

  AnalyzedInstruction({required this.name, required this.steps});

  factory AnalyzedInstruction.fromJson(json) {
    return AnalyzedInstruction(
      name: json['name'] as String,
      steps: (json['steps'] as List<dynamic>)
          .map((e) => Step.fromJson(e))
          .toList(),
    );
  }

  toJson() => {
        'name': name,
        'steps': steps.map((e) => e != null ? e.toJson() : '').toList() ?? [],
      };
}
