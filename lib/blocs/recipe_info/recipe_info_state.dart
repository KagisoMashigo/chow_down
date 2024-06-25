// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:equatable/equatable.dart';

abstract class RecipeInfoState extends Equatable {
  @override
  String toString() => 'RecipeInfoState{}';
}

class RecipeInfoInitial extends RecipeInfoState {
  @override
  String toString() => 'RecipeInfoInitial{}';

  @override
  List<Object?> get props => [];
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

  @override
  List<Object?> get props => [id, url];
}

class RecipeInfoLoaded extends RecipeInfoState {
  final Recipe recipe;

  RecipeInfoLoaded({required this.recipe});

  @override
  String toString() => 'RecipeInfoLoaded{recipe: $recipe}';

  @override
  List<Object?> get props => [recipe];
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

  @override
  List<Object?> get props => [message, id, url];
}
