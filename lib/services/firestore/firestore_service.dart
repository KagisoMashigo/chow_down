// 🎯 Dart imports:
import 'dart:io';

// 📦 Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/models/error/error.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  Future<void> deleteData({
    required String path,
    required Recipe recipe,
  }) async {
    try {
      final reference = FirebaseFirestore.instance.collection(path);

      // OG ref to delete
      final originalId = reference.doc(recipe.id.toString());

      // Generated ref to delete
      final customId = reference
          .doc(recipe.sourceUrl.toString().replaceAll(RegExp(r"[^\s\w]"), ''));

      if (recipe.id.toString().length < 6) {
        await customId.delete();
      }

      await originalId.delete();
    } on SocketException catch (e) {
      print(e);
      throw Failure(message: 'No Internet connection');
    } on HttpException catch (e) {
      print(e);
      throw Failure(message: 'There was a problem deleting the data');
    }
  }

  Future<void> saveRecipe({
    required String path,
    required Recipe recipe,
  }) async {
    try {
      final CollectionReference _collectionRef =
          FirebaseFirestore.instance.collection(path);

      final CollectionReference<Recipe> convertedCollection =
          _collectionRef.withConverter<Recipe>(
        fromFirestore: (snapshot, _) => Recipe.fromJson(snapshot.data()!),
        toFirestore: (recipe, _) => recipe.toJson(),
      );

      if (recipe.id < 0) {
        await convertedCollection
            .doc(recipe.sourceUrl.toString().replaceAll(RegExp(r"[^\s\w]"), ''))
            .set(recipe);
      } else {
        await convertedCollection.doc(recipe.id.toString()).set(recipe);
      }
    } on SocketException catch (e) {
      print(e);
      throw Failure(message: 'No Internet connection');
    } on HttpException catch (e) {
      print(e);
      throw Failure(message: 'There was a problem saving the recipe');
    }
  }

  Future<List<Recipe>> fetchSavedRecipes({required String path}) async {
    final _collectionRef = FirebaseFirestore.instance.collection(path);

    try {
      final QuerySnapshot finalSnapshot = await _collectionRef.get();
      final List<DocumentSnapshot> documents = finalSnapshot.docs;

      // Convert documents to recipes
      final List<Recipe> savedRecipes = documents.map((document) {
        return Recipe.fromFirestore(document.data() as Map<String, dynamic>);
      }).toList();

      return savedRecipes;
    } catch (e) {
      print(e.toString());
      throw Failure(
          message: 'Failed to fetch saved recipes. Error: ${e.toString()}');
    }
  }
}
