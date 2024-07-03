// 🐦 Flutter imports:
import 'package:chow_down/components/builders/back_to_top_builder.dart';
import 'package:chow_down/components/empty_content.dart';
import 'package:chow_down/pages/recipes/saved_recipe_page.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:chow_down/blocs/recipe_info/recipe_detail_bloc.dart';
import 'package:chow_down/blocs/recipe_info/recipe_detail_event.dart';
import 'package:chow_down/blocs/saved_recipe/saved_recipe_bloc.dart';
import 'package:chow_down/blocs/saved_recipe/saved_recipe_event.dart';
import 'package:chow_down/components/alert_dialogs/show_alert_dialog.dart';
import 'package:chow_down/components/cards/base_card.dart';
import 'package:chow_down/components/design/chow.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/pages/recipes/recipe_detail_page.dart';
import 'package:chow_down/plugins/utils/constants.dart';

class RecipeCardGrid extends StatelessWidget {
  final List<Recipe> results;

  const RecipeCardGrid({
    Key? key,
    required this.results,
  }) : super(key: key);

  Future<void> _confirmDelete(
    BuildContext context,
    Recipe recipe,
  ) async {
    await showAlertDialog(
      context,
      isSave: false,
      title: 'Delete Recipe?',
      content: 'This will remove the recipe',
      defaultActionText: 'Delete',
      cancelActionText: 'Cancel',
    ).then((bool) => bool == true
        ? BlocProvider.of<SavedRecipeBloc>(context)
            .add(DeleteRecipeEvent(recipe))
        : null);
  }

  List<Widget> _buildRecipeGrid(
    List<Recipe> results,
    BuildContext context,
  ) {
    return results
        .map(
          (recipe) => _RecipeGridCard(
            firstChild: Flexible(
              flex: 3,
              child: _buildRecipeImage(context, recipe),
            ),
            secondChild: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: Spacing.xsm,
                      bottom: Spacing.xsm,
                    ),
                    child: Text(
                      recipe.title,
                      style: TextStyle(
                        fontSize: ChowFontSizes.sm,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: Spacing.xsm,
                    right: Spacing.xsm,
                  ),
                  child: InkWell(
                    splashColor: ChowColors.black,
                    onTap: (() => _confirmDelete(context, recipe)),
                    child: Icon(
                      Icons.delete,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();
  }

  Widget _buildRecipeImage(BuildContext context, Recipe recipe) {
    final image = recipe.image != null
        ? CachedNetworkImage(
            imageUrl: recipe.image!,
            fit: BoxFit.cover,
          )
        : Image.asset(
            NO_IMAGE_AVAILABLE,
            fit: BoxFit.cover,
          );

    return InkWell(
      onTap: () {
        BlocProvider.of<RecipeDetailBloc>(context).add(
          FetchRecipe(
            id: recipe.id,
            url: recipe.sourceUrl!,
            savedRecipes: context.read<SavedRecipeBloc>().state.savedRecipeList,
          ),
        );

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RecipeDetailPage(
              title: recipe.title,
              id: recipe.id,
              sourceUrl: recipe.sourceUrl!,
            ),
            fullscreenDialog: true,
          ),
        );
      },
      child: AspectRatio(
        aspectRatio: 1.25,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(ChowBorderRadii.lg),
            topRight: Radius.circular(ChowBorderRadii.lg),
          ),
          child: image,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return results.isEmpty
        ? EmptyContent(
            title: 'Nothing here yet...',
            message: 'When you edit recipes they will show up here.',
          )
        : Column(
            children: [
              GridView.count(
                primary: false,
                crossAxisCount: 2,
                childAspectRatio: 0.825,
                mainAxisSpacing: Spacing.sm,
                crossAxisSpacing: Spacing.sm,
                children: _buildRecipeGrid(results, context),
                shrinkWrap: true,
              ),
              SizedBox(height: Spacing.md),
              results.length > 10
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: ChowBackToTopTransitionBuilder(
                        desitnation: SavedRecipePage(),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          );
  }
}

class _RecipeGridCard extends StatelessWidget {
  final Widget firstChild;
  final Widget secondChild;

  const _RecipeGridCard({
    Key? key,
    required this.firstChild,
    required this.secondChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Column(
        children: <Widget>[
          firstChild,
          SizedBox(height: Spacing.xsm),
          secondChild,
        ],
      ),
    );
  }
}
