import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ventes/Auth/login_page.dart';
import 'package:ventes/Email_verification/verify_nav.dart';

class AuthNav extends StatefulWidget {
  const AuthNav({super.key});

  @override
  State<AuthNav> createState() => _AuthNavState();
}

class _AuthNavState extends State<AuthNav> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        // debugPrint(snapshot.data.toString());
        if (snapshot.data == null) {
          return LoginPage();
        } else {
          return const VerifyNav();
        }
      }),
    );
  }
}
