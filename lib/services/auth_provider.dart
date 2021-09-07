// import 'package:flutter/cupertino.dart';
// import 'package:chow_down/services/auth.dart';
//
// class AuthProvider extends InheritedWidget {
//   AuthProvider({@required this.auth, @required this.child});
//   final Widget child;
//   final AuthBase auth;
//
//   @override
//   bool updateShouldNotify(covariant InheritedWidget oldWidget) {
//     // TODO: implement updateShouldNotify
//     throw UnimplementedError();
//   }
//   // final auth = AuthProvider.of(context);
//   static AuthBase of(BuildContext context) {
//     AuthProvider provider = context.dependOnInheritedWidgetOfExactType<AuthProvider>();
//     return provider.auth;
//   }
// }