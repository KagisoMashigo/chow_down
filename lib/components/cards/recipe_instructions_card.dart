// 🐦 Flutter imports:
import 'dart:developer';

import 'package:chow_down/blocs/edit_recipe/edit_recipe_bloc.dart';
import 'package:chow_down/blocs/edit_recipe/edit_recipe_state.dart';
import 'package:chow_down/components/buttons/edit_recipe_buttons.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/components/cards/base_card.dart';
import 'package:chow_down/components/design/chow.dart';
import 'package:chow_down/components/empty_content.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeInstructionsCard extends StatelessWidget {
  final Recipe recipe;
  final Function? onEdit;

  const RecipeInstructionsCard({
    Key? key,
    required this.recipe,
    this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final actualSteps = recipe.analyzedInstructions?[0].steps;

    return actualSteps != null
        ? BaseCard(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(Spacing.sm),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (context.watch<EditRecipeBloc>().state
                                is EditRecipePending) ...[
                              FinishEditRecipeButton(
                                size: Spacing.md,
                                iconSize: Spacing.md,
                                onTap: () {},
                              ),
                              SizedBox(width: Spacing.sm),
                              CancelEditRecipeButton(
                                recipe: recipe,
                                size: Spacing.md,
                                iconSize: Spacing.md,
                              ),
                            ],
                          ],
                        ),
                        SizedBox(height: Spacing.sm),
                        ...actualSteps.map((instruction) {
                          return onEdit!(
                            state: context.watch<EditRecipeBloc>().state,
                            editableChild: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              initialValue: instruction.step,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                log('On changed: $value');
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
                                instruction.step,
                                style: TextStyle(
                                  fontSize: ChowFontSizes.sm,
                                ),
                              ),
                              leading: Text(
                                instruction.number.toString(),
                                style: TextStyle(
                                  fontSize: ChowFontSizes.sm,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ) as Widget;
                        }).toList(),
                      ]),
                ),
              ],
            ),
          )
        : EmptyContent(
            title: 'Instructions failed to load',
            message:
                'There was an issue loading the instructions for this recipe. Please try again.',
          );
  }
}
