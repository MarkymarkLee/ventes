import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.amber,
      primaryColor: isDarkTheme ? Colors.black : Colors.white,
      // backgroundColor: isDarkTheme ? Colors.black : Color(0xffF1F5FB),
      scaffoldBackgroundColor: isDarkTheme ? Colors.brown[700] : Colors.white,
      dialogBackgroundColor: isDarkTheme ? const Color.fromARGB(255, 176, 146, 135) : Colors.white,
      
      // indicatorColor: isDarkTheme ? const Color(0xff0E1D36) : const Color(0xffCBDCF8),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: isDarkTheme
              ? const Color.fromARGB(255, 2, 25, 161)
              : const Color.fromARGB(255, 0, 146, 179),
          foregroundColor: isDarkTheme ? Colors.white : Colors.black,
        ),
      ),
      cardColor: isDarkTheme
          ? const Color.fromARGB(255, 193, 192, 192)
          : const Color.fromARGB(255, 193, 192, 192),
      
      appBarTheme: AppBarTheme(
          elevation: 0.0,
          color: isDarkTheme
              ? const Color.fromARGB(255, 206, 162, 129)
              : Colors.blue),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: isDarkTheme
              ? const Color.fromARGB(255, 206, 162, 129)
              : Colors.blue,
          foregroundColor: isDarkTheme ? Colors.black : Colors.white,
        ),
      ),
      textTheme: TextTheme(
        titleSmall: TextStyle(
          fontSize: 12,
          color: isDarkTheme ? Colors.amber : Colors.amber.shade800,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          color: isDarkTheme ? Colors.amber : Colors.amber.shade800,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          color: isDarkTheme ? Colors.amber : Colors.amber.shade800,
        ),
        bodySmall: const TextStyle(
          fontSize: 12,
          color: Colors.black,
        ),
        bodyMedium: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        bodyLarge: const TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: isDarkTheme ? Colors.white : Colors.black,
        ),
        hintStyle: TextStyle(
          color: isDarkTheme ? Colors.white : Colors.black,
        ),
      ),
      // canvasColor: isDarkTheme ? Colors.brown : Colors.black,
    );
  }
}
