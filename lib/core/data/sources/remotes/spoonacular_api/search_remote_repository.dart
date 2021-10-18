import 'dart:convert';

import 'package:chow_down/core/data/sources/remotes/remote_commons.dart';
import 'package:chow_down/domain/models/search/search_repository.dart';
import 'package:chow_down/domain/models/search/search_result_model.dart';
import 'package:chow_down/models/error/error.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class RemoteSearchRepository extends SearchResultRepository
    implements DisposableRepository {
  RemoteSearchRepository({
    Dio client,
  }) : _client = client ?? Dio();

  /// The custom DIO that will manage API Calls
  Dio _client;
}

class RemoteSearch extends RemoteSearchRepository {
// TODO: NB endpoints = extract from website /

  static RemoteSearch _instance;

  RemoteSearch._({
    @required Dio client,
  }) : super(
          client: client,
        ) {
    _instance = this;
  }

  factory RemoteSearch({
    @required Dio client,
  }) =>
      _instance ??
      RemoteSearch._(
        client: client,
      );

  static RemoteSearch get instance => _instance;

  @override
  void dispose() {
    _client = null;
    _instance = null;
  }

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
    final body = json.decode(response.data);
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
