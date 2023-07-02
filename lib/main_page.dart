import 'package:flutter/material.dart';
import 'package:ventes/auth_page/verify_page.dart';
import 'package:ventes/main_content_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainPage extends StatefulWidget {
  final String email;
  const MainPage({super.key, required this.email});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var userdata = snapshot.data;
            if (userdata!["isVerified"]) {
              return const MainContentPage();
            } else {
              return const VerifyPage();
            }
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
