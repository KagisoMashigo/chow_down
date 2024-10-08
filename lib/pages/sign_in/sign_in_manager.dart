// 🎯 Dart imports:
import 'dart:async';

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';

// 📦 Package imports:
import 'package:firebase_auth/firebase_auth.dart';

// 🌎 Project imports:
import 'package:chow_down/services/auth.dart';

class SignInManager {
  SignInManager({
    required this.auth,
    required this.isLoading,
  });

  final AuthBase auth;
  final ValueNotifier<bool> isLoading;

  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      isLoading.value = true;
      return await signInMethod();
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<User> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);
  Future<User> signInAnonymously() async =>
      await _signIn(auth.signInAnonymously);
}
