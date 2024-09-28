// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrients.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nutrient _$NutrientFromJson(Map<String, dynamic> json) => Nutrient(
      calories: json['calories'] as String,
      carbs: json['carbs'] as String?,
      fat: json['fat'] as String?,
      good: (json['good'] as List<dynamic>?)
          ?.map((e) => Needs.fromJson(e as Map<String, dynamic>))
          .toList(),
      bad: (json['bad'] as List<dynamic>?)
          ?.map((e) => Needs.fromJson(e as Map<String, dynamic>))
          .toList(),
      protein: json['protein'] as String?,
    );

Map<String, dynamic> _$NutrientToJson(Nutrient instance) => <String, dynamic>{
      'calories': instance.calories,
      'carbs': instance.carbs,
      'fat': instance.fat,
      'protein': instance.protein,
      'good': instance.good,
      'bad': instance.bad,
    };

Needs _$NeedsFromJson(Map<String, dynamic> json) => Needs(
      name: json['name'] as String,
      amount: json['amount'] as String?,
      percentOfDailyNeeds: json['percentOfDailyNeeds'] as String?,
    );

Map<String, dynamic> _$NeedsToJson(Needs instance) => <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount,
      'percentOfDailyNeeds': instance.percentOfDailyNeeds,
    };
