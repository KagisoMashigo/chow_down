// 🎯 Dart imports:
import 'dart:convert';
import 'dart:io';

// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/core/models/spoonacular/search_result_model.dart';
import 'package:chow_down/models/error/error.dart';

abstract class SearchRepository {
  Future<RecipeCardInfoList> getRecipesList(String query);
  Future<Recipe> getExtractedRecipe(String url);
}

class RemoteSearchRepository implements SearchRepository {
  final String apiKey = dotenv.env['api_key'];

  @override
  Future<RecipeCardInfoList> getRecipesList(String query) async {
    final endpoint =
        'https://api.spoonacular.com/recipes/complexSearch?query=$query&apiKey=$apiKey&instructionsRequired=true&addRecipeInformation=true&number=10&sort=popularity&sortDirection=desc&addRecipeInformation';

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
    }
  }

  // Future<SearchAutoCompleteList> getAutoCompleteList(String searchText) async {
  //   final endpoint =
  //       'https://api.spoonacular.com/recipes/autocomplete?number=100&query=$searchText&apiKey=$apiKey';
  //   final response = await Dio().get(endpoint);
  //   final body = json.decode(response.data);
  //   print("get random food: " + response.statusCode.toString());

  //   if (response.statusCode == 200) {
  //     return SearchAutoCompleteList.fromJson(body);
  //   } else if (response.statusCode == 401) {
  //     throw Failure(code: 401, message: body['message']);
  //   } else {
  //     var msg = 'Something went wrong';
  //     if (body.containsKey('message')) {
  //       msg = body['message'];
  //     }
  //     throw Failure(code: response.statusCode, message: msg);
  //   }
  // }

}
