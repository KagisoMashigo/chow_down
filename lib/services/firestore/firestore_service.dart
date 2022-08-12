// 🐦 Flutter imports:
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/core/models/spoonacular/search_result_model.dart';
import 'package:flutter/foundation.dart';

// 📦 Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  Future<void> setData({
    @required String path,
    @required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    // print('$path: $data');
    await reference.set(data);
  }

  Future<void> deleteData({@required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    // print('delete: $path');
    await reference.delete();
  }

  Future<void> saveRecipe(
      {@required String path, @required Recipe recipe}) async {
    final CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection(path);

    final CollectionReference<Recipe> convertedCollection =
        _collectionRef.withConverter<Recipe>(
      fromFirestore: (snapshot, _) => Recipe.fromJson(snapshot.data()),
      toFirestore: (recipe, _) => recipe.toJson(),
    );

    await convertedCollection.add(recipe);
  }

  Future<List<Recipe>> fetchSavedRecipes({@required String path}) async {
    final CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection(path);

    final List<Recipe> savedRecipes = [];

    final CollectionReference<Recipe> covertedCollection =
        _collectionRef.withConverter<Recipe>(
      fromFirestore: (snapshot, _) {
        savedRecipes.add(Recipe.fromFirestore(snapshot));
        return Recipe.fromFirestore(snapshot);
      },
      toFirestore: (recipe, _) => recipe.toJson(),
    );

    QuerySnapshot finalSnapshot = await covertedCollection.get();

    final recipeList = finalSnapshot.docs.map((doc) => doc.data()).toList();

    return savedRecipes;
  }
}
