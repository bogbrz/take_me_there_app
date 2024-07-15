import 'package:flutter/material.dart';
import "package:flutter_hooks/flutter_hooks.dart";
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:take_me_there_app/features/pages/home_page/home_controller.dart';
import 'package:take_me_there_app/providers/is_writing_provider.dart';

class BottomNavPage extends HookConsumerWidget {
  const BottomNavPage({Key? key, required this.navigationShell})
      : super(key: key ?? const ValueKey<String>("NavigatorPage"));
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = useState(0);
    final isWriting = ref.watch(isWritingProvider);

    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
        floatingActionButton: isWriting
            ? SizedBox.shrink()
            : Builder(builder: (context) {
                return FloatingActionButton(
                  backgroundColor: const Color.fromARGB(69, 158, 158, 158),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Icon(
                    Icons.menu_outlined,
                    color: Colors.white,
                  ),
                );
              }),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(child: Text("")),

              ListTile(
                title: Text(
                  "Home",
                ),
                selected: index.value == 0,
                onTap: () {
                  index.value = 0;
                  _onTap(context, index.value);
                },
              ),
              // Container(
              //   child: Row(
              //     children: [
              //       Icon(
              //         Icons.home,
              //         size: 60,
              //       ),

              //     ],
              //   ),
              // ),
              ListTile(
                title: Text(
                  "History",
                ),
                onTap: () {
                  index.value = 1;
                  _onTap(context, index.value);
                },
              ),
              ListTile(
                title: Text(
                  "Profile",
                ),
                onTap: () {
                  index.value = 2;
                  _onTap(context, index.value);
                },
              ),
            ],
          ),
        ),
        body: navigationShell,
        // bottomNavigationBar: BottomNavigationBar(
        //     onTap: (newIndex) {
        //       index.value = newIndex;
        //       _onTap(context, newIndex);
        //     },
        //     currentIndex: index.value,
        //     items: <BottomNavigationBarItem>[
        //       BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.receipt), label: "History"),
        //       BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        //     ]),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
