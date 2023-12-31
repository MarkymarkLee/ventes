import 'package:flutter/material.dart';
import 'package:ventes/MainApp/main_app_page.dart';
import 'package:ventes/MainApp/set_profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ventes/Auth/auth_service.dart';
import 'package:ventes/Components/loading_components.dart';
import 'package:ventes/data.dart';

// Decides whether to show profile setting page or main page
class MainNav extends StatefulWidget {
  const MainNav({super.key});

  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  void reload() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(AuthService().getCurrentUserEmail())
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == null) {
              return const Loading();
            }
            Map<String, dynamic> userdata = snapshot.data!.data()!;

            if (userdata["nickname"] != "" &&
                userdata["gender"] != "") {
              currentUser = AppUser.fromJson(userdata);
              return const MainAppPage();
            } else {
              return SetProfilePage(
                reload: reload,
              );
            }
          } else {
            return const Loading();
          }
        });
  }
}
