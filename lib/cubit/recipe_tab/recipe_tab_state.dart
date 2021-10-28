part of 'recipe_tab_cubit.dart';

abstract class RecipeTabState extends Equatable {
  const RecipeTabState();

  @override
  List<Object> get props => [];
}

class RecipeTabInitial extends RecipeTabState {
  const RecipeTabInitial();
}

class RecipeTabLoading extends RecipeTabState {
  const RecipeTabLoading();
}

class RecipeTabLoaded extends RecipeTabState {
  const RecipeTabLoaded(this.recipeCardList);
  final RecipeCardInfoList recipeCardList;

  // TODO: incorporate freezed later on as this is not prod viable
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RecipeTabLoaded && other.recipeCardList == recipeCardList;
  }

  @override
  int get hashCode => recipeCardList.hashCode;
}

class RecipTabError extends RecipeTabState {
  final String message;
  const RecipTabError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RecipTabError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
