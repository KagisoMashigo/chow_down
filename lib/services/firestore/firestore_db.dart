// 📦 Package imports:
import 'package:meta/meta.dart';

// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/services/firestore/firestore_api_path.dart';
import 'package:chow_down/services/firestore/firestore_service.dart';

abstract class Database {
  Future<List<Recipe>> retrieveSavedRecipes();
  Future<void> saveRecipes(Recipe recipe);
  Future<void> deleteRecipe(Recipe recipe);
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final _service = FirestoreService.instance;

  @override
  Future<List<Recipe>> retrieveSavedRecipes() {
    return _service.fetchSavedRecipes(path: APIPath.savedRecipes(uid));
  }

  @override
  Future<void> saveRecipes(Recipe recipe) {
    return _service.saveRecipe(path: APIPath.savedRecipes(uid), recipe: recipe);
  }

  @override
  Future<void> deleteRecipe(Recipe recipe) => _service.deleteData(
      path: APIPath.recipe(uid), recipeId: recipe.id.toString());
}
