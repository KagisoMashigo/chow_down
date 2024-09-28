// 🎯 Dart imports:
import 'dart:developer';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:chow_down/blocs/edit_recipe/edit_recipe_bloc.dart';
import 'package:chow_down/blocs/edit_recipe/edit_recipe_event.dart';
import 'package:chow_down/blocs/edit_recipe/edit_recipe_state.dart';
import 'package:chow_down/blocs/recipe_info/recipe_detail_bloc.dart';
import 'package:chow_down/blocs/recipe_info/recipe_detail_event.dart';
import 'package:chow_down/blocs/recipe_info/recipe_detail_state.dart';
import 'package:chow_down/blocs/saved_recipe/saved_recipe_bloc.dart';
import 'package:chow_down/blocs/saved_recipe/saved_recipe_state.dart';
import 'package:chow_down/components/buttons/save_button.dart';
import 'package:chow_down/components/cards/base_card.dart';
import 'package:chow_down/components/cards/recipe_card_toggler.dart';
import 'package:chow_down/components/design/chow.dart';
import 'package:chow_down/components/empty_content.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/plugins/utils/constants.dart';

class RecipeDetailPage extends StatelessWidget {
  final String title;
  final int id;
  final String sourceUrl;

  const RecipeDetailPage({
    Key? key,
    required this.title,
    required this.id,
    required this.sourceUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final savedRecipes = context.read<SavedRecipeBloc>().state.savedRecipeList;

    Future<void> _pullRefresh(BuildContext context) async {
      return Future.delayed(
        Duration(milliseconds: 500),
        () => context.read<RecipeDetailBloc>().add(
              FetchRecipe(
                id: id,
                url: sourceUrl,
                savedRecipes:
                    context.read<SavedRecipeBloc>().state.savedRecipeList,
              ),
            ),
      );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
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
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: RefreshIndicator(
                      onRefresh: () => _pullRefresh(context),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 38.0),
                        child: BlocConsumer<SavedRecipeBloc, SavedRecipeState>(
                          listener: (context, state) {
                            if (state is SavedRecipeLoaded) {
                              log('Saved recipes loaded');
                              BlocProvider.of<RecipeDetailBloc>(context).add(
                                FetchRecipe(
                                  id: id,
                                  url: sourceUrl,
                                  savedRecipes: state.savedRecipeList,
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            return SingleChildScrollView(
                              child: BlocConsumer<RecipeDetailBloc,
                                  RecipeDetailState>(
                                listener: (context, state) {
                                  if (state is RecipeInfoError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(state.message ??
                                            'An unknown error occurred'),
                                      ),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  if (state is RecipeInfoInitial) {
                                    BlocProvider.of<RecipeDetailBloc>(context)
                                        .add(
                                      FetchRecipe(
                                        id: id,
                                        url: sourceUrl,
                                        savedRecipes: context
                                            .watch<SavedRecipeBloc>()
                                            .state
                                            .savedRecipeList,
                                      ),
                                    );
                                    return _buildLoading();
                                  } else if (state is RecipeInfoLoading) {
                                    log('Loading recipe...');
                                    return _buildLoading();
                                  } else if (state is RecipeInfoLoaded) {
                                    final isSaved = context
                                            .watch<SavedRecipeBloc>()
                                            .state
                                            .savedRecipeList
                                            ?.any((element) {
                                          log('Recipe url: ${state.recipe.sourceUrl}');

                                          log('element sourceUrl: ${state.recipe.sourceUrl}');
                                          return element.sourceUrl ==
                                              state.recipe.sourceUrl;
                                        }) ??
                                        false;

                                    log('savedRecipes: ${savedRecipes?.length}');

                                    log('Recipe is saved: $isSaved');

                                    return _buildContents(
                                      context,
                                      state.recipe,
                                      isSaved,
                                    );
                                  } else {
                                    return _buildErrorMessage(state);
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: Spacing.xsm,
                    left: Spacing.xsm,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: ChowFontSizes.xxlg,
                      ),
                      onPressed: () {
                        context.read<EditRecipeBloc>().add(CancelEditRecipe());
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorMessage(RecipeDetailState state) => Center(
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

  Widget _buildTitleContent(
    Recipe recipe,
    BuildContext context,
    bool isSaved,
  ) {
    log('isSaved in title: $isSaved');
    return BlocBuilder<EditRecipeBloc, EditRecipeState>(
      builder: (context, state) {
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
                if (state is! EditRecipePending) ...[
                  SaveRecipeButton(
                    key: ValueKey(isSaved),
                    recipe: recipe,
                    isSaved: isSaved,
                    size: Spacing.md,
                    iconSize: Spacing.md,
                  )
                ]
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContents(
    BuildContext context,
    Recipe recipe,
    bool isSaved,
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
          child: _buildTitleContent(recipe, context, isSaved),
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
