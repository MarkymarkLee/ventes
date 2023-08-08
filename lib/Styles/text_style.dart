import 'package:flutter/material.dart';

class MyTextStyle{

  static TextStyle? display4(BuildContext context){
    return Theme.of(context).textTheme.displayLarge;
  }

  static TextStyle? display3(BuildContext context){
    return Theme.of(context).textTheme.displayMedium;
  }

  static TextStyle? display2(BuildContext context){
    return Theme.of(context).textTheme.displaySmall;
  }

  static TextStyle? display1(BuildContext context){
    return Theme.of(context).textTheme.headlineMedium;
  }

  static TextStyle? headline(BuildContext context){
    return Theme.of(context).textTheme.headlineSmall;
  }

  static TextStyle? titleLarge(BuildContext context){
    return Theme.of(context).textTheme.titleLarge;
  }

  static TextStyle titleCustomFontsize(BuildContext context, double fontSize){
    return Theme.of(context).textTheme.titleMedium!.copyWith(
      fontSize: fontSize,
    );
  }

  static TextStyle? titleMedium(BuildContext context){
    return Theme.of(context).textTheme.titleMedium;
  }

  static TextStyle? bodyLarge(BuildContext context){
    return Theme.of(context).textTheme.bodyLarge;
  }

  static TextStyle? bodyMedium(BuildContext context){
    return Theme.of(context).textTheme.bodyMedium;
  }

  static TextStyle? bodySmall(BuildContext context){
    return Theme.of(context).textTheme.bodySmall;
  }

  static TextStyle? bodyCustomFontsize(BuildContext context, double fontSize){
    return Theme.of(context).textTheme.bodySmall!.copyWith(
      fontSize: fontSize,
    );
  }

  static TextStyle? button(BuildContext context){
    return Theme.of(context).textTheme.labelLarge!.copyWith(
        letterSpacing: 1
    );
  }

  static TextStyle? titleSmall(BuildContext context){
    return Theme.of(context).textTheme.titleSmall;
  }

  static TextStyle? overline(BuildContext context){
    return Theme.of(context).textTheme.labelSmall;
  }
}