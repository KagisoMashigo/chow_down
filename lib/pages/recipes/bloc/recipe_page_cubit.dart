// import 'package:bloc/bloc.dart';
// import 'package:chow_down/core/data/sources/spoonacular_api/recipe_remote_repository.dart';
// import 'package:chow_down/pages/recipes/bloc/recipe_page_state.dart';

// class RecipeCubit extends Cubit<RecipeState> {
//   RecipeCubit(this._recipeInformationService)
//       : super(
//           RecipeInitial(),
//         );

//   final RemoteRecipe _recipeInformationService;

//   Future<void> getRecipes(String id) async {
//     try {
//       emit(RecipeLoading());
//       final recipes =
//           await _recipeInformationService.getRecipeInformationFood(id);
//       emit(RecipeLoaded(recipes));
//     } catch (e) {
//       emit(RecipeError('Error'));
//     }
//   }
// }
