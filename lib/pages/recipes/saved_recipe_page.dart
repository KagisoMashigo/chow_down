// 🐦 Flutter imports:
import 'package:chow_down/components/design/typography.dart';
import 'package:chow_down/plugins/utils/constants.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:chow_down/blocs/recipe_tab/recipe_tab_bloc.dart';
import 'package:chow_down/blocs/recipe_tab/recipe_tab_event.dart';
import 'package:chow_down/blocs/recipe_tab/recipe_tab_state.dart';
import 'package:chow_down/components/cards/recipe_card_grid.dart';
import 'package:chow_down/components/design/color.dart';
import 'package:chow_down/components/design/spacing.dart';
import 'package:chow_down/components/empty_content.dart';
import 'package:chow_down/components/snackBar.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';

class RecipeTabPage extends StatelessWidget {
  const RecipeTabPage({Key? key}) : super(key: key);

  void showSnackbar(
    BuildContext context,
    String errorMessage,
  ) =>
      ScaffoldMessenger.of(context).showSnackBar(warningSnackBar(errorMessage));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  SAVED_RECIPE_BACKGROUND_IMAGE,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          RefreshIndicator(
            color: Color.fromARGB(255, 234, 180, 225),
            onRefresh: () => _pullRefresh(context),
            edgeOffset: 100,
            child: Padding(
              padding: const EdgeInsets.all(Spacing.md),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Spacing.lg),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: Spacing.sm),
                        child: Text(
                          'Saved Recipes',
                          style: TextStyle(
                            color: ChowColors.black,
                            fontSize: ChowFontSizes.lg,
                          ),
                        ),
                      ),
                    ),
                    BlocConsumer<RecipeTabBloc, RecipeTabState>(
                      listenWhen: (previous, current) => previous != current,
                      listener: (context, state) {
                        if (state is RecipeTabError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message!),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is RecipeTabLoading) {
                          return _buildLoading();
                        } else if (state is RecipeTabError) {
                          return _buildErrors(state);
                        }

                        return _buildColumnWithData(
                            context, state.recipeCardList);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pullRefresh(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    BlocProvider.of<RecipeTabBloc>(context).add(FetchHomeRecipesEvent());
  }

  Widget _buildErrors(RecipeTabState state) => state.recipeCardList.isEmpty
      ? Center(
          child: EmptyContent(
            message: 'It\'s as empty as your stomach...',
            title: 'No recipes currently saved',
            icon: Icons.hourglass_empty,
          ),
        )
      : Center(
          child: EmptyContent(
            message:
                'Please pull to refresh. If this persists please restart the application.',
            title: 'Something went wrong...',
            icon: Icons.error_outline_sharp,
          ),
        );

  Widget _buildLoading() => Center(
        child: CircularProgressIndicator(
          color: Color.fromARGB(255, 212, 147, 201),
        ),
      );

  Widget _buildColumnWithData(
    BuildContext context,
    List<Recipe> searchResultList,
  ) {
    return Column(
      children: [
        RecipeCardGrid(
          searchResults: searchResultList,
        ),
        searchResultList.length > 10
            ? Padding(
                padding: const EdgeInsets.only(bottom: Spacing.lg),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => RecipeTabPage()),
                    ),
                    child: Icon(
                      Icons.arrow_upward_outlined,
                      color: ChowColors.black,
                    ),
                    backgroundColor: ChowColors.white,
                  ),
                ),
              )
            : SizedBox.shrink(),
        SizedBox(height: Spacing.lg),
      ],
    );
  }
}
