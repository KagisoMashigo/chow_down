// 🎯 Dart imports:
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/search_result_model.dart';
import 'package:chow_down/models/error/error.dart';

abstract class SearchRepository {
  Future<RecipeCardInfoList> getRecipesList(String query);
}

class RemoteSearchRepository implements SearchRepository {
  final String apiKey = dotenv.env['api_key']!;
  final dioClient = Dio();

  @override
  Future<RecipeCardInfoList> getRecipesList(String query) async {
    final endpoint =
        'https://api.spoonacular.com/recipes/complexSearch?query=$query&apiKey=$apiKey&instructionsRequired=true&addRecipeInformation=true&number=20&sort=popularity&sortDirection=desc&addRecipeInformation';

    try {
      final response = await Dio().get(endpoint);
      final body = json.decode(response.toString());

      return RecipeCardInfoList.fromJson(body);
    } on SocketException catch (e) {
      print(e);
      throw Failure(message: 'No Internet connection');
    } on HttpException catch (e) {
      print(e);
      throw Failure(message: 'There was a problem fetching the recipes');
    } on DioException catch (e) {
      log(e.message!);
      if (e.type == DioExceptionType.receiveTimeout) {
        throw Failure(message: 'The request took too long to complete');
      }

      if (e.response?.statusCode == 503) {
        throw Failure(
          message:
              'Looks like the server is under maintenance. Please try again later.',
          code: e.response?.statusCode,
        );
      } else if (e.response?.statusCode == 400) {
        log('Error code: ${e.response?.statusCode}.');

        throw Failure(
          message: 'The query provided is invalid or empty',
          code: 400,
        );
      } else {
        throw Failure(
          message: 'There was a problem with your search',
          code: e.response?.statusCode,
        );
      }
    }
  }
}
