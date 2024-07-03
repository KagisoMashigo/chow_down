// 🐦 Flutter imports:
import 'package:chow_down/blocs/edit_recipe/edit_recipe_bloc.dart';
import 'package:chow_down/blocs/edit_recipe/edit_recipe_event.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/components/design/chow.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditRecipeButton extends StatefulWidget {
  final Recipe recipe;
  final double size;
  final double iconSize;

  const EditRecipeButton({
    super.key,
    required this.recipe,
    this.size = 44,
    this.iconSize = 24,
  });

  @override
  State<EditRecipeButton> createState() => _EditRecipeButtonState();
}

class _EditRecipeButtonState extends State<EditRecipeButton> {
  @override
  void initState() {
    super.initState();
  }

  void _handleTap(
    BuildContext context,
    Recipe recipe,
  ) async {
    print('Entering recipe edit mode---->>>>>>>>');
    context.read<EditRecipeBloc>().add(EditRecipe(recipe: recipe));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _handleTap(context, widget.recipe);
      },
      child: Semantics(
        button: true,
        focusable: true,
        label: 'Edit Recipe',
        hint: 'Edit Recipe',
        child: Container(
          height: widget.size,
          width: widget.size,
          child: Icon(
            Icons.edit,
            color: ChowColors.green700,
            size: widget.iconSize,
          ),
        ),
      ),
    );
  }
}

class FinishEditRecipeButton extends StatefulWidget {
  final Recipe recipe;
  final double size;
  final double iconSize;
  final String? text;

  const FinishEditRecipeButton({
    super.key,
    required this.recipe,
    this.text,
    this.size = 44,
    this.iconSize = 24,
  });

  @override
  State<FinishEditRecipeButton> createState() => _FinishEditRecipeButtonState();
}

class _FinishEditRecipeButtonState extends State<FinishEditRecipeButton> {
  @override
  void initState() {
    super.initState();
  }

  void _handleTap(
    BuildContext context,
    Recipe recipe,
    String? text,
  ) async {
    print('Attempting to save edited recipe---->>>>>>>>');
    context
        .read<EditRecipeBloc>()
        .add(SaveEditedRecipe(recipe: recipe, text: text));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _handleTap(context, widget.recipe, widget.text);
      },
      child: Semantics(
        button: true,
        focusable: true,
        label: 'Edit Recipe',
        hint: 'Edit Recipe',
        child: Container(
          height: widget.size,
          width: widget.size,
          child: Icon(
            Icons.check,
            color: ChowColors.green700,
            size: widget.iconSize,
          ),
        ),
      ),
    );
  }
}

class CancelEditRecipeButton extends StatefulWidget {
  final Recipe recipe;
  final double size;
  final double iconSize;

  const CancelEditRecipeButton({
    super.key,
    required this.recipe,
    this.size = 44,
    this.iconSize = 24,
  });

  @override
  State<CancelEditRecipeButton> createState() => _CancelEditRecipeButtonState();
}

class _CancelEditRecipeButtonState extends State<CancelEditRecipeButton> {
  @override
  void initState() {
    super.initState();
  }

  void _handleTap(
    BuildContext context,
    Recipe recipe,
  ) async {
    print('Exiting edit mode and cancelling---->>>>>>>>');
    context.read<EditRecipeBloc>().add(CancelEditRecipe());
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _handleTap(context, widget.recipe);
      },
      child: Semantics(
        button: true,
        focusable: true,
        label: 'Cancel Recipe',
        hint: 'Cancel Recipe',
        child: Container(
          height: widget.size,
          width: widget.size,
          child: Icon(
            Icons.cancel,
            color: ChowColors.red700,
            size: widget.iconSize,
          ),
        ),
      ),
    );
  }
}
