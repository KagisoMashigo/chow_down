// 📦 Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'nutrients.g.dart';

@JsonSerializable()
class Nutrient {
  final String calories;
  final String? carbs;
  final String? fat;
  final String? protein;
  final List<Needs>? good;
  final List<Needs>? bad;
  Nutrient({
    required this.calories,
    this.carbs,
    this.fat,
    this.good,
    this.bad,
    this.protein,
  });
}

@JsonSerializable()
class Needs {
  final String name;
  final String? amount;
  final String? percentOfDailyNeeds;
  Needs({
    required this.name,
    this.amount,
    this.percentOfDailyNeeds,
  });

  factory Needs.fromJson(Map<String, dynamic> json) => _$NeedsFromJson(json);

  Map<String, dynamic> toJson() => _$NeedsToJson(this);
}
