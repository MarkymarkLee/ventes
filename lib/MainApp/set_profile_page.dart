import 'package:ventes/Auth/auth_service.dart';
import 'package:ventes/Components/components.dart';
import 'package:flutter/material.dart';
import 'package:ventes/Functions/users_data.dart';

class SetProfilePage extends StatefulWidget {
  final Function reload;
  const SetProfilePage({Key? key, required this.reload}) : super(key: key);

  @override
  _SetProfilePageState createState() => _SetProfilePageState();
}

class _SetProfilePageState extends State<SetProfilePage> {
  String nicknameError = "";
  final _nicknameController = TextEditingController();

  String _selectedGender = "male";

  void onFinish() async {
    String nickname = _nicknameController.text.trim();
    String error = await UsersData.updateProfile(
        AuthService().getCurrentUserEmail(), nickname, _selectedGender);
    if (error == "") {
      widget.reload();
      return;
    }

    setState(() {
      nicknameError = error;
    });
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
          controller: _nicknameController,
          hintText: "",
          errorText: nicknameError,
          fieldName: "Your nickname: (Required)",
          fieldNameColor: Colors.amber.shade100,
          textfieldBorderColor: Colors.white,
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
              child: MyRadioButtons(
                fieldName: "male",
                onRadioChanged: onRadioChanged,
                selectedLabel: _selectedGender,
                labelColor: Colors.amber.shade100,
              ),
            ),
            Expanded(
              flex: 1,
              child: MyRadioButtons(
                fieldName: "female",
                onRadioChanged: onRadioChanged,
                selectedLabel: _selectedGender,
                labelColor: Colors.amber.shade100,
              ),
            ),
            Expanded(
              flex: 1,
              child: MyRadioButtons(
                fieldName: "others",
                onRadioChanged: onRadioChanged,
                selectedLabel: _selectedGender,
                labelColor: Colors.amber.shade100,
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
