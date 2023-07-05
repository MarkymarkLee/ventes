import 'package:flutter/material.dart';
import 'package:ventes/MainApp/Chat/main_chat_page.dart';
import 'package:ventes/MainApp/Profile/main_profile_page.dart';
import 'package:ventes/MainApp/Search/main_search_page.dart';

class MainAppPage extends StatefulWidget {
  const MainAppPage({super.key});

  @override
  State<MainAppPage> createState() => _MainAppPageState();
}

class _MainAppPageState extends State<MainAppPage> {
  var selectedIndex = 1;

  onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> pages = const [
    SearchPage(),
    ProfilePage(),
    ChatPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: pages[selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
            BottomNavigationBarItem(icon: Icon(Icons.message), label: "Chat"),
          ],
          currentIndex: selectedIndex,
          onTap: onItemTapped,
        ),
      ),
    );
  }
}
