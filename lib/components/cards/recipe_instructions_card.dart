// 🐦 Flutter imports:

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:chow_down/blocs/edit_recipe/edit_recipe_bloc.dart';
import 'package:chow_down/blocs/edit_recipe/edit_recipe_event.dart';
import 'package:chow_down/blocs/edit_recipe/edit_recipe_state.dart';
import 'package:chow_down/blocs/saved_recipe/saved_recipe_bloc.dart';
import 'package:chow_down/blocs/saved_recipe/saved_recipe_event.dart';
import 'package:chow_down/components/buttons/edit_recipe_buttons.dart';
import 'package:chow_down/components/cards/base_card.dart';
import 'package:chow_down/components/design/chow.dart';
import 'package:chow_down/components/empty_content.dart';
import 'package:chow_down/core/models/spoonacular/analysed_instructions.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/core/models/spoonacular/steps.dart' as steps;
import 'package:chow_down/plugins/debugHelper.dart';

class RecipeInstructionsCard extends StatefulWidget {
  final Recipe recipe;
  final Function? onEdit;

  const RecipeInstructionsCard({
    Key? key,
    required this.recipe,
    this.onEdit,
  }) : super(key: key);

  @override
  State<RecipeInstructionsCard> createState() => _RecipeInstructionsCardState();
}

class _RecipeInstructionsCardState extends State<RecipeInstructionsCard> {
  late List<steps.Step> _editedInstructions;

  @override
  void initState() {
    super.initState();
    _editedInstructions =
        List.from(widget.recipe.analyzedInstructions![0].steps);
  }

  void _saveEditedInstructions() {
    final newAnalyzedInstructions = AnalyzedInstruction(
      name: widget.recipe.analyzedInstructions![0].name,
      steps: _editedInstructions,
    );

    final updatedRecipe = widget.recipe.copyWith(
      analyzedInstructions: [newAnalyzedInstructions],
    );

    BlocProvider.of<EditRecipeBloc>(context)
        .add(SaveEditedRecipe(recipe: updatedRecipe));

    BlocProvider.of<SavedRecipeBloc>(context).add(FetchSavedRecipesEvent());
  }

  void _removeInstruction(int index) {
    setState(() {
      _editedInstructions.removeAt(index);
      for (int i = index; i < _editedInstructions.length; i++) {
        _editedInstructions[i] = _editedInstructions[i].copyWith(
          number: i + 1,
        );
      }
    });
  }

  void _addInstruction() {
    setState(() {
      _editedInstructions.add(
        steps.Step(
          number: _editedInstructions.length + 1,
          step: '',
        ),
      );
    });
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
              printDebug('Saving edited instructions...');
              _saveEditedInstructions();
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

    return _editedInstructions.isNotEmpty
        ? BaseCard(
            child: Padding(
              padding: EdgeInsets.all(Spacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildEditButtons(isSaved, editRecipeBloc),
                  SizedBox(height: Spacing.sm),
                  if (editRecipeBloc.state is EditRecipePending) ...[
                    SizedBox(height: Spacing.sm),
                    ElevatedButton(
                      onPressed: _addInstruction,
                      child: Text('Add Instruction'),
                    ),
                    SizedBox(height: Spacing.sm),
                  ],
                  ..._buildInstructions(context),
                ],
              ),
            ),
          )
        : EmptyContent(
            title: 'Instructions failed to load',
            message:
                'There was an issue loading the instructions for this recipe. Please try again.',
          );
  }

  List<Widget> _buildInstructions(BuildContext context) {
    return _editedInstructions.asMap().entries.map((entry) {
      int index = entry.key;
      steps.Step instruction = entry.value;

      return widget.onEdit!(
        state: context.watch<EditRecipeBloc>().state,
        editableChild: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.remove_circle,
                color: ChowColors.red,
                size: ChowFontSizes.sm,
              ),
              onPressed: () => _removeInstruction(index),
            ),
            SizedBox(width: Spacing.xsm),
            Expanded(
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: instruction.step,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    _editedInstructions[index] = instruction.copyWith(
                      step: value,
                    );
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Instruction cannot be empty'),
                      ),
                    );
                  }
                  return null;
                },
              ),
            ),
          ],
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
    }).toList();
  }
}
