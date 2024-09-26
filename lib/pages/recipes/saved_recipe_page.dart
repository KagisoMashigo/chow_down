// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:chow_down/blocs/saved_recipe/saved_recipe_bloc.dart';
import 'package:chow_down/blocs/saved_recipe/saved_recipe_event.dart';
import 'package:chow_down/blocs/saved_recipe/saved_recipe_state.dart';
import 'package:chow_down/components/alert_dialogs/floating_feedback.dart';
import 'package:chow_down/components/cards/recipe_card_grid.dart';
import 'package:chow_down/components/design/color.dart';
import 'package:chow_down/components/design/spacing.dart';
import 'package:chow_down/components/empty_content.dart';
import 'package:chow_down/plugins/utils/constants.dart';

class SavedRecipePage extends StatelessWidget {
  const SavedRecipePage({Key? key}) : super(key: key);

  void showFloatingFeedback(
    BuildContext context,
    String errorMessage,
  ) =>
      FloatingFeedback(
        message: errorMessage,
        style: FloatingFeedbackStyle.alert,
        duration: Duration(seconds: 3),
      ).show(context);

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
              color: ChowColors.borderGreen,
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
    BlocProvider.of<SavedRecipeBloc>(context).add(FetchSavedRecipesEvent());
  }
}

class SavedRecipesToggler extends StatelessWidget {
  const SavedRecipesToggler({
    super.key,
  });

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

            return RecipeCardGrid(results: state.savedRecipeList!);
          },
        ),
      ],
    );
  }

  Widget _buildErrors(SavedRecipeState state) =>
      state.savedRecipeList != null && state.savedRecipeList!.isEmpty
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
          color: ChowColors.white,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Spacing.sm),
        SizedBox(height: Spacing.sm),
        _buildSavedRecipes(),
        SizedBox(height: Spacing.xlg),
      ],
    );
  }
}
