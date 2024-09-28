// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodType _$FoodTypeFromJson(Map<String, dynamic> json) => FoodType(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String?,
      readyInMinutes: json['readyInMinutes'] as String?,
      servings: json['servings'] as String?,
    );

Map<String, dynamic> _$FoodTypeToJson(FoodType instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'readyInMinutes': instance.readyInMinutes,
      'servings': instance.servings,
    };

FoodTypeList _$FoodTypeListFromJson(Map<String, dynamic> json) => FoodTypeList(
      list: (json['list'] as List<dynamic>)
          .map((e) => FoodType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FoodTypeListToJson(FoodTypeList instance) =>
    <String, dynamic>{
      'list': instance.list,
    };
