import 'dart:convert';
import 'package:chow_down/domain/models/search/search_result_model.dart';
import 'package:chow_down/models/error/error.dart';
import 'package:dio/dio.dart';

abstract class SearchRepository {
  Future<SearchResultList> getRecipesList();
}

class RemoteSearchRepository {
  final String apiKey = '8888e278b728436ca3c758230ddf3e16';

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

  Future<SearchResultList> getRecipesList() async {
    final query = '';
    final endpoint =
        'https://api.spoonacular.com/recipes/complexSearch?query=apple&apiKey=$apiKey';
    final response = await Dio().get(endpoint);
    final body = json.decode(response.toString());
    print("body: $body");
    print("response: $response");

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
