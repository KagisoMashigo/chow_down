// 📦 Package imports:
import 'package:chow_down/plugins/debugHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

abstract class AuthBase {
  User get currentUser;
  Stream<User?> authStateChanges();
  Future<User> signInWithGoogle();
  Future<User> signInAnonymously();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> createUserWithEmailAndPassword(String email, String password);
  Future<void> sendPasswordResetEmail(String email);
  Future<void> signOut();
  Future<void> deleteUser();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  User get currentUser => _firebaseAuth.currentUser!;

  @override
  Future<User> signInAnonymously() async {
    try {
      printDebug('Attempting to sign in anonymously...');
      final userCredentials = await _firebaseAuth.signInAnonymously();
      printDebug(
        'Anonymous sign-in successful: ${userCredentials.user!.uid}',
        colour: DebugColour.green,
      );
      return userCredentials.user!;
    } catch (e, stack) {
      printAndLog(e, 'Anonymous sign-in failed, reason: $stack');
      rethrow;
    }
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      printDebug('Attempting to sign in with email: $email');
      final userCredentials = await _firebaseAuth.signInWithCredential(
          EmailAuthProvider.credential(email: email, password: password));
      printDebug('Email sign-in successful: ${userCredentials.user!.uid}');
      return userCredentials.user!;
    } catch (e, stack) {
      printAndLog(e, 'Email sign-in failed: $stack');
      rethrow;
    }
  }

  @override
  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      printDebug('Attempting to create user with email: $email');
      final userCredentials = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      printDebug('User creation successful: ${userCredentials.user!.uid}');
      return userCredentials.user!;
    } catch (e, stack) {
      printAndLog(e, 'User creation failed: $stack');
      rethrow;
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      printDebug('Attempting to send password reset email to: $email');
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      printDebug('Password reset email sent to: $email');
    } catch (e, stack) {
      printAndLog(e, 'Password reset email failed: $stack');
      rethrow;
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    try {
      printDebug('Attempting to sign in with Google...');
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;
        if (googleAuth.idToken != null) {
          final userCredential = await _firebaseAuth
              .signInWithCredential(GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ));
          printDebug('Google sign-in successful: ${userCredential.user!.uid}');
          return userCredential.user!;
        } else {
          throw FirebaseAuthException(
            message: 'Missing Google ID Token',
            code: 'ERROR_MISSING_TOKEN',
          );
        }
      } else {
        throw FirebaseAuthException(
          message: 'Sign in aborted by user',
          code: 'ERROR_USER',
        );
      }
    } catch (e, stack) {
      printAndLog(e, 'Google sign-in failed: $stack');
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      printDebug('Attempting to sign out...');
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      await _firebaseAuth.signOut();
      printDebug('Sign-out successful');
    } catch (e, stack) {
      printAndLog(e, 'Sign out failed: $stack');
      rethrow;
    }
  }

  @override
  Future<void> deleteUser() async {
    try {
      printDebug(
          'Attempting to delete user: ${_firebaseAuth.currentUser?.uid}');
      await _firebaseAuth.currentUser?.delete();
      printDebug('User deletion successful: ${_firebaseAuth.currentUser?.uid}');
    } catch (e, stack) {
      printAndLog(e, 'User deletion failed: $stack');
      rethrow;
    }
  }
}
