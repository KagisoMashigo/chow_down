// 🎯 Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:io';

// 📦 Package imports:
import 'package:chow_down/plugins/debugHelper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/models/error/error.dart';
import 'package:chow_down/plugins/utils/constants.dart';

abstract class RecipeRepository {
  Future<Recipe> getExistingRecipe(int id, String sourceUrl);
  Future<Recipe> getExtractedRecipe(String url);
}

class RemoteRecipe implements RecipeRepository {
  final String apiKey = dotenv.env['api_key']!;
  final dioClient = Dio(BaseOptions(
    connectTimeout: CONNECTION_TIMEOUT_TIME,
    receiveTimeout: RECEIVE_TIMEOUT_TIME,
  ));

  Future<Recipe> getExistingRecipe(int id, String sourceUrl) async {
    /// The first part of the function finds extracted recipes

    try {
      if (id == -1) {
        final endpoint =
            'https://api.spoonacular.com/recipes/extract?url=$sourceUrl&apiKey=$apiKey&analyze=true&forceExtraction=true&addRecipeInformation=true';
        final response = await dioClient.get(endpoint);
        final body = json.decode(response.toString());
        return Recipe.fromJson(body);
      } else {
        /// This part is for searched recipes
        final endpoint =
            'https://api.spoonacular.com/recipes/$id/information?apiKey=$apiKey';

        final response = await dioClient.get(endpoint);
        final body = json.decode(response.toString());
        return Recipe.fromJson(body);
      }
    } on SocketException catch (e) {
      printDebug(e.message);
      throw Failure(message: 'No Internet connection');
    } on HttpException catch (e) {
      printDebug(e.message);
      throw Failure(message: 'There was a problem extracting the recipe');
    } on DioException catch (e) {
      printDebug(e.message!);
      if (e.type == DioExceptionType.receiveTimeout) {
        throw Failure(message: 'The request took too long to complete');
      }
      if (e.response?.statusCode == 503) {
        printDebug(
            'Error code: ${e.response?.statusCode}. In method getExistingRecipe');

        throw Failure(
          message:
              'Looks like the server is under maintenance. Please try again later.',
          code: 503,
        );
      } else if (e.response?.statusCode == 400) {
        printDebug(
            'Error code: ${e.response?.statusCode}. In method getExistingRecipe');

        throw Failure(
          message: 'The URL provided is invalid or empty',
          code: 400,
        );
      } else if (e.response?.statusCode == 402) {
        printDebug(
            'Error code: ${e.response?.statusCode}. In method getExistingRecipe');

        // TODO: add analytics event for this

        throw Failure(
          message: 'API Quota exceeded. Please try again later.',
          code: 402,
        );
      } else {
        printDebug(
            'Error code: ${e.response?.statusCode}. In method getExistingRecipe');

        throw Failure(
          message: 'There was a problem fetching the recipe: ${e.message}',
          code: e.response?.statusCode,
        );
      }
    }
  }

  @override
  Future<Recipe> getExtractedRecipe(String url) async {
    final endpoint =
        'https://api.spoonacular.com/recipes/extract?url=$url/&apiKey=$apiKey&analyze=true&forceExtraction=true&addRecipeInformation=true';

    try {
      final response = await dioClient.get(endpoint);
      final body = json.decode(response.toString());

      if (response.data['analyzedInstructions'] != null &&
          response.data['extendedIngredients'] != null) {
        return Recipe.fromJson(body);
      } else {
        throw Failure(
            message:
                'We were unable to extract the recipe from the provided URL');
      }
    } on SocketException catch (e) {
      printDebug(e.message);
      throw Failure(message: 'No Internet connection');
    } on HttpException catch (e) {
      printDebug(e.message);
      throw Failure(message: 'There was a problem extracting the recipe');
    } on DioException catch (e) {
      printDebug(e.message!);
      if (e.type == DioExceptionType.receiveTimeout) {
        throw Failure(message: 'The request took too long to complete');
      }
      if (e.response?.statusCode == 503) {
        throw Failure(
          message:
              'Looks like the server is under maintenance. Please try again later.',
          code: 503,
        );
      } else if (e.response?.statusCode == 400) {
        printDebug('Error code: ${e.response?.statusCode}.');

        throw Failure(
          message: 'The URL provided is invalid or empty',
          code: 400,
        );
      } else {
        printDebug('Error code: ${e.response?.statusCode}.');

        throw Failure(
          message:
              'There was a problem extracting the recipe. Please try again.',
          code: e.response?.statusCode,
        );
      }
    }
  }
}
