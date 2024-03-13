// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';

abstract class RecipeTabState {
  const RecipeTabState();
}

class RecipeTabInitial extends RecipeTabState {
  const RecipeTabInitial();
}

class RecipeTabLoading extends RecipeTabState {
  const RecipeTabLoading();
}

class RecipeTabLoaded extends RecipeTabState {
  final List<Recipe> recipeCardList;

  const RecipeTabLoaded({required this.recipeCardList});

  @override
  String toString() => 'RecipeTabLoaded{recipeCardList: $recipeCardList}';
}

class RecipTabError extends RecipeTabState {
  final String? message;

  const RecipTabError({this.message});

  @override
  String toString() => 'RecipTabError{message: $message}';
}
