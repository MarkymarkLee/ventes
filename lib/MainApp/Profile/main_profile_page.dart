import 'package:flutter/material.dart';
import 'package:ventes/Auth/auth_service.dart';
import 'package:ventes/Functions/test.dart';
import 'package:ventes/MainApp/Profile/AddEvent/add_event_page.dart';
import 'package:ventes/MainApp/Profile/profile_info.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          // Expanded(child: Container()),
          const ProfileInfo(),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddEventPage()),
                );
              },
              child: const Text("Add Event")),
          ElevatedButton(
              onPressed: () {
                RandomEvent.clearEvents();
              },
              child: const Text("Delete all Events")),
          ElevatedButton(
              onPressed: () {
                AuthService().signOut();
              },
              child: const Text("Logout")),
          // Expanded(child: Container()),
        ],
      ),
    ));
  }
}
