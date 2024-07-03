// 🐦 Flutter imports:
import 'dart:developer';

import 'package:chow_down/blocs/edit_recipe/edit_recipe_bloc.dart';
import 'package:chow_down/blocs/edit_recipe/edit_recipe_state.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:chow_down/blocs/recipe_info/recipe_detail_bloc.dart';
import 'package:chow_down/blocs/recipe_info/recipe_detail_event.dart';
import 'package:chow_down/blocs/recipe_info/recipe_detail_state.dart';
import 'package:chow_down/components/buttons/edit_recipe_buttons.dart';
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
  final List<Recipe> savedRecipes;

  const RecipeDetailPage({
    Key? key,
    required this.title,
    required this.id,
    required this.sourceUrl,
    required this.savedRecipes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> _pullRefresh(BuildContext context) async {
      return Future.delayed(
        Duration(milliseconds: 500),
        () => context.read<RecipeDetailBloc>().add(
              FetchRecipe(
                id: id,
                url: sourceUrl,
                savedRecipes: savedRecipes,
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
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: RefreshIndicator(
                    onRefresh: () => _pullRefresh(context),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 38.0),
                      child: SingleChildScrollView(
                        child:
                            BlocConsumer<RecipeDetailBloc, RecipeDetailState>(
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
                              BlocProvider.of<RecipeDetailBloc>(context).add(
                                FetchRecipe(
                                  id: id,
                                  url: sourceUrl,
                                  savedRecipes: savedRecipes,
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
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
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

  Widget _buildWidgetOrTextfield(
    EditRecipeState state,
    Recipe recipe,
  ) {
    return state is EditRecipePending
        // TODO: heights need to be the same
        ? Expanded(
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              initialValue: recipe.title,
              // label: tr('egiftcard.recipient_email.label'),
              keyboardType: TextInputType.name,
              onChanged: (value) {
                log('On changed: $value');
              },
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  log('Validator: $value');
                }
                return null;
              },
            ),
          )
        : Flexible(
            child: Text(
              recipe.title,
              style: TextStyle(
                fontSize: ChowFontSizes.smd,
              ),
            ),
          );
  }

  Widget _buildTitleContent(
    Recipe recipe,
    BuildContext context,
  ) {
    final isSaved =
        savedRecipes.any((element) => element.sourceUrl == recipe.sourceUrl);

    return BlocBuilder<EditRecipeBloc, EditRecipeState>(
      builder: (context, state) {
        return BaseCard(
          child: Padding(
            padding: const EdgeInsets.all(Spacing.sm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildWidgetOrTextfield(state, recipe),
                SizedBox(width: Spacing.xsm),
                Row(
                  children: [
                    if (isSaved && state is! EditRecipePending) ...[
                      EditRecipeButton(
                        recipe: recipe,
                        size: Spacing.md,
                        iconSize: Spacing.md,
                      ),
                      SizedBox(width: Spacing.sm),
                    ],
                    if (state is EditRecipePending) ...[
                      FinishEditRecipeButton(
                        size: Spacing.md,
                        iconSize: Spacing.md,
                        onTap: () {
                          BlocProvider.of<RecipeDetailBloc>(context).add(
                            SaveRecipe(
                                recipe: recipe
                                    .savedEditedTitle('This is a test title')),
                          );
                        },
                      ),
                      SizedBox(width: Spacing.sm),
                      CancelEditRecipeButton(
                        recipe: recipe,
                        size: Spacing.md,
                        iconSize: Spacing.md,
                      ),
                    ],
                    if (state is! EditRecipePending) ...[
                      SaveRecipeButton(
                        recipe: recipe,
                        isSaved: isSaved,
                        size: Spacing.md,
                        iconSize: Spacing.md,
                      ),
                    ]
                  ],
                ),
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
