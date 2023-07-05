import 'package:flutter/material.dart';
import 'package:ventes/MainApp/main_app_page.dart';
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
          if (snapshot.hasData) {
            var userdata = snapshot.data;
            if (userdata == null) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (!userdata["profiles"].isEmpty) {
              return const MainAppPage();
            } else {
              return const SetProfilePage();
            }
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
