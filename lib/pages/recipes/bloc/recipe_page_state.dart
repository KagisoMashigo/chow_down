import 'package:chow_down/domain/models/recipe/recipe_model.dart';
import 'package:flutter/foundation.dart';

// TODO: consider freezed use case for immutable classes
@immutable
abstract class RecipeState {
  const RecipeState();
}

class RecipeInitial extends RecipeState {
  const RecipeInitial();
}

class RecipeLoading extends RecipeState {
  const RecipeLoading();
}

class RecipeLoaded extends RecipeState {
  const RecipeLoaded(this.recipe);
  final Recipe recipe;

  // consider freezed here
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RecipeLoaded && other.recipe == recipe;
  }

  @override
  int get hashCode => recipe.hashCode;
}

class RecipeError extends RecipeState {
  const RecipeError(this.message);
  final String message;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RecipeError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}



// class RecipePageState {
//   RecipePageState(this.isLoading);

//   final bool isLoading;
// }

// class MyCubit extends Cubit<RecipePageState> {
//   MyCubit() : super(RecipePageState(false));

//   void changeState() {
//     emit(RecipePageState(true));
//   }
// }
