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
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
            children: [
              const SizedBox(height: 60),

              // welcome text
              Text(
                "Register here!",
                style: TextStyle(color: Colors.amber.shade100, fontSize: 40),
              ),
              const SizedBox(height: 20),

              // school ID
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
                  child: Text(
                    "學號 School ID:",
                    style:
                        TextStyle(color: Colors.amber.shade100, fontSize: 16),
                  ),
                ),
              ),
              MyTextField(
                controller: idController,
                hintText: "ex: b11111111",
              ),
              if (idError.isNotEmpty)
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 3),
                    child: Text(
                      idError,
                      style:
                          TextStyle(color: Colors.red.shade500, fontSize: 12),
                    ),
                  ),
                )
              else
                const SizedBox(height: 20),
              const SizedBox(height: 15),

              // real name
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
                  child: Text(
                    "姓名 Name (實名模式使用): ",
                    style:
                        TextStyle(color: Colors.amber.shade100, fontSize: 16),
                  ),
                ),
              ),
              MyTextField(
                controller: realnameController,
                hintText: "ex: 王小名",
              ),
              if (realnameError.isNotEmpty)
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 3),
                    child: Text(
                      realnameError,
                      style:
                          TextStyle(color: Colors.red.shade500, fontSize: 12),
                    ),
                  ),
                )
              else
                const SizedBox(height: 20),
              const SizedBox(height: 15),

              // nickname
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
                  child: Text(
                    "稱呼 Nickname (暱名模式使用):",
                    style:
                        TextStyle(color: Colors.amber.shade100, fontSize: 16),
                  ),
                ),
              ),
              MyTextField(
                controller: nicknameController,
                hintText: "ex: Baby",
              ),
              if (nicknameError.isNotEmpty)
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 3),
                    child: Text(
                      nicknameError,
                      style:
                          TextStyle(color: Colors.red.shade500, fontSize: 12),
                    ),
                  ),
                )
              else
                const SizedBox(height: 20),
              const SizedBox(height: 15),

              // email
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
                  child: Text(
                    "學校信箱 Email (@*ntu.edu.tw): ",
                    style:
                        TextStyle(color: Colors.amber.shade100, fontSize: 16),
                  ),
                ),
              ),
              MyTextField(
                controller: emailController,
                hintText: "ex: b11111111@ntu.edu.tw",
              ),
              if (emailError.isNotEmpty)
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 3),
                    child: Text(
                      emailError,
                      style:
                          TextStyle(color: Colors.red.shade500, fontSize: 12),
                    ),
                  ),
                )
              else
                const SizedBox(height: 20),
              const SizedBox(height: 40),

              // register
              MyButton(
                buttonText: "Verify",
                onTap: verify,
              ),
            ],
          )),
        ));
  }
}
