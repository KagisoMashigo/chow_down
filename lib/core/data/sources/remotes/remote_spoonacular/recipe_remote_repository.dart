import 'dart:convert';
import 'dart:math';
import 'package:chow_down/core/data/models/spoonacular/equipment.dart';
import 'package:chow_down/core/data/models/spoonacular/nutrients.dart';
import 'package:chow_down/core/data/models/spoonacular/similar_recipe.dart';
import 'package:chow_down/core/data/models/spoonacular/recipe_model.dart';
import 'package:chow_down/models/error/error.dart';
import 'package:dio/dio.dart';

abstract class RecipeRepository {
  Future<Recipe> getRecipe();
}

class RemoteRecipe implements RecipeRepository {
  // TODO: use dotenv
  final String apiKey = '8888e278b728436ca3c758230ddf3e16';

  @override
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
