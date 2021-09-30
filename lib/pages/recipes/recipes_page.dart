import 'package:chow_down/components/cards/recipe_card.dart';
import 'package:chow_down/domain/models/recipe/recipe_model.dart';
import 'package:chow_down/providers/recipe_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipePage extends StatefulWidget {
  @override
  _RecipePageState createState() => _RecipePageState();
  // TODO: consider passing in uid I guess?
}

class _RecipePageState extends State<RecipePage> {
  // move to provider
  RecipeProvider _provider;
  // Recipe recipe;

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<RecipeProvider>(context, listen: false);
    _provider.getRecipeHome();
  }

  Widget _createCard(Recipe recipe) {
    final title = recipe.title;
    final image = recipe.image;
    final id = recipe.id;
    final imageType = recipe.imageType;

    return RecipeCard(
      title: title,
      imageUrl: image,
      id: id,
      imageType: imageType,
    );
  }

  List<Widget> _renderEventList() {
    final filteredEvents = _provider.recipes
        .map<Widget>((eventData) => _createCard(eventData))
        .toList();

    return filteredEvents;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeProvider>(
      builder: (context, provider, _) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(88.0),
              child: ListView(
                children: [..._renderEventList()],
              ),
            ),
          ],
        );
      },
    );
  }
}
