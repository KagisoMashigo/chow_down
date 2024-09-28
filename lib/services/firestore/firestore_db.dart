// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/plugins/debugHelper.dart';
import 'package:chow_down/services/firestore/firestore_api_path.dart';
import 'package:chow_down/services/firestore/firestore_service.dart';

abstract class Database {
  Future<List<Recipe>> retrieveSavedRecipes();
  Future<void> saveRecipe(Recipe recipe);
  Future<void> saveEditedRecipe(Recipe recipe);
  Future<void> deleteRecipe(Recipe recipe, {bool isEdited});
  Future<void> deleteAllRecipes();
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.uid});
  final String uid;

  final _service = FirestoreService.instance;

  @override
  Future<List<Recipe>> retrieveSavedRecipes() async {
    try {
      printDebug('Retrieving saved recipes for user: $uid');
      final recipes =
          await _service.fetchSavedRecipes(path: APIPath.savedRecipes(uid));
      printDebug('Retrieved ${recipes.length} saved recipes for user: $uid');
      return recipes;
    } catch (e, stack) {
      printAndLog(
          e, 'Failed to retrieve saved recipes for user: $uid, reason: $stack');
      rethrow;
    }
  }

  Future<List<Recipe>> retrieveEditedRecipes() async {
    try {
      printDebug('Retrieving edited recipes for user: $uid');
      final recipes =
          await _service.fetchEditedRecipes(path: APIPath.editedRecipes(uid));
      printDebug('Retrieved ${recipes.length} edited recipes for user: $uid');
      return recipes;
    } catch (e, stack) {
      printAndLog(e,
          'Failed to retrieve edited recipes for user: $uid, reason: $stack');
      rethrow;
    }
  }

  @override
  Future<void> saveRecipe(Recipe recipe) async {
    try {
      printDebug('Saving recipe with ID: ${recipe.id} for user: $uid');
      await _service.saveRecipe(
          path: APIPath.savedRecipes(uid), recipe: recipe);
      printDebug('Saved recipe with ID: ${recipe.id} for user: $uid');
    } catch (e, stack) {
      printAndLog(e,
          'Failed to save recipe with ID: ${recipe.id} for user: $uid, reason: $stack');
      rethrow;
    }
  }

  @override
  Future<void> saveEditedRecipe(Recipe recipe) async {
    try {
      printDebug('Saving edited recipe with ID: ${recipe.id} for user: $uid');
      await _service.saveEditedRecipe(
          path: APIPath.editedRecipes(uid), recipe: recipe);
      printDebug('Saved edited recipe with ID: ${recipe.id} for user: $uid');
    } catch (e, stack) {
      printAndLog(e,
          'Failed to save edited recipe with ID: ${recipe.id} for user: $uid, reason: $stack');
      rethrow;
    }
  }

  @override
  Future<void> deleteRecipe(Recipe recipe, {bool isEdited = false}) async {
    try {
      printDebug('Deleting recipe with ID: ${recipe.id} for user: $uid');
      await _service.deleteData(
        path: isEdited ? APIPath.editedRecipes(uid) : APIPath.savedRecipes(uid),
        recipe: recipe,
      );
      printDebug('Deleted recipe with ID: ${recipe.id} for user: $uid');
    } catch (e, stack) {
      printAndLog(e,
          'Failed to delete recipe with ID: ${recipe.id} for user: $uid, reason: $stack');
      rethrow;
    }
  }

  @override
  Future<void> deleteAllRecipes() async {
    try {
      printDebug('Deleting all recipes for user: $uid');
      final recipes = await retrieveSavedRecipes();
      for (var recipe in recipes) {
        await deleteRecipe(recipe);
      }
      printDebug('Deleted all recipes for user: $uid');
    } catch (e, stack) {
      printAndLog(
          e, 'Failed to delete all recipes for user: $uid, reason: $stack');
      rethrow;
    }
  }
}
