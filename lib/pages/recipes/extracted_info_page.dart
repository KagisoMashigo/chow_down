// 🐦 Flutter imports:
import 'package:chow_down/components/cards/recipe_dietry_card.dart';
import 'package:chow_down/components/cards/recipe_ingre_card.dart';
import 'package:chow_down/components/cards/recipe_instructions_card.dart';
import 'package:chow_down/components/design/color.dart';
import 'package:chow_down/components/empty_content.dart';
import 'package:chow_down/components/snackBar.dart';
import 'package:chow_down/pages/recipes/recipe_info_page.dart';
import 'package:chow_down/services/firestore/firestore_db.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:chow_down/components/customAppBar.dart';
import 'package:chow_down/components/design/responsive.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/cubit/recipe_info/recipe_info_cubit.dart';

class ExtractedInfoPage extends StatefulWidget {
  const ExtractedInfoPage({
    Key key,
    @required this.title,
    this.id,
    this.sourceUrl,
  }) : super(key: key);

  /// Recipe title
  final String title;

  /// Recipe id
  final int id;

  final String sourceUrl;

  @override
  _ExtractedInfoPageState createState() => _ExtractedInfoPageState();
}

class _ExtractedInfoPageState extends State<ExtractedInfoPage> {
  final List<bool> _isSelected = [];
  Database _database;

  /// Initial selected button
  int _currentIndex = 0;

  void initState() {
    super.initState();
    Provider.of<RecipeInfoCubit>(context, listen: false)
        .fetchRecipeInformation(widget.id, widget.sourceUrl);
    _populateButtonList(TAB_OPTIONS, _isSelected);
    _database = Provider.of<Database>(context, listen: false);
  }

  void showSnackbar(
    BuildContext context,
    String errorMessage,
  ) =>
      ScaffoldMessenger.of(context).showSnackBar(warningSnackBar(errorMessage));

  /// Handles how many buttons appear in nav and which is selected using bools
  void _populateButtonList(List data, List<bool> isSelected) {
    for (var i = 0; i < data.length; i++) {
      if (i == 0) {
        isSelected.add(true);
      } else {
        isSelected.add(false);
      }
    }
  }

  /// Determines which conditions to render on screen
  Widget _whichCard(int index, Recipe recipe) {
    // List desiredConditions = [];
    switch (index) {
      case 0:
        return RecipeDescCard(
          readyInMinutes: recipe.readyInMinutes,
          servings: recipe.servings,
          creditsText: recipe.creditsText,
          glutenFree: recipe.glutenFree,
          vegetarian: recipe.vegetarian,
          summary: recipe.summary,
          ingredients: recipe.extendedIngredients,
          sourceUrl: recipe.sourceUrl,
        );
        break;

      case 1:
        return RecipeInstCard(
          analyzedInstructions: recipe.analyzedInstructions,
          instructions: recipe.instructions,
        );
        break;
      case 2:
        return RecipeDietCard(
          dairyFree: recipe.dairyFree,
          glutenFree: recipe.glutenFree,
          healthScore: recipe.healthScore,
          vegetarian: recipe.vegetarian,
          vegan: recipe.vegan,
        );
        break;
      default:
    }
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
                'https://images.unsplash.com/photo-1604147706283-d7119b5b822c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8bGlnaHQlMjBiYWNrZ3JvdW5kfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60'),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: BlocConsumer<RecipeInfoCubit, RecipeInfoState>(
          listener: (context, state) {
            if (state is RecipInfoError) {
              return ScaffoldMessenger.of(context).showSnackBar(
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
              return _buildInitialInput(state);
            }
          },
        ),
      ),
    );
  }

  Widget _buildInitialInput(RecipeInfoState state) => EmptyContent(
        message: 'The was a problem saving this recipe. Please try again..',
        title: 'Something went wrong...',
        icon: Icons.error_outline_sharp,
      );

  Widget _buildLoading() => Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      );

  Widget _buildContents(Recipe recipe) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Image.network(
                  recipe.image,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          verticalDivider(factor: 2),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 4.5 * Responsive.ratioHorizontal),
            child: Column(
              children: [
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
                    IconButton(
                      onPressed: (() => _database.saveRecipes(recipe)),
                      iconSize: 7 * Responsive.ratioHorizontal,
                      icon: const Icon(
                        Icons.save_rounded,
                      ),
                    ),
                  ],
                ),
                verticalDivider(factor: 2),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: ChowColors.white,
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: ToggleButtons(
                      renderBorder: false,
                      borderRadius: BorderRadius.circular(18.0),
                      borderWidth: 0,
                      children: TAB_OPTIONS
                          .map(
                            (tabName) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                tabName,
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          )
                          .toList(),
                      isSelected: _isSelected,
                      onPressed: (int newIndex) {
                        setState(
                          () {
                            for (int i = 0; i < _isSelected.length; i++) {
                              if (i == newIndex) {
                                _isSelected[i] = true;
                                _currentIndex = i;
                              } else {
                                _isSelected[i] = false;
                              }
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
                verticalDivider(factor: 2),
                _whichCard(_currentIndex, recipe),
                verticalDivider(factor: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
