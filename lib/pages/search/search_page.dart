import 'package:chow_down/components/buttons/form_submit_button.dart';
import 'package:chow_down/components/cards/recipe_card.dart';
import 'package:chow_down/domain/models/recipe/recipe_model.dart';
import 'package:chow_down/providers/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchProvider provider;

  @override
  void initState() {
    provider = Provider.of<SearchProvider>(context, listen: false);
    super.initState();
    provider.getRecipeResults();
  }

  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 150),
            _buildEmailTextField(),
            SizedBox(height: 8.0),
            FormSubmitButton(
              text: 'Search',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

//TODO: create recipeCard model
  Widget _createCard(Recipe recipe) {
    final title = recipe.title;
    final image = recipe.image;
    final id = recipe.id;
    final imageType = recipe.imageType;

    return RecipeCard(
      title: title,
      imageUrl: image,
      id: id,
      imageType: imageType,
    );
  }

  //   List<Widget> _renderEventList() {
  //   final filteredEvents = events
  //       .where((e) => e.type != MotionType.stopped)
  //       .toSet()
  //       .map<Widget>((eventData) => _createCard(eventData))
  //       .toList();

  //   return filteredEvents;
  // }

  TextField _buildEmailTextField() {
    return TextField(
      // TODO: style the form and card
      // style: TextStyle(color: Colors.white),
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
          // labelText: 'Email',
          ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      // onChanged: model.updateEmail,
    );
  }
}

class Search extends StatelessWidget {
  const Search({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(),
    );
  }
}
