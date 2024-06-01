import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:take_me_there_app/features/pages/login_page/login_controller.dart';

class LoginPage extends HookConsumerWidget {
  LoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();

    final passwordController = useTextEditingController();

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
          decoration: InputDecoration(
            hintText: "Password",
          ),
          obscureText: true,
          controller: passwordController,
        ),
        Center(
          child: MaterialButton(
            color: Colors.red,
            onPressed: () {
              isCreatingAccount.value
                  ? ref.read(loginControllerProvider.notifier).createAccount(
                      email: emailController.value.text,
                      password: passwordController.value.text,
                      username: "TestNickName")
                  : ref.read(loginControllerProvider.notifier).login(
                      email: emailController.value.text,
                      password: passwordController.value.text);
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
                : "Dont have and account?"))
      ]),
    );
  }
}
