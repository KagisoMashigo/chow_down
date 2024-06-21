// 🎯 Dart imports:
import 'dart:io';

// 📦 Package imports:
import 'package:chow_down/plugins/utils/helpers.dart';
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
    final reference = FirebaseFirestore.instance.collection(path);
    final originalId = reference.doc(recipe.id.toString());
    final customId = reference.doc(StringHelper.generateCustomId(recipe.title));

    try {
      printDebug(
          'Attempting to delete recipe with ID: ${recipe.id} at path: $path');

      if (recipe.id.toString().length < 6) {
        await customId.delete();
        printDebug(
            'Deleted custom ID: ${StringHelper.generateCustomId(recipe.title)}');
      }

      await originalId.delete();
      printDebug('Deleted original ID: ${recipe.id}');
    } catch (e, stack) {
      _handleException(e, stack, 'deleting recipe with ID: ${recipe.id}');
    }
  }

  Future<void> saveRecipe({
    required String path,
    required Recipe recipe,
  }) async {
    final CollectionReference<Map<String, dynamic>> _collectionRef =
        FirebaseFirestore.instance.collection(path);

    try {
      printDebug(
          'Attempting to save recipe with ID: ${recipe.id} at path: $path');

      if (recipe.id < 0) {
        final documentId = StringHelper.generateCustomId(recipe.title);
        await _collectionRef.doc(documentId).set(recipe.toJson());
        printDebug('Saved recipe with generated ID: $documentId');
      } else {
        await _collectionRef.doc(recipe.id.toString()).set(recipe.toJson());
        printDebug('Saved recipe with original ID: ${recipe.id}');
      }
    } catch (e, stack) {
      _handleException(e, stack, 'saving recipe with ID: ${recipe.id}');
    }
  }

  Future<List<Recipe>> fetchSavedRecipes({required String path}) async {
    final _collectionRef = FirebaseFirestore.instance.collection(path);

    try {
      printDebug('Fetching saved recipes at path: $path');
      final QuerySnapshot finalSnapshot = await _collectionRef.get();
      final List<DocumentSnapshot> documents = finalSnapshot.docs;

      final List<Recipe> savedRecipes = documents.map((document) {
        return Recipe.fromFirestore(document.data() as Map<String, dynamic>);
      }).toList();

      printDebug('Fetched ${savedRecipes.length} saved recipes at path: $path');
      return savedRecipes;
    } catch (e, stack) {
      _handleException(e, stack, 'fetching saved recipes at path: $path');
      throw Failure(message: 'Failed to fetch saved recipes. Please try again');
    }
  }

  void _handleException(Object e, StackTrace stack, String action) {
    if (e is SocketException) {
      printAndLog(e, 'No Internet connection while $action, reason: $stack');
      throw Failure(message: 'No Internet connection');
    } else if (e is HttpException) {
      printAndLog(e, 'HTTP error occurred while $action, reason: $stack');
      throw Failure(message: 'There was a problem $action');
    } else if (e is FirebaseException) {
      printAndLog(e, 'Firestore error occurred while $action, reason: $stack');
      throw Exception('Error while $action');
    } else {
      printAndLog(e, 'An error occurred while $action, reason: $stack');
      throw Failure(message: 'An unknown error occurred');
    }
  }
}
