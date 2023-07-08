import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;

  const MyButton({super.key, required this.onTap, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.amber[100],
          ),
          onPressed: onTap,
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.brown,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final dynamic controller;
  final String hintText;
  final String errorText;
  final String fieldName;
  final Color fieldNameColor;
  final Color textfieldBorderColor;

  // Colors.amber.shade100

  const MyTextField({
    super.key,
    this.fieldNameColor = const Color.fromARGB(225, 0, 0, 0),
    this.textfieldBorderColor = const Color.fromARGB(225, 0, 0, 0),
    required this.controller,
    required this.hintText,
    required this.errorText,
    required this.fieldName,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint(fieldNameColor.toString());
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
                child: Text(
                  fieldName,
                  style: TextStyle(color: fieldNameColor, fontSize: 16),
                ),
              ),
            ),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: textfieldBorderColor),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber),
                  ),
                  fillColor: Colors.amber[50],
                  filled: true,
                  hintText: hintText,
                  errorText: errorText != "" ? errorText : null,
                  hintStyle: TextStyle(color: Colors.grey[500])),
            ),
          ],
        ));
  }
}

class MySizedBox extends StatelessWidget {
  final String fieldName;

  const MySizedBox({
    super.key,
    required this.fieldName,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
        child: Text(
          fieldName,
          style: TextStyle(color: Colors.amber.shade100, fontSize: 16),
        ),
      ),
    );
  }
}

class MyRadioButtons extends StatelessWidget {
  final String selectedLabel;
  final Function(String?) onRadioChanged;
  final String fieldName;
  final Color labelColor;
  final double horizontalTitleGap;
  final double fontSize;

  const MyRadioButtons(
      {super.key,
      required this.selectedLabel,
      required this.onRadioChanged,
      required this.fieldName,
      this.horizontalTitleGap = 8,
      this.fontSize = 17,
      this.labelColor = const Color.fromARGB(225, 0, 0, 0)});
  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      horizontalTitleGap: horizontalTitleGap,
      child: RadioListTile(
        visualDensity: const VisualDensity(horizontal: -4.0),
        // contentPadding: EdgeInsets.zero,
        title: Text(
          fieldName,
          style: TextStyle(color: labelColor, fontSize: fontSize),
        ),
        value: fieldName,
        groupValue: selectedLabel,
        onChanged: onRadioChanged,
      ),
    );
  }
}

