import 'dart:convert';
import 'dart:math';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:chow_down/core/models/spoonacular/equipment.dart';
import 'package:chow_down/core/models/spoonacular/nutrients.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/core/models/spoonacular/similar_recipe.dart';
import 'package:chow_down/models/error/error.dart';
import 'package:dio/dio.dart';

abstract class RecipeTabRepository {
  Future<Recipe> getRecipe();
  Future<Recipe> getRecipeInformation();
}

class RemoteRecipeTab implements RecipeTabRepository {
  final String apiKey = dotenv.env['api_key'];

  @override
  Future<Recipe> getRecipe() async {
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

  Future<Recipe> getRecipeInformation() async {
    final endpoint =
        'https://api.spoonacular.com/recipes/716429/information?apiKey=$apiKey';

    try {
      final response = await Dio().get(endpoint);
      final body = json.decode(response.toString());

      print("Data :" + body.toString());
      print("Response: " + response.statusCode.toString());
      // TODO: Actual error handling
      return Recipe.fromJson(body);
    } catch (e) {
      print(e);
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
