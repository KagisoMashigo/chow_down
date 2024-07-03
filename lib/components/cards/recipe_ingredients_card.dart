// 🐦 Flutter imports:
import 'dart:developer';

import 'package:chow_down/blocs/edit_recipe/edit_recipe_bloc.dart';
import 'package:chow_down/blocs/edit_recipe/edit_recipe_event.dart';
import 'package:chow_down/blocs/edit_recipe/edit_recipe_state.dart';
import 'package:chow_down/components/buttons/edit_recipe_buttons.dart';
import 'package:chow_down/components/forms/text_form_field.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 📦 Package imports:
import 'package:url_launcher/url_launcher.dart';

// 🌎 Project imports:
import 'package:chow_down/components/cards/base_card.dart';
import 'package:chow_down/components/cards/detail_card.dart';
import 'package:chow_down/components/design/chow.dart';
import 'package:chow_down/components/design/responsive.dart';
import 'package:chow_down/core/models/spoonacular/extended_ingredients.dart';
import 'package:chow_down/plugins/utils/helpers.dart';

class RecipeIngredientsCard extends StatefulWidget {
  final Recipe recipe;
  final Function? onEdit;

  const RecipeIngredientsCard({
    Key? key,
    required this.recipe,
    this.onEdit,
  }) : super(key: key);

  @override
  _RecipeIngredientsCardState createState() => _RecipeIngredientsCardState();
}

class _RecipeIngredientsCardState extends State<RecipeIngredientsCard> {
  late Map<int, String> _editedIngredients;

  @override
  void initState() {
    super.initState();
    _editedIngredients = {
      for (var i = 0; i < widget.recipe.extendedIngredients!.length; i++)
        i: widget.recipe.extendedIngredients![i].name
    };
  }

  void _saveEditedIngredients() {
    final updatedIngredients =
        widget.recipe.extendedIngredients!.asMap().entries.map((entry) {
      int index = entry.key;
      ExtendedIngredients ingredient = entry.value;
      return ingredient.copyWith(name: _editedIngredients[index]);
    }).toList();

    final updatedRecipe = widget.recipe.copyWith(
      extendedIngredients: updatedIngredients,
    );

    context.read<EditRecipeBloc>().add(SaveEditedRecipe(recipe: updatedRecipe));
  }

  Widget _buildDetailCard({
    required String title,
    required String subtitle,
  }) {
    return DetailCard(
      child: Column(
        children: [
          Text(title),
          SizedBox(height: Spacing.xsm),
          Text(
            subtitle,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      color: ChowColors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Padding(
        padding: EdgeInsets.all(
          Spacing.sm,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: Spacing.xsm),
                _buildDetailCard(
                  title: 'Ready In:',
                  subtitle:
                      '${StringHelper.cookTimeConverter(widget.recipe.readyInMinutes!)}',
                ),
                _buildDetailCard(
                  title: 'Servings:',
                  subtitle: '${widget.recipe.servings.toString()}',
                ),
                SizedBox(width: Spacing.xsm),
              ],
            ),
            if (widget.recipe.veryHealthy!) ...[
              SizedBox(height: Spacing.sm),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 25,
                  ),
                  Expanded(
                    child: Text(
                      'Very Healthy!',
                      style: TextStyle(
                        fontSize: 4 * Responsive.ratioHorizontal,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              )
            ],
            SizedBox(height: Spacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (context.watch<EditRecipeBloc>().state
                    is EditRecipePending) ...[
                  FinishEditRecipeButton(
                    size: Spacing.md,
                    iconSize: Spacing.md,
                    onTap: _saveEditedIngredients,
                  ),
                  SizedBox(width: Spacing.sm),
                  CancelEditRecipeButton(
                    recipe: widget.recipe,
                    size: Spacing.md,
                    iconSize: Spacing.md,
                  ),
                ],
              ],
            ),
            SizedBox(height: Spacing.xsm),
            TextButton(
              onPressed: _launchUrl,
              child: Text('Source: ${widget.recipe.sourceUrl}'),
            ),
            SizedBox(height: Spacing.xsm),
            ..._buildIngredients(widget.recipe.extendedIngredients!, context),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildIngredients(
    List<ExtendedIngredients> ingredients,
    BuildContext context,
  ) {
    return ingredients.map((ingredient) {
      int index = ingredients.indexOf(ingredient);
      return widget.onEdit!(
        state: context.watch<EditRecipeBloc>().state,
        editableChild: TestFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          initialValue: ingredient.name,
          keyboardType: TextInputType.name,
          onChanged: (value) {
            setState(() {
              _editedIngredients[index] = value;
            });
          },
          validator: (value) {
            if (value != null && value.isNotEmpty) {
              log('Validator: $value');
            }
            return null;
          },
        ),
        staticChild: ListTile(
          title: Text(
            '${StringHelper.processNumber(ingredient.amount.toString())} ${ingredient.unit == 'servings' ? '' : ingredient.unit} ${ingredient.name}',
            style: TextStyle(
              fontSize: 4 * Responsive.ratioHorizontal,
            ),
          ),
          leading: Icon(Icons.food_bank_sharp),
        ),
      ) as Widget;
    }).toList();
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(widget.recipe.sourceUrl!))) {
      throw 'Could not launch ${Uri.parse(widget.recipe.sourceUrl!)}';
    }
  }
}