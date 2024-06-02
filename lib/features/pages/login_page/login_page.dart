import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:take_me_there_app/features/pages/login_page/login_controller.dart';
import 'package:take_me_there_app/features/pages/login_page/login_state.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<LoginState>(loginControllerProvider, (previous, state) {
      if (state is LoginStateError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.error)));
      }
    });
    final usernameController = useTextEditingController();
    final emailController = useTextEditingController();

    final passwordController = useTextEditingController();
    final passwordConfrmController = useTextEditingController();

    final isCreatingAccount = useState(false);
    final _areFieldsEmpty = useState<bool>(true);

    bool areFieldsEmpty() {
      if (isCreatingAccount.value) {
        return emailController.value.text.toString().isEmpty ||
            usernameController.value.text.toString().isEmpty ||
            passwordConfrmController.value.text.toString().isEmpty ||
            passwordController.value.text.toString().isEmpty;
      } else {
        return emailController.value.text.toString().isEmpty ||
            passwordController.value.text.toString().isEmpty;
      }
    }

    useEffect(() {
      if (isCreatingAccount.value) {
        emailController.addListener(() {
          _areFieldsEmpty.value = areFieldsEmpty();
        });
        usernameController.addListener(() {
          _areFieldsEmpty.value = areFieldsEmpty();
        });

        passwordController.addListener(() {
          _areFieldsEmpty.value = areFieldsEmpty();
        });
        passwordConfrmController.addListener(() {
          _areFieldsEmpty.value = areFieldsEmpty();
        });
      } else {
        emailController.addListener(() {
          _areFieldsEmpty.value = areFieldsEmpty();
        });
        passwordController.addListener(() {
          _areFieldsEmpty.value = areFieldsEmpty();
        });
      }
      useEffect(() {
        return;
      });

      return;
    });
    return Scaffold(
      body: ListView(children: [
        isCreatingAccount.value
            ? TextField(
                decoration: InputDecoration(
                  hintText: "Username",
                ),
                controller: usernameController,
              )
            : SizedBox.shrink(),
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
        isCreatingAccount.value
            ? TextField(
                decoration: InputDecoration(
                  hintText: "Confirm password",
                ),
                obscureText: true,
                controller: passwordConfrmController,
              )
            : SizedBox.shrink(),
        Center(
          child: MaterialButton(
            color: Colors.red,
            onPressed: _areFieldsEmpty.value
                ? null
                : () {
                    if (isCreatingAccount.value) {
                      if (passwordController.value.text.toString().isNotEmpty &&
                          passwordConfrmController.value.text.toString() !=
                              passwordController.value.text.toString()) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Passwords are not the same")));
                      } else {
                        ref
                            .read(loginControllerProvider.notifier)
                            .createAccount(
                                email: emailController.value.text,
                                password: passwordController.value.text,
                                username: usernameController.value.text);
                      }
                    } else {
                      ref.read(loginControllerProvider.notifier).login(
                          email: emailController.value.text,
                          password: passwordController.value.text);
                    }
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
