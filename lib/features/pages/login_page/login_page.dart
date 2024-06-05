import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:take_me_there_app/app/app_routes.dart';
import 'package:take_me_there_app/app/core/enums.dart';

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
    final phoneNumberController = useTextEditingController();
    final passwordController = useTextEditingController();
    final passwordConfrmController = useTextEditingController();

    final isCreatingAccount = useState<bool>(false);
    final selectedType = useState<int?>(0);
    final userType = useState<UserType>(UserType.client);
    final fieldsAreEmpty = useState<bool>(true);

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
          fieldsAreEmpty.value = areFieldsEmpty();
        });
        usernameController.addListener(() {
          fieldsAreEmpty.value = areFieldsEmpty();
        });
        phoneNumberController.addListener(() {
          fieldsAreEmpty.value = areFieldsEmpty();
        });
        passwordController.addListener(() {
          fieldsAreEmpty.value = areFieldsEmpty();
        });
        passwordConfrmController.addListener(() {
          fieldsAreEmpty.value = areFieldsEmpty();
        });
      } else {
        emailController.addListener(() {
          fieldsAreEmpty.value = areFieldsEmpty();
        });
        passwordController.addListener(() {
          fieldsAreEmpty.value = areFieldsEmpty();
        });
      }
      useEffect(() {
        return;
      });

      return;
    });
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(children: [
                  isCreatingAccount.value
                      ? Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                hintText: "Username",
                              ),
                              controller: usernameController,
                            ),
                            TextField(
                              decoration: InputDecoration(hintText: "Email"),
                              controller: emailController,
                            ),
                            TextField(
                              decoration:
                                  InputDecoration(hintText: "Phone number"),
                              controller: phoneNumberController,
                              keyboardType: TextInputType.phone,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                hintText: "Password",
                              ),
                              obscureText: true,
                              controller: passwordController,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                hintText: "Confirm password",
                              ),
                              obscureText: true,
                              controller: passwordConfrmController,
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(hintText: "Email"),
                              controller: emailController,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                hintText: "Password",
                              ),
                              obscureText: true,
                              controller: passwordController,
                            ),
                          ],
                        ),
                  Center(
                    child: MaterialButton(
                      color: Colors.red,
                      onPressed: fieldsAreEmpty.value
                          ? null
                          : () {
                              if (isCreatingAccount.value) {
                                if (passwordController.value.text
                                        .toString()
                                        .isNotEmpty &&
                                    passwordConfrmController.value.text
                                            .toString() !=
                                        passwordController.value.text
                                            .toString()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Passwords are not the same")));
                                } else {
                                  ref
                                      .read(loginControllerProvider.notifier)
                                      .createAccount(
                                          email: emailController.value.text,
                                          password:
                                              passwordController.value.text,
                                          username:
                                              usernameController.value.text,
                                          userType: userType.value,phoneNumber: phoneNumberController.value.text);
                                }
                              } else {
                                ref
                                    .read(loginControllerProvider.notifier)
                                    .login(
                                        email: emailController.value.text,
                                        password:
                                            passwordController.value.text);
                              }
                            },
                      child:
                          Text(isCreatingAccount.value ? "Sign up" : "Sing in"),
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
              ),
              CupertinoSlidingSegmentedControl(
                children: {0: Text("Client"), 1: Text("Driver")},
                groupValue: selectedType.value,
                onValueChanged: (value) {
                  selectedType.value = value;
                  if (selectedType.value == 0) {
                    userType.value = UserType.client;
                  } else {
                    userType.value = UserType.driver;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
