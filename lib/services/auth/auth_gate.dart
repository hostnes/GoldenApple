
import 'package:flutter/material.dart';

import '../../pages/home_page.dart';
import 'login_or_register.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return HomePage();
    return LoginOrRegister();

    // return Scaffold(
    //   body: StreamBuilder(
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         return const HomePage();
    //       }
    //       return LoginOrRegister();
    //     },
    //   ),
    // );
  }
}
