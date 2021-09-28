import 'package:chow_down/core/data/models/spoonacular_models.dart/recipe.dart';
import 'package:chow_down/services/spoonacular_api/recipe_endpoints.dart';
import 'package:flutter/material.dart';

class RecipePage extends StatefulWidget {
  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  Future<Recipe> service;
  Recipe recipe;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    service =
        RecipeInformationService().getRecipe().then((value) => recipe = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${recipe.toString()}'),
      ),
      body: Column(
        children: [
          Container(),
        ],
      ),
    );
  }
}
