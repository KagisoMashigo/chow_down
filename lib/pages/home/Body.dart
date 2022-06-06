// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:chow_down/components/alert_dialogs/show_alert_dialog.dart';
import 'package:chow_down/components/cards/recipe_card.dart';
import 'package:chow_down/components/design/color.dart';
import 'package:chow_down/components/design/responsive.dart';
import 'package:chow_down/core/models/spoonacular/search_result_model.dart';
import 'package:chow_down/cubit/home_page/extract_cubit.dart';
import 'package:chow_down/pages/recipes/extracted_info_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: page needs to be refreshable, or does it?
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1558855410-3112e253d755?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDZ8fGljZSUyMGNyZWFtfGVufDB8MXwwfHw%3D&auto=format&fit=crop&w=800&q=60'),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocConsumer<ExtractCubit, ExtractState>(
          listener: (context, state) {
            if (state is ExtractError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is ExtractInitial) {
              return _buildInitialInput();
            } else if (state is ExtractLoading) {
              return _buildLoading();
            } else if (state is ExtractLoaded) {
              print('STATE ${state.extractedResult.sourceUrl}');
              return _buildColumnWithData(state.extractedResult);
            } else {
              // error state snackbar
              return _buildInitialInput();
            }
          },
        ),
      ),
    );
  }

  Widget _buildInitialInput() {
    return Padding(
      padding: EdgeInsets.only(top: 7.5 * Responsive.ratioVertical),
      child: Column(
        children: [
          Image.asset(
            'assets/images/chow_down.png',
            height: 18.5 * Responsive.ratioVertical,
            width: 18.5 * Responsive.ratioVertical,
            fit: BoxFit.cover,
          ),
          verticalDivider(factor: 5),
          RecipeExtractInput()
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      // TODO: Cooler loading bar, maybe with text too
      child: CircularProgressIndicator(
        color: ChowColors.white,
      ),
    );
  }

  Widget _buildColumnWithData(RecipeCardInfo searchResult) {
    final result = searchResult;

    return Container(
      child: Padding(
        padding: EdgeInsets.only(
          top: 7.5 * Responsive.ratioVertical,
        ),
        child: Column(
          children: [
            Image.asset(
              'assets/images/chow_down.png',
              height: 18.5 * Responsive.ratioVertical,
              width: 18.5 * Responsive.ratioVertical,
              fit: BoxFit.fill,
            ),
            verticalDivider(factor: 2),
            RecipeExtractInput(),
            verticalDivider(),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 5 * Responsive.ratioHorizontal),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExtractedInfoPage(
                      title: result.name,
                      id: result.id,
                      sourceUrl: result.sourceUrl,
                    ),
                  ),
                ),
                child: RecipeCard(
                  id: result.id,
                  name: result.name,
                  imageUrl: result.image,
                  url: result.sourceUrl,
                  readyInMinutes: result.readyInMinutes,
                  vegetarian: result.vegetarian,
                  servings: result.servings,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RecipeExtractInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5 * Responsive.ratioHorizontal),
      child: TextField(
        keyboardType: TextInputType.url,
        style: TextStyle(color: ChowColors.white),
        onSubmitted: (url) => _submitForm(context, url),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
            // TODO: error handling if url is not recipe
            hintText: "Enter a recipe url here",
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ChowColors.white,
                width: 0.0,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            suffixIcon: Icon(
              Icons.search,
              color: ChowColors.white,
            ),
            hintStyle: TextStyle(
              color: ChowColors.white,
            )),
      ),
    );
  }

  void _submitForm(BuildContext context, String url) {
    // TODO: error handling with cubit
    final extractCubit = context.read<ExtractCubit>();
    extractCubit.fetchExtractedResult(url);
  }
}
