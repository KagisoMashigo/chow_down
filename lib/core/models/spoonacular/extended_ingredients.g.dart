// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extended_ingredients.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtendedIngredients _$ExtendedIngredientsFromJson(Map<String, dynamic> json) =>
    ExtendedIngredients(
      id: json['id'] as int,
      aisle: json['aisle'] as String?,
      image: json['image'] as String?,
      consistency: json['consistency'] as String?,
      name: json['name'] as String?,
      nameClean: json['nameClean'] as String?,
      original: json['original'] as String?,
      originalString: json['originalString'] as String?,
      originalName: json['originalName'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
      meta: json['meta'] as List<dynamic>?,
      metaInformation: json['metaInformation'] as List<dynamic>?,
      measures: json['measures'] == null
          ? null
          : Measures.fromJson(json['measures'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExtendedIngredientsToJson(
        ExtendedIngredients instance) =>
    <String, dynamic>{
      'id': instance.id,
      'aisle': instance.aisle,
      'image': instance.image,
      'consistency': instance.consistency,
      'name': instance.name,
      'nameClean': instance.nameClean,
      'original': instance.original,
      'originalString': instance.originalString,
      'originalName': instance.originalName,
      'amount': instance.amount,
      'unit': instance.unit,
      'meta': instance.meta,
      'metaInformation': instance.metaInformation,
      'measures': instance.measures,
    };
