import 'package:bloc/bloc.dart';
import 'package:chow_down/pages/recipes/bloc/recipe_page_state.dart';
import 'package:chow_down/services/spoonacular_api/recipe_endpoints.dart';

class RecipeCubit extends Cubit<RecipeState> {
  RecipeCubit(this._recipeInformationService)
      : super(
          RecipeInitial(),
        );

  final RecipeInformationService _recipeInformationService;

  Future<void> getRecipes(String id) async {
    try {
      emit(RecipeLoading());
      final recipes =
          await _recipeInformationService.getRecipeInformationFood(id);
      emit(RecipeLoaded(recipes));
    } catch (e) {
      emit(RecipeError('Error'));
    }
  }
}
