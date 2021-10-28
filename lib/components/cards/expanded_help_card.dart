import 'package:chow_down/plugins/responsive.dart';
import 'package:flutter/material.dart';

class HelpCard extends StatelessWidget {
  const HelpCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedIconColor: Theme.of(context).primaryColor,
      backgroundColor: Colors.white,
      leading: Icon(Icons.quiz),
      title: Container(
        child: Text(
          'Text',
        ),
      ),
      tilePadding: EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 2.5 * Responsive.ratioHorizontal,
      ),
      children: [
        ListView.separated(
          itemCount: 3,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          separatorBuilder: (BuildContext context, int index) =>
              verticalDivider(),
          itemBuilder: (BuildContext context, int index) {
            int item = index + 1;
            return ListTile(
              dense: true,
              horizontalTitleGap: 0,
              leading:
                  item == 3 ? Icon(Icons.report_problem) : Icon(Icons.help),
              title: Container(
                child: Text(
                  'Text',
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
