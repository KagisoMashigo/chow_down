// 🎯 Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

// 📦 Package imports:
import 'package:chow_down/plugins/utils/constants.dart';
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
    } on TimeoutException catch (e) {
      log(e.message!);
      throw Failure(message: 'The request took too long to complete');
    } on SocketException catch (e) {
      log(e.message);
      throw Failure(message: 'No Internet connection');
    } on HttpException catch (e) {
      log(e.message);
      throw Failure(message: 'There was a problem extracting the recipe');
    } on DioException catch (e) {
      log(e.message!);
      if (e.type == DioExceptionType.receiveTimeout) {
        throw Failure(message: "Connection  Timeout Exception");
      }
      if (e.response?.statusCode == 503) {
        throw Failure(
          message:
              'Looks like the server is under maintenance. Please try again later.',
          code: 503,
        );
      } else if (e.response?.statusCode == 400) {
        throw Failure(
          message:
              'Please enter a valid URL. Error code: ${e.response?.statusCode}.',
          code: 400,
        );
      } else {
        throw Failure(
          message:
              'There was a problem extracting the recipe. Error code: ${e.response?.statusCode}.',
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

      if (response.data['image'] != null) {
        return Recipe.fromJson(body);
      } else {
        throw Failure(
            message:
                'There was a problem extracting the data, please try again later');
      }
    } on SocketException catch (e) {
      log(e.message);
      throw Failure(message: 'No Internet connection');
    } on HttpException catch (e) {
      log(e.message);
      throw Failure(message: 'There was a problem extracting the recipe');
    } on DioException catch (e) {
      log(e.message!);
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
        throw Failure(
          message:
              'Please enter a valid URL. Error code: ${e.response?.statusCode}.',
          code: 400,
        );
      } else {
        throw Failure(
          message:
              'There was a problem extracting the recipe. Error code: ${e.response?.statusCode}.',
          code: e.response?.statusCode,
        );
      }
    }
  }
}
