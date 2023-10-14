// 🎯 Dart imports:
import 'dart:async';

// 🌎 Project imports:
import 'package:chow_down/models/page/email_sign_in_model.dart';
import 'package:chow_down/services/auth.dart';

class EmailSignInBloc {
  EmailSignInBloc({required this.auth});
  final AuthBase auth;

  final StreamController<EmailSignInModel> _modelController =
      StreamController<EmailSignInModel>();
  Stream<EmailSignInModel> get modelStream => _modelController.stream;
  EmailSignInModel _model = EmailSignInModel();

  void dispose() {
    _modelController.close();
  }

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      if (_model.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
      } else {
        await auth.createUserWithEmailAndPassword(
            _model.email, _model.password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  void toggleFormType() {
    final formType = _model.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;
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
    final String? password,
    final String? email,
    final bool? isLoading,
    final bool? submitted,
    final EmailSignInFormType? formType,
  }) {
    // update model
    _model = _model.copyWith(
      email: email!,
      password: password!,
      submitted: submitted!,
      isLoading: isLoading!,
      formType: formType!,
    );
    // add updated model to _modelController
    _modelController.add(_model);
  }
}
