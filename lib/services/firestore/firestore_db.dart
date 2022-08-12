// 📦 Package imports:
import 'package:meta/meta.dart';

// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/models/firestore/entry.dart';
import 'package:chow_down/models/firestore/job.dart';
import 'package:chow_down/services/firestore/firestore_api_path.dart';
import 'package:chow_down/services/firestore/firestore_service.dart';

abstract class Database {
  Future<void> setJob(Job job);
  retrieveSavedRecipes();
  Future<void> setEntry(Entry entry);
  Future<void> saveRecipes(Recipe recipe);
  Future<void> deleteEntry(Entry entry);
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final _service = FirestoreService.instance;

  @override
  Future<void> setJob(Job job) => _service.setData(
        path: APIPath.job(uid, job.id),
        data: job.toMap(),
      );

  @override
  Future<List<Recipe>> retrieveSavedRecipes() {
    print(uid);
    return _service.fetchSavedRecipes(path: APIPath.saved_recipes(uid));
  }

  @override
  Future<void> saveRecipes(Recipe recipe) {
    return _service.saveRecipe(
        path: APIPath.saved_recipes(uid), recipe: recipe);
  }

  @override
  Future<void> setEntry(Entry entry) => _service.setData(
        path: APIPath.entry(uid, entry.id),
        data: entry.toMap(),
      );

  @override
  Future<void> deleteEntry(Entry entry) => _service.deleteData(
        path: APIPath.entry(uid, entry.id),
      );
}
