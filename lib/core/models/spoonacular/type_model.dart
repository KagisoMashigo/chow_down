import 'package:json_annotation/json_annotation.dart';

part 'type_model.g.dart';

@JsonSerializable()
class FoodType {
  final String id;
  final String name;
  final String? image;
  final String? readyInMinutes;
  final String? servings;
  FoodType({
    required this.id,
    required this.name,
    this.image,
    this.readyInMinutes,
    this.servings,
  });

  factory FoodType.fromJson(Map<String, dynamic> json) =>
      _$FoodTypeFromJson(json);

  Map<String, dynamic> toJson() => _$FoodTypeToJson(this);
}

@JsonSerializable()
class FoodTypeList {
  final List<FoodType> list;
  FoodTypeList({
    required this.list,
  });

  factory FoodTypeList.fromJson(Map<String, dynamic> json) =>
      _$FoodTypeListFromJson(json);

  Map<String, dynamic> toJson() => _$FoodTypeListToJson(this);
}
