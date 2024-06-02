import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:take_me_there_app/domain/models/user_model.dart';
import 'package:take_me_there_app/features/pages/user_page/user_state.dart';
import 'package:take_me_there_app/providers/auth_provider.dart';

class UserController extends StateNotifier<UserModel> {
  UserController(this.ref)
      : super(UserModel(email: "", username: "", pictureUrl: ""));
  final Ref ref;

  Future<UserModel> getUser() async {
    final user = await ref.read(authDataSourceProvider).getUser();
    return user;
  }
}

final userControllerProvider =
    StateNotifierProvider<UserController, UserModel>((ref) {
  return UserController(ref);
});
