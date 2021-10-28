part of 'recipe_info_cubit.dart';

abstract class RecipeInfoState extends Equatable {
  const RecipeInfoState();

  @override
  List<Object> get props => [];
}

class RecipeTabInitial extends RecipeInfoState {
  const RecipeTabInitial();
}

class RecipeTabLoading extends RecipeInfoState {
  const RecipeTabLoading();
}

class RecipeInfoLoaded extends RecipeInfoState {
  const RecipeInfoLoaded(this.recipe);
  final Recipe recipe;

  // TODO: incorporate freezed later on as this is not prod viable
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RecipeInfoLoaded && other.recipe == recipe;
  }

  @override
  int get hashCode => recipe.hashCode;
}

class RecipInfoError extends RecipeInfoState {
  final String message;
  const RecipInfoError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RecipInfoError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
