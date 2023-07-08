import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ventes/Auth/auth_service.dart';
import 'package:ventes/Components/components.dart';
import 'package:ventes/Functions/users_data.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(AuthService().getCurrentUserEmail())
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var userdata = snapshot.data!.data()!;
            if (userdata.containsKey("nickname") &&
                userdata.containsKey("gender")) {
              return BuildPage(
                  nickname: userdata["nickname"],
                  selectedGender: userdata["gender"]);
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}

class BuildPage extends StatefulWidget {
  final String nickname;
  final String selectedGender;

  const BuildPage(
      {Key? key, required this.nickname, required this.selectedGender})
      : super(key: key);

  @override
  State<BuildPage> createState() => _BuildPageState();
}

class _BuildPageState extends State<BuildPage> {
  String nickname = "";
  String selectedGender = "";
  String nicknameError = "";
  final _nicknameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nickname = widget.nickname;
    selectedGender = widget.selectedGender;
  }

  void onRadioChanged(String? index) {
    if (index == null) {
      return;
    }
    setState(() {
      selectedGender = index;
    });
  }

  void onFinish() async {
    String nickname = _nicknameController.text.trim();
    String error = await UsersData.updateProfile(
        AuthService().getCurrentUserEmail(), nickname, selectedGender);
    if (error == "") {
      if (context.mounted) Navigator.pop(context);
      return;
    }

    setState(() {
      nicknameError = error;
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(height: 20),
          MyTextField(
            controller: _nicknameController,
            hintText: nickname,
            errorText: nicknameError,
            fieldName: "Your nickname: (Required)",
          ),
          const SizedBox(height: 20),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: MyRadioButtons(
                    fieldName: "male",
                    onRadioChanged: onRadioChanged,
                    selectedLabel: selectedGender),
              ),
              Expanded(
                flex: 1,
                child: MyRadioButtons(
                    fieldName: "female",
                    onRadioChanged: onRadioChanged,
                    selectedLabel: selectedGender),
              ),
              Expanded(
                flex: 1,
                child: MyRadioButtons(
                    fieldName: "others",
                    onRadioChanged: onRadioChanged,
                    selectedLabel: selectedGender),
              ),
            ],
          ),
          const SizedBox(height: 20),
          MyButton(onTap: onFinish, buttonText: "Finish Editting"),
        ],
      )),
    );
  }
}
