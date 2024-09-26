// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:chow_down/components/design/color.dart';
import 'package:chow_down/components/design/responsive.dart';
import 'package:chow_down/components/design/typography.dart';
import 'package:chow_down/pages/landing_page.dart';
import 'package:chow_down/services/auth.dart';

// 🌎 Project imports:


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            Responsive.init(constraints, orientation);
            SystemChrome.setPreferredOrientations(
              [
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown,
              ],
            );
            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
                systemNavigationBarColor: Colors.white,
                systemNavigationBarIconBrightness: Brightness.dark,
              ),
            );
            return ChowDown();
          },
        );
      },
    );
  }
}

class ChowDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        color: ChowColors.black,
        title: 'Chow Down',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          fontFamily: ChowFontFamilies.primary,
        ),
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
        ],
        home: LandingPage(),
      ),
    );
  }
}
