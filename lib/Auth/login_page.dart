import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ventes/Auth/auth_service.dart';
import 'package:ventes/Components/components.dart';
import 'package:ventes/Functions/users_data.dart';

class LoginPage extends StatelessWidget {
  LoginPage({
    super.key,
  });
  final emailcontroller = TextEditingController();

  void signin() async {
    await AuthService().signInWithGoogle();

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    UsersData.checkIfUserExists(user.email!).then((value) async {
      if (!value) {
        await UsersData.addUser(user.email!, {
          "email": user.email,
          "isVerified": false,
          "schoolEmail": "",
          "isDarkMode": false,
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Expanded(child: Container()),
            // Logo
            Image.asset(
              "images/logo.png",
              width: 200,
            ),
            const SizedBox(height: 20),

            // welcome text
            Text(
              "Welcome!",
              style: TextStyle(color: Colors.amber.shade100, fontSize: 40),
            ),
            const SizedBox(height: 20),

            MyButton(
              onTap: signin,
              buttonText: "Sign in with Google",
            ),

            Expanded(child: Container()),
          ],
        ),
      )),
    );
  }
}
