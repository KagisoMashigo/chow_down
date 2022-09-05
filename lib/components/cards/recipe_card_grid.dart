// 🐦 Flutter imports:
import 'package:chow_down/components/alert_dialogs/show_alert_dialog.dart';
import 'package:chow_down/components/design/chow.dart';
import 'package:chow_down/cubit/recipe_tab/recipe_tab_cubit.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/components/design/responsive.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/pages/recipes/recipe_info_page.dart';
import 'package:provider/provider.dart';

class RecipeCardGrid extends StatefulWidget {
  const RecipeCardGrid({
    Key key,
    @required this.searchResultList,
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
      childAspectRatio: 0.425 * Responsive.ratioSquare,
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
    return results.map(
      (recipe) {
        return Container(
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
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RecipeInfoPage(
                      title: recipe.title,
                      id: recipe.id,
                      sourceUrl: recipe.sourceUrl,
                    ),
                    fullscreenDialog: true,
                  ));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.network(
                    recipe.image,
                    height: 26 * Responsive.ratioHorizontal,
                    width: 23 * Responsive.ratioVertical,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 2 * Responsive.ratioHorizontal,
                  // vertical: 1.1 * Responsive.ratioHorizontal,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        recipe.title,
                        style: TextStyle(
                          fontSize: 3.75 * Responsive.ratioHorizontal,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: (() => _confirmDelete(context, delete, recipe)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 2 * Responsive.ratioHorizontal),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Icon(
                        Icons.delete,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    ).toList();
  }
}
