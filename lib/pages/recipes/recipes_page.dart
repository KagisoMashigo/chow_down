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
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Provider<RecipeProvider>(
  //     create: (_) => RecipeProvider(),
  //     builder: (context, provider, _) {
  //       return Column(
  //         children: [
  //           Text('Hey'),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeProvider>(
      builder: (context, provider, _) {
        return Column(
          children: [
            Text('Hey'),
          ],
        );
      },
    );
  }
}
