import 'package:ventes/auth_page/components.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({
    super.key,
  });

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final idController = TextEditingController();
  final realnameController = TextEditingController();
  final nicknameController = TextEditingController();
  final emailController = TextEditingController();
  String idError = "";
  String realnameError = "";
  String nicknameError = "";
  String emailError = "";

  void verify() {
    setState(() {
      idError = "Not a valid ID";
      realnameError = "Not a valid name";
      nicknameError = "Not a valid nickname";
      emailError = "Not a valid email";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Navigator();
  }
}
