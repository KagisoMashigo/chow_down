// 🐦 Flutter imports:
import 'package:chow_down/plugins/utils/constants.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:chow_down/blocs/recipe_info/recipe_info_bloc.dart';
import 'package:chow_down/blocs/recipe_info/recipe_info_event.dart';
import 'package:chow_down/blocs/recipe_info/recipe_info_state.dart';
import 'package:chow_down/components/cards/recipe_card_toggler.dart';
import 'package:chow_down/components/customAppBar.dart';
import 'package:chow_down/components/design/chow.dart';
import 'package:chow_down/components/empty_content.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/plugins/debugHelper.dart';

const List<String> TAB_OPTIONS = [
  'Ingredients',
  'Instructions',
  'Dietry Info',
];

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
    // TODO: cache recipes that have been fetched

    // make refresh method that refetches the recipe
    Future<void> _pullRefresh(BuildContext context) async {
      return Future.delayed(
        Duration(milliseconds: 500),
        () => context
            .read<RecipeInfoBloc>()
            .add(FetchRecipe(id: id, url: sourceUrl)),
      );
    }

    return CustomLogoAppBar(
      imgUrl: CHOW_DOWN_LOGO,
      title: title,
      body: BlocConsumer<RecipeInfoBloc, RecipeInfoState>(
        listener: (context, state) {
          if (state is RecipeInfoError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message ?? 'An unknown error occurred'),
              ),
            );
          }
        },
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  RECIPE_INFO_BACKGROUND_IMAGE,
                ),
                fit: BoxFit.fill,
              ),
            ),
            alignment: Alignment.center,
            child: RefreshIndicator(
              onRefresh: () => _pullRefresh(context),
              child: SingleChildScrollView(
                child: Builder(
                  builder: (context) {
                    if (state is RecipeInfoInitial) {
                      BlocProvider.of<RecipeInfoBloc>(context).add(
                        FetchRecipe(id: id, url: sourceUrl),
                      );
                      return _buildLoading();
                    } else if (state is RecipeInfoLoading) {
                      printDebug(state.toString());
                      return _buildLoading();
                    } else if (state is RecipeInfoLoaded) {
                      printDebug(state.toString());
                      return _buildContents(
                        context,
                        state.recipe,
                      );
                    } else {
                      printDebug(state.toString());
                      return _buildErrorMessage(state);
                    }
                  },
                ),
              ),
            ),
          );
        },
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

  Widget _buildContents(
    BuildContext context,
    Recipe recipe,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.5,
            child: CachedNetworkImage(
              imageUrl: recipe.image,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: Spacing.sm),
          RecipeCardToggler(
            options: TAB_OPTIONS,
            recipe: recipe,
          ),
        ],
      ),
    );
  }
}
