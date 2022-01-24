// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:chow_down/components/customAppBar.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/cubit/recipe_info/recipe_info_cubit.dart';
import 'package:chow_down/plugins/responsive.dart';

class RecipeInfoPage extends StatefulWidget {
  const RecipeInfoPage({
    Key key,
    @required this.title,
    this.id,
  }) : super(key: key);

  /// Recipe title
  final String title;

  /// Recipe id
  final int id;

  @override
  _RecipeInfoPageState createState() => _RecipeInfoPageState();
}

class _RecipeInfoPageState extends State<RecipeInfoPage> {
  void initState() {
    super.initState();
    // Will change this to a DB call once user can save recipes
    Provider.of<RecipeInfoCubit>(context, listen: false)
        .fetchRecipeInformation(widget.id);
  }

  @override
  Widget build(BuildContext conxtext) {
    return CustomLogoAppBar(
      imgUrl: 'assets/images/chow_down.png',
      title: widget.title,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1528458876861-544fd1761a91?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1388&q=80'),
            fit: BoxFit.cover,
          ),
        ),
        // padding: EdgeInsets.all(11.1),
        alignment: Alignment.center,
        child: BlocConsumer<RecipeInfoCubit, RecipeInfoState>(
          listener: (context, state) {
            if (state is RecipInfoError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is RecipeInfoLoading) {
              return _buildLoading();
            } else if (state is RecipeInfoLoaded) {
              return _buildContents(state.recipe);
            } else {
              // error state snackbar
              return _buildInitialInput();
            }
          },
        ),
      ),
    );
  }

  Widget _buildInitialInput() => Padding(
        padding: EdgeInsets.only(top: 12 * Responsive.ratioVertical),
        child: Column(
          children: [Container()],
        ),
      );

  Widget _buildLoading() => Center(
        child: CircularProgressIndicator(),
      );

  Widget _buildContents(Recipe recipe) => ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: Image.network(
                  recipe.image,
                  // width: 3 * Responsive.ratioHorizontal,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // verticalDivider(factor: 2),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        recipe.title,
                        style: TextStyle(
                          fontSize: 7 * Responsive.ratioHorizontal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                verticalDivider(factor: 2),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'By ${recipe.creditsText}',
                        style: TextStyle(
                          fontSize: 4 * Responsive.ratioHorizontal,
                          fontStyle: FontStyle.italic,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                verticalDivider(factor: 2.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // TODO create rating system
                    const Icon(Icons.stars),
                    horizontalDivider(factor: 2),
                    Text(
                      '564 ratings',
                      style: TextStyle(
                        fontSize: 5 * Responsive.ratioHorizontal,
                        // fontStyle: FontStyle.italic,
                      ),
                    ),
                    horizontalDivider(factor: 2),
                    TextButton(
                      onPressed: () => print('rated!'),
                      child: Text(
                        'rate this recipe',
                        style: TextStyle(
                          fontSize: 5 * Responsive.ratioHorizontal,
                          // fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
                verticalDivider(factor: 2.5),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => print('saved!'),
                      iconSize: 35,
                      icon: const Icon(
                        Icons.save_rounded,
                      ),
                    ),
                    Text(
                      'Save recipe',
                      style: TextStyle(
                        fontSize: 5 * Responsive.ratioHorizontal,
                        // fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                verticalDivider(factor: 2.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Servings: ${recipe.servings.toString()}',
                            style: TextStyle(
                              fontSize: 4 * Responsive.ratioHorizontal,
                              // fontStyle: FontStyle.italic,
                            ),
                          ),
                          verticalDivider(factor: 4),
                          Text(
                            'Ready In: ${recipe.readyInMinutes.toString()} minutes',
                            style: TextStyle(
                              fontSize: 4 * Responsive.ratioHorizontal,
                              // fontStyle: FontStyle.italic,
                            ),
                          )
                        ],
                      ),
                    ),
                    // horizontalDivider(factor: 4),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gluten Free: ${recipe.glutenFree.toString()}',
                            style: TextStyle(
                              fontSize: 4 * Responsive.ratioHorizontal,
                              // fontStyle: FontStyle.italic,
                            ),
                          ),
                          verticalDivider(factor: 4),
                          Text(
                            'Vegetarian: ${recipe.vegetarian.toString()}',
                            style: TextStyle(
                              fontSize: 4 * Responsive.ratioHorizontal,
                              // fontStyle: FontStyle.italic,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                verticalDivider(factor: 2.5),
                Center(
                  child: Text(
                    recipe.summary
                        .replaceAll('</b>', '')
                        .replaceAll('<b>', '')
                        .replaceAll('<a href=', '')
                        .replaceAll('</a>', '')
                        .replaceAll('>', '')
                        .replaceAll('"', ''),
                    style: TextStyle(
                      fontSize: 4 * Responsive.ratioHorizontal,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
