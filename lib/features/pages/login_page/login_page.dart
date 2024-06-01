import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:take_me_there_app/app/app_routes.gr.dart';

@RoutePage()
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
          decoration: InputDecoration(hintText: "Password"),
          controller: passwordController,
        ),
        Center(
          child: MaterialButton(
            color: Colors.red,
            onPressed: () {
              context.router.replace(BottomNavPage());
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
