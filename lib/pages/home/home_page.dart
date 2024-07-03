// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:chow_down/blocs/home_page/extract_bloc.dart';
import 'package:chow_down/blocs/home_page/extract_event.dart';
import 'package:chow_down/blocs/home_page/extract_state.dart';
import 'package:chow_down/blocs/recipe_info/recipe_detail_bloc.dart';
import 'package:chow_down/blocs/recipe_info/recipe_detail_event.dart';
import 'package:chow_down/blocs/saved_recipe/saved_recipe_bloc.dart';
import 'package:chow_down/components/alert_dialogs/floating_feedback.dart';
import 'package:chow_down/components/cards/expanded_help_card.dart';
import 'package:chow_down/components/cards/recipe_card.dart';
import 'package:chow_down/components/design/color.dart';
import 'package:chow_down/components/design/spacing.dart';
import 'package:chow_down/components/forms/chow_form.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/pages/recipes/recipe_detail_page.dart';
import 'package:chow_down/plugins/utils/constants.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(BACKGROUND_TEXTURE),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () => _pullRefresh(context),
            color: ChowColors.black,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: Spacing.lg,
                      ),
                      child: BlocConsumer<ExtractBloc, ExtractState>(
                        listener: (context, state) {
                          if (state is ExtractError) {
                            FloatingFeedback(
                              message: state.message,
                              style: FloatingFeedbackStyle.alert,
                              duration: Duration(seconds: 3),
                            ).show(context);
                          }
                        },
                        builder: (context, state) {
                          if (state is ExtractPending) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: ChowColors.white,
                              ),
                            );
                          }

                          return Column(
                            children: [
                              SizedBox(height: Spacing.md),
                              Image.asset(
                                CHOW_DOWN_LOGO,
                                height: Spacing.massive,
                                width: Spacing.massive,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(height: Spacing.md),
                              ChowForm(
                                submitForm: (context, url) => context
                                    .read<ExtractBloc>()
                                    .add(ExtractRecipe(url: url)),
                              ),
                              SizedBox(height: Spacing.sm),
                              if (state is! ExtractPending) HelpCard(),
                              SizedBox(height: Spacing.xsm),
                              if (state is ExtractLoaded)
                                _buildColumnWithData(
                                    state.extractedResult, context),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColumnWithData(Recipe searchResult, BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.sm),
          child: GestureDetector(
            onTap: () {
              BlocProvider.of<RecipeDetailBloc>(context).add(
                FetchRecipe(
                  id: searchResult.id,
                  url: searchResult.sourceUrl!,
                  savedRecipes:
                      context.read<SavedRecipeBloc>().state.savedRecipeList,
                ),
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetailPage(
                    title: searchResult.title,
                    id: searchResult.id,
                    sourceUrl: searchResult.sourceUrl!,
                    savedRecipes:
                        // TODO what if it is null?
                        context.read<SavedRecipeBloc>().state.savedRecipeList ??
                            [],
                  ),
                ),
              );
            },
            child: RecipeCard(
              loadingColor: ChowColors.red700,
              id: searchResult.id,
              name: searchResult.title,
              imageUrl: searchResult.image,
              url: searchResult.sourceUrl!,
              glutenFree: searchResult.glutenFree!,
              readyInMinutes: searchResult.readyInMinutes!,
              vegetarian: searchResult.vegetarian!,
              vegan: searchResult.vegan!,
              servings: searchResult.servings!,
            ),
          ),
        ),
        SizedBox(height: Spacing.lg),
      ],
    );
  }

  Future<void> _pullRefresh(BuildContext context) async => Future.delayed(
        Duration(milliseconds: 1500),
        () {
          context.read<ExtractBloc>().add(RefreshHome());
        },
      );
}
