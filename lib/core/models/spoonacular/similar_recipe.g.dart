// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'similar_recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Similar _$SimilarFromJson(Map<String, dynamic> json) => Similar(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String?,
      readyInMinutes: json['readyInMinutes'] as String?,
      servings: json['servings'] as String?,
    );

Map<String, dynamic> _$SimilarToJson(Similar instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'readyInMinutes': instance.readyInMinutes,
      'servings': instance.servings,
    };

SimilarList _$SimilarListFromJson(Map<String, dynamic> json) => SimilarList(
      list: (json['list'] as List<dynamic>)
          .map((e) => Similar.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SimilarListToJson(SimilarList instance) =>
    <String, dynamic>{
      'list': instance.list,
    };
