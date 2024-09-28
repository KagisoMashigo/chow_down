// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChowAnnotatedRegion extends StatelessWidget {
  const ChowAnnotatedRegion({
    super.key,
    required this.child,
    this.isDark = false,
  });

  final Widget child;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final systemOverlayStyle =
        isDark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemOverlayStyle.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarIconBrightness:
            isDark ? Brightness.dark : Brightness.light,
      ),
      child: child,
    );
  }
}
