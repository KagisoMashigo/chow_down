// 🐦 Flutter imports:
import 'package:chow_down/blocs/recipe_info/recipe_info_bloc.dart';
import 'package:chow_down/blocs/recipe_info/recipe_info_event.dart';
import 'package:chow_down/blocs/recipe_tab/recipe_tab_bloc.dart';
import 'package:chow_down/blocs/recipe_tab/recipe_tab_event.dart';
import 'package:chow_down/components/design/chow.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaveRecipeButton extends StatefulWidget {
  final Recipe recipe;
  final double size;
  final double iconSize;
  final bool outlined;

  const SaveRecipeButton({
    super.key,
    required this.recipe,
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
      BlocProvider.of<RecipeInfoBloc>(context).add(
        SaveRecipe(recipe: recipe),
      );
    }

    BlocProvider.of<SavedRecipeBloc>(context).add(FetchHomeRecipesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final isSaved = context.select((SavedRecipeBloc bloc) => bloc
        .state.recipeCardList
        .any((element) => element.id == widget.recipe.id));

    return InkWell(
      onTap: () {
        _handleTap(context, widget.recipe, isSaved);
      },
      child: Semantics(
        button: true,
        focusable: true,
        label: 'Save Recipe',
        hint: isSaved ? 'Saved' : 'Not Saved',
        child: Container(
          height: widget.size,
          width: widget.size,
          child: Icon(
            isSaved ? Icons.favorite : Icons.favorite_outline,
            color: ChowColors.red700,
            size: widget.iconSize,
          ),
        ),
      ),
    );
  }
}
