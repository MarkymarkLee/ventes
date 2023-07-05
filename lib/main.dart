import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ventes/MainApp/main_app_page.dart';
import 'Settings/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ventes',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MainAppPage(),
    );
  }
}
