// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';

abstract class SavedRecipeState {
  final List<Recipe>? savedRecipeList;
  final List<Recipe>? editedRecipeList;

  SavedRecipeState({this.savedRecipeList, this.editedRecipeList});

  @override
  String toString() =>
      'SavedRecipeState{recipeCardList: $savedRecipeList, editedRecipeList: $editedRecipeList}';
}

class SavedRecipeInitial extends SavedRecipeState {
  SavedRecipeInitial() : super(savedRecipeList: [], editedRecipeList: []);

  @override
  String toString() => 'SavedRecipeInitial{}';
}

class SavedRecipePending extends SavedRecipeState {
  SavedRecipePending({
    List<Recipe>? recipeCardList,
    List<Recipe>? editedRecipeList,
  }) : super(
          savedRecipeList: recipeCardList,
          editedRecipeList: editedRecipeList,
        );

  @override
  String toString() => 'SavedRecipePending{}';
}

class SavedRecipeLoaded extends SavedRecipeState {
  final List<Recipe>? savedRecipeList;
  final List<Recipe>? editedRecipeList;

  SavedRecipeLoaded({this.savedRecipeList, this.editedRecipeList})
      : super(
          savedRecipeList: savedRecipeList,
          editedRecipeList: editedRecipeList,
        );

  @override
  String toString() =>
      'SavedRecipeLoaded{recipeCardList: $savedRecipeList, editedRecipeList: $editedRecipeList}';
}

class SavedRecipeError extends SavedRecipeState {
  final String? message;

  SavedRecipeError({this.message})
      : super(
          savedRecipeList: [],
          editedRecipeList: [],
        );

  @override
  String toString() => 'SavedRecipeError{message: $message}';
}
