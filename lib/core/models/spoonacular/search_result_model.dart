// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';

class RecipeExtracted {
  final int id;
  final String title;
  final String image;
  final String sourceUrl;
  final int readyInMinutes;
  final bool vegetarian;
  final bool vegan;
  final bool glutenFree;
  final int servings;
  RecipeExtracted({
    this.id,
    this.title,
    this.image,
    this.sourceUrl,
    this.readyInMinutes,
    this.vegetarian,
    this.glutenFree,
    this.vegan,
    this.servings,
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

class RecipeCardInfoList {
  final List<Recipe> list;
  RecipeCardInfoList({
    this.list,
  });

  factory RecipeCardInfoList.fromJson(List<dynamic> json) {
    return RecipeCardInfoList(
      list: json.map((data) => Recipe.fromJson(data)).toList(),
    );
  }
}
