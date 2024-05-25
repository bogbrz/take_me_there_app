import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:take_me_there_app/app/app_routes.gr.dart';

@RoutePage()
class BottomNavPage extends StatelessWidget {
  const BottomNavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: [
        HomePage(),
        HistoryPage(),
        UserPage(),
      ],
      builder: (context, child) {
        final _tabRouterIndex = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: _tabRouterIndex.activeIndex,
              onTap: (value) {
                _tabRouterIndex.setActiveIndex(value);
              },
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.receipt), label: "History"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Profile"),
              ]),
        );
      },
    );
  }
}
