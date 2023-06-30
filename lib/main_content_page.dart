import 'package:flutter/material.dart';
import 'package:ventes/auth_page/auth_service.dart';
import 'auth_page/components.dart';

class MainContentPage extends StatefulWidget {
  const MainContentPage({super.key});

  @override
  State<MainContentPage> createState() => _MainContentPageState();
}

class _MainContentPageState extends State<MainContentPage> {
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
              style: TextStyle(color: Colors.amber.shade100, fontSize: 30),
            ),
            Text(
              "${AuthService().getCurrentUserEmail()}",
              style: TextStyle(color: Colors.amber.shade100, fontSize: 30),
            ),
            const SizedBox(height: 20),

            MyButton(
              onTap: () {
                AuthService().signOut();
              },
              buttonText: "Sign out",
            ),

            Expanded(child: Container()),
          ],
        ),
      )),
    );
  }
}
