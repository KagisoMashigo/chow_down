// 🎯 Dart imports:
import 'dart:convert';
import 'dart:io';

// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/core/models/spoonacular/search_result_model.dart';
import 'package:chow_down/models/error/error.dart';
// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class SearchRepository {
  Future<RecipeCardInfoList> getRecipesList(String query);
}

class RemoteSearchRepository implements SearchRepository {
  final String apiKey = dotenv.env['api_key'];

  @override
  Future<RecipeCardInfoList> getRecipesList(String query) async {
    final endpoint =
        'https://api.spoonacular.com/recipes/complexSearch?query=$query&apiKey=$apiKey&instructionsRequired=true&addRecipeInformation=true&number=20&sort=popularity&sortDirection=desc&addRecipeInformation';

    try {
      final response = await Dio().get(endpoint);
      final body = json.decode(response.toString());

      return RecipeCardInfoList.fromJson(body['results']);
    } on SocketException catch (e) {
      print(e);
      throw Failure(message: 'No Internet connection');
    } on HttpException catch (e) {
      print(e);
      throw Failure(message: 'There was a problem extracting the recipe');
    } on DioError catch (e) {
      print(e);

      if (e.response.statusCode == 503) {
        throw Failure(
          message:
              'There\'s a problem with the recipe server. Please try again later. Error code: ${e.response.statusCode}.',
          code: 503,
        );
      } else {
        throw Failure(
          message:
              'Please enter a valid URL. Error code: ${e.response.statusCode}.',
          code: 400,
        );
      }
    }
  }
}
