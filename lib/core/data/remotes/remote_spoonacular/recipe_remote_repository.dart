// 🎯 Dart imports:
import 'dart:convert';
import 'dart:math';

// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/equipment.dart';
import 'package:chow_down/core/models/spoonacular/nutrients.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/core/models/spoonacular/similar_recipe.dart';
import 'package:chow_down/models/error/error.dart';

abstract class RecipeRepository {
  Future<Recipe> getRecipeInformation(int id, String sourceUrl);
}

class RemoteRecipe implements RecipeRepository {
  // TODO: refactor this logic and maybe sperate/ also try catch
  // TODO: Actual error handling and try catch blocks
  final String apiKey = dotenv.env['api_key'];

  Future<Recipe> getRecipeInformation(int id, String sourceUrl) async {
    if (id == -1) {
      final endpoint =
          'https://api.spoonacular.com/recipes/extract?url=$sourceUrl&apiKey=$apiKey&addRecipeInformation=true';
      final response = await Dio().get(endpoint);
      final body = json.decode(response.toString());
      print('endpoint recipe ${endpoint}');
      return Recipe.fromJson(body);
    } else {
      final endpoint =
          'https://api.spoonacular.com/recipes/$id/information?apiKey=$apiKey';

      final response = await Dio().get(endpoint);
      final body = json.decode(response.toString());
      return Recipe.fromJson(body);
    }

    // if (response.statusCode == 200) {
    //   print("Data : $body");
    //   print("Data 2: $body");
    //   // print("Response: " + response.statusCode.toString());
    //   return Recipe.fromJson(body);
    // } else if (response.statusCode == 401) {
    //   throw Failure(code: 401, message: body['message']);
    // } else {
    //   var msg = 'Something went wrong';
    //   if (body.containsKey('message')) {
    //     msg = body['message'];
    //   }
    //   throw Failure(code: response.statusCode, message: msg);
    // }

    // try {

    // } catch (e) {
    //   print(e);
    // }
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
