import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:ventes/Auth/auth_service.dart';
// import 'package:ventes/Functions/users_data.dart';
import 'package:ventes/MainApp/Profile/edit_profile_page.dart';

class ProfileInfo extends StatelessWidget {
  // final VoidCallback editProfile;
  const ProfileInfo({
    Key? key,
  }) : super(key: key);

  static const tDefaultSize = 20.0;
  static const tPrimaryColor = Color.fromARGB(255, 207, 208, 178);
  static const String tProfileImage = "images/logo.png";

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
            if (userdata.containsKey("nickname")) {
              String nickname = userdata["nickname"];
              return Container(
                padding: const EdgeInsets.all(tDefaultSize),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  tProfileImage,
                                  width: 200,
                                ))),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: tPrimaryColor),
                            child: IconButton(
                                icon: const Icon(
                                  LineAwesomeIcons.alternate_pencil,
                                  color: Colors.black,
                                  size: 15,
                                ),
                                onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EditProfilePage()),
                                    )),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        Text(nickname,
                            style: Theme.of(context).textTheme.headlineMedium),
                        const SizedBox(height: 20),
                      ],
                    )
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
