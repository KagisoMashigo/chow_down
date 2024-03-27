// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';

abstract class RecipeTabState {
  final List<Recipe> recipeCardList;

  RecipeTabState({required this.recipeCardList});

  @override
  String toString() => 'RecipeTabState{recipeCardList: $recipeCardList}';
}

class RecipeTabInitial extends RecipeTabState {
  RecipeTabInitial() : super(recipeCardList: []);

  @override
  String toString() => 'RecipeTabInitial{}';
}

class RecipeTabLoading extends RecipeTabState {
  RecipeTabLoading({required List<Recipe> recipeCardList})
      : super(recipeCardList: recipeCardList);

  @override
  String toString() => 'RecipeTabLoading{}';
}

class RecipeTabLoaded extends RecipeTabState {
  final List<Recipe> recipeCardList;

  RecipeTabLoaded({required this.recipeCardList})
      : super(recipeCardList: recipeCardList);

  @override
  String toString() => 'RecipeTabLoaded{recipeCardList: $recipeCardList}';
}

class RecipeTabError extends RecipeTabState {
  final String? message;

  RecipeTabError({this.message}) : super(recipeCardList: []);

  @override
  String toString() => 'RecipTabError{message: $message}';
}
