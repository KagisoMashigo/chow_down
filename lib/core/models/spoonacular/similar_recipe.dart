import 'package:json_annotation/json_annotation.dart';

part 'similar_recipe.g.dart';

@JsonSerializable()
class Similar {
  final String id;
  final String name;
  final String? image;
  final String? readyInMinutes;
  final String? servings;
  Similar({
    required this.id,
    required this.name,
    this.image,
    this.readyInMinutes,
    this.servings,
  });

  factory Similar.fromJson(Map<String, dynamic> json) =>
      _$SimilarFromJson(json);

  Map<String, dynamic> toJson() => _$SimilarToJson(this);
}

@JsonSerializable()
class SimilarList {
  final List<Similar> list;
  SimilarList({
    required this.list,
  });

  factory SimilarList.fromJson(Map<String, dynamic> json) =>
      _$SimilarListFromJson(json);

  Map<String, dynamic> toJson() => _$SimilarListToJson(this);
}
