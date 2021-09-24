import 'package:chow_down/components/buttons/form_submit_button.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
    );
  }

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
