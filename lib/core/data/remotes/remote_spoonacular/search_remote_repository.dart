// 🎯 Dart imports:
import 'dart:convert';

// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/search_result_model.dart';
import 'package:chow_down/models/error/error.dart';

abstract class SearchRepository {
  Future<RecipeCardInfoList> getRecipesList(String query);
  Future<RecipeExtracted> getExtractedRecipe(String url);
}

class RemoteSearchRepository implements SearchRepository {
  final String apiKey = dotenv.env['api_key'];

  @override
  Future<RecipeCardInfoList> getRecipesList(String query) async {
    final endpoint =
        'https://api.spoonacular.com/recipes/complexSearch?query=$query&apiKey=$apiKey&instructionsRequired=true&addRecipeInformation=true&number=50&sort=popularity&sortDirection=desc&addRecipeInformation';

    // TODO do error handling
    // try {
    //   final response = await Dio().get(endpoint);
    //   final body = json.decode(response.toString());
    //   return RecipeCardInfoList.fromJson(body['results']);
    // } on Failure {
    //   throw Failure;
    // }

    final response = await Dio().get(endpoint);
    final body = json.decode(response.toString());

    if (response.statusCode == 200) {
      print('BODY: ${body.toString()}');

      return RecipeCardInfoList.fromJson(body['results']);
    } else if (response.statusCode == 401) {
      throw Failure(code: 401, message: body['message']);
    } else {
      var msg = 'Something went wrong';
      if (body.containsKey('message')) {
        msg = body['message'];
      }
      throw Failure(code: response.statusCode, message: msg);
    }
  }

  @override
  Future<RecipeExtracted> getExtractedRecipe(String url) async {
    final endpoint =
        'https://api.spoonacular.com/recipes/extract?url=$url/&apiKey=$apiKey&addRecipeInformation=true';

    // TODO do error handling
    // try {
    //   final response = await Dio().get(endpoint);
    //   final body = json.decode(response.toString());
    //   return RecipeCardInfoList.fromJson(body['results']);
    // } on Failure {
    //   throw Failure;
    // }

    final response = await Dio().get(endpoint);
    final body = json.decode(response.toString());

    if (response.statusCode == 200) {
      print('reposnse: $body');
      print('reposnse: ${body['title']}');
      print('reposnse: ${body['sourceUrl']}');

      return RecipeExtracted.fromJson(body);
    } else if (response.statusCode == 401) {
      throw Failure(code: 401, message: body['message']);
    } else {
      var msg = 'Something went wrong';
      if (body.containsKey('message')) {
        msg = body['message'];
      }
      throw Failure(code: response.statusCode, message: msg);
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

  // Future<SearchResultList> getSearchList(String type, int no) async {
  //   final endpoint =
  //       'https://api.spoonacular.com/recipes/complexSearch?query=$type&number=$no&apiKey=$apiKey';
  //   final response = await Dio().get(endpoint);
  //   final body = json.decode(response.data);
  //   print("get random food: " + response.statusCode.toString());

  //   if (response.statusCode == 200) {
  //     return SearchResultList.fromJson(body['results']);
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
