import 'package:chow_down/core/models/spoonacular/recipe_model.dart';

abstract class RecipeInfoState {
  @override
  String toString() => 'RecipeInfoState{}';
}

class RecipeInfoInitial extends RecipeInfoState {
  @override
  String toString() => 'RecipeInfoInitial{}';
}

class RecipeInfoLoading extends RecipeInfoState {
  final int? id;
  final String? url;

  RecipeInfoLoading({
    this.id,
    this.url,
  });

  @override
  String toString() => 'RecipeInfoLoading{id: $id, url: $url}';
}

class RecipeInfoLoaded extends RecipeInfoState {
  final Recipe recipe;

  RecipeInfoLoaded({required this.recipe});

  @override
  String toString() => 'RecipeInfoLoaded{recipe: $recipe}';
}

class RecipeInfoError extends RecipeInfoState {
  final String? message;
  final int? id;
  final String? url;

  RecipeInfoError({
    this.message,
    this.id,
    this.url,
  });

  @override
  String toString() => 'RecipeInfoError{message: $message, id: $id, url: $url}';
}
