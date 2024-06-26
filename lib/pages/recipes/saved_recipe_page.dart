// 🐦 Flutter imports:
import 'package:chow_down/components/design/typography.dart';
import 'package:chow_down/plugins/utils/constants.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
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

class SavedRecipePage extends StatelessWidget {
  const SavedRecipePage({Key? key}) : super(key: key);

  void showSnackbar(
    BuildContext context,
    String errorMessage,
  ) =>
      ScaffoldMessenger.of(context).showSnackBar(warningSnackBar(errorMessage));

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
            color: Color.fromARGB(255, 234, 180, 225),
            onRefresh: () => _pullRefresh(context),
            edgeOffset: 100,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(Spacing.md),
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
                    BlocConsumer<SavedRecipeBloc, SavedRecipeState>(
                      listenWhen: (previous, current) => previous != current,
                      listener: (context, state) {
                        if (state is SavedRecipeError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message!),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is SavedRecipePending) {
                          return _buildLoading();
                        } else if (state is SavedRecipeError) {
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
        ),
      ),
    );
  }

  Future<void> _pullRefresh(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    BlocProvider.of<SavedRecipeBloc>(context).add(FetchHomeRecipesEvent());
  }

  Widget _buildErrors(SavedRecipeState state) => state.recipeCardList.isEmpty
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

  // Widget _buildToggleButtons(List<String> options, List<Recipe> searchResultList) {
  //   return ToggleButtons(
  //     borderColor: Colors.black,
  //     selectedBorderColor: Color.fromARGB(255, 69, 6, 164),
  //     borderWidth: 1,
  //     borderRadius: BorderRadius.circular(8),
  //     fillColor: Color.fromARGB(255, 69, 6, 164).withOpacity(0.1),
  //     selectedColor: Colors.black,
  //     color: Colors.black,
  //     children: options
  //         .map((option) => Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //               child: Text(option),
  //             ))
  //         .toList(),
  //     isSelected: _isSelected,
  //     onPressed: (int newIndex) {
  //       setState(
  //         () {
  //           for (int i = 0; i < _isSelected.length; i++) {
  //             if (i == newIndex) {
  //               _isSelected[i] = true;
  //               _currentIndex = i;
  //             } else {
  //               _isSelected[i] = false;
  //             }
  //           }
  //         },
  //       );
  //     },
  //   );
  // }

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
                      MaterialPageRoute(
                          builder: (context) => SavedRecipePage()),
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
