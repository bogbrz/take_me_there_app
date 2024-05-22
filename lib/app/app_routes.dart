import 'package:auto_route/auto_route.dart';
import 'package:take_me_there_app/app/app_routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        // HomeScreen is generated as HomeRoute because
        // of the replaceInRouteName property

        AutoRoute(page: LoginPage.page, initial: true),
        AutoRoute(page: BottomNavPage.page, children: [
          AutoRoute(page: HistoryPage.page),
          AutoRoute(page: UserPage.page),
          AutoRoute(page: HomePage.page)
        ]),
      ];
}
