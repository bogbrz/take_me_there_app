// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:take_me_there_app/bottom_nav_page.dart';
// import 'package:take_me_there_app/features/pages/login_page/login_page.dart';
// import 'package:take_me_there_app/providers/auth_provider.dart';


// class AuthChecker extends ConsumerWidget {
//   const AuthChecker({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final _authState = ref.watch(authStateProvider);
//     return _authState.when(data: (user) {
//       if (user != null) {
//         return const BottomNavPage();
//       } else {
//         return LoginPage();
//       }
//     }, error: (e, trace) {
//       return LoginPage();
//     }, loading: () {
//       return SplashScreen();
//     });
//   }
// }

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }
