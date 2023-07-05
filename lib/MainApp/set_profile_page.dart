import 'package:ventes/Auth/auth_service.dart';
import 'package:ventes/Components/components.dart';
import 'package:flutter/material.dart';
import 'package:ventes/Functions/users_data.dart';

class SetProfilePage extends StatefulWidget {
  const SetProfilePage({Key? key}) : super(key: key);

  @override
  _SetProfilePageState createState() => _SetProfilePageState();
}

class _SetProfilePageState extends State<SetProfilePage> {
  final _nameController = TextEditingController();
  String nameError = "";
  final _nicknameController = TextEditingController();

  String _selectedGender = "male";

  void onFinish() {
    String name = _nameController.text.trim();
    String nickname = _nicknameController.text.trim();
    if (name.isEmpty) {
      setState(() {
        nameError = "Name cannot be empty";
      });
      return;
    }
    if (nickname.isEmpty) {
      nickname = name;
    }

    Map<String, String>? profile = {
      "name": name,
      "nickname": nickname,
      "gender": _selectedGender,
    };
    debugPrint(profile.toString());
    String email = AuthService().getCurrentUserEmail();
    UsersData.updateUser(email, profile);
    return;
  }

  void onRadioChanged(String? index) {
    if (index == null) {
      return;
    }
    setState(() {
      _selectedGender = index;
    });
  }

  // show the profile setting page with three text fields
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(children: [
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
          fieldName: "Your name: (Required)",
        ),
        if (nameError.isNotEmpty)
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 3),
              child: Text(
                nameError,
                style: TextStyle(color: Colors.red.shade500, fontSize: 14),
              ),
            ),
          )
        else
          const SizedBox(height: 20),
        MyTextField(
          controller: _nicknameController,
          hintText: "",
          fieldName: "Your nickname: (Default: Your name)",
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
      ]),
    )));
  }
}
