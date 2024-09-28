// 📦 Package imports:
import 'package:equatable/equatable.dart';

// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';

abstract class EditRecipeState extends Equatable {
  final Recipe? recipe;

  const EditRecipeState({this.recipe});
}

class EditRecipeInitial extends EditRecipeState {
  const EditRecipeInitial();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'EditRecipeInitial{}';
}

class EditRecipePending extends EditRecipeState {
  final Recipe recipe;

  const EditRecipePending({required this.recipe}) : super(recipe: recipe);

  @override
  List<Object> get props => [];

  @override
  String toString() => 'EditRecipePending{recipe: $recipe}';
}

class EditRecipeSuccess extends EditRecipeState {
  final Recipe recipe;
  const EditRecipeSuccess({required this.recipe}) : super(recipe: recipe);

  @override
  List<Object> get props => [];

  @override
  String toString() => 'EditRecipeSuccess{recipe: $recipe}';
}

class EditRecipeFailure extends EditRecipeState {
  final String message;

  const EditRecipeFailure({required this.message});

  @override
  List<Object> get props => [];

  @override
  String toString() => 'EditRecipeFailure{message: $message}';
}

class EditRecipeCancel extends EditRecipeState {
  const EditRecipeCancel();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'EditRecipeCancel{}';
}
