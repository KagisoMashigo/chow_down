// 🎯 Dart imports:
import 'dart:io';

// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/models/error/error.dart';
// 📦 Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  Future<void> deleteData({
    @required String path,
    @required Recipe recipe,
  }) async {
    try {
      final reference = FirebaseFirestore.instance.collection(path);

      // OG ref to delete
      final originalId = reference.doc(recipe.id.toString());

      // Generated ref to delete
      final customId = reference
          .doc(recipe.sourceUrl.toString().replaceAll(RegExp(r"[^\s\w]"), ''));

      if (recipe.id.toString().length < 6) {
        print(recipe);
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

  Future<void> saveRecipe(
      {@required String path, @required Recipe recipe}) async {
    try {
      throw Failure(message: 'There was a problem saving the recipe');

      // final CollectionReference _collectionRef =
      //     FirebaseFirestore.instance.collection(path);

      // final CollectionReference<Recipe> convertedCollection =
      //     _collectionRef.withConverter<Recipe>(
      //   fromFirestore: (snapshot, _) => Recipe.fromJson(snapshot.data()),
      //   toFirestore: (recipe, _) => recipe.toJson(),
      // );

      // if (recipe.id < 0) {
      //   await convertedCollection
      //       .doc(recipe.sourceUrl.toString().replaceAll(RegExp(r"[^\s\w]"), ''))
      //       .set(recipe);
      // } else {
      //   await convertedCollection.doc(recipe.id.toString()).set(recipe);
      // }
    } on SocketException catch (e) {
      print(e);
      throw Failure(message: 'No Internet connection');
    } on HttpException catch (e) {
      print(e);
      throw Failure(message: 'There was a problem saving the recipe');
    }
  }

  Future<List<Recipe>> fetchSavedRecipes({@required String path}) async {
    try {
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
    } on SocketException catch (e) {
      print(e);
      throw Failure(message: 'No Internet connection');
    } on HttpException catch (e) {
      print(e);
      throw Failure(message: 'There was a problem fetching the recipes');
    }
  }
}
