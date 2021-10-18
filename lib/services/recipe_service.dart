import 'package:chow_down/core/data/sources/remotes/spoonacular_api/recipe_remote_repository.dart';
import 'package:chow_down/domain/models/recipe/recipe_model.dart';
import 'package:chow_down/domain/models/recipe/recipe_repository.dart';
import 'package:chow_down/services/service_commons.dart';
import 'package:flutter/material.dart';

class RecipeService implements DisposableService {
  static RecipeService _instance;

  RecipeService._(this._repository) {
    _instance = this;
  }

  RemoteRecipe _repository;

  factory RecipeService({@required RecipeRepository repository}) =>
      _instance ?? RecipeService._(repository);

  static RecipeService get instance => _instance;

  @override
  void dispose() {
    _repository?.dispose();
    _instance = null;
  }

  Future<Recipe> getRecipe() async => await _repository.getRecipe();
}
