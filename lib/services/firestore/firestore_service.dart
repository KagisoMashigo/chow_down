// 🐦 Flutter imports:
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:flutter/foundation.dart';

// 📦 Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  Future<void> deleteData(
      {@required String path, @required String recipeId}) async {
    final reference = FirebaseFirestore.instance.collection(path);

    // OG ref to delete
    final originalId = reference.doc(recipeId);

    // Generated ref to delete
    final docId = reference.doc().id;

    // print(originalId.id);
    print(docId);
    // RegExp(r'[a-z]').hasMatch(docId.id

    if (docId.length > 6) {
      await reference.doc().delete();
    }

    await originalId.delete();
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

    if (recipe.id < 0) {
      await convertedCollection.doc(UniqueKey().toString()).set(recipe);
    } else {
      await convertedCollection.doc(recipe.id.toString()).set(recipe);
    }
  }

  Future<List<Recipe>> fetchSavedRecipes({@required String path}) async {
    final CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection(path);

    final List<Recipe> savedRecipes = [];

    final CollectionReference<Recipe> covertedCollection =
        _collectionRef.withConverter<Recipe>(
      fromFirestore: (snapshot, _) {
        /// This line colects the recipes as Recipes instead of Objects
        savedRecipes.add(Recipe.fromFirestore(snapshot));
        return Recipe.fromFirestore(snapshot);
      },
      toFirestore: (recipe, _) => recipe.toJson(),
    );

    /// These two lines are necessary to perform the fetch
    QuerySnapshot finalSnapshot = await covertedCollection.get();
    final recipeList = finalSnapshot.docs.map((doc) => doc.data()).toList();

    return savedRecipes;
  }
}
