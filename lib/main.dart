import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:chow_down/pages/landing_page.dart';
import 'package:chow_down/services/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChowDown());
}

// Main app call
// TODO: Consider using cachedImage for network images
class ChowDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'Chow Down',
        theme: ThemeData(
          appBarTheme:
              AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.light),
          primarySwatch: Colors.deepPurple,
          fontFamily: 'Lato',
        ),
        home: LandingPage(),
      ),
    );
  }
}
