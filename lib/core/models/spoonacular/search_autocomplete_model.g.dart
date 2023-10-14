// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_autocomplete_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchAutoComplete _$SearchAutoCompleteFromJson(Map<String, dynamic> json) =>
    SearchAutoComplete(
      id: json['id'] as String,
      name: json['name'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$SearchAutoCompleteToJson(SearchAutoComplete instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
    };

SearchAutoCompleteList _$SearchAutoCompleteListFromJson(
        Map<String, dynamic> json) =>
    SearchAutoCompleteList(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => SearchAutoComplete.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchAutoCompleteListToJson(
        SearchAutoCompleteList instance) =>
    <String, dynamic>{
      'list': instance.list,
    };
