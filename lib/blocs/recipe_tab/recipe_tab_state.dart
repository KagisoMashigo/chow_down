// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';

abstract class SavedRecipeState {
  final List<Recipe> recipeCardList;

  SavedRecipeState({required this.recipeCardList});

  @override
  String toString() => 'SavedRecipeState{recipeCardList: $recipeCardList}';
}

class SavedRecipeInitial extends SavedRecipeState {
  SavedRecipeInitial() : super(recipeCardList: []);

  @override
  String toString() => 'SavedRecipeInitial{}';
}

class SavedRecipePending extends SavedRecipeState {
  SavedRecipePending({required List<Recipe> recipeCardList})
      : super(recipeCardList: recipeCardList);

  @override
  String toString() => 'SavedRecipePending{}';
}

class SavedRecipeLoaded extends SavedRecipeState {
  final List<Recipe> recipeCardList;

  SavedRecipeLoaded({required this.recipeCardList})
      : super(recipeCardList: recipeCardList);

  @override
  String toString() => 'SavedRecipeLoaded{recipeCardList: $recipeCardList}';
}

class SavedRecipeError extends SavedRecipeState {
  final String? message;

  SavedRecipeError({this.message}) : super(recipeCardList: []);

  @override
  String toString() => 'SavedRecipeError{message: $message}';
}
