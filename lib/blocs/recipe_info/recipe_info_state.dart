// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';

abstract class RecipeInfoState {
  const RecipeInfoState();
}

class RecipeInfoInitial extends RecipeInfoState {
  const RecipeInfoInitial();
}

class RecipeInfoLoading extends RecipeInfoState {
  const RecipeInfoLoading();
}

class RecipeInfoLoaded extends RecipeInfoState {
  final Recipe recipe;

  const RecipeInfoLoaded(this.recipe);

  @override
  String toString() => 'RecipeInfoLoaded{recipe: $recipe}';
}

class RecipeInfoError extends RecipeInfoState {
  final String message;

  const RecipeInfoError(this.message);

  @override
  String toString() => 'RecipInfoError{message: $message}';
}
