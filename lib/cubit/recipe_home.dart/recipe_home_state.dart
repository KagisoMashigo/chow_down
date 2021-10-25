part of 'recipe_home_cubit.dart';

abstract class RecipeHomeState extends Equatable {
  const RecipeHomeState();

  @override
  List<Object> get props => [];
}

class RecipeHomeInitial extends RecipeHomeState {
  const RecipeHomeInitial();
}

class RecipeHomeLoading extends RecipeHomeState {
  const RecipeHomeLoading();
}

class RecipeHomeLoaded extends RecipeHomeState {
  const RecipeHomeLoaded(this.recipeCardList);
  final RecipeCardInfoList recipeCardList;

  // TODO: incorporate freezed later on as this is not prod viable
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RecipeHomeLoaded && other.recipeCardList == recipeCardList;
  }

  @override
  int get hashCode => recipeCardList.hashCode;
}

class RecipeHomeError extends RecipeHomeState {
  final String message;
  const RecipeHomeError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RecipeHomeError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
