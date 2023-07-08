import 'package:ventes/Auth/auth_service.dart';
import 'package:ventes/Components/components.dart';
import 'package:ventes/Components/loading_components.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VerifyPage extends StatefulWidget {
  final Function switchPage;
  final Function setemail;
  const VerifyPage({
    super.key,
    required this.switchPage,
    required this.setemail,
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
      // check if email is empty
      if (emailController.text.trim().isEmpty) {
        setState(() {
          emailError = "Email cannot be empty";
        });
        return false;
      }
      // check if email is valid (school email)
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

  void sendemail() async {
    if (!goodemail()) {
      return;
    }
    widget.setemail(email);

    showGeneralDialog(
      barrierDismissible: false,
      useRootNavigator: false,
      context: context,
      pageBuilder: (BuildContext context, a, b) {
        return const AlertLoading();
      },
    );

    sendOtp().then((value) {
      Navigator.of(context, rootNavigator: false).pop(context);
      if (value) {
        widget.switchPage();
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
                "Sorry!",
                style: TextStyle(color: Colors.amber.shade100, fontSize: 40),
              ),
              const SizedBox(height: 20),

              // explanation text
              Text(
                "This app is currently only available for NTU students.",
                style: TextStyle(color: Colors.amber.shade100, fontSize: 25),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // email
              
              MyTextField(
                controller: emailController,
                hintText: "ex: b11111111@ntu.edu.tw",
                errorText: emailError,
                fieldName: "學校信箱 Email (@*ntu.edu.tw): ",
                fieldNameColor: Colors.amber.shade100,
                textfieldBorderColor: Colors.white,
              ),
              const SizedBox(height: 20),

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
