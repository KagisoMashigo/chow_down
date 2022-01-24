// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/plugins/responsive.dart';

class CustomLogoAppBar extends StatelessWidget {
  const CustomLogoAppBar({
    Key key,
    this.imgUrl,
    @required this.title,
    @required this.body,
    this.bottomNav,
  }) : super(key: key);

  final String imgUrl;

  final String title;

  final Widget body;

  final Widget bottomNav;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            horizontalDivider(factor: 2),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 5 * Responsive.ratioHorizontal,
                ),
              ),
            ),
            Image.asset(
              imgUrl,
              height: 10 * Responsive.ratioHorizontal,
              width: 10 * Responsive.ratioHorizontal,
              fit: BoxFit.cover,
            ),
            horizontalDivider(factor: 2.5),
          ],
        ),
      ),
      body: body,
      bottomNavigationBar: bottomNav,
    );
  }
}
