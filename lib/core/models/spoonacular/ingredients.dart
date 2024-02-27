// 📦 Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'ingredients.g.dart';

@JsonSerializable()
class Ingredient {
  final int id;
  final String name;
  final String? localizedName;
  final String? image;

  Ingredient({
    required this.id,
    required this.name,
    this.localizedName,
    this.image,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}
