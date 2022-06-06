// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:chow_down/components/design/responsive.dart';
import 'package:chow_down/components/design/typography.dart';
import 'package:chow_down/pages/landing_page.dart';
import 'package:chow_down/providers/providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");

  runApp(
    MultiProvider(
      providers: providers,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              Responsive().init(constraints, orientation);
              return ChowDown();
            },
          );
        },
      ),
    ),
  );
}

// Main app call
// TODO: Consider using cachedImage for network images
class ChowDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chow Down',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        fontFamily: ChowFontFamilies.primary,
      ),
      // TODO: make sure logged in goes to home
      home: LandingPage(),
    );
  }
}
