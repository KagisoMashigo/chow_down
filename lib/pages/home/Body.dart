// 🐦 Flutter imports:
import 'package:chow_down/components/cards/recipe_card.dart';
import 'package:chow_down/core/models/spoonacular/search_result_model.dart';
import 'package:chow_down/cubit/home_page/extract_cubit.dart';
import 'package:chow_down/pages/recipes/extracted_info_page.dart';
import 'package:chow_down/pages/recipes/recipe_info_page.dart';
import 'package:chow_down/plugins/responsive.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // title: Text('What are we eating?'),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1528458876861-544fd1761a91?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1388&q=80'),
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
      padding: EdgeInsets.only(top: 12 * Responsive.ratioVertical),
      child: Column(
        children: [
          Image.asset(
            // TODO: Can make a better logo / reconsider padding or text size
            'assets/images/chow_down.png',
            height: 200,
            width: 200,
            fit: BoxFit.fill,
          ),
          verticalDivider(factor: 5),
          RecipeExtractInput()
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildColumnWithData(RecipeCardInfo searchResult) {
    final result = searchResult;
    print('RESULT: ${result.sourceUrl}');
    return Container(
      child: Padding(
        padding: EdgeInsets.only(
            top: 12 * Responsive.ratioVertical,
            left: 2 * Responsive.ratioVertical,
            right: 2 * Responsive.ratioVertical),
        child: Column(children: [
          Image.asset(
            // TODO: Can make a better logo / reconsider padding or text size
            'assets/images/chow_down.png',
            height: 200,
            width: 200,
            fit: BoxFit.fill,
          ),
          verticalDivider(factor: 2),
          RecipeExtractInput(),
          verticalDivider(),
          GestureDetector(
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
            ),
          )
        ]),
      ),
    );
  }
}

class RecipeExtractInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        style: TextStyle(color: Colors.white),
        onSubmitted: (query) => _submitForm(context, query),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
            hintText: "Enter a url",
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 0.0),
              borderRadius: BorderRadius.circular(12),
            ),
            suffixIcon: Icon(Icons.search),
            labelStyle: TextStyle(color: Colors.white),
            hintStyle: TextStyle(color: Colors.white)),
      ),
    );
  }

  void _submitForm(BuildContext context, String url) {
    final extractCubit = context.read<ExtractCubit>();
    extractCubit.fetchExtractedResult(url);
  }
}
