import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:take_me_there_app/bottom_nav_page.dart';
import 'package:take_me_there_app/features/pages/history_page.dart';
import 'package:take_me_there_app/features/pages/home_page.dart';
import 'package:take_me_there_app/features/pages/login_page/login_page.dart';
import 'package:take_me_there_app/features/pages/user_page/user_page.dart';

final User? user = FirebaseAuth.instance.currentUser;

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');
final GlobalKey<NavigatorState> _sectionBNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');
final GlobalKey<NavigatorState> _sectionCNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');
StatefulNavigationShell? globalNavigationShell;

class AppRouter {
  static GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    refreshListenable:
        GoRouterRefreshStream(FirebaseAuth.instance.authStateChanges()),
    redirectLimit: 3,
    redirect: (context, state) {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return "/loginPage";
      } else if (state.matchedLocation == '/loginPage') {
        return "/homePage";
      }
    },
    initialLocation: "/loginPage",
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (BuildContext context, GoRouterState state,
            StatefulNavigationShell navigationShell) {
          return BottomNavPage(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: _sectionANavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                  path: '/homePage',
                  builder: (BuildContext context, GoRouterState state) {
                    return HomePage();
                  }),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _sectionCNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/historPage',
                builder: (BuildContext context, GoRouterState state) =>
                    HistoryPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _sectionBNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                  path: '/userPage',
                  builder: (BuildContext context, GoRouterState state) {
                    return UserPage();
                  }),
            ],
          ),
        ],
      ),
      GoRoute(
        path: "/loginPage",
        name: "/loginPage",
        builder: (context, state) {
          return LoginPage();
        },
      ),
    ],
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }
  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
