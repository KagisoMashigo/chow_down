// 📦 Package imports:
import 'package:json_annotation/json_annotation.dart';

// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/steps.dart';

part 'analysed_instructions.g.dart';

@JsonSerializable(explicitToJson: true)
class AnalyzedInstruction {
  final String name;
  final List<Step> steps;

  AnalyzedInstruction({required this.name, required this.steps});

  factory AnalyzedInstruction.fromJson(Map<String, dynamic> json) =>
      _$AnalyzedInstructionFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyzedInstructionToJson(this);
}
