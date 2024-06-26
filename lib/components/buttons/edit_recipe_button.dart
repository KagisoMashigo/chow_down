// 🐦 Flutter imports:
import 'package:chow_down/blocs/recipe_info/recipe_info_bloc.dart';
import 'package:chow_down/blocs/recipe_info/recipe_info_event.dart';
import 'package:chow_down/blocs/recipe_tab/recipe_tab_bloc.dart';
import 'package:chow_down/blocs/recipe_tab/recipe_tab_event.dart';
import 'package:chow_down/components/design/chow.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditRecipeButton extends StatefulWidget {
  final Recipe recipe;
  final double size;
  final double iconSize;
  final bool outlined;

  const EditRecipeButton({
    super.key,
    required this.recipe,
    this.size = 44,
    this.iconSize = 24,
    this.outlined = false,
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
    BlocProvider.of<RecipeInfoBloc>(context).add(
      SaveRecipe(recipe: recipe),
    );
    BlocProvider.of<SavedRecipeBloc>(context).add(FetchHomeRecipesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final isSaved = context.select((SavedRecipeBloc bloc) => bloc
        .state.recipeCardList
        .any((element) => element.id == widget.recipe.id));

    return InkWell(
      onTap: () {
        _handleTap(context, widget.recipe);
      },
      child: Semantics(
        button: true,
        focusable: true,
        label: 'Save Recipe',
        hint: isSaved ? 'Saved' : 'Not Saved',
        child: Container(
          height: widget.size,
          width: widget.size,
          decoration: widget.outlined
              ? BoxDecoration(
                  border: Border.all(
                    color: ChowColors.borderPurple,
                    width: 1.5,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(3),
                  ),
                )
              : null,
          child: Icon(
            isSaved ? Icons.edit : Icons.edit_outlined,
            color: ChowColors.fillPurple,
            size: widget.iconSize,
          ),
        ),
      ),
    );
  }
}
