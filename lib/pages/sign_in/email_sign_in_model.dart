import 'package:time_tracker_flutter_course/pages/sign_in/validators.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInModel with EmailAndPasswordValidators {
  EmailSignInModel({
    this.password = '',
    this.email = '',
    this.isLoading = false,
    this.submitted = false,
    this.formType = EmailSignInFormType.signIn,
  });
  final String password;
  final String email;
  final bool isLoading;
  final bool submitted;
  final EmailSignInFormType formType;

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

  String get passwordErrorText {
    bool showErrorText = submitted && !passwordValidator.isValid(password);
    return showErrorText ? invalidPasswordErrorText : null;
  }

  String get emailErrorText {
    bool showErrorText = submitted && !emailValidator.isValid(email);
    return showErrorText ? invalidEmailErrorText : null;
  }

  EmailSignInModel copyWith({
    final String password,
    final String email,
    final bool isLoading,
    final bool submitted,
    final EmailSignInFormType formType,
  }) {
    return EmailSignInModel(
      email: email ?? this.email,
      password: password ?? this.password,
      submitted: submitted ?? this.submitted,
      isLoading: isLoading ?? this.isLoading,
      formType: formType ?? this.formType,
    );
  }
}
