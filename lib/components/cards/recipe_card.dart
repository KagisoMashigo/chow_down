import 'package:chow_down/components/cards/base_card.dart';
import 'package:chow_down/plugins/responsive.dart';
import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    Key key,
    this.id,
    @required this.name,
    @required this.imageUrl,
    this.imageType,
  }) : super(key: key);

  /// the Asset uri string
  final int id;

  final String name;

  final String imageUrl;

  final String imageType;

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    imageUrl,
                    width: 30,
                    fit: BoxFit.cover,
                  ),
                )),
          ),
          SizedBox(
            width: 100,
          ),
          Column(
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
                      fontSize: 30,
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
    );
  }
}
