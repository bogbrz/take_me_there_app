import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:take_me_there_app/domain/models/user_model.dart';
import 'package:take_me_there_app/features/pages/user_page/user_state.dart';
import 'package:take_me_there_app/providers/auth_provider.dart';
@riverpod
class UserController extends StateNotifier<UserModel> {
  UserController(this.ref)
      : super(UserModel(email: "", username: "", pictureUrl: ""));
  final Ref ref;

  Future<UserModel> getUser() async {
    final user = await ref.read(authDataSourceProvider).getUser();
    print("CONTROLLER $user");
    return UserModel(
        email: user!.email.toString(),
        username: user.displayName.toString(),
        pictureUrl: user.photoURL.toString());
  }

   @override
  FutureOr<UserModel> build() async {
    // Load initial todo list from the remote repository
    return getUser();
  }
}

class UserTest extends AsyncNotifier<UserModel> {
  @override
  Future<UserModel> build() async {
    final user = await ref.watch(authDataSourceProvider).getUser();
    return UserModel(
        email: user!.email.toString(),
        username: user.displayName.toString(),
        pictureUrl: user.photoURL.toString());
  }
}
