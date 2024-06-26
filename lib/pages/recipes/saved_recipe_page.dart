// 🐦 Flutter imports:
import 'package:chow_down/components/builders/back_to_top_builder.dart';
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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(BACKGROUND_TEXTURE),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: RefreshIndicator(
              color: Color.fromARGB(255, 234, 180, 225),
              onRefresh: () => _pullRefresh(context),
              edgeOffset: 100,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
                  child: SavedRecipesToggler(),
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
    BlocProvider.of<SavedRecipeBloc>(context).add(FetchHomeRecipesEvent());
  }
}

class SavedRecipesToggler extends StatefulWidget {
  const SavedRecipesToggler({
    super.key,
  });

  @override
  State<SavedRecipesToggler> createState() => _SavedRecipesTogglerState();
}

class _SavedRecipesTogglerState extends State<SavedRecipesToggler> {
  final List<bool> _isSelected = [];

  /// Initial selected button
  int _currentIndex = 0;

  final options = [
    'Saved Recipes',
    'Edited Recipes',
  ];

  void initState() {
    _populateButtonList(options, _isSelected);
    super.initState();
  }

  /// Handles how many buttons appear in nav and which is selected using bools
  void _populateButtonList(List data, List<bool> isSelected) {
    for (var i = 0; i < data.length; i++) {
      if (i == 0) {
        isSelected.add(true);
      } else {
        isSelected.add(false);
      }
    }
  }

  Widget _buildSavedRecipes() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              context,
              state.recipeCardList,
            );
          },
        ),
      ],
    );
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

  Widget _buildColumnWithData(
    BuildContext context,
    List<Recipe> searchResultList,
  ) {
    return Column(
      children: [
        RecipeCardGrid(
          searchResults: searchResultList,
        ),
        SizedBox(height: Spacing.md),
        searchResultList.length > 10
            ? Align(
                alignment: Alignment.bottomCenter,
                child: ChowBackToTopTransitionBuilder(
                  desitnation: SavedRecipePage(),
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Spacing.sm),
        Container(
          decoration: BoxDecoration(
            color: ChowColors.white,
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: _buildToggleButtons(options),
        ),
        SizedBox(height: Spacing.sm),
        _whichList(
          context,
          _currentIndex,
        ),
        SizedBox(height: Spacing.xlg),
      ],
    );
  }

  Widget _buildToggleButtons(
    List<String> options,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: ChowColors.white,
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: ToggleButtons(
        selectedBorderColor: ChowColors.borderGreen,
        borderWidth: 1,
        borderRadius: BorderRadius.circular(14),
        fillColor: ChowColors.fillGreen,
        selectedColor: Colors.black,
        color: Colors.black,
        children: options
            .map((option) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
                  child: Text(
                    option,
                    style: TextStyle(fontSize: ChowFontSizes.sm),
                  ),
                ))
            .toList(),
        isSelected: _isSelected,
        onPressed: (int newIndex) {
          setState(
            () {
              for (int i = 0; i < _isSelected.length; i++) {
                if (i == newIndex) {
                  _isSelected[i] = true;
                  _currentIndex = i;
                } else {
                  _isSelected[i] = false;
                }
              }
            },
          );
        },
      ),
    );
  }

  Widget _whichList(
    BuildContext context,
    int index,
  ) {
    switch (index) {
      case 0:
        return _buildSavedRecipes();
      case 1:
        return Column(
          children: [
            Center(
              child: EmptyContent(
                title: 'Not Built Yet...',
                message: 'Coming soon!',
                icon: Icons.hourglass_empty,
              ),
            ),
          ],
        );
      default:
        return _buildSavedRecipes();
    }
  }
}
