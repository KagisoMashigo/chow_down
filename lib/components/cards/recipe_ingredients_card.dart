// 🐦 Flutter imports:

// 🎯 Dart imports:
import 'dart:math';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

// 🌎 Project imports:
import 'package:chow_down/blocs/edit_recipe/edit_recipe_bloc.dart';
import 'package:chow_down/blocs/edit_recipe/edit_recipe_event.dart';
import 'package:chow_down/blocs/edit_recipe/edit_recipe_state.dart';
import 'package:chow_down/blocs/saved_recipe/saved_recipe_bloc.dart';
import 'package:chow_down/blocs/saved_recipe/saved_recipe_event.dart';
import 'package:chow_down/components/buttons/edit_recipe_buttons.dart';
import 'package:chow_down/components/cards/base_card.dart';
import 'package:chow_down/components/cards/detail_card.dart';
import 'package:chow_down/components/design/chow.dart';
import 'package:chow_down/core/models/spoonacular/extended_ingredients.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/plugins/debugHelper.dart';
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
  late List<ExtendedIngredients> _editedIngredients;

  @override
  void initState() {
    super.initState();
    _editedIngredients = List.from(widget.recipe.extendedIngredients!);
  }

  void _saveEditedIngredients() {
    final updatedRecipe = widget.recipe.copyWith(
      extendedIngredients: _editedIngredients,
    );

    BlocProvider.of<EditRecipeBloc>(context)
        .add(SaveEditedRecipe(recipe: updatedRecipe));

    BlocProvider.of<SavedRecipeBloc>(context).add(FetchSavedRecipesEvent());
  }

  void _removeIngredient(int index) {
    setState(() {
      _editedIngredients.removeAt(index);
    });
  }

  void _addIngredient() {
    setState(() {
      _editedIngredients.add(
        ExtendedIngredients(
          id: Random().nextInt(1000),
          name: '',
          amount: 0.0,
          unit: '',
        ),
      );
    });
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

  Widget _buildEditButtons(bool isSaved, EditRecipeBloc editRecipeBloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isSaved && editRecipeBloc.state is! EditRecipePending)
          EditRecipeButton(
            recipe: widget.recipe,
            size: Spacing.md,
            iconSize: Spacing.md,
          ),
        if (editRecipeBloc.state is EditRecipePending) ...[
          FinishEditRecipeButton(
            size: Spacing.md,
            iconSize: Spacing.lg,
            onTap: () {
              printDebug('Saving edited ingredients...');
              _saveEditedIngredients();
            },
          ),
          SizedBox(width: Spacing.md),
          CancelEditRecipeButton(
            recipe: widget.recipe,
            size: Spacing.md,
            iconSize: Spacing.lg,
          ),
        ],
        SizedBox(width: Spacing.sm),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final editRecipeBloc = context.watch<EditRecipeBloc>();
    final isSaved = context
            .watch<SavedRecipeBloc>()
            .state
            .savedRecipeList
            ?.any((element) => element.sourceUrl == widget.recipe.sourceUrl) ??
        false;

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
              Padding(
                padding: const EdgeInsets.only(left: Spacing.sm),
                child: Column(
                  children: [
                    SizedBox(height: Spacing.md),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: ChowFontSizes.lg,
                        ),
                        SizedBox(width: Spacing.xsm),
                        Expanded(
                          child: Text(
                            'Very Healthy!',
                            style: TextStyle(
                              fontSize: ChowFontSizes.smd,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
            SizedBox(height: Spacing.sm),
            TextButton(
              onPressed: _launchUrl,
              child: Text('Source: ${widget.recipe.sourceUrl}'),
            ),
            SizedBox(height: Spacing.xsm),
            _buildEditButtons(isSaved, editRecipeBloc),
            SizedBox(height: Spacing.sm),
            if (editRecipeBloc.state is EditRecipePending) ...[
              SizedBox(height: Spacing.sm),
              ElevatedButton(
                onPressed: _addIngredient,
                child: Text('Add Ingredient'),
              ),
              SizedBox(height: Spacing.sm),
            ],
            ..._buildIngredients(context),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildIngredients(BuildContext context) {
    return _editedIngredients.asMap().entries.map((entry) {
      int index = entry.key;
      ExtendedIngredients ingredient = entry.value;

      return widget.onEdit!(
        state: context.watch<EditRecipeBloc>().state,
        editableChild: Row(
          children: [
            Flexible(
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.remove_circle,
                      color: ChowColors.red,
                      size: ChowFontSizes.sm,
                    ),
                    onPressed: () => _removeIngredient(index),
                  ),
                  SizedBox(width: Spacing.xxsm),
                  Expanded(
                    child: TextFormField(
                      initialValue: ingredient.amount.toString(),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      onChanged: (value) {
                        setState(() {
                          _editedIngredients[index] = ingredient.copyWith(
                            amount: double.tryParse(value) ?? 0.0,
                          );
                        });
                      },
                    ),
                  ),
                  SizedBox(width: Spacing.xsm),
                  Expanded(
                    child: TextFormField(
                      initialValue: ingredient.unit,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        setState(() {
                          _editedIngredients[index] = ingredient.copyWith(
                            unit: value,
                          );
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: Spacing.sm),
            Expanded(
              child: TextFormField(
                initialValue: ingredient.name,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    _editedIngredients[index] = ingredient.copyWith(
                      name: value,
                    );
                  });
                },
              ),
            ),
          ],
        ),
        staticChild: ListTile(
          title: Text(
            '${StringHelper.processNumber(ingredient.amount.toString())} ${ingredient.unit == 'servings' ? '' : ingredient.unit} ${ingredient.name}',
            style: TextStyle(
              fontSize: ChowFontSizes.sm,
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
