import 'package:chow_down/plugins/responsive.dart';
import 'package:chow_down/providers/providers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chow_down/pages/landing_page.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        appBarTheme:
            AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.light),
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Lato',
      ),
      // TODO: make sure logged in goes to home
      home: LandingPage(),
    );
  }
}
