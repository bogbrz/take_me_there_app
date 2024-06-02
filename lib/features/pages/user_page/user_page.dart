import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:take_me_there_app/features/pages/login_page/login_controller.dart';
import 'package:take_me_there_app/features/pages/user_page/user_contoller.dart';

class UserPage extends HookConsumerWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userControllerProvider.notifier).getUser();
    print(user);
    return Scaffold(
        body: ListView(
      children: [
        CircleAvatar(),
        
        IconButton(
            onPressed: () {
              ref.read(loginControllerProvider.notifier).signOut();
            },
            icon: Icon(Icons.logout))
      ],
    ));
  }
}
