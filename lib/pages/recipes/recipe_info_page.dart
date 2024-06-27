// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:chow_down/blocs/recipe_info/recipe_info_bloc.dart';
import 'package:chow_down/blocs/recipe_info/recipe_info_event.dart';
import 'package:chow_down/blocs/recipe_info/recipe_info_state.dart';
import 'package:chow_down/blocs/recipe_tab/recipe_tab_bloc.dart';
import 'package:chow_down/components/buttons/edit_recipe_button.dart';
import 'package:chow_down/components/buttons/save_button.dart';
import 'package:chow_down/components/cards/base_card.dart';
import 'package:chow_down/components/cards/recipe_card_toggler.dart';
import 'package:chow_down/components/design/chow.dart';
import 'package:chow_down/components/empty_content.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/plugins/utils/constants.dart';

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
    Future<void> _pullRefresh(BuildContext context) async {
      return Future.delayed(
        Duration(milliseconds: 500),
        () => context.read<RecipeInfoBloc>().add(
              FetchRecipe(
                id: id,
                url: sourceUrl,
                savedRecipes: context.select(
                  (SavedRecipeBloc bloc) => bloc.state.recipeCardList,
                ),
              ),
            ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              RECIPE_INFO_BACKGROUND_IMAGE,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Align(
            alignment: Alignment.center,
            child: RefreshIndicator(
              onRefresh: () => _pullRefresh(context),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 38.0),
                child: SingleChildScrollView(
                  child: BlocConsumer<RecipeInfoBloc, RecipeInfoState>(
                    listener: (context, state) {
                      if (state is RecipeInfoError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                state.message ?? 'An unknown error occurred'),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is RecipeInfoInitial) {
                        BlocProvider.of<RecipeInfoBloc>(context).add(
                          FetchRecipe(
                            id: id,
                            url: sourceUrl,
                            savedRecipes: context
                                .read<SavedRecipeBloc>()
                                .state
                                .recipeCardList,
                          ),
                        );
                        return _buildLoading();
                      } else if (state is RecipeInfoLoading) {
                        return _buildLoading();
                      } else if (state is RecipeInfoLoaded) {
                        return _buildContents(
                          context,
                          state.recipe,
                        );
                      } else {
                        return _buildErrorMessage(state);
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
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

  Widget _buildTitleContent(Recipe recipe, BuildContext context) {
    final isSaved = context.select((SavedRecipeBloc bloc) => bloc
        .state.recipeCardList
        .any((element) => element.sourceUrl == recipe.sourceUrl));

    return BaseCard(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.sm),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                recipe.title,
                style: TextStyle(
                  fontSize: ChowFontSizes.smd,
                ),
              ),
            ),
            SizedBox(width: Spacing.xsm),
            Row(
              children: [
                if (isSaved) ...[
                  EditRecipeButton(
                    recipe: recipe,
                    size: Spacing.md,
                    iconSize: Spacing.md,
                  ),
                  SizedBox(width: Spacing.sm),
                ],
                SaveRecipeButton(
                  recipe: recipe,
                  size: Spacing.md,
                  iconSize: Spacing.md,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContents(
    BuildContext context,
    Recipe recipe,
  ) {
    final image = recipe.image != null
        ? CachedNetworkImage(
            imageUrl: recipe.image!,
            fit: BoxFit.cover,
          )
        : Image.asset(
            NO_IMAGE_AVAILABLE,
            fit: BoxFit.cover,
          );

    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.25,
          child: image,
        ),
        SizedBox(height: Spacing.sm),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
          child: _buildTitleContent(recipe, context),
        ),
        SizedBox(height: Spacing.sm),
        RecipeCardToggler(
          options: TAB_OPTIONS,
          recipe: recipe,
        ),
        SizedBox(height: Spacing.xlg),
      ],
    );
  }
}
