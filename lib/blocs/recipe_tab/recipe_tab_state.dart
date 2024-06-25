// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:equatable/equatable.dart';

abstract class RecipeTabState extends Equatable {
  final List<Recipe> recipeCardList;

  RecipeTabState({required this.recipeCardList});

  @override
  String toString() => 'RecipeTabState{recipeCardList: $recipeCardList}';
}

class RecipeTabInitial extends RecipeTabState {
  RecipeTabInitial() : super(recipeCardList: []);

  @override
  String toString() => 'RecipeTabInitial{}';

  @override
  List<Object?> get props => [];
}

class RecipeTabLoading extends RecipeTabState {
  RecipeTabLoading({required List<Recipe> recipeCardList})
      : super(recipeCardList: recipeCardList);

  @override
  String toString() => 'RecipeTabLoading{}';

  @override
  List<Object?> get props => [];
}

class RecipeTabLoaded extends RecipeTabState {
  final List<Recipe> recipeCardList;

  RecipeTabLoaded({required this.recipeCardList})
      : super(recipeCardList: recipeCardList);

  @override
  String toString() => 'RecipeTabLoaded{recipeCardList: $recipeCardList}';

  @override
  List<Object?> get props => [recipeCardList];
}

class RecipeTabError extends RecipeTabState {
  final String? message;

  RecipeTabError({this.message}) : super(recipeCardList: []);

  @override
  String toString() => 'RecipTabError{message: $message}';

  @override
  List<Object?> get props => [message];
}
