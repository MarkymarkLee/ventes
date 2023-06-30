import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ventes/users_data.dart';
import 'components.dart';

// ignore: constant_identifier_names
const int RESENDSECONDS = 60;

class OTPPage extends StatefulWidget {
  final String email;
  const OTPPage({super.key, required this.email});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final otpController = TextEditingController();
  String otpError = "";

  bool canResend = false;
  int resendSeconds = RESENDSECONDS;

  late Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendSeconds != 1) {
        setState(() {
          resendSeconds--;
        });
      } else {
        setState(() {
          canResend = true;
        });
      }
    });
  }

  void resend() {
    http.get(Uri.parse(
        'https://ventes.pythonanywhere.com/send-otp/${widget.email}'));
    if (canResend) {
      setState(() {
        resendSeconds = RESENDSECONDS;
        canResend = false;
      });
    }
  }

  Future<bool> verifyOtp() async {
    String otp = otpController.text.trim();
    final response = await http.get(Uri.parse(
        'https://ventes.pythonanywhere.com/verify-otp/${widget.email}/$otp'));
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

  void verify() {
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
    verifyOtp().then((value) async {
      if (value) {
        Navigator.pop(context);
        Navigator.pop(context);
        await UsersData.updateUser(FirebaseAuth.instance.currentUser!.email!,
            {"isVerified": true, "schoolEmail": widget.email});
      } else {
        Navigator.pop(context);
        setState(() {
          otpError = "Try again!";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 60),

              // explanation text
              Text(
                "An email has been sent to your email address. Please enter the verification code here.",
                style: TextStyle(color: Colors.amber.shade100, fontSize: 25),
              ),
              const SizedBox(height: 20),

              // otp textfield
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
                  child: Text(
                    "Verification Code:",
                    style:
                        TextStyle(color: Colors.amber.shade100, fontSize: 16),
                  ),
                ),
              ),
              MyTextField(
                controller: otpController,
                hintText: "ex: 123456",
              ),
              if (otpError.isNotEmpty)
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 3),
                    child: Text(
                      otpError,
                      style:
                          TextStyle(color: Colors.red.shade500, fontSize: 12),
                    ),
                  ),
                )
              else
                const SizedBox(height: 20),
              const SizedBox(height: 40),

              // resend button
              canResend
                  ? MyButton(
                      buttonText: "Resend",
                      onTap: resend,
                    )
                  : Text("Resend in $resendSeconds seconds",
                      style: TextStyle(
                          color: Colors.amber.shade100, fontSize: 30)),
              const SizedBox(height: 40),

              // register
              MyButton(
                buttonText: "Verify",
                onTap: verify,
              ),
            ],
          ),
        ));
  }
}
