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

  @override
  Future<Recipe> getExistingRecipe(int id, String sourceUrl) async {
    try {
      if (id == -1) {
        printDebug('Attempting to extract recipe from URL: $sourceUrl');
        final endpoint =
            'https://api.spoonacular.com/recipes/extract?url=$sourceUrl&apiKey=$apiKey&analyze=true&forceExtraction=true&addRecipeInformation=true';
        final response = await dioClient.get(endpoint);
        final body = json.decode(response.toString());
        printDebug('Recipe extraction successful from URL: $sourceUrl');
        return Recipe.fromJson(body);
      } else {
        printDebug('Attempting to fetch recipe information with ID: $id');
        final endpoint =
            'https://api.spoonacular.com/recipes/$id/information?apiKey=$apiKey';
        final response = await dioClient.get(endpoint);
        final body = json.decode(response.toString());
        printDebug('Recipe information fetched successfully with ID: $id');
        return Recipe.fromJson(body);
      }
    } on SocketException catch (e, stack) {
      printAndLog(e, 'No Internet connection while fetching recipe: $stack');
      throw Failure(message: 'No Internet connection');
    } on HttpException catch (e, stack) {
      printAndLog(e, 'HTTP error occurred while fetching recipe: $stack');
      throw Failure(message: 'There was a problem extracting the recipe');
    } on DioException catch (e, stack) {
      printAndLog(e, 'Dio error occurred while fetching recipe: $stack');
      if (e.response?.statusCode == 503) {
        printDebug('Server under maintenance: ${e.response?.statusCode}');
        throw Failure(
          message:
              'Looks like the server is under maintenance. Please try again later.',
          code: 503,
        );
      } else if (e.response?.statusCode == 400) {
        printDebug('Invalid URL provided: ${e.response?.statusCode}');
        throw Failure(
          message: 'The URL provided is invalid or empty',
          code: 400,
        );
      } else if (e.response?.statusCode == 402) {
        printDebug('API quota exceeded: ${e.response?.statusCode}');
        throw Failure(
          message: 'API Quota exceeded. Please try again later.',
          code: 402,
        );
      } else {
        printDebug('Error code: ${e.response?.statusCode}');
        throw Failure(
          message:
              '[${e.response?.data['code']}]${e.response?.data['message']}',
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
      printDebug('Attempting to extract recipe from URL: $url');
      final response = await dioClient.get(endpoint);
      final body = json.decode(response.toString());

      if (response.data['analyzedInstructions'] != null &&
          response.data['extendedIngredients'] != null) {
        printDebug('Recipe extraction successful from URL: $url');
        return Recipe.fromJson(body);
      } else {
        throw Failure(
            message:
                'We were unable to extract the recipe from the provided URL');
      }
    } on SocketException catch (e, stack) {
      printAndLog(e, 'No Internet connection while extracting recipe: $stack');
      throw Failure(message: 'No Internet connection');
    } on HttpException catch (e, stack) {
      printAndLog(e, 'HTTP error occurred while extracting recipe: $stack');
      throw Failure(message: 'There was a problem extracting the recipe');
    } on DioException catch (e, stack) {
      printAndLog(e, 'Dio error occurred while extracting recipe: $stack');
      if (e.type == DioExceptionType.receiveTimeout) {
        throw Failure(message: 'The request took too long to complete');
      }
      if (e.response?.statusCode == 503) {
        printDebug('Server under maintenance: ${e.response?.statusCode}');
        throw Failure(
          message:
              'Looks like the server is under maintenance. Please try again later.',
          code: 503,
        );
      } else if (e.response?.statusCode == 400) {
        printDebug('Invalid URL provided: ${e.response?.statusCode}');
        throw Failure(
          message: 'The URL provided is invalid or empty',
          code: 400,
        );
      } else {
        printDebug('Error code: ${e.response?.statusCode}');
        throw Failure(
          message:
              'There was a problem extracting the recipe. Please try again.',
          code: e.response?.statusCode,
        );
      }
    }
  }
}
