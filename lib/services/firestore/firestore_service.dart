// 🎯 Dart imports:
import 'dart:developer';
import 'dart:io';

// 📦 Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/models/error/error.dart';
import 'package:chow_down/plugins/debugHelper.dart';

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
      log(e.message);
      throw Failure(message: 'No Internet connection');
    } on HttpException catch (e) {
      log(e.message);
      throw Failure(message: 'There was a problem deleting the data');
    }
  }

  Future<void> saveRecipe({
    required String path,
    required Recipe recipe,
  }) async {
    try {
      final CollectionReference<Map<String, dynamic>> _collectionRef =
          FirebaseFirestore.instance.collection(path);

      if (recipe.id < 0) {
        // If the recipe has no ID, generate a document ID based on sourceUrl
        final documentId =
            recipe.sourceUrl.toString().replaceAll(RegExp(r"[^\s\w]"), '');
        await _collectionRef.doc(documentId).set(recipe.toJson());
      } else {
        // If the recipe has an ID, use it as the document ID
        await _collectionRef.doc(recipe.id.toString()).set(recipe.toJson());
      }
    } on FirebaseException catch (e) {
      printDebug('Firestore error:${e.message}', colour: DebugColour.red);

      throw Exception('Error while saving the recipe');
    } on SocketException catch (e) {
      printDebug('Socket error:${e.message}', colour: DebugColour.red);
      log(e.message);
      throw Failure(message: 'No Internet connection');
    } on HttpException catch (e) {
      log(e.message);
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
      log(e.toString());
      throw Failure(message: 'Failed to fetch saved recipes. Please try again');
    }
  }
}
