import 'package:flutter/material.dart';
import 'package:ventes/auth_page/login_page.dart';
import 'package:ventes/auth_page/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void switchPage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        showRegisterPage: switchPage,
      );
    } else {
      return RegisterPage(
        showLoginPage: switchPage,
      );
    }
  }
}
