// 🎯 Dart imports:
import 'dart:convert';
import 'dart:io';

// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/models/error/error.dart';

abstract class RecipeRepository {
  Future<Recipe> getExistingRecipe(int id, String sourceUrl);
  Future<Recipe> getExtractedRecipe(String url);
}

class RemoteRecipe implements RecipeRepository {
  final String apiKey = dotenv.env['api_key'];

  Future<Recipe> getExistingRecipe(int id, String sourceUrl) async {
    /// The first part of the function finds extracted recipes

    try {
      if (id == -1) {
        final endpoint =
            'https://api.spoonacular.com/recipes/extract?url=$sourceUrl&apiKey=$apiKey&analyze=true&forceExtraction=true&addRecipeInformation=true';
        final response = await Dio().get(endpoint);
        final body = json.decode(response.toString());
        return Recipe.fromJson(body);
      } else {
        /// This part is for searched recipes
        final endpoint =
            'https://api.spoonacular.com/recipes/$id/information?apiKey=$apiKey';

        final response = await Dio().get(endpoint);
        final body = json.decode(response.toString());
        return Recipe.fromJson(body);
      }
    } on SocketException catch (e) {
      print(e);
      throw Failure(message: 'No Internet connection');
    } on HttpException catch (e) {
      print(e);
      throw Failure(message: 'There was a problem extracting the recipe');
    } on DioError catch (e) {
      print(e);
      if (e.type == DioErrorType.connectTimeout) {
        throw Failure(message: "Connection  Timeout Exception");
      }
      if (e.response.statusCode == 503) {
        throw Failure(
          message:
              'Looks like the server is under maintenance. Please try again later.',
          code: 503,
        );
      } else if (e.response.statusCode == 400) {
        throw Failure(
          message:
              'Please enter a valid URL. Error code: ${e.response.statusCode}.',
          code: 400,
        );
      }
    }
  }

  @override
  Future<Recipe> getExtractedRecipe(String url) async {
    final endpoint =
        'https://api.spoonacular.com/recipes/extract?url=$url/&apiKey=$apiKey&analyze=true&forceExtraction=true&addRecipeInformation=true';

    try {
      final response = await Dio().get(endpoint);
      final body = json.decode(response.toString());

      if (response.data['image'] != null) {
        return Recipe.fromJson(body);
      }

      throw Failure(message: 'No Data');
    } on SocketException catch (e) {
      print(e);
      throw Failure(message: 'No Internet connection');
    } on HttpException catch (e) {
      print(e);
      throw Failure(message: 'There was a problem extracting the recipe');
    } on DioError catch (e) {
      print(e);
      if (e.type == DioErrorType.connectTimeout) {
        throw Failure(message: "Connection  Timeout Exception");
      }
      if (e.response.statusCode == 503) {
        throw Failure(
          message:
              'Looks like the server is under maintenance. Please try again later.',
          code: 503,
        );
      } else if (e.response.statusCode == 400) {
        throw Failure(
          message:
              'Please enter a valid URL. Error code: ${e.response.statusCode}.',
          code: 400,
        );
      }
    }
  }
}
