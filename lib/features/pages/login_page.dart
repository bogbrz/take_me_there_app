import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:take_me_there_app/app/app_routes.gr.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:take_me_there_app/controllers/login_page_controller.dart';
import 'package:take_me_there_app/data_sources/auth_data_source.dart';
import 'package:take_me_there_app/domain/models/user_model.dart';
import 'package:take_me_there_app/domain/repositories/auth_repository.dart';
import 'package:take_me_there_app/features/pages/user_page/user_page.dart';

final loginPageController =
    StateNotifierProvider<LoginPageController, UserModel>((ref) {
  return LoginPageController(UserModel(user: null),
      authRepository: AuthRepository(authDataSource: AuthDataSource()));
});

@RoutePage()
class LoginPage extends HookConsumerWidget {
  LoginPage({
    super.key,
  });

  late LoginPageController _loginPageController;
  late UserModel _userModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();

    final passwordController = useTextEditingController();
    _loginPageController = ref.watch(loginPageController.notifier);

    _userModel = ref.watch(loginPageController);
   
    final isCreatingAccount = useState(false);
    return Scaffold(
      appBar: AppBar(
        title: Text("LOGINPAGE"),
      ),
      body: ListView(children: [
        TextField(
          decoration: InputDecoration(hintText: "email"),
          controller: emailController,
        ),
        TextField(
          decoration: InputDecoration(hintText: "Password"),
          controller: passwordController,
        ),
        Center(
          child: MaterialButton(
            color: Colors.red,
            onPressed: () {
              // context.router.replace(BottomNavPage());
     
          
            },
            child: Text(isCreatingAccount.value ? "Sign up" : "Sing in"),
          ),
        ),
        TextButton(
            onPressed: () {
              isCreatingAccount.value
                  ? isCreatingAccount.value = false
                  : isCreatingAccount.value = true;
            },
            child: Text(isCreatingAccount.value
                ? "Already have an account?"
                : "Doesnt have and account?"))
      ]),
    );
  }
}
