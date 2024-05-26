import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
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
        body: SupaEmailAuth(
          redirectTo: kIsWeb ? null : 'io.mydomain.myapp://callback',
          onSignInComplete: (response) {
            context.router.replace(BottomNavPage());
          },
          onSignUpComplete: (response) {
            context.router.replace(BottomNavPage());
          },
          metadataFields: [
            MetaDataField(
              prefixIcon: const Icon(Icons.person),
              label: 'Username',
              key: 'username',
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please enter something';
                }
                return null;
              },
            ),
          ],
        )

        //  ListView(children: [

        //   Center(
        //     child: MaterialButton(
        //       color: Colors.red,
        //       onPressed: () {
        //         context.router.replace(BottomNavPage());
        //       },
        //       child: Text("HOMEPAGE"),
        //     ),
        //   ),
        // ]),
        );
  }
}
