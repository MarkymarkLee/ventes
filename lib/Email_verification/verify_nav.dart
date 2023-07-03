import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ventes/Auth/auth_service.dart';
import 'package:ventes/Email_verification/otp_page.dart';
import 'package:ventes/Email_verification/verify_page.dart';
import 'package:ventes/Main/main_content_page.dart';

// Decides whether to show verification page or main page
class VerifyNav extends StatefulWidget {
  const VerifyNav({super.key});

  @override
  State<VerifyNav> createState() => _VerifyNavState();
}

class _VerifyNavState extends State<VerifyNav> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(AuthService().getCurrentUserEmail())
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var userdata = snapshot.data;
            if (userdata!["isVerified"]) {
              return const MainContentPage();
            } else {
              return const OTPNav();
            }
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}

// allows switch between verification page and otp page
class OTPNav extends StatefulWidget {
  const OTPNav({super.key});

  @override
  State<OTPNav> createState() => _OTPNavState();
}

class _OTPNavState extends State<OTPNav> {
  var showOTP = false;
  var email = "";

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [
        MaterialPage(
            child: VerifyPage(
          switchPage: () {
            setState(() {
              showOTP = true;
            });
          },
          setemail: (String x) {
            setState(() {
              email = x;
            });
          },
        )),
        if (showOTP)
          MaterialPage(
              child: OTPPage(
            email: email,
            switchPage: () {
              setState(() {
                showOTP = false;
              });
            },
          )),
      ],
      onPopPage: (route, result) {
        showOTP = false;
        return route.didPop(result);
      },
    );
  }
}
