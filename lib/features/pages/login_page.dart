import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:take_me_there_app/app/app_routes.gr.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LOGINPAGE"),
      ),
      body: Center(
        child: MaterialButton(
          color: Colors.red,
          onPressed: () {
            context.router.replace(BottomNavPage());
          },
          child: Text("HOMEPAGE"),
        ),
      ),
    );
  }
}
