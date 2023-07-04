import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ventes/Components/components.dart';
import 'package:flutter/material.dart';

class SetProfilePage extends StatefulWidget {
  const SetProfilePage({Key? key}) : super(key: key);

  @override
  _SetProfilePageState createState() => _SetProfilePageState();
}

class _SetProfilePageState extends State<SetProfilePage> {
  final _nameController = TextEditingController();
  final _nicknameController = TextEditingController();
  String? _selectedGender;

  void onFinish() {
    return;
  }

  void onRadioChanged(String? index) {
    setState(() {
      _selectedGender = index;
    });
  }

  // show the profile setting page with three text fields
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Text(
          "One Last Step!",
          style: TextStyle(color: Colors.amber.shade100, fontSize: 40),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Text(
          "Let's build your profile!",
          style: TextStyle(color: Colors.amber.shade100, fontSize: 25),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        MyTextField(
          controller: _nameController,
          hintText: "",
          fieldName: "Your name: ",
        ),
        const SizedBox(height: 20),
        MyTextField(
          controller: _nicknameController,
          hintText: "",
          fieldName: "Your nickname: ",
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: MySizedBox(fieldName: "Gender"),
        ),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 1,
              child: ListTileTheme(
                horizontalTitleGap: 8,
                child: RadioListTile(
                  visualDensity: const VisualDensity(horizontal: -4.0),
                  // contentPadding: EdgeInsets.zero,
                  title: Text(
                    'male',
                    style:
                        TextStyle(color: Colors.amber.shade100, fontSize: 17),
                  ),
                  value: "male",
                  groupValue: _selectedGender,
                  onChanged: onRadioChanged,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ListTileTheme(
                horizontalTitleGap: 8,
                child: RadioListTile(
                  visualDensity: const VisualDensity(horizontal: -4.0),
                  // contentPadding: EdgeInsets.zero,
                  title: Text(
                    'female',
                    style:
                        TextStyle(color: Colors.amber.shade100, fontSize: 17),
                  ),
                  value: "female",
                  groupValue: _selectedGender,
                  onChanged: onRadioChanged,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ListTileTheme(
                horizontalTitleGap: 8,
                child: RadioListTile(
                  visualDensity: const VisualDensity(horizontal: -4.0),
                  // contentPadding: EdgeInsets.zero,
                  title: Text(
                    'others',
                    style:
                        TextStyle(color: Colors.amber.shade100, fontSize: 17),
                  ),
                  value: "others",
                  groupValue: _selectedGender,
                  onChanged: onRadioChanged,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 50),
        MyButton(
          buttonText: "Finish",
          onTap: onFinish,
        )
      ],
    )));
  }
}
