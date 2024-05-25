// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/cupertino.dart' as _i7;
import 'package:take_me_there_app/bottom_nav_page.dart' as _i1;
import 'package:take_me_there_app/features/pages/history_page.dart' as _i2;
import 'package:take_me_there_app/features/pages/home_page.dart' as _i3;
import 'package:take_me_there_app/features/pages/login_page.dart' as _i4;
import 'package:take_me_there_app/features/pages/user_page/user_page.dart'
    as _i5;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    BottomNavPage.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.BottomNavPage(),
      );
    },
    HistoryPage.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HistoryPage(),
      );
    },
    HomePage.name: (routeData) {
      final args =
          routeData.argsAs<HomePageArgs>(orElse: () => const HomePageArgs());
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.HomePage(key: args.key),
      );
    },
    LoginPage.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.LoginPage(),
      );
    },
    UserPage.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.UserPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.BottomNavPage]
class BottomNavPage extends _i6.PageRouteInfo<void> {
  const BottomNavPage({List<_i6.PageRouteInfo>? children})
      : super(
          BottomNavPage.name,
          initialChildren: children,
        );

  static const String name = 'BottomNavPage';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HistoryPage]
class HistoryPage extends _i6.PageRouteInfo<void> {
  const HistoryPage({List<_i6.PageRouteInfo>? children})
      : super(
          HistoryPage.name,
          initialChildren: children,
        );

  static const String name = 'HistoryPage';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HomePage]
class HomePage extends _i6.PageRouteInfo<HomePageArgs> {
  HomePage({
    _i7.Key? key,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          HomePage.name,
          args: HomePageArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'HomePage';

  static const _i6.PageInfo<HomePageArgs> page =
      _i6.PageInfo<HomePageArgs>(name);
}

class HomePageArgs {
  const HomePageArgs({this.key});

  final _i7.Key? key;

  @override
  String toString() {
    return 'HomePageArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.LoginPage]
class LoginPage extends _i6.PageRouteInfo<void> {
  const LoginPage({List<_i6.PageRouteInfo>? children})
      : super(
          LoginPage.name,
          initialChildren: children,
        );

  static const String name = 'LoginPage';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.UserPage]
class UserPage extends _i6.PageRouteInfo<void> {
  const UserPage({List<_i6.PageRouteInfo>? children})
      : super(
          UserPage.name,
          initialChildren: children,
        );

  static const String name = 'UserPage';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}
