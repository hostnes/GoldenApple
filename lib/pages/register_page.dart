import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../comonents/my_button.dart';
import '../comonents/my_textfield.dart';
import '../services/validate.dart';
import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();

  void login() {
    Navigator.push(
        context, MaterialPageRoute(builder: ((context) => HomePage())));
  }

  String blocError = '';

  final box = Hive.box('userInfo');

  void register() async {
    if (validateEmail(emailController.text) == false) {
      setState(() {
        blocError = 'введите валидный email';
      });
      return;
    }
    setState(() {
      blocError = '';
    });
    if (passwordController.text != confirmpasswordController.text) {
      setState(() {
        blocError = 'пароли не совпадают';
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
    // var userData = await ConnectServer.register(emailController.text,
    //     passwordController.text, confirmpasswordController.text);
    // box.put("auth", userData);
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(Theme.of(context).colorScheme.background);
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
              "Let's create an account for you",
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
            MyTextField(
                controller: confirmpasswordController,
                hintText: "confirm password",
                obscureText: true),
            const SizedBox(
              height: 10,
            ),
            MyButton(
              text: "Sign Up",
              onTap: register,
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "already have an account?",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "Login now",
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
