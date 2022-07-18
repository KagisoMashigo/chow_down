// 🐦 Flutter imports:
import 'package:chow_down/components/design/chow.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/components/design/responsive.dart';

class HelpCard extends StatelessWidget {
  const HelpCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5 * Responsive.ratioHorizontal),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ExpansionTile(
          collapsedIconColor: ChowColors.white,
          collapsedTextColor: ChowColors.white,
          backgroundColor: Colors.white,
          leading: Icon(Icons.quiz),
          title: Container(
            child: Padding(
              padding: EdgeInsets.all(2 * Responsive.ratioHorizontal),
              child: Text(
                'So how does it all work?',
                style: TextStyle(
                  fontSize: 4 * Responsive.ratioHorizontal,
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
                padding: EdgeInsets.all(2 * Responsive.ratioHorizontal),
                child: Text(
                  'In the text area abouve you can paste a URL from a recipe on the web and we will format it for easy use later on.',
                  style: TextStyle(
                    fontSize: 4 * Responsive.ratioHorizontal,
                    color: ChowColors.black,
                  ),
                ),
              ),
              iconColor: ChowColors.black,
            ),

            /// The below could be useful
            // ListView.separated(
            //   itemCount: 3,
            //   shrinkWrap: true,
            //   physics: BouncingScrollPhysics(),
            //   separatorBuilder: (BuildContext context, int index) =>
            //       verticalDivider(factor: 1),
            //   itemBuilder: (BuildContext context, int index) {
            //     int item = index + 1;
            //     return ListTile(
            //       // dense: true,
            //       horizontalTitleGap: 0,
            //       leading:
            //           item == 3 ? Icon(Icons.report_problem) : Icon(Icons.help),
            //       title: Container(
            //         child: Text(
            //           'Text',
            //         ),
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
