// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/steps.dart';

class AnalyzedInstruction {
  String name;
  List<Step> steps;

  AnalyzedInstruction({this.name, this.steps});

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
        'steps':
            steps?.map((e) => e != null ? e?.toJson() : '')?.toList() ?? [],
      };
}
