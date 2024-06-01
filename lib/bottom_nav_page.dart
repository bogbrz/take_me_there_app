import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import "package:flutter_hooks/flutter_hooks.dart";

class BottomNavPage extends HookConsumerWidget {
  const BottomNavPage({Key? key, required this.navigationShell})
      : super(key: key ?? const ValueKey<String>("NavigatorPage"));
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = useState(0);
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
          onTap: (newIndex) {
            index.value = newIndex;
            _onTap(context, newIndex);
          },
          currentIndex: index.value,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.receipt), label: "History"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ]),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
