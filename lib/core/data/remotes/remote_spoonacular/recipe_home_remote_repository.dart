import 'dart:convert';
import 'package:chow_down/core/models/spoonacular/search_result_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:chow_down/core/models/spoonacular/equipment.dart';
import 'package:chow_down/core/models/spoonacular/nutrients.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/core/models/spoonacular/similar_recipe.dart';
import 'package:chow_down/models/error/error.dart';
import 'package:dio/dio.dart';

abstract class RecipeHomeRepository {
  Future<RecipeCardInfoList> getLatestRecipe();
}

// This is the repo for the home page, the tab page will be calling firebase
class RemoteHomeRecipe implements RecipeHomeRepository {
  final String apiKey = dotenv.env['api_key'];
  final baseUrl = 'https://api.spoonacular.com/recipes';

  @override
  Future<RecipeCardInfoList> getLatestRecipe() async {
    String endpoint =
        '$baseUrl/complexSearch?query=chicken&apiKey=$apiKey&includeNutrition=true';

    // final ingredientsString =
    //     ingredients.map((ingredient) => ingredient + '%2C').toString();

    // endpoint = endpoint + ingredientsString;

    try {
      final response = await Dio().get(endpoint);
      final body = json.decode(response.toString());

      print("Data :" + body.toString());
      print("Response: " + response.statusCode.toString());
      // TODO: Actual error handling
      return RecipeCardInfoList.fromJson(body['results']);
    } catch (e) {
      print(e);
    }
  }

  Future<SimilarList> getSimilarFood(String id) async {
    // This will be useful for simialr recs on the actual recipe page
    final enpoint = '$baseUrl/recipes/$id/similar?apiKey=$apiKey';
    final response = await Dio().get(enpoint);
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

  Future<Recipe> getRecipeInformationFood(String id) async {
    // Might be the endpoint for the actual recipe
    final enpoint = '$baseUrl/$id/information?apiKey=$apiKey';
    final response = await Dio().get(enpoint);
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

  Future<EquipmentList> getEquipments(String id) async {
    final enpoint = '$baseUrl/$id/equipmentWidget.json?apiKey=$apiKey';
    final response = await Dio().get(enpoint);
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
    final enpoint = '$baseUrl/$id/nutritionWidget.json?apiKey=$apiKey';
    final response = await Dio().get(enpoint);
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
