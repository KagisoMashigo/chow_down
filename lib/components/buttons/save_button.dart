// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:chow_down/blocs/recipe_info/recipe_detail_bloc.dart';
import 'package:chow_down/blocs/recipe_info/recipe_detail_event.dart';
import 'package:chow_down/blocs/saved_recipe/saved_recipe_bloc.dart';
import 'package:chow_down/blocs/saved_recipe/saved_recipe_event.dart';
import 'package:chow_down/components/design/chow.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';

class SaveRecipeButton extends StatefulWidget {
  final Recipe recipe;
  final double size;
  final double iconSize;
  final bool outlined;
  final bool isSaved;

  const SaveRecipeButton({
    super.key,
    required this.recipe,
    this.isSaved = false,
    this.size = 44,
    this.iconSize = 24,
    this.outlined = false,
  });

  @override
  State<SaveRecipeButton> createState() => _SaveRecipeButtonState();
}

class _SaveRecipeButtonState extends State<SaveRecipeButton> {
  @override
  void initState() {
    super.initState();
  }

  void _handleTap(
    BuildContext context,
    Recipe recipe,
    bool isSaved,
  ) async {
    if (isSaved) {
      BlocProvider.of<SavedRecipeBloc>(context).add(DeleteRecipeEvent(recipe));
    } else {
      BlocProvider.of<RecipeDetailBloc>(context).add(
        SaveRecipe(recipe: recipe),
      );
    }

    BlocProvider.of<SavedRecipeBloc>(context).add(FetchSavedRecipesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _handleTap(context, widget.recipe, widget.isSaved);
      },
      child: Semantics(
        button: true,
        focusable: true,
        label: 'Save Recipe',
        hint: widget.isSaved ? 'Saved' : 'Not Saved',
        child: Container(
          height: widget.size,
          width: widget.size,
          child: Icon(
            widget.isSaved ? Icons.favorite : Icons.favorite_outline,
            color: ChowColors.red700,
            size: widget.iconSize,
          ),
        ),
      ),
    );
  }
}
