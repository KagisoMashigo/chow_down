// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/models/page/email_sign_in_model.dart';
import 'package:chow_down/pages/sign_in/validators.dart';
import 'package:chow_down/services/auth.dart';

class EmailSignInChangeModel with EmailAndPasswordValidators, ChangeNotifier {
  EmailSignInChangeModel({
    @required this.auth,
    this.password = '',
    this.email = '',
    this.isLoading = false,
    this.submitted = false,
    this.formType = EmailSignInFormType.signIn,
  });
  final AuthBase auth;
  String password;
  String email;
  bool isLoading;
  bool submitted;
  EmailSignInFormType formType;
  bool passwordForgotten = true;
  bool alertText = false;

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      if (this.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(this.email, this.password);
      } else {
        await auth.createUserWithEmailAndPassword(this.email, this.password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  Future<String> resetPassword() async {
    updateWith(submitted: true, isLoading: true);
    try {
      // print('${this.email} is');
      await auth.sendPasswordResetEmail(this.email);
      alertText = true;
      // print('reset');
      return this.email;
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  String get primaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';
  }

  String get secondaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';
  }

  bool get canSubmit {
    return emailValidator.isValid(email) &&
        passwordValidator.isValid(password) &&
        !isLoading;
  }

  bool get canReset {
    return emailValidator.isValid(email) && !isLoading;
  }

  String get passwordErrorText {
    bool showErrorText = submitted && !passwordValidator.isValid(password);
    return showErrorText ? invalidPasswordErrorText : null;
  }

  String get emailErrorText {
    bool showErrorText = submitted && !emailValidator.isValid(email);
    return showErrorText ? invalidEmailErrorText : null;
  }

  void toggleFormType() {
    if (this.formType == EmailSignInFormType.signIn) {
      formType = EmailSignInFormType.register;
      passwordForgotten = false;
    } else {
      formType = EmailSignInFormType.signIn;
      passwordForgotten = true;
    }
    updateWith(
      email: '',
      password: '',
      formType: formType,
      isLoading: false,
      submitted: false,
    );
  }

  void updateEmail(String email) => updateWith(email: email);

  void updatePassword(String password) => updateWith(password: password);

  void updateWith({
    String password,
    String email,
    bool isLoading,
    bool submitted,
    EmailSignInFormType formType,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.submitted = submitted ?? this.submitted;
    this.isLoading = isLoading ?? this.isLoading;
    this.formType = formType ?? this.formType;
    notifyListeners();
  }
}
