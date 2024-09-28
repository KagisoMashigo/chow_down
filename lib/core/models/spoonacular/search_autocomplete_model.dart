// 📦 Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'search_autocomplete_model.g.dart';

@JsonSerializable()
class SearchAutoComplete {
  final String id;
  final String? name;
  final String? image;
  SearchAutoComplete({
    required this.id,
    this.name,
    this.image,
  });

  factory SearchAutoComplete.fromJson(Map<String, dynamic> json) =>
      _$SearchAutoCompleteFromJson(json);

  Map<String, dynamic> toJson() => _$SearchAutoCompleteToJson(this);
}

@JsonSerializable()
class SearchAutoCompleteList {
  final List<SearchAutoComplete>? list;
  SearchAutoCompleteList({
    this.list,
  });

  factory SearchAutoCompleteList.fromJson(Map<String, dynamic> json) =>
      _$SearchAutoCompleteListFromJson(json);

  Map<String, dynamic> toJson() => _$SearchAutoCompleteListToJson(this);
}
