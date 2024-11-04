import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../comonents/my_button.dart';
import '../comonents/my_textfield.dart';
import '../services/validate.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  String blocError = '';
  final box = Hive.box('userInfo');
  void login() async {
    if (validateEmail(emailController.text) == false) {
      setState(() {
        blocError = 'введите валидный email';
      });
      return;
    }
    setState(() {
      blocError = '';
    });
    if (passwordController.text.length <= 7) {
      setState(() {
        blocError = 'пароль меньше 8 символов';
      });
      return;
    }
    setState(() {
      blocError = '';
    });
    // var userData = await ConnectServer.auth(
    //   emailController.text,
    //   passwordController.text,
    // );
    // if (userData.isEmpty) {
    //   setState(() {
    //     blocError = 'Пользователь не найден';
    //   });
    //   return;
    // }
    // box.put("auth", userData[0]);
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_florist,
              size: 100,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              "Golden Apple App",
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              blocError,
              style: TextStyle(color: Colors.red),
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
                controller: emailController,
                hintText: "email",
                obscureText: false),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
                controller: passwordController,
                hintText: "password",
                obscureText: true),
            const SizedBox(
              height: 10,
            ),
            MyButton(
              text: "Sign In",
              onTap: login,
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member?",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "Register now",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
