import 'package:flutter/material.dart';
import 'package:ventes/Functions/test.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(child: Container()),
          ElevatedButton(
              onPressed: () {
                randomEvent.addEvent();
              },
              child: const Text("Add Event")),
          ElevatedButton(
              onPressed: () {
                randomEvent.clearEvents();
              },
              child: const Text("Delete all Events")),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
