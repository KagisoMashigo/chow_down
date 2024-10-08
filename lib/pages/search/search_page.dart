// 🐦 Flutter imports:

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:chow_down/blocs/recipe_info/recipe_detail_bloc.dart';
import 'package:chow_down/blocs/recipe_info/recipe_detail_event.dart';
import 'package:chow_down/blocs/saved_recipe/saved_recipe_bloc.dart';
import 'package:chow_down/blocs/search/search_bloc.dart';
import 'package:chow_down/blocs/search/search_event.dart';
import 'package:chow_down/blocs/search/search_state.dart';
import 'package:chow_down/components/alert_dialogs/floating_feedback.dart';
import 'package:chow_down/components/annotated_region.dart';
import 'package:chow_down/components/builders/back_to_top_builder.dart';
import 'package:chow_down/components/cards/recipe_card.dart';
import 'package:chow_down/components/design/color.dart';
import 'package:chow_down/components/design/spacing.dart';
import 'package:chow_down/components/empty_content.dart';
import 'package:chow_down/components/forms/chow_form.dart';
import 'package:chow_down/core/models/spoonacular/search_result_model.dart';
import 'package:chow_down/pages/recipes/recipe_detail_page.dart';
import 'package:chow_down/plugins/utils/constants.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChowAnnotatedRegion(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(BACKGROUND_TEXTURE),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: RefreshIndicator(
              color: ChowColors.borderGreen,
              onRefresh: () => _pullRefresh(context),
              child: Column(
                children: [
                  Expanded(
                    child: BlocConsumer<SearchBloc, SearchState>(
                      listener: (context, state) {
                        if (state is SearchError) {
                          FloatingFeedback(
                            message: state.message!,
                            style: FloatingFeedbackStyle.alert,
                            duration: Duration(seconds: 3),
                          ).show(context);
                        }
                      },
                      builder: (context, state) {
                        if (state is SearchLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: ChowColors.white,
                            ),
                          );
                        }

                        return SingleChildScrollView(
                          physics: ClampingScrollPhysics(),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: Spacing.xlg,
                                ),
                                child: ChowForm(
                                  submitForm: (context, url) => context
                                      .read<SearchBloc>()
                                      .add(SearchRecipes(query: url)),
                                  borderColor: ChowColors.white,
                                  hintText: 'Search for a recipe',
                                ),
                              ),
                              if (state is SearchLoaded)
                                _buildColumnWithData(
                                    state.searchResultList, context),
                            ],
                          ),
                        );
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

  Widget _buildColumnWithData(
      RecipeCardInfoList searchResultList, BuildContext context) {
    final recipes = searchResultList.results;
    final mappedRecipes = recipes.asMap().entries;

    return recipes.isNotEmpty
        ? Column(
            children: [
              Padding(
                padding: EdgeInsets.all(Spacing.sm),
                child: Column(
                  children: mappedRecipes.map(
                    (recipe) {
                      // This is the index to be used to iterate
                      int index = recipe.key;

                      return GestureDetector(
                        onTap: () {
                          BlocProvider.of<RecipeDetailBloc>(context).add(
                            FetchRecipe(
                              id: recipes[index].id,
                              url: recipes[index].sourceUrl!,
                              savedRecipes: context
                                  .read<SavedRecipeBloc>()
                                  .state
                                  .savedRecipeList,
                            ),
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeDetailPage(
                                title: recipes[index].title,
                                id: recipes[index].id,
                                sourceUrl: recipes[index].sourceUrl!,
                              ),
                            ),
                          );
                        },
                        child: RecipeCard(
                          loadingColor: ChowColors.borderGreen,
                          id: recipes[index].id,
                          name: recipes[index].title,
                          imageUrl: recipes[index].image,
                          url: recipes[index].sourceUrl!,
                          glutenFree: recipes[index].glutenFree!,
                          readyInMinutes: recipes[index].readyInMinutes!,
                          vegetarian: recipes[index].vegetarian!,
                          vegan: recipes[index].vegan!,
                          servings: recipes[index].servings!,
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
              recipes.length < 4
                  ? Container()
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: ChowBackToTopTransitionBuilder(
                        desitnation: SearchPage(),
                      ),
                    ),
              SizedBox(height: Spacing.sm)
            ],
          )
        : Padding(
            padding: EdgeInsets.all(Spacing.sm),
            child: EmptyContent(
              icon: Icons.question_mark,
              title: 'Oof no results...',
              message: 'Try a different search term',
            ),
          );
  }

  Future<void> _pullRefresh(BuildContext context) async =>
      await Future.delayed(Duration(seconds: 1), () {
        context.read<SearchBloc>().add(Refresh());
      });
}
