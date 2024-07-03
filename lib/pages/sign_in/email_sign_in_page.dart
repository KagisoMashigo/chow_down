// 🐦 Flutter imports:
import 'package:chow_down/components/design/chow.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';

// 🌎 Project imports:
import 'package:chow_down/pages/sign_in/email_sign_in_form_change_notifier.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  'https://images.unsplash.com/photo-1623595119708-26b1f7300075?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2566&q=80',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                foregroundColor: ChowColors.white,
                backgroundColor: Colors.transparent,
              ),
              body: Column(
                children: [
                  SizedBox(height: Spacing.xlg),
                  Padding(
                    padding: EdgeInsets.all(Spacing.sm),
                    child: Card(
                      color: Colors.transparent,
                      child: EmailSignInFormChangeNotifier.create(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
