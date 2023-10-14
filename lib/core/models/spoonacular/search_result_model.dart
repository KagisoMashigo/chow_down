// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:json_annotation/json_annotation.dart';

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
  factory RecipeExtracted.fromJson(Map<String, dynamic> json) {
    return RecipeExtracted(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      glutenFree: json['glutenFree'],
      sourceUrl: json['sourceUrl'],
      readyInMinutes: json['readyInMinutes'],
      vegetarian: json['vegetarian'],
      vegan: json['vegan'],
      servings: json['servings'],
    );
  }
}

@JsonSerializable()
class RecipeCardInfoList {
  final List<Recipe> list;
  RecipeCardInfoList({
    required this.list,
  });

  factory RecipeCardInfoList.fromJson(List<dynamic> json) {
    return RecipeCardInfoList(
      list: json.map((data) => Recipe.fromJson(data)).toList(),
    );
  }
}
