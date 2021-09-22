import 'dart:convert';
import 'dart:math';

import 'package:chow_down/core/data/models/spoonacular_models.dart/equipment.dart';
import 'package:chow_down/core/data/models/spoonacular_models.dart/nutrients.dart';
import 'package:chow_down/core/data/models/spoonacular_models.dart/recipe.dart';
import 'package:chow_down/core/data/models/spoonacular_models.dart/similar_recipe.dart';
import 'package:chow_down/models/error/error.dart';
import 'package:dio/dio.dart';

class RecipeInformation {
  // TODO: use dotenv
  final String apiKey = 'ApiKey.keys';

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
}
