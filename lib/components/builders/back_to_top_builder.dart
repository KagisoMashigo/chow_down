import 'package:chow_down/components/design/color.dart';
import 'package:flutter/material.dart';

class ChowBackToTopTransitionBuilder extends StatelessWidget {
  final Widget desitnation;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  const ChowBackToTopTransitionBuilder({
    super.key,
    required this.desitnation,
    this.icon = Icons.arrow_upward_outlined,
    this.iconColor = ChowColors.black,
    this.backgroundColor = ChowColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => desitnation,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return FadeTransition(
              opacity: animation.drive(tween),
              child: child,
            );
          },
        ),
      ),
      child: Icon(
        icon,
        color: iconColor,
      ),
      backgroundColor: backgroundColor,
    );
  }
}
