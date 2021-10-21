import 'package:chow_down/core/data/sources/remotes/spoonacular_api/search_remote_repository.dart';
import 'package:chow_down/domain/models/search/search_repository.dart';
import 'package:chow_down/domain/models/search/search_result_model.dart';
import 'package:chow_down/services/service_commons.dart';
import 'package:flutter/material.dart';

// class SearchService implements DisposableService {
//   static SearchService _instance;

//   SearchService._(this._repository) {
//     _instance = this;
//   }

//   SearchRepository _repository;

//   factory SearchService({@required SearchResultRepository repository}) =>
//       _instance ?? SearchService._(repository);

//   static SearchService get instance => _instance;

//   @override
//   void dispose() {
//     _repository?.dispose();
//     _instance = null;
//   }

//   Future<SearchResultList> getRecipe() async {
//     final response = await _repository.getRecipesList();

//     return response;
//   }
// }
