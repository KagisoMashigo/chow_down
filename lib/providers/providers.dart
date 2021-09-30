// /// all providers being used in the application
// final providers = <SingleChildWidget>[
//   ..._authProviders,
//   ..._functionalityProviders,
//   Provider<GoogleAnalytics>(
//     create: (_) => GoogleAnalytics(analytics),
//   ),
// ];

// /// All providers being used through user management, sign in and sign out
// final _authProviders = <SingleChildWidget>[
//   ChangeNotifierProvider<SignInProvider>(
//     create: (_) => SignInProvider(),
//   ),
//   ChangeNotifierProvider<ResetPasswordProvider>(
//     create: (_) => ResetPasswordProvider(),
//   ),
//   ChangeNotifierProvider<AuthProvider>(
//     create: (_) => AuthProvider(),
//   ),
//   ChangeNotifierProvider<ChangePasswordProvider>(
//     create: (_) => ChangePasswordProvider(),
//   )
// ];

// /// Providers that may or may not require an token, but provides functionality on the scope
// /// of the app domains
// final _functionalityProviders = <SingleChildWidget>[
//   ChangeNotifierProvider<PushNotificationProvider>(
//     create: (_) => PushNotificationProvider(),
//   ),
//   ChangeNotifierProvider<EventHistoryProvider>(
//     create: (_) => EventHistoryProvider(),
//   ),
//   ChangeNotifierProvider<HomeEventProvider>(
//     create: (_) => HomeEventProvider(),
//   ),
//   ChangeNotifierProvider<MotionProvider>(
//     create: (_) => MotionProvider(),
//   ),
//   ChangeNotifierProvider<SourceProvider>(
//     create: (_) => SourceProvider(),
//   ),

//   /// Provider managing thingsMeta
//   ChangeNotifierProvider<SourceMetaProvider>(
//       create: (_) => SourceMetaProvider()),
// ];
