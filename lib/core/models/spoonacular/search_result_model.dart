// 📦 Package imports:
import 'package:json_annotation/json_annotation.dart';

// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';

part 'search_result_model.g.dart';

@JsonSerializable()
class RecipeExtracted {
  final int id;
  final String title;
  final String image;
  final String? sourceUrl;
  final int readyInMinutes;
  final bool? vegetarian;
  final bool? vegan;
  final bool? glutenFree;
  final int servings;
  RecipeExtracted({
    required this.id,
    required this.title,
    required this.image,
    this.sourceUrl,
    required this.readyInMinutes,
    this.vegetarian,
    this.glutenFree,
    this.vegan,
    required this.servings,
  });
}

@JsonSerializable()
class RecipeCardInfoList {
  final List<Recipe> list;
  RecipeCardInfoList({
    required this.list,
  });

  factory RecipeCardInfoList.fromJson(Map<String, dynamic> json) =>
      _$RecipeCardInfoListFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeCardInfoListToJson(this);
}
