import 'package:ventes/auth_page/auth_service.dart';
import 'package:ventes/auth_page/components.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ventes/auth_page/otp_page.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({
    super.key,
  });

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final emailController = TextEditingController();
  String emailError = "";

  final otpController = TextEditingController();
  bool showOtp = false;
  late String email;

  bool goodemail() {
    try {
      const availDomain = ["ntu.edu.tw", "g.ntu.edu.tw", "csie.ntu.edu.tw"];
      email = emailController.text.trim();
      var t = email.split('@');
      String domain = t[1];
      if (!availDomain.contains(domain)) {
        setState(() {
          emailError = "Not a school email";
        });
        return false;
      }
      return true;
    } catch (e) {
      setState(() {
        emailError = "Bad email";
      });
      return false;
    }
  }

  Future<bool> sendOtp() async {
    final response = await http
        .get(Uri.parse('https://ventes.pythonanywhere.com/send-otp/$email'));
    if (response.statusCode == 200) {
      final result = response.body;
      if (result == "success") {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  void sendemail() {
    if (!goodemail()) {
      return;
    }
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text("Loading")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    sendOtp().then((value) {
      Navigator.pop(context);
      if (value) {
        Navigator.push(context,
            MaterialPageRoute<bool>(builder: (BuildContext context) {
          // otp page
          return OTPPage(
            email: email,
          );
        }));
      } else {
        setState(() {
          emailError = "Email not found";
        });
      }
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

              // sorry text
              Text(
                "Sorry.",
                style: TextStyle(color: Colors.amber.shade100, fontSize: 40),
              ),
              const SizedBox(height: 20),

              // explanation text
              Text(
                "This app is currently only available for NTU students.",
                style: TextStyle(color: Colors.amber.shade100, fontSize: 25),
              ),
              const SizedBox(height: 20),

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
                buttonText: "Send email verification.",
                onTap: sendemail,
              ),

              const SizedBox(height: 20),

              MyButton(
                  onTap: () {
                    AuthService().signOut();
                  },
                  buttonText: "sign out")
            ],
          )),
        ));
  }
}
