import 'package:chow_down/components/cards/base_card.dart';
import 'package:chow_down/plugins/responsive.dart';
import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    Key key,
    this.id,
    this.title,
    this.imageUrl,
    this.imageType,
  }) : super(key: key);

  /// the Asset uri string
  final int id;

  final String title;

  final String imageUrl;

  final String imageType;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BaseCard(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Image.asset(
                imageUrl,
              ),
            ),
            horizontalDivider(factor: 4),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    title.toString(),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textScaleFactor: 1,
                    style: TextStyle(
                        fontSize: 2 * Responsive.ratioVertical,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple),
                  ),
                ),
                // Container(
                //   child: Text(
                //     eventText,
                //     softWrap: true,
                //     overflow: TextOverflow.ellipsis,
                //     textScaleFactor: 1,
                //     style: TextStyle(
                //       fontSize: 2 * Responsive.ratioVertical,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                // Flexible(
                //   flex: 2,
                //   child: Text(
                //     descriptionText,
                //     overflow: TextOverflow.ellipsis,
                //     textScaleFactor: 1,
                //     style: TextStyle(
                //       fontSize: 2 * Responsive.ratioVertical,
                //       fontWeight: FontWeight.w200,
                //       color: Colors.grey,
                //     ),
                //   ),
                // ),
              ],
            ),
            SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
