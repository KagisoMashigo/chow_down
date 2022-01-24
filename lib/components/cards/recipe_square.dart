// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/components/cards/base_card.dart';
import 'package:chow_down/plugins/responsive.dart';

class RecipeSquare extends StatelessWidget {
  const RecipeSquare({
    Key key,
    this.id,
    @required this.name,
    @required this.imageUrl,
    this.imageType,
  }) : super(key: key);

  /// Recipe id
  final int id;

  /// Recipe name
  final String name;

  /// Recipe url
  final String imageUrl;

  final String imageType;

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  name.toString(),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  textScaleFactor: 1,
                  style: TextStyle(
                      fontSize: 4 * Responsive.ratioHorizontal,
                      // fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ],
          ),
          horizontalDivider(factor: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    imageUrl,
                    width: 35 * Responsive.ratioHorizontal,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              horizontalDivider(factor: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Placeholder: Rating'),
                  verticalDivider(factor: 3),
                  Text('Placeholder: Relevant info'),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
