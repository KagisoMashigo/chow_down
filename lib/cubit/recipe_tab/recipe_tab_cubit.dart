// 📦 Package imports:
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chow_down/services/firestore/firestore_db.dart';
import 'package:equatable/equatable.dart';

// 🌎 Project imports:
import 'package:chow_down/core/data/remotes/remote_spoonacular/recipe_home_remote_repository.dart';
import 'package:chow_down/core/models/spoonacular/search_result_model.dart';
import 'package:chow_down/models/error/error.dart';

part 'recipe_tab_state.dart';

class RecipeTabCubit extends Cubit<RecipeTabState> {
  RecipeTabCubit(this._recipeHomeRepository, this._database)
      : super(RecipeTabInitial());

  final RemoteHomeRecipe _recipeHomeRepository;
  final FirestoreDatabase _database;

  Future<void> fetchHomeRecipesList() async {
    try {
      emit(RecipeTabLoading());

      final searchResults = await _database.retrieveSavedRecipes();
      await Future<void>.delayed(const Duration(milliseconds: 50));

      emit(RecipeTabLoaded(searchResults));
    } on Failure catch (e) {
      // print('${e} UI state');

      emit(RecipTabError(e.toString()));
    }
  }
}
