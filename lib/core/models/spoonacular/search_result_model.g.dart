// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeExtracted _$RecipeExtractedFromJson(Map<String, dynamic> json) =>
    RecipeExtracted(
      id: json['id'] as int,
      title: json['title'] as String,
      image: json['image'] as String,
      sourceUrl: json['sourceUrl'] as String?,
      readyInMinutes: json['readyInMinutes'] as int,
      vegetarian: json['vegetarian'] as bool?,
      glutenFree: json['glutenFree'] as bool?,
      vegan: json['vegan'] as bool?,
      servings: json['servings'] as int,
    );

Map<String, dynamic> _$RecipeExtractedToJson(RecipeExtracted instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'sourceUrl': instance.sourceUrl,
      'readyInMinutes': instance.readyInMinutes,
      'vegetarian': instance.vegetarian,
      'vegan': instance.vegan,
      'glutenFree': instance.glutenFree,
      'servings': instance.servings,
    };

RecipeCardInfoList _$RecipeCardInfoListFromJson(Map<String, dynamic> json) =>
    RecipeCardInfoList(
      results: (json['results'] as List<dynamic>)
          .map((e) => Recipe.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecipeCardInfoListToJson(RecipeCardInfoList instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
