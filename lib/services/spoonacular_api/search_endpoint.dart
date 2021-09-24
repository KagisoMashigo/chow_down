import 'dart:convert';
import 'package:chow_down/core/data/models/spoonacular_models.dart/search_autocomplete_model.dart';
import 'package:chow_down/core/data/models/spoonacular_models.dart/search_result_model.dart';
import 'package:chow_down/models/error/error.dart';
import 'package:dio/dio.dart';

class SearchRepo {
  final String apiKey = 'ApiKey.keys';

  Future<SearchResultList> getSearchList(String type, int no) async {
    var endpoint =
        'https://api.spoonacular.com/recipes/complexSearch?query=$type&number=$no&apiKey=$apiKey';
    var response = await Dio().get(endpoint);
    var body = json.decode(response.data);
    print("get random food: " + response.statusCode.toString());

    if (response.statusCode == 200) {
      return SearchResultList.fromJson(body['results']);
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

  Future<SearchAutoCompleteList> getAutoCompleteList(String searchText) async {
    var endpoint =
        'https://api.spoonacular.com/recipes/autocomplete?number=100&query=$searchText&apiKey=$apiKey';
    var response = await Dio().get(endpoint);
    var body = json.decode(response.data);
    print("get random food: " + response.statusCode.toString());

    if (response.statusCode == 200) {
      return SearchAutoCompleteList.fromJson(body);
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
}
