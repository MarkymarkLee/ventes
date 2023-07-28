import 'package:flutter/material.dart';

class MyTextfield extends StatefulWidget {
  final String name;
  final int maxLength;
  const MyTextfield({super.key, required this.name, required this.maxLength});

  @override
  State<MyTextfield> createState() => _MyTextfieldState();
}

class _MyTextfieldState extends State<MyTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: widget.name,
      ),
      maxLength: widget.maxLength,
    );
  }
}
