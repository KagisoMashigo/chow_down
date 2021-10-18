import 'dart:convert';
import 'dart:math';

import 'package:chow_down/core/data/models/spoonacular_models.dart/equipment.dart';
import 'package:chow_down/core/data/models/spoonacular_models.dart/nutrients.dart';
import 'package:chow_down/core/data/models/spoonacular_models.dart/similar_recipe.dart';
import 'package:chow_down/core/data/sources/remotes/remote_commons.dart';
import 'package:chow_down/domain/models/recipe/recipe_model.dart';
import 'package:chow_down/domain/models/recipe/recipe_repository.dart';
import 'package:chow_down/models/error/error.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class RemoteRecipeRepository extends RecipeRepository
    implements DisposableRepository {
  RemoteRecipeRepository({
    Dio client,
  }) : _client = client ?? Dio();

  /// The custom DIO that will manage API Calls
  Dio _client;
}

class RemoteRecipe extends RemoteRecipeRepository {
// TODO: NB endpoints = extract from website /

  static RemoteRecipe _instance;

  RemoteRecipe._({
    @required Dio client,
  }) : super(
          client: client,
        ) {
    _instance = this;
  }

  factory RemoteRecipe({
    @required Dio client,
  }) =>
      _instance ??
      RemoteRecipe._(
        client: client,
      );

  static RemoteRecipe get instance => _instance;

  @override
  void dispose() {
    _client = null;
    _instance = null;
  }

  // TODO: use dotenv
  final String apiKey = '8888e278b728436ca3c758230ddf3e16';

  Future<Recipe> getRecipeInformationFood(String id) async {
    final url =
        'https://api.spoonacular.com/recipes/$id/information?apiKey=$apiKey';
    final response = await Dio().get(url);
    final body = json.decode(response.data);
    print("get random food: " + response.statusCode.toString());

    if (response.statusCode == 200) {
      return Recipe.fromJson(body);
    } else if (response.statusCode == 401) {
      throw Failure(code: 401, message: body['message']);
    } else {
      String msg = 'Something went wrong';
      if (body.containsKey('message')) {
        msg = body['message'];
      }
      throw Failure(code: response.statusCode, message: msg);
    }
  }

  Future<SimilarList> getSimilarFood(String id) async {
    final url =
        'https://api.spoonacular.com/recipes/$id/similar?apiKey=${apiKey[Random().nextInt(14)]}';
    final response = await Dio().get(url);
    final body = json.decode(response.data);
    print("get similar food :" + response.statusCode.toString());

    if (response.statusCode == 200) {
      return SimilarList.fromJson(body);
    } else if (response.statusCode == 401) {
      throw Failure(code: 401, message: body['message']);
    } else {
      final msg = 'Something went wrong';
      if (body.containsKey('message')) {
        String msg = body['message'];
      }
      throw Failure(code: response.statusCode, message: msg);
    }
  }

  Future<EquipmentList> getEquipments(String id) async {
    final url =
        'https://api.spoonacular.com/recipes/$id/equipmentWidget.json?apiKey=${apiKey[Random().nextInt(14)]}';
    final response = await Dio().get(url);
    final body = json.decode(response.data);
    print("get Equipments food :" + response.statusCode.toString());

    if (response.statusCode == 200) {
      return EquipmentList.fromJson(body['equipment']);
    } else if (response.statusCode == 401) {
      throw Failure(code: 401, message: body['message']);
    } else {
      final msg = 'Something went wrong';
      if (body.containsKey('message')) {
        String msg = body['message'];
      }
      throw Failure(code: response.statusCode, message: msg);
    }
  }

  Future<Nutrient> getNutrient(String id) async {
    final url =
        'https://api.spoonacular.com/recipes/$id/nutritionWidget.json?apiKey=${apiKey[Random().nextInt(14)]}';
    final response = await Dio().get(url);
    final body = json.decode(response.data);
    print("get Equipments food :" + response.statusCode.toString());

    if (response.statusCode == 200) {
      return Nutrient.fromJson(body);
    } else if (response.statusCode == 401) {
      throw Failure(code: 401, message: body['message']);
    } else {
      final msg = 'Something went wrong';
      if (body.containsKey('message')) {
        String msg = body['message'];
      }
      throw Failure(code: response.statusCode, message: msg);
    }
  }

  Future<Recipe> getRecipe() async {
    // List<String> ingredients = ['bananas', 'apples', 'cheese', 'crackers'];

    String requestString =
        "https://api.spoonacular.com/recipes/complexSearch?query=apple&apiKey=$apiKey&includeNutrition=true";

    // final ingredientsString =
    //     ingredients.map((ingredient) => ingredient + '%2C').toString();

    // requestString = requestString + ingredientsString;
    try {
      final response = await Dio().get(requestString);
      final body = Recipe.fromJson(response.data);
      print("Data :" + body.toString());
      print("Response: " + response.statusCode.toString());
      return body;
    } catch (e) {
      print(e);
    }
  }
}
