// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:chow_down/components/alert_dialogs/show_alert_dialog.dart';
import 'package:chow_down/components/design/chow.dart';
import 'package:chow_down/components/design/responsive.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/cubit/recipe_tab/recipe_tab_cubit.dart';
import 'package:chow_down/pages/recipes/recipe_info_page.dart';

class RecipeCardGrid extends StatefulWidget {
  const RecipeCardGrid({
    Key? key,
    required this.searchResultList,
  }) : super(key: key);

  final List<Recipe> searchResultList;

  @override
  State<RecipeCardGrid> createState() => _RecipeCardGridState();
}

class _RecipeCardGridState extends State<RecipeCardGrid> {
  Future<void> _confirmDelete(
      BuildContext context, RecipeTabCubit delete, Recipe recipe) async {
    final confirmDelete = await showAlertDialog(
      context,
      isSave: false,
      title: 'Delete Recipe?',
      content: 'This will remove the recipe',
      defaultActionText: 'Delete',
      cancelActionText: 'Cancel',
    );
    if (confirmDelete == true) {
      delete.deleteRecipeFromCollection(recipe);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Recipe> results = widget.searchResultList;
    final _delete = Provider.of<RecipeTabCubit>(context, listen: false);

    return GridView.count(
      primary: false,
      crossAxisCount: 2,
      childAspectRatio: Responsive.isSmallScreen()
          ? MediaQuery.of(context).size.aspectRatio * 1.55
          : MediaQuery.of(context).size.aspectRatio * 2,
      mainAxisSpacing: 3 * Responsive.ratioVertical,
      crossAxisSpacing: 5.5 * Responsive.ratioHorizontal,
      children: _getStructuredCardGrid(results, context, _delete),
      shrinkWrap: true,
    );
  }

  List<Widget> _getStructuredCardGrid(
    List<Recipe> results,
    context,
    RecipeTabCubit delete,
  ) {
    return results
        .map(
          (recipe) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: ChowColors.offWhite,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 6.0,
                  offset: const Offset(7, 0),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    // TODO: check if extracted
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RecipeInfoPage(
                          title: recipe.title,
                          id: recipe.id,
                          sourceUrl: recipe.sourceUrl,
                        ),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: recipe.image,
                      height: 26 * Responsive.ratioHorizontal,
                      width: 25.5 * Responsive.ratioVertical,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                verticalDivider(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 2 * Responsive.ratioHorizontal,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          recipe.title,
                          style: TextStyle(
                            fontSize: 3.75 * Responsive.ratioHorizontal,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                      InkWell(
                        splashColor: ChowColors.black,
                        onTap: (() => _confirmDelete(context, delete, recipe)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2 * Responsive.ratioHorizontal,
                          ),
                          child: Icon(
                            Icons.delete,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();
  }
}
