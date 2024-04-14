// 🐦 Flutter imports:
import 'package:chow_down/plugins/debugHelper.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:chow_down/blocs/recipe_info/recipe_info_bloc.dart';
import 'package:chow_down/blocs/recipe_info/recipe_info_event.dart';
import 'package:chow_down/blocs/recipe_info/recipe_info_state.dart';
import 'package:chow_down/components/buttons/save_button.dart';
import 'package:chow_down/components/cards/recipe_dietry_card.dart';
import 'package:chow_down/components/cards/recipe_ingre_card.dart';
import 'package:chow_down/components/cards/recipe_instructions_card.dart';
import 'package:chow_down/components/customAppBar.dart';
import 'package:chow_down/components/design/chow.dart';
import 'package:chow_down/components/design/responsive.dart';
import 'package:chow_down/components/empty_content.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';

const List<String> TAB_OPTIONS = [
  'Ingredients',
  'Instructions',
  'Dietry Info',
];

class RecipeInfoPage extends StatelessWidget {
  final String title;
  final int id;
  final String sourceUrl;

  const RecipeInfoPage({
    Key? key,
    required this.title,
    required this.id,
    required this.sourceUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<bool> isSelected = [];
    int currentIndex = 0;
    bool isButtonTapped = false;

    // TODO: cache recipes that have been fetched

    // make refresh method that refetches the recipe
    Future<void> _pullRefresh(BuildContext context) async => Future.delayed(
          Duration(milliseconds: 1500),
          () {
            context
                .read<RecipeInfoBloc>()
                .add(FetchRecipe(id: id, url: sourceUrl));
          },
        );

    void _populateButtonList(List data, List<bool> isSelected) {
      for (var i = 0; i < data.length; i++) {
        isSelected.add(i == 0);
      }
    }

    void _buttonTapped() {
      if (isButtonTapped == false) {
        isButtonTapped = true;
        Future.delayed(Duration(milliseconds: 1200), () {
          isButtonTapped = false;
        });
      } else {
        isButtonTapped = false;
        Future.delayed(Duration(milliseconds: 1200), () {
          isButtonTapped = true;
        });
      }
    }

    return CustomLogoAppBar(
      imgUrl: 'assets/images/chow_down.png',
      title: title,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              'https://images.unsplash.com/photo-1604147706283-d7119b5b822c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8bGlnaHQlMjBiYWNrZ3JvdW5kfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
            ),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: BlocConsumer<RecipeInfoBloc, RecipeInfoState>(
          listener: (context, state) {
            if (state is RecipeInfoError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  // TODO: Use generic error message for now
                  content: Text(state.message ?? 'An unknown error occurred'),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is RecipeInfoInitial) {
              BlocProvider.of<RecipeInfoBloc>(context).add(
                FetchRecipe(id: id, url: sourceUrl),
              );
            }
            if (state is RecipeInfoLoading) {
              printDebug(state.toString());
              return _buildLoading();
            } else if (state is RecipeInfoLoaded) {
              printDebug(state.toString());
              _populateButtonList(TAB_OPTIONS, isSelected);
              return _buildContents(context, state.recipe, _buttonTapped);
            } else {
              printDebug(state.toString());
              return _buildErrorMessage(state);
            }
          },
        ),
      ),
    );
  }

  Widget _buildErrorMessage(RecipeInfoState state) => Center(
        child: EmptyContent(
          message: 'If this persists please restart the application.',
          title: 'Something went wrong...',
          icon: Icons.error_outline_sharp,
        ),
      );

  Widget _buildLoading() => Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      );

  Widget _buildContents(
    BuildContext context,
    Recipe recipe,
    void Function() onTapped,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: recipe.image,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          SizedBox(height: Spacing.sm),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 4.5 * Responsive.ratioHorizontal),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        recipe.title,
                        style: TextStyle(
                          fontSize: 6 * Responsive.ratioHorizontal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: Spacing.sm),
                    ChowSaveButton(
                      onTap: () {
                        onTapped();
                        BlocProvider.of<RecipeInfoBloc>(context).add(
                          SaveRecipe(recipe: recipe),
                        );
                      },
                      isButtonTapped: false,
                    ),
                  ],
                ),
                SizedBox(height: Spacing.sm),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: ChowColors.white,
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: ToggleButtons(
                      renderBorder: false,
                      borderRadius: BorderRadius.circular(18.0),
                      borderWidth: 0,
                      children: TAB_OPTIONS
                          .map(
                            (tabName) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                tabName,
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          )
                          .toList(),
                      isSelected: [],
                      onPressed: (int newIndex) {
                        // Handle button press
                      },
                    ),
                  ),
                ),
                SizedBox(height: Spacing.sm),
                _whichCard(context, 0, recipe),
                SizedBox(height: Spacing.sm)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _whichCard(BuildContext context, int index, Recipe recipe) {
    switch (index) {
      case 0:
        return RecipeDescCard(
          veryHealthy: recipe.veryHealthy!,
          readyInMinutes: recipe.readyInMinutes!,
          servings: recipe.servings!,
          creditsText: recipe.creditsText!,
          glutenFree: recipe.glutenFree!,
          vegetarian: recipe.vegetarian!,
          ingredients: recipe.extendedIngredients,
          sourceUrl: recipe.sourceUrl!,
        );
      case 1:
        return RecipeInstCard(
          analyzedInstructions: recipe.analyzedInstructions!,
          instructions: recipe.instructions!,
        );
      case 2:
        return RecipeDietCard(
          dairyFree: recipe.dairyFree!,
          glutenFree: recipe.glutenFree!,
          healthScore: recipe.healthScore!,
          vegetarian: recipe.vegetarian!,
          vegan: recipe.vegan!,
        );
      default:
        return RecipeDescCard(
          veryHealthy: recipe.veryHealthy!,
          readyInMinutes: recipe.readyInMinutes!,
          servings: recipe.servings!,
          creditsText: recipe.creditsText!,
          glutenFree: recipe.glutenFree!,
          vegetarian: recipe.vegetarian!,
          summary: recipe.summary!,
          ingredients: recipe.extendedIngredients,
          sourceUrl: recipe.sourceUrl!,
        );
    }
  }
}
