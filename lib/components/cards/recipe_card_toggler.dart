// 🐦 Flutter imports:

import 'package:chow_down/blocs/edit_recipe/edit_recipe_state.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/components/cards/recipe_dietry_card.dart';
import 'package:chow_down/components/cards/recipe_ingredients_card.dart';
import 'package:chow_down/components/cards/recipe_instructions_card.dart';
import 'package:chow_down/components/design/color.dart';
import 'package:chow_down/components/design/spacing.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';

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

  Widget _buildWidgetOrTextfield({
    required EditRecipeState state,
    required Widget editableChild,
    required Widget staticChild,
  }) =>
      state is EditRecipePending ? editableChild : staticChild;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.md),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: ChowColors.white,
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: ToggleButtons(
              selectedBorderColor: ChowColors.borderPurple,
              borderWidth: 1,
              borderRadius: BorderRadius.circular(14),
              fillColor: ChowColors.fillPurple,
              selectedColor: Colors.black,
              color: Colors.black,
              children: widget.options
                  .map((option) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(option),
                      ))
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
          SizedBox(height: Spacing.sm),
          _whichCard(context, _currentIndex, widget.recipe),
          SizedBox(height: Spacing.sm),
        ],
      ),
    );
  }

  Widget _whichCard(BuildContext context, int index, Recipe recipe) {
    switch (index) {
      case 0:
        return RecipeIngredientsCard(
          recipe: recipe,
          onEdit: _buildWidgetOrTextfield,
        );
      case 1:
        return RecipeInstructionsCard(
          recipe: recipe,
          onEdit: _buildWidgetOrTextfield,
        );
      case 2:
        return RecipeDietaryCard(
          dairyFree: recipe.dairyFree!,
          glutenFree: recipe.glutenFree!,
          healthScore: recipe.healthScore!,
          vegetarian: recipe.vegetarian!,
          vegan: recipe.vegan!,
        );
      default:
        return RecipeIngredientsCard(
          recipe: recipe,
          onEdit: _buildWidgetOrTextfield,
        );
    }
  }
}
