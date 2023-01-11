// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members

// 📦 Package imports:
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCTlynKJl8RZGQamwiQ84twWTVIMsCvuzM',
    appId: '1:873973766406:android:41b497e9e23d69be8ea687',
    messagingSenderId: '873973766406',
    projectId: 'chow-down-d9b94',
    storageBucket: 'chow-down-d9b94.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAk3O0vtQHVAf-PiVWaHdNIrv-36yzo7qA',
    appId: '1:873973766406:ios:5f0ea1eb42740ff98ea687',
    messagingSenderId: '873973766406',
    projectId: 'chow-down-d9b94',
    storageBucket: 'chow-down-d9b94.appspot.com',
    androidClientId: '873973766406-84l9knq5ro99obl2g6io8n4q6bc9iae7.apps.googleusercontent.com',
    iosClientId: '873973766406-7incvrooh783efo0h4fkdkhfjpe2q552.apps.googleusercontent.com',
    iosBundleId: 'com.codewithkakes.chowDown',
  );
}
