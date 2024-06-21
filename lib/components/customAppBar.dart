// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/components/design/responsive.dart';
import 'package:chow_down/components/design/spacing.dart';

class CustomLogoAppBar extends StatelessWidget {
  const CustomLogoAppBar({
    Key? key,
    this.imgUrl,
    required this.title,
    required this.body,
    this.bottomNav,
    this.color,
  }) : super(key: key);

  final String? imgUrl;

  final String title;

  final Widget body;

  final Widget? bottomNav;

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: color ?? Color.fromARGB(236, 246, 243, 243),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: Spacing.sm),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 5 * Responsive.ratioHorizontal,
                ),
              ),
            ),
            Image.asset(
              imgUrl!,
              height: 10 * Responsive.ratioHorizontal,
              width: 10 * Responsive.ratioHorizontal,
              fit: BoxFit.cover,
            ),
            SizedBox(width: Spacing.sm),
          ],
        ),
      ),
      body: body,
      bottomNavigationBar: bottomNav,
    );
  }
}
