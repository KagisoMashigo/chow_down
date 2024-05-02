// 🐦 Flutter imports:
import 'package:chow_down/blocs/recipe_info/recipe_info_bloc.dart';
import 'package:chow_down/blocs/recipe_info/recipe_info_event.dart';
import 'package:chow_down/components/cards/base_card.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:chow_down/blocs/recipe_tab/recipe_tab_bloc.dart';
import 'package:chow_down/blocs/recipe_tab/recipe_tab_event.dart';
import 'package:chow_down/components/alert_dialogs/show_alert_dialog.dart';
import 'package:chow_down/components/design/chow.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/pages/recipes/recipe_info_page.dart';

class RecipeCardGrid extends StatelessWidget {
  final List<Recipe> searchResults;

  const RecipeCardGrid({
    Key? key,
    required this.searchResults,
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
        ? BlocProvider.of<RecipeTabBloc>(context).add(DeleteRecipeEvent(recipe))
        : null);
  }

  Widget _buildRecipeImage(BuildContext context, Recipe recipe) {
    return InkWell(
      onTap: () {
        BlocProvider.of<RecipeInfoBloc>(context).add(
          FetchRecipe(id: recipe.id, url: recipe.sourceUrl!),
        );

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RecipeInfoPage(
              title: recipe.title,
              id: recipe.id,
              sourceUrl: recipe.sourceUrl!,
            ),
            fullscreenDialog: true,
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(ChowBorderRadii.lg),
          topRight: Radius.circular(ChowBorderRadii.lg),
        ),
        child: CachedNetworkImage(
          imageUrl: recipe.image,
          height: Spacing.sm * 8,
          width: Spacing.sm * 12,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      crossAxisCount: 2,
      childAspectRatio: 0.825,
      mainAxisSpacing: Spacing.sm,
      crossAxisSpacing: Spacing.sm,
      children: _getStructuredCardGrid(searchResults, context),
      shrinkWrap: true,
    );
  }

  List<Widget> _getStructuredCardGrid(
    List<Recipe> results,
    BuildContext context,
  ) =>
      results
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
                      ),
                      child: Text(
                        recipe.title,
                        style: TextStyle(
                          fontSize: ChowFontSizes.sm,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
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
