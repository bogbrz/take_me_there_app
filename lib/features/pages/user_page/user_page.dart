import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:take_me_there_app/domain/models/user_model.dart';
import 'package:take_me_there_app/features/pages/login_page/login_controller.dart';
import 'package:take_me_there_app/features/pages/user_page/user_contoller.dart';

class UserPage extends HookConsumerWidget {
  UserPage({super.key});

  final userControllerProvider =
      AsyncNotifierProvider.autoDispose<UserTest, UserModel>(UserTest.new);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userControllerProvider);

    return Scaffold(
        body: ListView(
      children: [
        CircleAvatar(),
        Text(user.value!.email),
        Text(
          user.value!.username,
        ),
        Text(
          user.value!.pictureUrl,
        ),
        IconButton(
            onPressed: () {
              ref.read(loginControllerProvider.notifier).signOut();
            },
            icon: Icon(Icons.logout))
      ],
    ));
  }
}
