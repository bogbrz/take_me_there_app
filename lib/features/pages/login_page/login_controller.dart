import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:take_me_there_app/features/pages/login_page/login_state.dart';
import 'package:take_me_there_app/providers/auth_provider.dart';

class LoginController extends StateNotifier<LoginState> {
  LoginController(this.ref) : super(const LoginStateInitial());

  final Ref ref;
  void login({required String email, required String password}) async {
    state = LoginStateLoading();
    try {
    await ref
          .read(authDataSourceProvider)
          .signInWithEmailAndPassword(email: email, password: password);

      state = LoginStateSuccess();
    } catch (e) {
      state = LoginStateError(e.toString());
    }
  }

  void createAccount(
      {required String email,
      required String password,
      required String username}) async {
    state = LoginStateLoading();
    try {
      ref.read(authDataSourceProvider).createUserWithEmailAndPassword(
          email: email, password: password, username: username);
      state = LoginStateSuccess();
    } catch (e) {
      state = LoginStateError(e.toString());
    }
  }

  void signOut() {
    ref.read(authDataSourceProvider).signOut();
  }
}

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>((ref) {
  return LoginController(ref);
});
