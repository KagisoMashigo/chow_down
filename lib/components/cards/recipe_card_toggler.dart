import 'package:chow_down/blocs/recipe_info/recipe_info_bloc.dart';
import 'package:chow_down/blocs/recipe_info/recipe_info_event.dart';
import 'package:chow_down/components/buttons/save_button.dart';
import 'package:chow_down/components/cards/recipe_dietry_card.dart';
import 'package:chow_down/components/cards/recipe_ingre_card.dart';
import 'package:chow_down/components/cards/recipe_instructions_card.dart';
import 'package:chow_down/components/design/color.dart';
import 'package:chow_down/components/design/spacing.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeCardToggler extends StatefulWidget {
  final List<String> options;
  final Recipe recipe;

  const RecipeCardToggler({
    super.key,
    required this.options,
    required this.recipe,
  });

  @override
  State<RecipeCardToggler> createState() => _RecipeCardTogglerState();
}

class _RecipeCardTogglerState extends State<RecipeCardToggler> {
  final List<bool> _isSelected = [];

  /// Initial selected button
  int _currentIndex = 0;

  bool _isButtonTapped = false;

  void initState() {
    _populateButtonList(widget.options, _isSelected);
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.md),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.recipe.title,
                  style: TextStyle(
                    fontSize: Spacing.md,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: Spacing.sm),
              ChowSaveButton(
                onTap: () {
                  _buttonTapped();
                  BlocProvider.of<RecipeInfoBloc>(context).add(
                    SaveRecipe(recipe: widget.recipe),
                  );
                },
                isButtonTapped: _isButtonTapped,
              ),
            ],
          ),
          SizedBox(height: Spacing.sm),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              decoration: BoxDecoration(
                color: ChowColors.white,
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: ToggleButtons(
                children: widget.options.map((option) => Text(option)).toList(),
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
          SizedBox(height: Spacing.sm),
          _whichCard(context, _currentIndex, widget.recipe),
          SizedBox(height: Spacing.sm)
        ],
      ),
    );
  }

  Widget _whichCard(BuildContext context, int index, Recipe recipe) {
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
}
