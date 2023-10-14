import 'package:json_annotation/json_annotation.dart';

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
  factory Nutrient.fromJson(Map<String, dynamic> json) {
    return Nutrient(
      calories: json['calories'],
      carbs: json['carbs'],
      fat: json['fat'],
      protein: json['protein'],
      bad: (json['bad'] as List).map((hmm) => Needs.formJson(hmm)).toList(),
      good: (json['good'] as List).map((hmm) => Needs.formJson(hmm)).toList(),
    );
  }
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
  factory Needs.formJson(Map<String, dynamic> json) {
    return Needs(
      name: json.containsKey('title') ? json['title'] : json['name'],
      amount: json['amount'],
      percentOfDailyNeeds: json['percentOfDailyNeeds'].toString(),
    );
  }
}
