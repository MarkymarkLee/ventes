import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.amber,
      primaryColor: isDarkTheme ? Colors.black : Colors.white,
      // backgroundColor: isDarkTheme ? Colors.black : Color(0xffF1F5FB),
      scaffoldBackgroundColor: isDarkTheme ? Colors.brown[700] : Colors.white,
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
      // canvasColor: isDarkTheme ? Colors.amber[50] : Colors.white,
    );
  }
}
