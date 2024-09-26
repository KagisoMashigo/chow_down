// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/components/design/chow.dart';

class HelpCard extends StatelessWidget {
  const HelpCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.sm),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ExpansionTile(
          collapsedIconColor: ChowColors.white,
          collapsedTextColor: ChowColors.white,
          backgroundColor: Colors.white,
          leading: Icon(Icons.quiz),
          title: Container(
            child: Padding(
              padding: EdgeInsets.all(Spacing.sm),
              child: Text(
                'So how does it all work?',
                style: TextStyle(
                  fontSize: ChowFontSizes.sm,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          children: [
            ListTile(
              leading: Icon(
                Icons.info_rounded,
              ),
              title: Padding(
                padding: EdgeInsets.all(Spacing.sm),
                child: Text(
                  'In the text area above you can paste a URL from a recipe on the web and we will format it for easy use later on.',
                  style: TextStyle(
                    fontSize: ChowFontSizes.sm,
                    color: ChowColors.black,
                  ),
                ),
              ),
              iconColor: ChowColors.black,
            ),
          ],
        ),
      ),
    );
  }
}
