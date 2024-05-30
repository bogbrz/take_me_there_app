import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:take_me_there_app/features/pages/user_page/user.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

final userProvider = NotifierProvider<UserProfile, User>(UserProfile.new);

@RoutePage()
class UserPage extends HookConsumerWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newNameController = useTextEditingController();
    final user = ref.watch(userProvider);
    return ProviderScope(
      child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.logout_outlined))
            ],
          ),
          body: ListView(
            children: [
              CircleAvatar(),
              Center(
                child: Text("${user.name} ${user.surname}"),
              ),
              Center(
                child: Text("${user.email}"),
              ),
              Center(
                child: Text("${user.isVerifed}"),
              ),
              Center(
                child: TextField(
                  controller: newNameController,
                  decoration: InputDecoration(labelText: "New Name"),
                  onSubmitted: (value) {
                    ref.read(userProvider.notifier).edit(name: value);
                    newNameController.clear();
                  },
                ),
              )
            ],
          )),
    );
  }
}
