import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventes/Auth/auth_service.dart';
import 'package:ventes/DarkTheme/theme_mode_notifier.dart';
import 'package:ventes/MainApp/Profile/edit_profile_page.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});
  static const double paddings = 10;

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(children: [
        const Text(
          "Setting Page",
          style: TextStyle(fontSize: 30),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        Card(
          child: Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: const EdgeInsets.fromLTRB(
                        paddings, paddings, 0, paddings),
                    child: const ListTile(
                      leading: Icon(Icons.dark_mode),
                      title: Text('Dark Mode'),
                    )),
                Switch(
                  value: themeChange.darkTheme,
                  activeColor: const Color.fromARGB(255, 47, 10, 255),
                  onChanged: (bool value) {
                    themeChange.darkTheme = value;
                  },
                ),
              ]),
        ),
        const SizedBox(height: 20),
        Card(
          child: Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: const EdgeInsets.fromLTRB(
                        paddings, paddings, 0, paddings),
                    child: const ListTile(
                      leading: Icon(Icons.edit),
                      title: Text('Edit profiles'),
                    )),
                IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditProfilePage()));
                    }),
              ]),
        ),
        const SizedBox(height: 20),
        const Divider(thickness: 3),
        const SizedBox(height: 20),
        Card(
          clipBehavior: Clip.hardEdge,

          child: InkWell(
            onTap: () => AuthService().signOut(),
            child: Container(
                padding:
                    const EdgeInsets.fromLTRB(paddings, paddings, 0, paddings),
                child: const ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                )))
        ),
      ]),
    );
  }
}
