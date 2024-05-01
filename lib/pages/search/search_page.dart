// 🐦 Flutter imports:

// 🐦 Flutter imports:
import 'package:chow_down/blocs/recipe_info/recipe_info_bloc.dart';
import 'package:chow_down/blocs/recipe_info/recipe_info_event.dart';
import 'package:chow_down/components/design/spacing.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:chow_down/blocs/search/search_bloc.dart';
import 'package:chow_down/blocs/search/search_event.dart';
import 'package:chow_down/blocs/search/search_state.dart';
import 'package:chow_down/components/alert_dialogs/floating_feedback.dart';
import 'package:chow_down/components/cards/recipe_card.dart';
import 'package:chow_down/components/design/color.dart';
import 'package:chow_down/components/design/responsive.dart';
import 'package:chow_down/components/empty_content.dart';
import 'package:chow_down/components/forms/chow_form.dart';
import 'package:chow_down/core/models/spoonacular/search_result_model.dart';
import 'package:chow_down/pages/recipes/recipe_info_page.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: RefreshIndicator(
          color: ChowColors.blue300,
          onRefresh: () => _pullRefresh(context),
          child: Container(
            height: Responsive.isSmallScreen()
                ? MediaQuery.of(context).size.height
                : MediaQuery.of(context).size.height * 0.91,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                    'https://images.unsplash.com/photo-1559703248-dcaaec9fab78?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE5fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60'),
                fit: BoxFit.cover,
              ),
            ),
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
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: Responsive.ratioVertical * 10.0),
                        child: ChowForm(
                          submitForm: (context, url) => context
                              .read<SearchBloc>()
                              .add(SearchRecipes(query: url)),
                          borderColor: ChowColors.white,
                        ),
                      ),
                      if (state is SearchLoaded)
                        _buildColumnWithData(state.searchResultList, context),
                    ],
                  ),
                  physics: BouncingScrollPhysics(),
                );
              },
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
                padding: EdgeInsets.all(5 * Responsive.ratioHorizontal),
                child: Column(
                  children: mappedRecipes.map(
                    (recipe) {
                      // This is the index to be used to iterate
                      int index = recipe.key;

                      return GestureDetector(
                        onTap: () {
                          BlocProvider.of<RecipeInfoBloc>(context).add(
                            FetchRecipe(
                              id: recipes[index].id,
                              url: recipes[index].sourceUrl!,
                            ),
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeInfoPage(
                                title: recipes[index].title,
                                id: recipes[index].id,
                                sourceUrl: recipes[index].sourceUrl!,
                              ),
                            ),
                          );
                        },
                        child: RecipeCard(
                          loadingColor: ChowColors.blue300,
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
                      child: FloatingActionButton(
                        onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SearchPage())),
                        child: Icon(
                          Icons.arrow_upward_outlined,
                          color: ChowColors.black,
                        ),
                        backgroundColor: ChowColors.white,
                      ),
                    ),
              SizedBox(height: Spacing.sm)
            ],
          )
        : Padding(
            padding: EdgeInsets.all(5 * Responsive.ratioHorizontal),
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
