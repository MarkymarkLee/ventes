import 'package:flutter/material.dart';
import 'package:ventes/MainApp/Chat/main_chat_page.dart';
import 'package:ventes/MainApp/MyEvents/my_events.dart';
import 'package:ventes/MainApp/Search/main_search_page.dart';
import 'package:ventes/MainApp/Setting/main_setting_page.dart';

class MainAppPage extends StatefulWidget {
  const MainAppPage({super.key});

  @override
  State<MainAppPage> createState() => _MainAppPageState();
}

class _MainAppPageState extends State<MainAppPage> {
  var selectedIndex = 0;

  onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> pages = const [
    MyEventsPage(),
    SearchPage(),
    ChatPage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: pages[selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.event), label: "My events"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Chat"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}
