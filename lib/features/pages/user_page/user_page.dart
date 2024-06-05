import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:take_me_there_app/domain/models/user_model.dart';
import 'package:take_me_there_app/features/pages/login_page/login_controller.dart';
import 'package:take_me_there_app/features/pages/user_page/user_contoller.dart';
import 'package:take_me_there_app/providers/auth_provider.dart';

class UserPage extends HookConsumerWidget {
  UserPage({super.key});

  final userControllerProvider =
      AsyncNotifierProvider<UserTest, UserModel>(UserTest.new);

  final userStreamProvider =
      StreamProvider((ref) => ref.watch(authDataSourceProvider).getUserById());
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userControllerProvider);
    final streamUser = ref.watch(userStreamProvider);

    print(FirebaseAuth.instance.currentUser);

    return Scaffold(
        body: ListView(
      children: [
        for (final userStream in streamUser.value!) ...[
          Text(
              '''${userStream.username}\n ${userStream.email} \n ${userStream.phoneNumber}''')
        ],
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
