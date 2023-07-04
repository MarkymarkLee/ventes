import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ventes/MainApp/main_content_page.dart';
import 'package:ventes/MainApp/set_profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ventes/Auth/auth_service.dart';

// Decides whether to show profile setting page or main page
class MainNav extends StatefulWidget {
  const MainNav({super.key});

  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(AuthService().getCurrentUserEmail())
            .snapshots(),
        builder: (context, snapshot) {
          var userdata = snapshot.data;
          if (!userdata!["profiles"].isEmpty) {
            return const MainContentPage();
          } else {
            return const SetProfilePage();
          }
        });
  }
}
