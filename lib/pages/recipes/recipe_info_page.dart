// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:chow_down/components/buttons/save_button.dart';
import 'package:chow_down/components/cards/recipe_dietry_card.dart';
import 'package:chow_down/components/cards/recipe_ingre_card.dart';
import 'package:chow_down/components/cards/recipe_instructions_card.dart';
import 'package:chow_down/components/customAppBar.dart';
import 'package:chow_down/components/design/chow.dart';
import 'package:chow_down/components/design/responsive.dart';
import 'package:chow_down/components/empty_content.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/cubit/recipe_info/recipe_info_cubit.dart';

const List<String> TAB_OPTIONS = [
  'Ingredients',
  'Instructions',
  'Dietry Info',
];

class RecipeInfoPage extends StatefulWidget {
  const RecipeInfoPage({
    Key? key,
    required this.title,
    required this.id,
    required this.sourceUrl,
  }) : super(key: key);

  /// Recipe title
  final String title;

  /// Recipe id
  final int id;

  /// Recipe url
  final String sourceUrl;

  @override
  _RecipeInfoPageState createState() => _RecipeInfoPageState();
}

class _RecipeInfoPageState extends State<RecipeInfoPage> {
  final List<bool> _isSelected = [];

  /// Initial selected button
  int _currentIndex = 0;

  bool _isButtonTapped = false;

  void initState() {
    super.initState();
    Provider.of<RecipeInfoCubit>(context, listen: false)
        .fetchRecipe(widget.id, widget.sourceUrl);
    _populateButtonList(TAB_OPTIONS, _isSelected);
  }

  void _buttonTapped() {
    setState(
      () {
        if (_isButtonTapped == false) {
          _isButtonTapped = true;
          Future.delayed(Duration(milliseconds: 1200), () {
            setState(() {
              _isButtonTapped = false;
            });
          });
          // isButtonTapped = false;
        } else if (_isButtonTapped == true) {
          _isButtonTapped = false;
          Future.delayed(Duration(milliseconds: 1200), () {
            setState(() {
              _isButtonTapped = true;
            });
          });
        }
      },
    );
  }

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
    switch (index) {
      case 0:
        return RecipeDescCard(
          veryHealthy: recipe.veryHealthy!,
          readyInMinutes: recipe.readyInMinutes!,
          servings: recipe.servings!,
          creditsText: recipe.creditsText!,
          glutenFree: recipe.glutenFree!,
          vegetarian: recipe.vegetarian!,
          ingredients: recipe.extendedIngredients,
          sourceUrl: recipe.sourceUrl!,
        );
      case 1:
        return RecipeInstCard(
          analyzedInstructions: recipe.analyzedInstructions!,
          instructions: recipe.instructions!,
        );
      case 2:
        return RecipeDietCard(
          dairyFree: recipe.dairyFree!,
          glutenFree: recipe.glutenFree!,
          healthScore: recipe.healthScore!,
          vegetarian: recipe.vegetarian!,
          vegan: recipe.vegan!,
        );
      default:
        return RecipeDescCard(
          veryHealthy: recipe.veryHealthy!,
          readyInMinutes: recipe.readyInMinutes!,
          servings: recipe.servings!,
          creditsText: recipe.creditsText!,
          glutenFree: recipe.glutenFree!,
          vegetarian: recipe.vegetarian!,
          summary: recipe.summary!,
          ingredients: recipe.extendedIngredients,
          sourceUrl: recipe.sourceUrl!,
        );
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
            image: CachedNetworkImageProvider(
              'https://images.unsplash.com/photo-1604147706283-d7119b5b822c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8bGlnaHQlMjBiYWNrZ3JvdW5kfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
            ),
            fit: BoxFit.cover,
          ),
        ),
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
              return _buildInitialInput(state);
            }
          },
        ),
      ),
    );
  }

  Widget _buildInitialInput(RecipeInfoState state) => Center(
        child: EmptyContent(
          message: 'If this persists please restart the application.',
          title: 'Something went wrong...',
          icon: Icons.error_outline_sharp,
        ),
      );

  Widget _buildLoading() => Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      );

  Widget _buildContents(Recipe recipe) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: recipe.image,
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
                          fontSize: 6 * Responsive.ratioHorizontal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    horizontalDivider(factor: 1.9),
                    ChowSaveButton(
                      onTap: () {
                        _buttonTapped();
                        Provider.of<RecipeInfoCubit>(context, listen: false)
                            .saveRecipe(recipe);
                        // showAlertDialog(
                        //   context,
                        //   isSave: true,
                        //   title: 'Saved!',
                        //   content:
                        //       'You can find this recipe in your saved list.',
                        //   defaultActionText: 'Gotcha!',
                        // );
                      },
                      isButtonTapped: _isButtonTapped,
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
