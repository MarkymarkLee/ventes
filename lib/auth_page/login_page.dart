import 'package:flutter/material.dart';
import 'package:ventes/auth_page/components.dart';

class LoginPage extends StatelessWidget {
  final VoidCallback showRegisterPage;
  LoginPage({
    super.key,
    required this.showRegisterPage,
  });
  final emailcontroller = TextEditingController();

  void signin() {}

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

            // email text field
            MyTextField(
              controller: emailcontroller,
              hintText: "email",
            ),
            const SizedBox(height: 20),

            // sign in button
            MyButton(
              buttonText: "Sign in",
              onTap: signin,
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(child: Container()),
                    Text(
                      "First time? ",
                      style:
                          TextStyle(color: Colors.amber.shade100, fontSize: 16),
                    ),
                    TextButton(
                        onPressed: showRegisterPage,
                        child: Text(
                          "Register here !",
                          style: TextStyle(
                              color: Colors.amber.shade100, fontSize: 16),
                        )),
                  ],
                ),
              ),
            ),

            Expanded(child: Container()),
          ],
        ),
      )),
    );
  }
}
