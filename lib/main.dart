import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ventes/Auth/auth_nav.dart';
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
        scaffoldBackgroundColor: Colors.brown[700],
        primarySwatch: Colors.amber,
      ),
      home: const AuthNav(),
    );
  }
}
