// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/cupertino.dart' as _i8;
import 'package:flutter/material.dart' as _i9;
import 'package:take_me_there_app/app/auth_checker.dart' as _i1;
import 'package:take_me_there_app/bottom_nav_page.dart' as _i2;
import 'package:take_me_there_app/features/pages/history_page.dart' as _i3;
import 'package:take_me_there_app/features/pages/home_page.dart' as _i4;
import 'package:take_me_there_app/features/pages/login_page/login_page.dart'
    as _i5;
import 'package:take_me_there_app/features/pages/user_page/user_page.dart'
    as _i6;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    AuthChecker.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthChecker(),
      );
    },
    BottomNavPage.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.BottomNavPage(),
      );
    },
    HistoryPage.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HistoryPage(),
      );
    },
    HomePage.name: (routeData) {
      final args =
          routeData.argsAs<HomePageArgs>(orElse: () => const HomePageArgs());
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.HomePage(key: args.key),
      );
    },
    LoginPage.name: (routeData) {
      final args =
          routeData.argsAs<LoginPageArgs>(orElse: () => const LoginPageArgs());
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.LoginPage(key: args.key),
      );
    },
    UserPage.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.UserPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthChecker]
class AuthChecker extends _i7.PageRouteInfo<void> {
  const AuthChecker({List<_i7.PageRouteInfo>? children})
      : super(
          AuthChecker.name,
          initialChildren: children,
        );

  static const String name = 'AuthChecker';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i2.BottomNavPage]
class BottomNavPage extends _i7.PageRouteInfo<void> {
  const BottomNavPage({List<_i7.PageRouteInfo>? children})
      : super(
          BottomNavPage.name,
          initialChildren: children,
        );

  static const String name = 'BottomNavPage';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HistoryPage]
class HistoryPage extends _i7.PageRouteInfo<void> {
  const HistoryPage({List<_i7.PageRouteInfo>? children})
      : super(
          HistoryPage.name,
          initialChildren: children,
        );

  static const String name = 'HistoryPage';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i4.HomePage]
class HomePage extends _i7.PageRouteInfo<HomePageArgs> {
  HomePage({
    _i8.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          HomePage.name,
          args: HomePageArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'HomePage';

  static const _i7.PageInfo<HomePageArgs> page =
      _i7.PageInfo<HomePageArgs>(name);
}

class HomePageArgs {
  const HomePageArgs({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return 'HomePageArgs{key: $key}';
  }
}

/// generated route for
/// [_i5.LoginPage]
class LoginPage extends _i7.PageRouteInfo<LoginPageArgs> {
  LoginPage({
    _i9.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          LoginPage.name,
          args: LoginPageArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LoginPage';

  static const _i7.PageInfo<LoginPageArgs> page =
      _i7.PageInfo<LoginPageArgs>(name);
}

class LoginPageArgs {
  const LoginPageArgs({this.key});

  final _i9.Key? key;

  @override
  String toString() {
    return 'LoginPageArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.UserPage]
class UserPage extends _i7.PageRouteInfo<void> {
  const UserPage({List<_i7.PageRouteInfo>? children})
      : super(
          UserPage.name,
          initialChildren: children,
        );

  static const String name = 'UserPage';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}
