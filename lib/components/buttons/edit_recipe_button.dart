// 🐦 Flutter imports:
import 'package:chow_down/components/design/chow.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:flutter/material.dart';

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
    // TODO: implement edit recipe
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
